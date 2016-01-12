/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package nci.bbrb.cdr


import grails.transaction.Transactional
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.util.AppSetting

@Transactional
class LocalPathReviewService {
    
    
    
    def upload(params, uploadedFile, username) {   
        try {
            
            def caseRecordInstance = CaseRecord.get(params.id)
            def originalFileName = uploadedFile.originalFilename.replace(' ', '_') //replace whitespace with underscores
            def strippedFileName = originalFileName.substring(0, originalFileName.lastIndexOf('.'))                    
            def fileExtension = originalFileName.substring(originalFileName.lastIndexOf('.') + 1, originalFileName.toString().size())                         
            def current_time = (new Date()).getTime()           
            def newFileName = strippedFileName + "-" + current_time + "." + fileExtension
            def dir_name = 'surgical_path_report'
            def pathUploads = AppSetting.findByCode('FILE_STORAGE')?.value + File.separator + caseRecordInstance.study.code + File.separator + caseRecordInstance.caseId + File.separator + dir_name
            File dir = new File(pathUploads)
            if (!dir.exists()) {
                dir.mkdirs()
            }
            uploadedFile.transferTo(new File(pathUploads, newFileName))
            caseRecordInstance.finalSurgicalPath = pathUploads + File.separator + newFileName
            caseRecordInstance.dateFspUploaded = new Date()
            caseRecordInstance.fspUploadedBy = username
            caseRecordInstance.save(failOnError: true)
        } catch (Exception e) {
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
    }
    
    def remove(params) {
        try {
            def caseRecordInstance = CaseRecord.get(params.id)
            def convertedFilePath = caseRecordInstance.finalSurgicalPath
            def file = new File(convertedFilePath)
            if (file.exists()) {
                if (!file.delete()) {
                    throw new IOException("Failed to delete the final surgical pathology report")
                }
            }
            caseRecordInstance.finalSurgicalPath = null
            caseRecordInstance.dateFspUploaded = null
            caseRecordInstance.fspUploadedBy = null
            caseRecordInstance.save(failOnError:true)
        } catch (Exception e) {
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
    }
	
}

