package nci.bbrb.cdr.util

import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.staticmembers.CaseAttachmentType
import nci.bbrb.cdr.staticmembers.Study
import nci.bbrb.cdr.staticmembers.BSS

class FileUpload {
    CaseRecord caseRecord
    String caseId
    String fileName
    String filePath
    String comments
    String uploadTime    
    BSS bss
    CaseAttachmentType category
    Study study
    //Boolean hideFromBss
   // Boolean dmUseOnly
    
     def static searchable = {
         only= ['id', 'category']
         category component: true
        
         root false
         
     }

    static constraints = {
        caseRecord(nullable:true, blank:true)
        caseId(nullable:true, blank:true)        
        fileName(nullable:true, blank:true)                        
        filePath(nullable:true, blank:true)
        comments(nullable:true, blank:true, widget:'textarea', maxSize:4000)
        uploadTime(nullable:true, blank:true)       
        bss(nullable:true, blank:true)
        category(nullable:true, blank:true)
        study(nullable:true, blank:true)
       // hideFromBss(nullable:true, blank:true)
        //dmUseOnly(nullable:true, blank:true)
       
    }
    
    static mapping = {    
        table 'file_upload'
        id generator:'sequence', params:[sequence:'file_upload_pk']
        sort id:"desc"  
    }
}
