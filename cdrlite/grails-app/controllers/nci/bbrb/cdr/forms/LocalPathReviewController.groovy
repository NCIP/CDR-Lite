package nci.bbrb.cdr.forms

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.datarecords.*

@Transactional
class LocalPathReviewController {
    
    def localPathReviewService

    def index() { }
    
    def upload = {
        def caseRecordInstance = CaseRecord.get(params.id)
        return [caseRecordInstance: caseRecordInstance]
    }
    
    def upload_save ={
        
        def caseRecordInstance = CaseRecord.get(params.id)
        def uploadedFile = request.getFile("filepath")
        def originalFilename = uploadedFile.originalFilename.toLowerCase()
        if (!uploadedFile.empty) {
            if (!originalFilename.endsWith('.pdf') &&
                !originalFilename.endsWith('.doc') &&
                !originalFilename.endsWith('.docx')) {
                
                caseRecordInstance.errors.reject("error", "You can only upload a pdf, doc or docx file type. Please upload the right file.")
                render(view: "upload", model: [caseRecordInstance:caseRecordInstance])
            } else {
                if (params.version) {
                    def version = params.version.toLong()
                    if (caseRecordInstance.version > version) {    
                        caseRecordInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'caseRecord.label', default: 'CaseRecord')] as Object[], "Another user has updated this CaseRecord while you were editing")
                        render(view: "upload", model: [caseRecordInstance:caseRecordInstance])
                        return
                    }
                }
                def username = session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
                localPathReviewService.upload(params, uploadedFile, username)
                flash.message = "${message(code: 'default.uploaded.message', args: ['Surgical Pathology Form' + ' for Case', caseRecordInstance.caseId])}"
                redirect(controller: 'caseRecord', action: "display", params: [id:caseRecordInstance.id])
            }
        } else {
            caseRecordInstance.errors.reject("error", "Please choose a file")
            render(view: "upload", model: [caseRecordInstance:caseRecordInstance])
        }
    }
   
    def download = {
        def caseRecordInstance = CaseRecord.get(params.id)
        def convertedFilePath = caseRecordInstance.finalSurgicalPath
        def file = new File(convertedFilePath)
        if (file.exists()) {
            def inputStream = new FileInputStream(file)
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=${file.getName()}")
            response.outputStream << inputStream //Performing a binary stream copy
            inputStream.close()
            response.outputStream.close()
        } else {
            flash.message = "File not found, please remove Final Surgical Pathology Report"
            redirect(controller: 'caseRecord', action: "display", params: [id:params.id])
        }
    }

    def remove = {
        localPathReviewService.remove(params)
        redirect(controller: 'caseRecord', action: "display", params: [id: params.id])
    }  
}
