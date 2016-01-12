package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CandidateRecord


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GeneralMedicalHistoryController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond GeneralMedicalHistory.list(params), model:[generalMedicalHistoryInstanceCount: GeneralMedicalHistory.count()]
    }
    
    
    def list() {
        def generalMedicalHistoryList
       def candId
       def candidateInstance
       def healthInstance
       
        if (!params.sort) params.sort = "id"
        if (!params.order) params.order = "desc"
       
        if(params.id){
            
            generalMedicalHistoryList=GeneralMedicalHistory.findAllByCandidateRecord(CandidateRecord.findById(params.id))
            //candId=params.id
            candId =CandidateRecord.findById(params.id)?.id
            candidateInstance=CandidateRecord.findById(candId)
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        else if(params.candidateRecord.id){
            
            generalMedicalHistoryList=GeneralMedicalHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candidateRecord.id))
            //candId=params.candidateRecord.id
            candId =CandidateRecord.findById(params.candidateRecord.id)?.id
            candidateInstance=CandidateRecord.findById(candId)
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        
      def canAdd='Yes'
      if(healthInstance?.dateSubmitted){
          canAdd='No'
      }
         [generalMedicalHistoryList: generalMedicalHistoryList, candId:candId,generalMedicalHistoryListCount:generalMedicalHistoryList?.size(),candidateInstance:candidateInstance,healthInstanceId:healthInstance?.id,canAdd:canAdd]
    }

    def show(GeneralMedicalHistory generalMedicalHistoryInstance) {
        
        respond generalMedicalHistoryInstance
    }

    def create() {
        respond new GeneralMedicalHistory(params)
    }

    @Transactional
    def save(GeneralMedicalHistory generalMedicalHistoryInstance) {
       
        if (generalMedicalHistoryInstance == null) {
            notFound()
            return
        }

        if(params.candidateRecord.id){
           
            generalMedicalHistoryInstance.candidateRecord=CandidateRecord.get(params.candidateRecord.id)
                
        }
        
        def errorMap = checkError(generalMedicalHistoryInstance)
        errorMap.each() {key, value ->
            generalMedicalHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond generalMedicalHistoryInstance.errors, view:'create'
            return
        }
        
        generalMedicalHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'generalMedicalHistory.label', default: 'General Medical History'), generalMedicalHistoryInstance.id])
                redirect(action:"list", params:[id:generalMedicalHistoryInstance.candidateRecord?.id])
            }
            '*' { respond generalMedicalHistoryInstance, [status: CREATED] }
        }
    }

    def edit(GeneralMedicalHistory generalMedicalHistoryInstance) {
        respond generalMedicalHistoryInstance
    }

    @Transactional
    def update(GeneralMedicalHistory generalMedicalHistoryInstance) {
        if (generalMedicalHistoryInstance == null) {
            notFound()
            return
        }
        
        
        def errorMap = checkError(generalMedicalHistoryInstance)
        errorMap.each() {key, value ->
            generalMedicalHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond generalMedicalHistoryInstance.errors, view:'edit'
            return
        }

        
        generalMedicalHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GeneralMedicalHistory.label', default: 'General Medical History'), generalMedicalHistoryInstance.id])
                redirect generalMedicalHistoryInstance
            }
            '*'{ respond generalMedicalHistoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GeneralMedicalHistory generalMedicalHistoryInstance) {

        if (generalMedicalHistoryInstance == null) {
            notFound()
            return
        }
        def candId =generalMedicalHistoryInstance.candidateRecord?.id
        generalMedicalHistoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GeneralMedicalHistory.label', default: 'General Medical History'), generalMedicalHistoryInstance.id])
                //redirect action:"index"
                 redirect(action:"list", params:[id:candId])
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'generalMedicalHistory.label', default: 'General Medical History'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    Map checkError(generalMedicalHistoryInstance) {
        def errorMap = [:]
        
       
        if (!generalMedicalHistoryInstance.source) {           
            errorMap.put('source', 'healthhistory.source.blank')
        }
        
        if (!generalMedicalHistoryInstance.diseaseName) {             
            errorMap.put('diseaseName', 'healthhistory.diseaseName.blank')
        }
        
        if (!generalMedicalHistoryInstance.treatment) {           
            errorMap.put('treatment', 'healthhistory.treatment.blank')
        }
        
        if (!generalMedicalHistoryInstance.monthYearOfFirstDiagnosis) {             
            errorMap.put('monthYearOfFirstDiagnosis', 'healthhistory.monthYearOfFirstDiagnosis.blank')
        }
        
         if (!generalMedicalHistoryInstance.monthYearOfLastTreatment) {             
            errorMap.put('monthYearOfLastTreatment', 'healthhistory.monthYearOfLastTreatment.blank')
        }
        
        return errorMap
    }
}
