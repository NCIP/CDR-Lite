package nci.bbrb.cdr.util
import groovy.xml.MarkupBuilder

import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.staticmembers.ActivityType
import nci.bbrb.cdr.staticmembers.Study
import nci.bbrb.cdr.staticmembers.CaseAttachmentType
import grails.util.GrailsUtil


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FileUploadController {
    def hubIdGenService
    def activityEventService
   // static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
       // params.max = Math.min(max ?: 10, 100)
       // respond FileUpload.list(params), model:[fileUploadInstanceCount: FileUpload.count()]
       redirect(action: "list")
    }

        
    def list = {
        //params.each{key,value->
        //println "in fileupload list key: ${key}   value:${value}"
        //}
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.offset) params.offset = 0
        else params.offset = params.int('offset')
        
        //def studyP = Study.findByCode(session?.study?.code)
        
        if (!params.sort) params.sort = "uploadTime"
        if (!params.order) params.order = "desc"
        
        def fileUploadInstanceList = FileUpload.findAllByUploadTimeIsNotNull()
         
        if (params.sort == "uploadTime")
        {
            if (params.order.equalsIgnoreCase('asc')) fileUploadInstanceList.sort({a,b-> transFormatDate(a.uploadTime).compareTo(transFormatDate(b.uploadTime))})
            else fileUploadInstanceList.sort({a,b-> transFormatDate(b.uploadTime).compareTo(transFormatDate(a.uploadTime))})
        }
        
        
        [fileUploadInstanceList: fileUploadInstanceList, fileUploadInstanceTotal: fileUploadInstanceList.size(), isTest:false]
    }
    
    def show = {
        def fileUploadInstance = FileUpload.get(params.id)
        
        def caseRecord = fileUploadInstance.caseRecord
        
        if(fileUploadInstance && !fileUploadInstance.bssCode.equals(session?.org?.code) && !(session?.org?.code.equals('OBBR') && session.DM==true)){
            redirect(controller: "login", action: "denied")
            return
        }
        
        if (caseRecord && !accessPrivilegeService.checkAccessPrivUploads(caseRecord, session)) {
            redirect(controller: "login", action: "denied")
            return
        }
        if (!fileUploadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), params.id])}"
            redirect(action: "list")
        }
        else {
            [fileUploadInstance: fileUploadInstance]
        }
    }

    
    def create = {
        
        def fileUploadInstance = new FileUpload()
        fileUploadInstance.properties = params
        
        // hide the case recall categories for general file uploads
        def gencatList=CaseAttachmentType.executeQuery("from CaseAttachmentType where (name is null or name not like 'Case Recall%') and code != 'OTHER' order by name")
        gencatList.add(CaseAttachmentType.findByCode('OTHER'))
        if (params.catype){
            gencatList.clear()
            gencatList.add(CaseAttachmentType.findByCode('BLOODFORMAPPREMAIL'))
            return [fileUploadInstance: fileUploadInstance,gencatList:gencatList, bloodFormId:params.bloodFormId]
        }
        return [fileUploadInstance: fileUploadInstance,gencatList:gencatList]      
    }

    
    
    @Transactional
    def save(FileUpload fileUploadInstance) {

        def gencatList=CaseAttachmentType.executeQuery("from CaseAttachmentType where (name is null or name not like 'Case Recall%') and code != 'OTHER' order by name")
        gencatList.add(CaseAttachmentType.findByCode('OTHER'))
        //handle incoming file
        def uploadedFile = request.getFile('nameOfFile')    
        //if(uploadedFile){
         //   println " file not empty"
       //}
       
        if(params.caseRecord.id){
                fileUploadInstance.caseRecord=CaseRecord.get(params.caseRecord.id)
                fileUploadInstance.caseId=CaseRecord.get(params.caseRecord.id)?.caseId
            }
        def result= checkError(uploadedFile, fileUploadInstance)
            
        if(result){
            result.each{                
                fileUploadInstance.errors.reject(it, it)                
            }
            
            render(view: "create", model: [fileUploadInstance: fileUploadInstance,gencatList:gencatList])
            return            
        }
        
        //if (fileUploadInstance.save(flush: true)) {
        if (uploadedFile && fileUploadInstance) {
            
            def originalFileName = uploadedFile.originalFilename.replace(' ', '_') //replace whitespace with underscores
            def strippedFileName = originalFileName.substring(0,originalFileName.lastIndexOf('.'))                    
            def fileExtension = originalFileName.substring(originalFileName.lastIndexOf('.') + 1, originalFileName.toString().size())       
            def fileKey = hubIdGenService.genFilenameKey() //get an 8 character alpha numeric and append to filename. replaces former lengthy time in ms.
            def newFileName = strippedFileName + "-" + fileKey + "." + fileExtension
            
            def pathUploads
            def pathUploadsAttachments
           
                        
            // determine the study code.. it is BPS for now
            def studyCode 
            if(session.study){
                studyCode=session.study?.code
            }
            else{
               
                studyCode=fileUploadInstance.study
               
            }
            //println studyCode+" is study code"
            
            //path depends upon if it is a CASE specific upload or general upload
            if(fileUploadInstance.caseRecord){
                pathUploads = File.separator + 'var' + File.separator + 'storage' + File.separator + 'cdr-filestore' + File.separator + studyCode
                pathUploadsAttachments = pathUploads + File.separator + fileUploadInstance.caseRecord.caseId + File.separator + 'attachments'
            }
            else{
                pathUploads = File.separator + 'var' + File.separator + 'storage' + File.separator + 'cdr-filestore' + File.separator + session.org?.code
                pathUploadsAttachments = pathUploads + File.separator + 'attachments'
            }
            
           
            File dir = new File(pathUploadsAttachments)
            println 'CCC DD path=' + dir.getAbsolutePath()
            if (!dir.exists()) {
                if (!dir.mkdirs())
                {
                    String m = 'Error: File uploading Fail. System cannot create this directory \''+pathUploadsAttachments+'\'. Ask to the system administrator.'
                    println m
                    flash.message = m
                    fileUploadInstance.caseRecord.index()
                    redirect(controller: 'caseRecord', action: "show", params: [id:fileUploadInstance.caseRecord.id])
                    return
                }
            }
            uploadedFile.transferTo( new File(pathUploadsAttachments, newFileName) )
                                                                       
            fileUploadInstance.filePath = pathUploadsAttachments
            fileUploadInstance.fileName = newFileName
            fileUploadInstance.uploadTime = new Date().getDateTimeString()              
           
            
            fileUploadInstance.save (flush:true)
            
            if (!fileUploadInstance.save()) {
                fileUploadInstance.errors.each {
                    println it
                }
            }
            
            //sendMailService.sendFileUploadEventEmail(fileUploadInstance)
            def activityType = ActivityType.findByCode("FILEUPLOAD")
            def caseId = fileUploadInstance.caseId
            def study = fileUploadInstance.study
            //def bss =fileUploadInstance.bss.code
            def bss =fileUploadInstance?.caseRecord?.bss?.code
            def fname=fileUploadInstance.fileName
            def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
            
            activityEventService.createEvent(activityType, caseId, study, bss, '', username,fname , null)
            /*
            if(fileUploadInstance.category?.code=='ENCODE'){
            def fileList = FileUpload.findAllByCaseRecordAndCategory(fileUploadInstance.caseRecord, CaseAttachmentType.findByCode("ENCODE")) 
            if(fileList.size()==1){
            def env = "production".equalsIgnoreCase(GrailsUtil.environment) ? "" : " [${GrailsUtil.environment}]"      
        
            def sub="CDR Alert:$env Encode file uploaded"
            def bodytext = "Parent Case ID: ${fileUploadInstance.caseRecord.caseId}"
            def emailTo = AppSetting.findByCode('ENCODE_FILE_UPLOAD_DISTRO')?.bigValue
         
            sendMailService.sendAppRequestEmail(sub, bodytext,emailTo)
            }
            }
             */
            
            flash.message = "${message(code: 'default.uploaded.message', args: [message(code: 'fileUpload.label', default: 'File'), fileUploadInstance.fileName])}"
            if(fileUploadInstance.caseRecord){
                /*
                if (params.bloodFormId) {
                redirect(controller: 'bpvBloodForm', action: "edit", params: [id:params.bloodFormId])
                return
                }
                 */
                fileUploadInstance.caseRecord.index()
                redirect(controller: 'caseRecord', action: "show", params: [id:fileUploadInstance.caseRecord.id])
            }
            else{
                //redirect(controller: 'home', action: "more")
                redirect(action: "list")
            }
            
        }                                                               
        else {
            
            render(view: "create", model: [fileUploadInstance: fileUploadInstance,gencatList:gencatList])
        }
    }

      
    def edit = {
        def fileUploadInstance = FileUpload.get(params.id)
        // hide the case recall categories for general file uploads
        def gencatList=CaseAttachmentType.executeQuery("from CaseAttachmentType where (name is null or name not like 'Case Recall%') and code != 'OTHER' order by name")
        gencatList.add(CaseAttachmentType.findByCode('OTHER'))
        
        /*
        if(fileUploadInstance && !fileUploadInstance.bssCode.equals(session?.org?.code) && !(session?.org?.code.equals('OBBR') && session.DM==true)){
            redirect(controller: "login", action: "denied")
            return
        }
        */
        def editPage='Yes'
        if (!fileUploadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [fileUploadInstance: fileUploadInstance,gencatList:gencatList,editPage:editPage]
        }
    }

    
    @Transactional
    def update (FileUpload fileUploadInstance){
        
    def gencatList=CaseAttachmentType.executeQuery("from CaseAttachmentType where (name is null or name not like 'Case Recall%') and code != 'OTHER' order by name")
        gencatList.add(CaseAttachmentType.findByCode('OTHER'))
        
        def caseRecord = fileUploadInstance.caseRecord
        fileUploadInstance.properties = params
        //if(params.category.id.equals('null')){
        // fileUploadInstance.errors.reject("category", "Please enter category")
        // println "error category"
        // }
             println  fileUploadInstance.category.id  
        if (fileUploadInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (fileUploadInstance.version > version) {
                    
                    fileUploadInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'fileUpload.label', default: 'FileUpload')] as Object[], "Another user has updated this FileUpload while you were editing")
                    render(view: "edit", model: [fileUploadInstance: fileUploadInstance,gencatList:gencatList])
                    return
                }
                
                
            }
            
            fileUploadInstance.save(flush: true)
            if (!fileUploadInstance.hasErrors() && fileUploadInstance.save(flush: true)) {
                /*
                if(oldType?.code != 'ENCODE' && fileUploadInstance.category?.code=='ENCODE'){
                    def fileList = FileUpload.findAllByCaseRecordAndCategory(fileUploadInstance.caseRecord, CaseAttachmentType.findByCode("ENCODE")) 
                    if(fileList.size()==1){
                        def env = "production".equalsIgnoreCase(GrailsUtil.environment) ? "" : " [${GrailsUtil.environment}]"      
        
                        def sub="CDR Alert:$env Encode file uploaded"
                        def bodytext = "Parent Case ID: ${fileUploadInstance.caseRecord.caseId}"
                        def emailTo = AppSetting.findByCode('ENCODE_FILE_UPLOAD_DISTRO')?.bigValue
         
                        sendMailService.sendAppRequestEmail(sub, bodytext,emailTo)
                    }
                }
                */
                
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), fileUploadInstance.id])}"
                
                if(caseRecord){
                    caseRecord.index()
                    redirect(controller: 'caseRecord', action: "display", params: [id:caseRecord.id])
                }
                else{
                    //redirect(controller: 'home', action: "more")
                    redirect(action: "show", id: fileUploadInstance.id)
                }
                
            }
            else {
               
                render(view: "edit", model: [fileUploadInstance: fileUploadInstance,gencatList:gencatList])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), params.id])}"
            redirect(action: "list")
        }
    }

    @Transactional
    def delete(FileUpload fileUploadInstance) {

        if (fileUploadInstance == null) {
            notFound()
            return
        }
        def caseRecord = fileUploadInstance.caseRecord
        
        
        def convertedFilePath = fileUploadInstance.filePath + File.separator + fileUploadInstance.fileName
            def file = new File(convertedFilePath)
            def parentFile = file.getParentFile()
            try {
                if (file.exists()) {
                    if (!file.delete()) {
                        throw new IOException("Failed to delete the file")
                    }
                }
                fileUploadInstance.delete(flush: true)
                while ((caseRecord)&&(parentFile?.exists())&&(parentFile?.isDirectory())) 
                {
                    File[] fl = parentFile.listFiles()
                    if (fl.length == 0)
                    {
                        parentFile.delete()
                        if (parentFile.getName().equals(caseRecord.caseId)) break
                        parentFile = parentFile.getParentFile()
                    }
                    else break
                }
            } catch (Exception e) {
                e.printStackTrace()
                throw new RuntimeException(e.toString())
            }
              
        println "pmh in delete"
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FileUpload.label', default: 'FileUpload'), fileUploadInstance.id])
                //redirect action:"index"
                 redirect(controller: 'caseRecord', action: "show", params: [id:fileUploadInstance.caseRecord.id])
				
            }
           
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def download (FileUpload fileUploadInstance){
        //def fileUploadInstance = FileUpload.get(params.id)
        if (!fileUploadInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'fileUpload.label', default: 'FileUpload'), params.id])}"
            redirect(action: "list")
        }
        else {  
          
         
                def convertedFilePath = fileUploadInstance.filePath +"/"+fileUploadInstance.fileName
                def file = new File(convertedFilePath)
                if (file.exists()) {
                    def inputStream = new FileInputStream(file)
                    response.setContentType("application/octet-stream")
                    response.setHeader("Content-disposition", "attachment;filename=${file.getName()}")
                    response.outputStream << inputStream // Performing a binary stream copy
                    inputStream.close()
                    response.outputStream.close()
                } else {
                    flash.message = "File not found, please remove: " + file.getName()
                    //redirect(controller: 'caseRecord', action: "display", params: [id:fileUploadInstance.caseRecord.id])
                    //In case there is no caseRecord for old data
                    redirect(controller: 'caseRecord', action: "display", params: [id:CaseRecord.findByCaseId(fileUploadInstance.caseId).id])
                }
            
        }
    }
    
    static List checkError(uploadedFile, fileUploadInstance){
        def result = []
        
        if(fileUploadInstance.caseRecord){
            def caseId = fileUploadInstance.caseId
            if(!caseId){
                result.add("Case Id is a required field.")
            } 
            if(!fileUploadInstance.category?.id){
                result.add("Category is a required field.")
            }  
        }
        
        if (uploadedFile?.empty) {
            
            result.add("File can't be empty. Please choose a file.")             
        }
        else {
        
            def originalFileName = uploadedFile?.originalFilename?.toLowerCase()
            //            println "uploadedFile original name" + originalFileName
        
            // Custom validation                  
            if (originalFileName == null)  {      
                
                result.add("File can't be empty. Please choose a file.")
            }
            else if ( (! originalFileName.toString().endsWith(".pdf")) &&
                (! originalFileName.toString().endsWith(".zip")) &&
                (! originalFileName.toString().endsWith(".xls")) &&
                (! originalFileName.toString().endsWith(".xlsx")) &&
                (! originalFileName.toString().endsWith(".csv")) &&
                (! originalFileName.toString().endsWith(".doc")) &&
                (! originalFileName.toString().endsWith(".docx"))) {
                      
              
                result.add("You can only upload a pdf, zip, xls, xlsx, csv, doc or docx file type.  Please choose the right file to upload.")               
            }          
          
        }
        //println("result size:" + result.size())
        return result
        
    }
    private String transFormatDate(String dDate)
    {
        return transFormatDate(dDate, true)
    }
    private String transFormatDate(String dDate, boolean isForSort)
    {
        //"6/3/13 10:50:22 AM"
        String format1 = "M/d/yy hh:mm:ss a"
        String format2 = "yyyyMMddHHmmss"
        String format3 = "yyyy-MMM-d hh:mm:ss a"
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(format1)
        String format
        Date date
        int n = 0
        while(true)
        {
            if (n == 0) format = format1
            else if (n == 1) format = format2
            else if (n == 2) format = format3
            else throw new Exception("Unparable date :" + dDate )
            try
            {
                sdf = new java.text.SimpleDateFormat(format)
                date = sdf.parse(dDate) 
            }
            catch(Exception)
            {
                date = null
            }
            if (date) break;
            n++
        }
               
        if (isForSort) format = format2
        else format = format1
        java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat(format)
	String dateS = sdf2.format(date)
        //println 'a=' + dDate + ', b=' + dateS + ', isForSort=' + isForSort + ', n=' + n
        return dateS
    }
}
