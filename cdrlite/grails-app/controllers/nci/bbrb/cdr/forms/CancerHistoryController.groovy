package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.CandidateRecord



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CancerHistoryController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CancerHistory.list(params), model:[cancerHistoryInstanceCount: CancerHistory.count()]
    }
    
    
    def show(CancerHistory cancerHistoryInstance) {
        respond cancerHistoryInstance
    }
    
    
    def list() {
        def cancerHistoryList
        def candId
        def candidateFullID
        def healthInstance
        // this is from the save action
        if(params.id){
            
            cancerHistoryList=CancerHistory.findAllByCandidateRecord(CandidateRecord.findById(params.id))
            //candId=params.id
            candId =CandidateRecord.findById(params.id)?.id
            candidateFullID=CandidateRecord.findById(candId)?.candidateId
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        else if(params.candidateRecord.id){
            
            cancerHistoryList=CancerHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candidateRecord.id))
            //candId=params.candidateRecord.id
            candId =CandidateRecord.findById(params.candidateRecord.id)?.id
            candidateFullID=CandidateRecord.findById(candId)?.candidateId
            healthInstance=HealthHistory.findByCandidateRecord(CandidateRecord.findById(candId))
              
        }
        
        def canAdd='Yes'
        if(healthInstance?.dateSubmitted){
            canAdd='No'
        }
        
       
        [cancerHistoryList: cancerHistoryList, candId:candId,cancerHistoryListCount:cancerHistoryList?.size(),candidateFullID:candidateFullID,healthInstanceId:healthInstance?.id,canAdd:canAdd]
    }

    def create() {
        respond new CancerHistory(params)
    }

    @Transactional
    def save(CancerHistory cancerHistoryInstance) {
        if (cancerHistoryInstance == null) {
            notFound()
            return
        }
        
        if(params.candidateRecord.id){
            cancerHistoryInstance.candidateRecord=CandidateRecord.get(params.candidateRecord.id)
                
        }

        def errorMap = checkError(cancerHistoryInstance)
        errorMap.each() {key, value ->
            cancerHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond cancerHistoryInstance.errors, view:'create'
            return
        }

        cancerHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cancerHistory.label', default: 'CancerHistory'), cancerHistoryInstance.id])
                redirect(action:"list", params:[id:cancerHistoryInstance.candidateRecord?.id])
            }
            '*' { respond cancerHistoryInstance, [status: CREATED] }
        }
    }

    def edit(CancerHistory cancerHistoryInstance) {
        respond cancerHistoryInstance
    }

    @Transactional
    def update(CancerHistory cancerHistoryInstance) {
        if (cancerHistoryInstance == null) {
            notFound()
            return
        }

        def errorMap = checkError(cancerHistoryInstance)
        errorMap.each() {key, value ->
            cancerHistoryInstance.errors.rejectValue(key, value)
        }

        if (errorMap.size() > 0) {
            respond cancerHistoryInstance.errors, view:'edit'
            return
        }

        cancerHistoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CancerHistory.label', default: 'CancerHistory'), cancerHistoryInstance.id])
                redirect cancerHistoryInstance
            }
            '*'{ respond cancerHistoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CancerHistory cancerHistoryInstance) {

        if (cancerHistoryInstance == null) {
            notFound()
            return
        }
        def candId =cancerHistoryInstance.candidateRecord?.id
        cancerHistoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CancerHistory.label', default: 'CancerHistory'), cancerHistoryInstance.id])
                // redirect action:"list"
                redirect(action:"list", params:[id:candId])
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cancerHistory.label', default: 'CancerHistory'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    Map checkError(cancerHistoryInstance) {
        def errorMap = [:]
        
       
        if (!cancerHistoryInstance.source) {           
            errorMap.put('source', 'healthhistory.source.blank')
        }
        
        if (!cancerHistoryInstance.primaryTumorSite) {             
            errorMap.put('primaryTumorSite', 'healthhistory.primaryTumorSite.blank')
        }
        boolean treatmentSurgery=false
    boolean treatmentRadiation=false
    boolean treatmentChemotherapy=false
    boolean treatmentOther=false
    boolean  treatmentNo =false
    boolean treatmentUnknown=false
        if (!cancerHistoryInstance.treatmentSurgery && !cancerHistoryInstance.treatmentRadiation && !cancerHistoryInstance.treatmentChemotherapy
        && !cancerHistoryInstance.treatmentOther && !cancerHistoryInstance.treatmentNo && !cancerHistoryInstance.treatmentUnknown) {           
            errorMap.put('treatments', 'healthhistory.treatment.blank')
        }
        
        if (!cancerHistoryInstance.monthYearOfFirstDiagnosis) {             
            errorMap.put('monthYearOfFirstDiagnosis', 'healthhistory.monthYearOfFirstDiagnosis.blank')
        }
        
         if (!cancerHistoryInstance.monthYearOfLastTreatment) {             
            errorMap.put('monthYearOfLastTreatment', 'healthhistory.monthYearOfLastTreatment.blank')
        }
        
        return errorMap
    }
}
