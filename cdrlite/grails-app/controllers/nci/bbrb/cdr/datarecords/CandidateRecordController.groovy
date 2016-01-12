package nci.bbrb.cdr.datarecords



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import nci.bbrb.cdr.staticmembers.Study
import nci.bbrb.cdr.staticmembers.BSS

@Transactional(readOnly = true)
class CandidateRecordController {
     def hubIdGenService
     def candidateService
     def accessPrivilegeService
     
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
         def candidateList
         def count
         if(bss && bss.code !='DCC'){
            candidateList = CandidateRecord.findAllByStudyAndBss(study, bss, params)
            count = CandidateRecord.countByStudyAndBss(study, bss)
         }else{
             candidateList = CandidateRecord.findAllByStudy(study, params)  
             count = CandidateRecord.countByStudy(study)
         }
      
        
        
        respond candidateList, model:[candidateRecordInstanceCount: count]
    }

    def show(CandidateRecord candidateRecordInstance) {
        
         if(!accessPrivilegeService.hasPrivilegeCandi(candidateRecordInstance, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        
        respond candidateRecordInstance
    }

    def create() {
       
        
        def study=Study.get(params.studyId)
        
        
        def candidateRecord= new CandidateRecord(params)
        candidateRecord.study=study
        
       // respond new CandidateRecord(params)
       respond candidateRecord
    }

    @Transactional
    def save(CandidateRecord candidateRecordInstance) {
        if (candidateRecordInstance == null) {
            notFound()
            return
        }

        candidateRecordInstance.candidateId = hubIdGenService.genCandidateId(candidateRecordInstance.bss.code)
     
        
      /**  if (candidateRecordInstance.hasErrors()) {
            respond candidateRecordInstance.errors, view:'create'
            return
        }**/

        candidateRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'candidateRecord.label', default: 'Candidate record'), candidateRecordInstance.candidateId])
                redirect candidateRecordInstance
            }
            '*' { respond candidateRecordInstance, [status: CREATED] }
        }
    }

    def edit(CandidateRecord candidateRecordInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(candidateRecordInstance, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        respond candidateRecordInstance
    }

    @Transactional
    def update(CandidateRecord candidateRecordInstance) {
        if (candidateRecordInstance == null) {
            notFound()
            return
        }

        if (candidateRecordInstance.hasErrors()) {
            respond candidateRecordInstance.errors, view:'edit'
            return
        }

        
        //candidateRecordInstance.save flush:true
        
        candidateService.updateCandidate(candidateRecordInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CandidateRecord.label', default: 'Candidate record'), candidateRecordInstance.candidateId])
                redirect candidateRecordInstance
            }
            '*'{ respond candidateRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CandidateRecord candidateRecordInstance) {

        if (candidateRecordInstance == null) {
            notFound()
            return
        }

        candidateRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CandidateRecord.label', default: 'Candidate record'), candidateRecordInstance.candidateId])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'candidateRecord.label', default: 'Candidate record'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
