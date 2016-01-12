package nci.bbrb.cdr.prc



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import nci.bbrb.cdr.datarecords.CaseRecord

@Transactional(readOnly = true)
class PrcReportController {

    def prcReportService
    
    static allowedMethods = [ update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PrcReport.list(params), model:[prcReportInstanceCount: PrcReport.count()]
    }

    def show(PrcReport prcReportInstance) {
        respond prcReportInstance
    }

    def create() {
        respond new PrcReport(params)
    }

    def save ={
        def prcReportInstance = new PrcReport(params)
        
        if (prcReportInstance == null) {
            notFound()
            return
        }

        if (prcReportInstance.hasErrors()) {
            respond prcReportInstance.errors, view:'create'
            return
        }

        
         try{
            
            prcReportService.createReport(prcReportInstance)
             
            
             
          
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'caseReportForm.label', default: 'PRC Report For'), prcReportInstance?.slideRecord?.slideId])}"
         
            redirect(action: "edit", id:prcReportInstance.id)
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
        
            redirect(action:"edit", params:[id:prcReportInstance.id])
         
        }
        
        
      /**  prcReportInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'prcReport.label', default: 'PrcReport'), prcReportInstance.id])
                redirect prcReportInstance
            }
            '*' { respond prcReportInstance, [status: CREATED] }
        }**/
    }

    def edit = {
        
     def prcReportInstance = PrcReport.get(params.id)
        
          def prcReviewList
        def prcIssueList
       
       
        def canSub=false
        
        
        try{
            
          
         
            
          
          
             
            if(prcReportInstance.version > 0){
               
                def result= checkError(prcReportInstance)
                
                if(result){
                    result.each(){key,value->
                  
                        prcReportInstance.errors.rejectValue(key, null, value)
                    }
                }else{
                    
                    canSub=true
                }
              
            }
            
           
            
            return [prcReportInstance: prcReportInstance,   canSub:canSub ]
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
         
           return [prcReportInstance: prcReportInstance,   canSub:canSub ]
            
        }
        
        
       
    }
    
    
    
    

    @Transactional
    def update(PrcReport prcReportInstance) {
        
    
        
        if (prcReportInstance == null) {
            notFound()
            return
        }

        if (prcReportInstance.hasErrors()) {
            respond prcReportInstance.errors, view:'edit'
            return
        }

      
        
        
          
         prcReportService.saveReport(prcReportInstance, params, request)
         flash.message='PRC report ' + prcReportInstance.id + " has been updated."
            
         redirect(action:"edit", params:[id:prcReportInstance.id])
           
            
    }

    @Transactional
    def delete(PrcReport prcReportInstance) {

        if (prcReportInstance == null) {
            notFound()
            return
        }

        prcReportInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PrcReport.label', default: 'PrcReport'), prcReportInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'prcReport.label', default: 'PrcReport'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    static Map checkError(prcReportInstance) {
        
        
        def result = [:]
 
        if (!prcReportInstance?.diagnosis) {
            result.put("diagnosis", "The Diagnosis/Morphology  is a required field")
        }
         
        if (!prcReportInstance?.tissueCategory.code=='TUMOR') {
            result.put("autolysis", "The autolysis rating  is a required field")
        }
         
        if(prcReportInstance?.tissueCategory?.code=="TUMOR"){
           if (prcReportInstance?.tumorDimension == null)
            result.put("tumorDimension", "The greatest tumor dimension on slide is a required field")
             
        if (prcReportInstance?.pctTumorArea == null)
            result.put("pctTumorArea", "The percent of cross-sectional surface area composed of tumor focus is a required field")
         
        if (prcReportInstance?.pctTumorCellularity == null)
            result.put("pctTumorCellularity", "The percent of tumor cellularity by cell count of the entire slide is a required field")

        
       
        if (prcReportInstance?.pctNecroticTissue == null)
                result.put("pctNecroticTissue", "The percent of necrotic tissue by surface area of the entire slide is a required field")
       
        
        if (prcReportInstance?.pctViablTumor == null)
            result.put("pctViablTumor", "The percent viable tumor by surface area is a required field")
          
        if (prcReportInstance?.pctNecroticTumor == null)
            result.put("pctNecroticTumor", "The percent necrotic tumor by surface area is a required field")
             
        //if (bpvPrcPathReviewInstance?.pctViableNonTumor == null)
        //    result.put("pctViableNonTumor", "The percent viable non-tumor tissue by surface area is a required field")
        if (prcReportInstance?.pctViableNonTumor == null)
           result.put("pctViableNonTumor", "The percent tumor stroma by surface area is a required field")
        
             
        if (prcReportInstance?.pctNonCellular == null)
            result.put("pctNonCellular", "The percent non-cellular component by surface area is a required field")
            
        if (prcReportInstance?.hisTotal != 100.0)
            result.put("hisTotal", "Histologic Profile Total value should be 100%")
   
      
        }
        return result
    }
     
    
    
    def submit = {
        def prcReportInstance = PrcReport.get(params.id)
        def prcReviewList
        
        def errorMap=[:]
        def canSub=false
      
        try{
         
           
      
            def result= checkError(prcReportInstance)
            if(result){
                result.each(){key,value->
                    
                    prcReportInstance.errors.rejectValue(key, null, value)
                 
                }//each
                flash.message="failed to submit"
                 redirect(action:"edit", params:[id:prcReportInstance.id])    
                   
             
            }else{
                //prcReportService.submitReport(prcReportInstance)
                def username= session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                
                prcReportService.submitReport(prcReportInstance, username)
                flash.message='PRC report ' + prcReportInstance.id + " has been submitted."
                 
                redirect(action:"view", params:[id:prcReportInstance.id])    
                
                
            }
              
        }catch(Exception e){
            flash.message="Failed: " + e.toString()  
          
            redirect(action:"edit", params:[id:prcReportInstance.id])
         
            
        }
        
    }
    
    
     def view = {
       
        def prcReportInstance = PrcReport.get(params.id)
        
       
        
      
      
      
      
        
        return [prcReportInstance: prcReportInstance]
       
        
        
    }
    
     def startnew ={
        
        def prcReportInstance = PrcReport.get(params.id)
        
             
        try{
           
            prcReportService.startNew(prcReportInstance)
          
            
          
            redirect(action:"edit", params:[id:prcReportInstance.id])
           
            // redirect(action:"edit", params:[id:prcReportInstance.id])
        }catch(Exception e){
            flash.message="Failed: " + e.toString() 
           
            redirect(action:"view", params:[id:prcReportInstance.id])
         
        }
        
        
    }
    
    
    
     def caselist = {
       
        def study = session.study
           
        def caseList=[]
        //def count = CaseRecord.findAllByStudy(Study.findByCode(studyCode)).size()
        def count
       
        count = CaseRecord.countByStudy(study)
         
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        //def all = CaseRecord.list(params)
        def offset=0
        if(params.offset)
        offset = params.offset
        def all =CaseRecord.findAllByStudy(study, params)
       
        
        caseList=prcReportService.getPrcCaseMaps(all)
        
         return [caseList:caseList, caseRecordInstanceTotal: count]
        
    }

    
   
}
