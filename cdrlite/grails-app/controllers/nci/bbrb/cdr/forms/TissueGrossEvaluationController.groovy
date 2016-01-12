package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.PhotoRecord
import java.text.SimpleDateFormat
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TissueGrossEvaluationController {
    def tissueGrossEvaluationService
    def accessPrivilegeService
    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueGrossEvaluation.list(params), model:[tissueGrossEvaluationInstanceCount: TissueGrossEvaluation.count()]
    }

    def show(TissueGrossEvaluation tissueGrossEvaluationInstance) {
        def canResume
        if(!accessPrivilegeService.hasPrivilege(tissueGrossEvaluationInstance?.caseRecord, session, 'show')){
            redirect(controller: "login", action: "denied")
            return
        }
        canResume=true
        
        [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance, canResume: canResume]
    }
    
   

    def create() {
        respond new TissueGrossEvaluation(params)
    }
    
   

    @Transactional
    
    //create->save->edit
    def save(TissueGrossEvaluation tissueGrossEvaluationInstance) {
        if (tissueGrossEvaluationInstance == null) {
            notFound()
            return
        }
        
        if(params.caseRecord.id){
           
            tissueGrossEvaluationInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
            // tissueGrossEvaluationInstance.tissueGrossId1=tissueGrossEvaluationInstance.caseRecord.caseId+"-TG1"
            // tissueGrossEvaluationInstance.tissueGrossId2=tissueGrossEvaluationInstance.caseRecord.caseId+"-TG2"
                
        }
       
        if (tissueGrossEvaluationInstance.hasErrors()) {
         
            render(view: "create", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance])
            return
        }
        
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        if(params.dateTimeArrived){
            tissueGrossEvaluationInstance.dateTimeArrived=df.parse(params.dateTimeArrived)
        }
       
        boolean successSaved = false
        
        try
        {
            
            successSaved = tissueGrossEvaluationInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            tissueGrossEvaluationInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
            render(view: "edit", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance])
            return
        }
        
       
        request.withFormat {           
             
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueGrossEvaluation.label', default: 'TissueGrossEvaluation Form for '), tissueGrossEvaluationInstance.caseRecord.caseId])
                redirect(action: "editWithValidation", id: tissueGrossEvaluationInstance.id)
            }
            
            
        }
    }
  
    def edit(TissueGrossEvaluation tissueGrossEvaluationInstance) {
        // respond tissueGrossEvaluationInstance
        
        if(!tissueGrossEvaluationInstance) {
            flash.message = "tissueGrossEvaluationInstance not found"
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(tissueGrossEvaluationInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            tissueGrossEvaluationInstance.submittedBy=null
            tissueGrossEvaluationInstance.dateSubmitted=null
            
            
            def canSubmit
            
            
            SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            if(params.dateTimeArrived){
                tissueGrossEvaluationInstance.dateTimeArrived=df.parse(params.dateTimeArrived)
            }
             
            def errorMap = checkError(tissueGrossEvaluationInstance)
            if (errorMap.size() == 0) {
                canSubmit = 'Yes'
            }
            
            //tissueGrossEvaluationInstance.clearErrors()
            errorMap.each() {key, value ->
                tissueGrossEvaluationInstance.errors.rejectValue(key,null, value)
            }
            
            def warningMap = getWarningMap(tissueGrossEvaluationInstance)
           
            return [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance, canSubmit: canSubmit,warningMap:warningMap]
        }
    }      

    def editWithValidation = {
        def tissueGrossEvaluationInstance = TissueGrossEvaluation.get(params.id)
        if(!tissueGrossEvaluationInstance) {
           
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueGrossEvaluation.label', default: 'TissueGrossEvaluation Form for '), tissueGrossEvaluationInstance.caseRecord.caseId])
            redirect(action: "list")
        } else {
            if(!accessPrivilegeService.hasPrivilege(tissueGrossEvaluationInstance?.caseRecord, session, 'edit')){
                redirect(controller: "login", action: "denied")
                return
            }
            if (tissueGrossEvaluationInstance.submittedBy != null) {
                tissueGrossEvaluationInstance.submittedBy=null
                tissueGrossEvaluationInstance.dateSubmitted=null
            }            
            
            def canSubmit
            
            
            SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
            if(params.dateTimeArrived){
                tissueGrossEvaluationInstance.dateTimeArrived=df.parse(params.dateTimeArrived)
            }
          
            def errorMap = checkError(tissueGrossEvaluationInstance)
            if (errorMap.size() == 0) {
                canSubmit = 'Yes'
            }
            errorMap.each() {key, value ->
                tissueGrossEvaluationInstance.errors.rejectValue(key,null, value)
            }
            def warningMap = getWarningMap(tissueGrossEvaluationInstance)
            
            render(view: "edit", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance, canSubmit: canSubmit,warningMap:warningMap])
            return
            
        }
    }


    @Transactional
    def update(TissueGrossEvaluation tissueGrossEvaluationInstance) {
      
        if (tissueGrossEvaluationInstance == null) {
            notFound()
            return
        }
       
        tissueGrossEvaluationInstance.properties = params
        
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        if(params.dateTimeArrived){
            tissueGrossEvaluationInstance.dateTimeArrived=df.parse(params.dateTimeArrived)
        }
        def errorMap = checkError(tissueGrossEvaluationInstance)
           
        errorMap.each() {key, value ->
            tissueGrossEvaluationInstance.errors.rejectValue(key,null, value)
        }

        // now remove all the photos flagged to be removed. I had to use this method to avoid staleObjectException
        def pl=[]
        pl +=tissueGrossEvaluationInstance.photos
        pl.each{
            if(it.rmFlg =='Y'){
                 
                tissueGrossEvaluationInstance.removeFromPhotos(it)                 
            }            
        }
        
        def warningMap = getWarningMap(tissueGrossEvaluationInstance)

        boolean successSaved = false
        try
        {
            successSaved = tissueGrossEvaluationInstance.save(flush: true)
        }catch(java.sql.BatchUpdateException se)
        {
            tissueGrossEvaluationInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
            render(view: "edit", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance,warningMap:warningMap])
            return
        }
        
        request.withFormat {
            if(!tissueGrossEvaluationInstance.hasErrors() && successSaved) {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'tissueGrossEvaluation.label', default: 'TissueGrossEvaluation Form for '), tissueGrossEvaluationInstance.caseRecord.caseId])                   
                    redirect(action: "editWithValidation", id: tissueGrossEvaluationInstance.id)
                }            
            }
            else {
                
                render(view: "edit", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance,warningMap:warningMap])
            }
        }
    }
    


    @Transactional
    def submit(TissueGrossEvaluation tissueGrossEvaluationInstance) {
        if (tissueGrossEvaluationInstance == null) {
            notFound()
            return
        }
        
        
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        if(params.dateTimeArrived){
            tissueGrossEvaluationInstance.dateTimeArrived=df.parse(params.dateTimeArrived)
        }
        if(params.version) {
            def version = params.version.toLong()
            if(tissueGrossEvaluationInstance.version > version) {
                    
                tissueGrossEvaluationInstance.errors.rejectValue("version",  "Another user has updated this form while you were editing")
               
                respond tissueGrossEvaluationInstance.errors, view:'edit'
                return
            }
        }
        // now remove all the photos flagged to be removed. I had to use this method to avoid staleObjectException
        def pl=[]
        pl +=tissueGrossEvaluationInstance.photos
        def photosTaken =tissueGrossEvaluationInstance.photoTaken
        
        
        
        pl.each{
            if(it.rmFlg =='Y' || photosTaken == 'No'){
                 
                tissueGrossEvaluationInstance.removeFromPhotos(it)                 
            }            
        }
       
        if (tissueGrossEvaluationInstance.hasErrors()) {
            redirect(action: "editWithValidation", id: tissueGrossEvaluationInstance.id)
            
        }
        else{
        
            tissueGrossEvaluationInstance.dateSubmitted = new Date()
            tissueGrossEvaluationInstance.submittedBy = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
            tissueGrossEvaluationInstance.save flush:true

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.submitted.message', args: [message(code: 'TissueGrossEvaluation.label', default: 'Tissue Gross Evaluation Form for '), tissueGrossEvaluationInstance.caseRecord.caseId])
                    redirect tissueGrossEvaluationInstance
                }
            '*'{ respond tissueGrossEvaluationInstance, [status: OK] }
            }
        }
    }

  

    def resumeEditing = {
        def tissueGrossEvaluationInstance = TissueGrossEvaluation.get(params.id)
        tissueGrossEvaluationInstance.dateSubmitted = null
        tissueGrossEvaluationInstance.submittedBy = null

        if(tissueGrossEvaluationInstance.save(flush: true)) {
            redirect(action: "edit", id: tissueGrossEvaluationInstance.id)
        } else {
            render(view: "show", model: [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance])
        }
    }
    
   
    @Transactional
    def delete(TissueGrossEvaluation tissueGrossEvaluationInstance) {

        if (tissueGrossEvaluationInstance == null) {
            notFound()
            return
        }

        tissueGrossEvaluationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueGrossEvaluation.label', default: 'TissueGrossEvaluation'), tissueGrossEvaluationInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueGrossEvaluation.label', default: 'TissueGrossEvaluation'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    
    def upload = {
        def tissueGrossEvaluationInstance = TissueGrossEvaluation.get(params.id)
        return [tissueGrossEvaluationInstance: tissueGrossEvaluationInstance]
    }
    
    def upload_save ={
        def tissueGrossEvaluationInstance = TissueGrossEvaluation.get(params.id)
        def uploadedFile = request.getFile("filepath")
        if (!uploadedFile.empty) {
            if (params.version) {
                def version = params.version.toLong()
                if (tissueGrossEvaluationInstance.version > version) {    
                    tissueGrossEvaluationInstance.errors.rejectValue("version", null, "Another user has updated this BpvTissueGrossEvaluation while you were editing")
                    render(view: "upload", model: [tissueGrossEvaluationInstance:tissueGrossEvaluationInstance])
                    return
                }
            }
            tissueGrossEvaluationService.upload(params, uploadedFile)
            flash.message = "${message(code: 'default.uploaded.message', args: [message(code: 'tissueGrossEvaluationInstance.label', default: 'Tissue photo for Case'), tissueGrossEvaluationInstance.caseRecord.caseId])}"
            //redirect(controller: 'tissueGrossEvaluation', action: "edit", params: [id:tissueGrossEvaluationInstance.id])
            redirect(action: "editWithValidation", id: tissueGrossEvaluationInstance.id)
        } else {
            // pmh: I chose photoTaken field just for a placeholder. no other importance
            tissueGrossEvaluationInstance.errors.rejectValue("photoTaken", null,"Please choose a valid file")
            render(view: "upload", model: [tissueGrossEvaluationInstance:tissueGrossEvaluationInstance])
        }
    }
   
    def download = {
        def photoRecordInstance = PhotoRecord.get(params.photoId)
        def path = photoRecordInstance.filePath + File.separator + photoRecordInstance.fileName
        def file = new File(path)
        if (file.exists()) {
            def inputStream = new FileInputStream(file)
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${file.getName()}")
            response.outputStream << inputStream //Performing a binary stream copy
            inputStream.close()
            response.outputStream.close()
        } else {
            flash.message = "File not found, please remove: " + file.getName()
            //redirect(controller: 'tissueGrossEvaluation', action: "edit", params: [id:params.id])
            redirect(action: "editWithValidation", id: tissueGrossEvaluationInstance.id)
            
        }
    }

    def remove = {
        
        
        tissueGrossEvaluationService.remove(params)
        
        def tissueGrossEvaluationInstance = TissueGrossEvaluation.get(params.id)
        
        render(template: "photoTable", bean: tissueGrossEvaluationInstance, var: "tissueGrossEvaluationInstance") 
    } 
    
    
    Map checkError(tissueGrossEvaluationInstance) {
        def errorMap = [:]
       
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        if (tissueGrossEvaluationInstance.tissueReceived != null) {
            if (tissueGrossEvaluationInstance.tissueReceived == 'Yes') {
                if (!tissueGrossEvaluationInstance.dateTimeArrived) {
                    errorMap.put('dateTimeArrived', 'Question #1 Please enter date and time of arrival')
                }
              
                if (!tissueGrossEvaluationInstance.nameReceived) {
                    errorMap.put('nameReceived', 'Question #2 Please enter person who recieved specimen in gross room')
                }
                if (!tissueGrossEvaluationInstance.transportSOP) {
                    errorMap.put('transportSOP', 'Question #3 Please enter SOP governing transport of tissue')
                }
                if (!tissueGrossEvaluationInstance.roomTemperature) {
                    errorMap.put('roomTemperature', 'Question #5 Please enter room temperature')
                }
                
                if (!tissueGrossEvaluationInstance.roomHumidity) {
                    errorMap.put('roomHumidity', 'Question #6 Please enter room humidity')
                }               
                
                if (tissueGrossEvaluationInstance.transportPerformed != 'Yes' && tissueGrossEvaluationInstance.transportPerformed != 'No') {
                    errorMap.put('transportPerformed', 'Please select an option for question #4')
                }
                if (tissueGrossEvaluationInstance.transportPerformed == 'No' && !tissueGrossEvaluationInstance.transportComments) {
                    errorMap.put('transportComments', 'Question #4, tissue transport comments cannot be blank')
                }   
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && tissueGrossEvaluationInstance.roomTemperature == null) {
                    errorMap.put('roomTemperature', 'Question #5 Please enter room temperature')
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && tissueGrossEvaluationInstance.roomHumidity == null) {
                    errorMap.put('roomHumidity', 'Question #6 Please enter room humidity')
                }
                if (!tissueGrossEvaluationInstance.nameEvaluated) {
                    errorMap.put('nameEvaluated', 'Question #7 Please enter who performed gross evaluation of resected tissue')
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes') {
                    if (tissueGrossEvaluationInstance.resectionH <= 0) {
                        errorMap.put('resectionH', 'Question #8 Please specify the height of resected tissue')
                    }
                    if (tissueGrossEvaluationInstance.resectionW <= 0) {
                        errorMap.put('resectionW', 'Question #8 Please specify the width of resected tissue')
                    }
                    if (tissueGrossEvaluationInstance.resectionD <= 0) {
                        errorMap.put('resectionD', 'Question #8 Please specify the depth of resected tissue')
                    } 
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && tissueGrossEvaluationInstance.resectionWeight <= 0) {
                    errorMap.put('resectionWeight', 'Question #9 Please specify the weight of resection')
                }
                if (tissueGrossEvaluationInstance.diseaseObserved != 'Yes' && tissueGrossEvaluationInstance.diseaseObserved != 'No') {
                    errorMap.put('diseaseObserved', 'Question #10 Please select if Gross appearance of disease was observed')
                }
                if (!tissueGrossEvaluationInstance.diagnosis) {
                    errorMap.put('diagnosis', 'Question #12 Please enter gross diagnosis of resected tissue')
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && tissueGrossEvaluationInstance.photoTaken != 'Yes' && tissueGrossEvaluationInstance.photoTaken != 'No') {
                    errorMap.put('photoTaken', 'Question #13 Please enter if Photograph(s) of tissue was/were taken ')
                }
                
                if (tissueGrossEvaluationInstance.photoTaken == 'Yes' && !tissueGrossEvaluationInstance.photos) {
                    
                    errorMap.put('photos', 'Please upload the tissue photograph(s)')
                }
                
              
               
                if (tissueGrossEvaluationInstance.photoTaken == 'No' && !tissueGrossEvaluationInstance.reasonNoPhoto) {
                    errorMap.put('reasonNoPhoto', 'Please explain why no photograph was taken')
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && tissueGrossEvaluationInstance.inkUsed != 'Yes' && tissueGrossEvaluationInstance.inkUsed != 'No') {
                    errorMap.put('inkUsed', 'Question #14 Please  enter Pathology ink used')
                }
                if (tissueGrossEvaluationInstance.inkUsed == 'Yes' && !tissueGrossEvaluationInstance.inkType) {
                    errorMap.put('inkType', 'Please specify the type of ink')
                }
                if (tissueGrossEvaluationInstance.excessReleased != 'Yes' && tissueGrossEvaluationInstance.excessReleased != 'No') {
                    errorMap.put('excessReleased', 'Question #15 Please enter if tumor tissue was released to the tissue bank')
                }
                if (tissueGrossEvaluationInstance.excessReleased == 'No' && !tissueGrossEvaluationInstance.noReleaseReason) {
                    errorMap.put('noReleaseReason', 'Please specify reason why no tumor tissue was released')
                }
                
                                   
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes'  && !tissueGrossEvaluationInstance.dimenMeetCriteria) {
                    errorMap.put('dimenMeetCriteria', 'Please specify if dimension of each experimental piece meet criteria')
                }
                    
                if (tissueGrossEvaluationInstance.excessReleased == 'Yes' && !tissueGrossEvaluationInstance.tissueBankId) {
                    errorMap.put('tissueBankId', 'Question #16 Please enter Tissue Bank ID')
                }

                if (tissueGrossEvaluationInstance.excessReleased == 'Yes') {
                    if (tissueGrossEvaluationInstance.excessH <= 0) {
                        errorMap.put('excessH', 'Please specify the height of tumor tissue')
                    }
                    if (tissueGrossEvaluationInstance.excessW <= 0) {
                        errorMap.put('excessW', 'Please specify the width of tumor tissue')
                    }
                    if (tissueGrossEvaluationInstance.excessD <= 0) {
                        errorMap.put('excessD', 'Please specify the depth of tumor tissue')
                    }
                    if (tissueGrossEvaluationInstance.areaPercentage == null) {
                        errorMap.put('areaPercentage', 'Question #18 Please enter percentage of gross area of necrosis of material sent to tissue bank')
                    }
                    if (tissueGrossEvaluationInstance.contentPercentage == null) {
                        errorMap.put('contentPercentage', 'Question #19 Please enter percentage of tumor content of material sent to tissue bank')
                    }
                    if (!tissueGrossEvaluationInstance.appearance) {
                        errorMap.put('appearance', 'Question #20 Please enter gross appearance of material sent to tissue bank')
                    }
                    if (!tissueGrossEvaluationInstance.timeTransferred) {
                        errorMap.put('timeTransferred', 'Question #29 Please specify time specimen was transferred from the pathology gross room to the tissue bank')
                    }                 
                   
                }
                
                
                if (tissueGrossEvaluationInstance.normalAdjReleased == 'Yes') {
                    if (tissueGrossEvaluationInstance.normalAdjH <= 0) {
                        errorMap.put('normalAdjH', 'Please specify the height of Normal adjacent tumor tissue')
                    }
                    if (tissueGrossEvaluationInstance.normalAdjW <= 0) {
                        errorMap.put('normalAdjW', 'Please specify the width of Normal adjacent tumor tissue')
                    }
                    if (tissueGrossEvaluationInstance.normalAdjD <= 0) {
                        errorMap.put('normalAdjD', 'Please specify the depth of Normal adjacent tumor tissue')
                    }
                }
            } else {
                if (!tissueGrossEvaluationInstance.tissueNotReceivedReason) {
                    errorMap.put('tissueNotReceivedReason', 'Please explain why tissue was not received in Gross Room from OR')
                }         
            }
        } else {
            errorMap.put('tissueReceived', 'Please choose an option to state whether Tissue was received in Gross Room from OR or not')
        }    
        return errorMap
    }
    
    Map getWarningMap(tissueGrossEvaluationInstance) {
        Map warningMap = [:]
        if (tissueGrossEvaluationInstance.tissueReceived == 'Yes') {        
            if (tissueGrossEvaluationInstance.excessReleased == 'Yes') {
                
                if ((tissueGrossEvaluationInstance.areaPercentage != null)&&(tissueGrossEvaluationInstance.areaPercentage > 20))
                {   
                    warningMap.put('areaPercentage', 'The value of Question #18 is greater than 20 %.')
                }
                if ((tissueGrossEvaluationInstance.contentPercentage != null)&&(tissueGrossEvaluationInstance.contentPercentage < 50))
                {   
                    warningMap.put('contentPercentage', 'The value of Question #19 is less than 50 %.')
                }
            }
            
            
            if (tissueGrossEvaluationInstance.normalAdjReleased == 'Yes')
            {
                if ((tissueGrossEvaluationInstance.normalAdjH > 0)&&(tissueGrossEvaluationInstance.normalAdjH < 1)) 
                {
                    warningMap.put('normalAdjH', 'The value of the height of Normal adjacent tumor tissue is less than 1 cm.')
                }
                if ((tissueGrossEvaluationInstance.normalAdjW > 0)&&(tissueGrossEvaluationInstance.normalAdjW < 1))
                {   
                    warningMap.put('normalAdjW', 'The value of the width of Normal adjacent tumor tissue is less than 1 cm.')
                }
                if ((tissueGrossEvaluationInstance.normalAdjD > 0)&&(tissueGrossEvaluationInstance.normalAdjD < 1))
                {   
                    warningMap.put('normalAdjD', 'The value of the depth of Normal adjacent tumor tissue is less than 1 cm.')
                }
            }
        }   
        return warningMap
    }
    
}
