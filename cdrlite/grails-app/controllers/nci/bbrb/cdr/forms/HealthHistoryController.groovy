package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CandidateRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class HealthHistoryController {
    def accessPrivilegeService
    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond HealthHistory.list(params), model:[healthHistoryInstanceCount: HealthHistory.count()]
    }
    
    def list() {
        def healthHistoryInstance
        def candId 
        if(params.id){
            
            healthHistoryInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(params.id))
           
              
        }
        if (healthHistoryInstance){
            candId =healthHistoryInstance?.candidateRecord?.candidateId
           
        }
        [healthHistoryInstance: healthHistoryInstance, candId:candId]
    }

    def show(HealthHistory healthHistoryInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(healthHistoryInstance?.candidateRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        respond healthHistoryInstance
    }

    def create() {
        def healthHistoryInstance = new HealthHistory(params)
       
        return [healthHistoryInstance: healthHistoryInstance]
    }


    @Transactional
    def save(HealthHistory healthHistoryInstance) {
        if (healthHistoryInstance == null) {
            notFound()
            return
        }
        if(params.candidateRecord.id){
            healthHistoryInstance.candidateRecord=CandidateRecord.get(params.candidateRecord.id)
                
        }
        def errorMap = checkError(healthHistoryInstance)
        errorMap.each() {key, value ->
            healthHistoryInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() > 0) {
            respond healthHistoryInstance.errors, view:'create'
            return
        }
        healthHistoryInstance.submittedBy=null
        healthHistoryInstance.dateSubmitted=null
        healthHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'healthHistory.label', default: 'Health History'), healthHistoryInstance.id])
                redirect healthHistoryInstance
                
            }
            
            '*' { respond healthHistoryInstance, [status: CREATED] }
        }
    }

    def edit(HealthHistory healthHistoryInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(healthHistoryInstance?.candidateRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }
        def errorMap = checkError(healthHistoryInstance)
        errorMap.each() {key, value ->
            healthHistoryInstance.errors.rejectValue(key, value)
        }
        respond healthHistoryInstance
    }
    
    
    // update is like our BPV resume editing.... 
    @Transactional
    def update(HealthHistory healthHistoryInstance) {
        if (healthHistoryInstance == null) {
            notFound()
            return
        }
        
        def errorMap = checkError(healthHistoryInstance)
        errorMap.each() {key, value ->
            healthHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond healthHistoryInstance.errors, view:'edit'
            return
        }
        healthHistoryInstance.lastUpdated = new Date()
        healthHistoryInstance.dateSubmitted = null
        healthHistoryInstance.submittedBy = null
        healthHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'HealthHistory.label', default: 'Health History'), healthHistoryInstance.id])
                redirect healthHistoryInstance
            }
            '*'{ respond healthHistoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(HealthHistory healthHistoryInstance) {

        if (healthHistoryInstance == null) {
            notFound()
            return
        }

        healthHistoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'HealthHistory.label', default: 'HealthHistory'), healthHistoryInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'healthHistory.label', default: 'Health History'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    
    @Transactional
    def submit(HealthHistory healthHistoryInstance) {
        if (healthHistoryInstance == null) {
            notFound()
            return
        }

        if (healthHistoryInstance.hasErrors()) {
            respond healthHistoryInstance.errors, view:'edit'
            return
        }
        healthHistoryInstance.dateSubmitted = new Date()
        healthHistoryInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        healthHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.submitted.message', args: [message(code: 'HealthHistory.label', default: 'Health History '), healthHistoryInstance.id])
                //redirect healthHistoryInstance
                 redirect(controller: "candidateRecord", action: "show", id: healthHistoryInstance.candidateRecord.id)
            }
            '*'{ respond healthHistoryInstance, [status: OK] }
        }
    }
    
    
    
    
    
    def display(HealthHistory healthHistoryInstance) {
        if (healthHistoryInstance == null) {
            notFound()
            return
        }
        def candId=healthHistoryInstance.candidateRecord.id
        def cancerHistoryList=CancerHistory.findAllByCandidateRecord(CandidateRecord.findById(candId))
        def generalMedicalHistoryList=GeneralMedicalHistory.findAllByCandidateRecord(CandidateRecord.findById(candId))
        def medicationHistoryList=MedicationHistory.findAllByCandidateRecord(CandidateRecord.findById(candId))
        
        [healthHistoryInstance: healthHistoryInstance, candId:candId,cancerHistoryList:cancerHistoryList,generalMedicalHistoryList:generalMedicalHistoryList,medicationHistoryList:medicationHistoryList]
    }

    
    Map checkError(healthHistoryInstance) {
        def errorMap = [:]
        
       
        if (!healthHistoryInstance.source) {           
            errorMap.put('source', 'healthhistory.source.blank')
        }
        
        if (!healthHistoryInstance.historyOfCancer) {             
            errorMap.put('historyOfCancer', 'healthhistory.historyOfCancer.blank')
        }
        
        return errorMap
    }

}
