package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CandidateRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MedicationHistoryController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MedicationHistory.list(params), model:[medicationHistoryInstanceCount: MedicationHistory.count()]
    }

    def show(MedicationHistory medicationHistoryInstance) {
        respond medicationHistoryInstance
    }
    
    
    
    def list() {
        def medicationHistoryList
        def candId
        def candidateInstance
        def healthInstance
        
         if (!params.sort) params.sort = "id"
        if (!params.order) params.order = "desc"
       
        if(params.id){
            
            medicationHistoryList=MedicationHistory.findAllByCandidateRecord(CandidateRecord.findById(params.id))
            //candId=params.id
            candId =CandidateRecord.findById(params.id)?.id
            //candidateFullID=CandidateRecord.findById(candId)?.candidateId
            candidateInstance=CandidateRecord.findById(candId)
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        else if(params.candidateRecord.id){
            
            medicationHistoryList=MedicationHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candidateRecord.id))
            //candId=params.candidateRecord.id
            candId =CandidateRecord.findById(params.candidateRecord.id)?.id
           // candidateFullID=CandidateRecord.findById(candId)?.candidateId
            candidateInstance=CandidateRecord.findById(candId)
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        
        def canAdd='Yes'
        if(healthInstance?.dateSubmitted){
            canAdd='No'
        }
        
       
        [medicationHistoryList: medicationHistoryList, candId:candId,medicationHistoryListCount:medicationHistoryList?.size(),candidateInstance:candidateInstance,healthInstanceId:healthInstance?.id,canAdd:canAdd]
    }
    
    

    def create() {
        respond new MedicationHistory(params)
    }

    @Transactional
    def save(MedicationHistory medicationHistoryInstance) {
        if (medicationHistoryInstance == null) {
            notFound()
            return
        }
        if(params.candidateRecord.id){
            medicationHistoryInstance.candidateRecord=CandidateRecord.get(params.candidateRecord.id)
                
        }
        
        
        def errorMap = checkError(medicationHistoryInstance)
        errorMap.each() {key, value ->
            medicationHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond medicationHistoryInstance.errors, view:'create'
            return
        }
       
        
        medicationHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'medicationHistory.label', default: 'Medication History'), medicationHistoryInstance.id])
                redirect(action:"list", params:[id:medicationHistoryInstance.candidateRecord?.id])
            }
            '*' { respond medicationHistoryInstance, [status: CREATED] }
        }
    }

    def edit(MedicationHistory medicationHistoryInstance) {
        respond medicationHistoryInstance
    }

    @Transactional
    def update(MedicationHistory medicationHistoryInstance) {
        if (medicationHistoryInstance == null) {
            notFound()
            return
        }

        def errorMap = checkError(medicationHistoryInstance)
        errorMap.each() {key, value ->
            medicationHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond medicationHistoryInstance.errors, view:'edit'
            return
        }

        medicationHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'MedicationHistory.label', default: 'Medication History'), medicationHistoryInstance.id])
                redirect medicationHistoryInstance
            }
            '*'{ respond medicationHistoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MedicationHistory medicationHistoryInstance) {

        if (medicationHistoryInstance == null) {
            notFound()
            return
        }
        def candId =medicationHistoryInstance.candidateRecord?.id
        medicationHistoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MedicationHistory.label', default: 'Medication History'), medicationHistoryInstance.id])
                //redirect action:"index"
                redirect(action:"list", params:[id:candId])
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'medicationHistory.label', default: 'Medication History'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    Map checkError(medicationHistoryInstance) {
        def errorMap = [:]
        
       
        if (!medicationHistoryInstance.source) {           
            errorMap.put('source', 'healthhistory.source.blank')
        }
        
        if (!medicationHistoryInstance.medicationName) {             
            errorMap.put('medicationName', 'healthhistory.medicationName.blank')
        }
        
        if (!medicationHistoryInstance.dateofLastAdministration) {             
            errorMap.put('dateofLastAdministration', 'healthhistory.dateofLastAdministration.blank')
        }
        
                 
        return errorMap
    }
}
