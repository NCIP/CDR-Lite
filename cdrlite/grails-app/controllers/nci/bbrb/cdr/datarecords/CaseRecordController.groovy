package nci.bbrb.cdr.datarecords
import nci.bbrb.cdr.staticmembers.ActivityType
import nci.bbrb.cdr.staticmembers.CaseStatus
import nci.bbrb.cdr.staticmembers.QueryStatus
import nci.bbrb.cdr.util.querytracker.Query
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import nci.bbrb.cdr.staticmembers.*

@Transactional(readOnly = true)
class CaseRecordController {
    def activityEventService
    def accessPrivilegeService
    def caseStatusService
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 25, 100)
        
        def study=session.study
        if(!study){
              redirect(controller: "login", action: "denied")
              return
        }
        // println("max: " + max + " params.max: " + params.max)
        
        // params.max='3'
       // def caseList = CaseRecord.list(params)
          def bss = BSS.findByCode(session.org?.code)
         def caseList
         def count
         if(bss && bss.code !='DCC'){
            caseList = CaseRecord.findAllByStudyAndBss(study, bss, params)
            count = CaseRecord.countByStudyAndBss(study, bss)
         }else{
            caseList = CaseRecord.findAllByStudy(study, params) 
            count = CaseRecord.countByStudy(study)
         }
        
      
        def specimenCount=[:]
        if(caseList){
            def count_result = SpecimenRecord.executeQuery("select c.id, count(*) from SpecimenRecord s inner join s.caseRecord c where c in (:list) group by c.id",  [list: caseList])
            count_result.each(){
                specimenCount.put(it[0], it[1])
             
            }
        }
        
        def queryCount = getQueryCountMap(caseList)
        
      
        
        respond caseList, model:[caseRecordInstanceCount: count, specimenCount:specimenCount, queryCount: queryCount]
    }

    def show(CaseRecord caseRecordInstance) {
        if (!caseRecordInstance) {
            caseRecordInstance = CaseRecord.findByCaseId(params.caseRecordInstance)
        }
         if(!accessPrivilegeService.hasPrivilege(caseRecordInstance, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        def showEdit=false
        def showChangeStatus=false
         if ((caseRecordInstance.bss?.code?.equals(session.org?.code) || session.org?.code?.equals('DCC')) && session.DM == true && 
                (caseRecordInstance.caseStatus?.code == 'INIT' || caseRecordInstance.caseStatus?.code == 'DATA'  || caseRecordInstance.caseStatus?.code == 'REMED')){
                showEdit=true
                }
                
         if ( session.DM == true && (session.org?.code?.equals('DCC') ||
                (caseRecordInstance.bss?.code?.equals(session.org?.code) && (caseRecordInstance.caseStatus?.code == 'DATACOMP' || caseRecordInstance.caseStatus?.code == 'DATA'  || caseRecordInstance.caseStatus?.code == 'REMED')))){
               showChangeStatus=true
                }
        
        def caseStatus = caseStatusService.getStatus(caseRecordInstance)
        
        def canModify=false
        if(session.DM && ((caseRecordInstance?.caseStatus?.code == 'INIT' || caseRecordInstance?.caseStatus?.code == 'DATA'  || caseRecordInstance?.caseStatus?.code == 'REMED') ||(caseRecordInstance?.caseStatus?.code == 'QA' && session.org?.code=='DCC'))){
            canModify=true
        }
        
        respond caseRecordInstance, model:[showEdit:showEdit, showChangeStatus:showChangeStatus, caseStatus:caseStatus, canModify:canModify]
    }

    def create() {
        def caseRecord = new CaseRecord(params)
        caseRecord.bss=caseRecord.candidateRecord?.bss
        caseRecord.study=caseRecord.candidateRecord?.study
        caseRecord.caseStatus = CaseStatus.findByCode("DATA")
        // respond new CaseRecord(params)
        respond caseRecord
    }

    @Transactional
    def save(CaseRecord caseRecordInstance) {
        if (caseRecordInstance == null) {
            notFound()
            return
        }

         caseRecordInstance.caseStatus = CaseStatus.findByCode('DATA')
         caseRecordInstance.caseCollectionType=CaseCollectionType.findByCode('SURGI')
        if (caseRecordInstance.hasErrors()) {
            respond caseRecordInstance.errors, view:'create'
            return
        }

       
        caseRecordInstance.save flush:true
        
        def activityType = ActivityType.findByCode("CASECREATE")
        def caseId = caseRecordInstance.caseId
        def study = caseRecordInstance.study
        def bssCode = caseRecordInstance.bss?.code
        def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        def additionalInfo =caseId+ " created by "+username
        activityEventService.createEvent(activityType, caseId, study, bssCode,'', username, additionalInfo, null)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caseRecord.label', default: 'Case record '), caseRecordInstance.caseId])
                redirect caseRecordInstance
            }
            '*' { respond caseRecordInstance, [status: CREATED] }
        }
    }

    def edit(CaseRecord caseRecordInstance) {
        respond caseRecordInstance
    }

    
     def changeCaseStatus = {
         
        

        def caseRecordInstance = CaseRecord.get(params.id)
        
         if(!accessPrivilegeService.hasPrivilege(caseRecordInstance, session, 'changeCaseStatus')){
            redirect(controller: "login", action: "denied")
            return
        }
        
        if (!caseRecordInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'caseRecord.label', default: 'Case Status For Case'), caseRecordInstance.caseId])}"
            redirect(action: "list")
        }
        else {
            
            def currentStatus = caseRecordInstance.caseStatus
            def statusId = currentStatus?.id
            def filteredStatusList = []
            
            if(currentStatus.code == 'DATA'){
                def s1 = CaseStatus.findByCode('DATACOMP');
                filteredStatusList.add(s1);
            }
            if(currentStatus.code == 'DATACOMP' || currentStatus.code == 'REMED'){
                if (currentStatus.code == 'DATACOMP' && session.org.code != 'DCC') {
                    def s3 = CaseStatus.findByCode('DATA')
                    filteredStatusList.add(s3)
                }
                def s2 = CaseStatus.findByCode('BSSQACOMP');
                filteredStatusList.add(s2);
            }                        

            
            return [caseRecordInstance: caseRecordInstance, filteredStatusList:filteredStatusList, statusId:statusId]
        }        
                                                                                                                            
    }               
    
    
    @Transactional
    def update(CaseRecord caseRecordInstance) {
        boolean statusChanged = false
        def oldStatus
        def newStatus
        if (caseRecordInstance == null) {
            notFound()
            return
        }
        //pmh  09/01/15: check if case status has changed in this update. If so, send alert email
        if (caseRecordInstance.caseStatus.id != params.statusId) {
           
            statusChanged = true
            newStatus = caseRecordInstance.caseStatus?.name
            oldStatus =CaseStatus.get(params.statusId)?.name
        }
        
        
        if (caseRecordInstance.hasErrors()) {
            respond caseRecordInstance.errors, view:'edit'
            return
        }

        caseRecordInstance.save flush:true
        
        
        if(statusChanged) {
               
            def activityType = ActivityType.findByCode("STATUSCHG")
            def caseId = caseRecordInstance.caseId
            def study = caseRecordInstance.study
            def bssCode = caseRecordInstance.bss?.code
            def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
            activityEventService.createEvent(activityType, caseId, study, bssCode, '', username, oldStatus, newStatus)
        }
        else{
            def activityType = ActivityType.findByCode("CASEUPDATE")
            def caseId = caseRecordInstance.caseId
            def study = caseRecordInstance.study
            def bssCode = caseRecordInstance.bss?.code
            def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
            def additionalInfo =caseId+ " updated by "+username 
            activityEventService.createEvent(activityType, caseId, study, bssCode, '', username,null , null)
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CaseRecord.label', default: 'Case record '), caseRecordInstance.caseId])
                redirect caseRecordInstance
            }
            '*'{ respond caseRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CaseRecord caseRecordInstance) {

        if (caseRecordInstance == null) {
            notFound()
            return
        }

        caseRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CaseRecord.label', default: 'Case record '), caseRecordInstance.caseId])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caseRecord.label', default: 'Case record '), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    def display = {
        def caseRecordInstance
        try {
            Long.parseLong(params.id)
            caseRecordInstance = CaseRecord.get(params.id)    
        } catch (Exception e) {}

        if (!caseRecordInstance) {
            caseRecordInstance = CaseRecord.findByCaseId(params.id)
        }
        /*
        //dispatcher method to figure out who is requesting the caserecord details page
        flash.message = flash.message
        if (session.org?.code == 'OBBR') {
            redirect(action: "show", id: params.id)            
        } else if ((session.org?.code == 'VARI' || session.org?.code == 'BROAD') && caseRecordInstance.study?.code == 'BMS') {
            redirect(controller: "login", action: "denied")
        } else if (session.org?.code == 'VARI' && (caseRecordInstance.study?.code == 'BPV' || caseRecordInstance.study?.code == 'BRN')) {
            redirect(action: "showbpvdeident", id: params.id)
        } else {
            redirect(action: "view", id: params.id)            
        }
        */
       //pmh 09/01/15 for now just apply this without filters..
       redirect(action: "show", id: caseRecordInstance.id)
    }
    
    
    
     def display2 = {
        def caseRecordInstance
      
            caseRecordInstance = CaseRecord.findByCaseId(params.id)
        
        /*
        //dispatcher method to figure out who is requesting the caserecord details page
        flash.message = flash.message
        if (session.org?.code == 'OBBR') {
            redirect(action: "show", id: params.id)            
        } else if ((session.org?.code == 'VARI' || session.org?.code == 'BROAD') && caseRecordInstance.study?.code == 'BMS') {
            redirect(controller: "login", action: "denied")
        } else if (session.org?.code == 'VARI' && (caseRecordInstance.study?.code == 'BPV' || caseRecordInstance.study?.code == 'BRN')) {
            redirect(action: "showbpvdeident", id: params.id)
        } else {
            redirect(action: "view", id: params.id)            
        }
        */
       //pmh 09/01/15 for now just apply this without filters..
       redirect(action: "show", id: caseRecordInstance.id)
    }
    
    def getQueryCountMap(caseRecordInstanceList) {
        
        def queryCount = [:]
        if (caseRecordInstanceList) {
            def activeStatus = QueryStatus.findByCode("ACTIVE")
            def countResult
            if (session.org?.code == 'DCC') {
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s where c in (:list) and s.id = :activeStatus group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id])
            } else {
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and s.id = :activeStatus and o.code like :org group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id, org:session.org?.code + "%"])
            }
            countResult.each() {
                queryCount.put(it[0], it[1]) 
            }
        }
            
        return queryCount
    }

}
