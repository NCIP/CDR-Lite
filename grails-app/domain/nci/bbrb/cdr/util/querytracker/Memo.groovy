package nci.bbrb.cdr.util.querytracker

import nci.bbrb.cdr.CDRBaseClass
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.util.FileUpload

class Memo extends CDRBaseClass {
    String memoNumber
    String title
    String sop
    Date startDate
    Date endDate
    Boolean deviationFlag
    Date dateSubmitted
    String submittedBy
    FileUpload file
    Study study
    Boolean submitted=false
    
    
     static hasMany = [bssList:BSS]
    
    static mapping = {
        table 'memo'
        id generator:'sequence', params:[sequence:'memo_pk']
        sort startDate:'desc'
       
    } 

    static constraints = {
        memoNumber(unique:true,blank:false,nullable:false)
        title(blank:true,nullable:true, maxSize:4000)
        startDate(blank:true,nullable:true)
        endDate(blank:true,nullable:true)
        deviationFlag(blank:true,nullable:true)
        bssList(blank:true,nullable:true)
        dateSubmitted(blank:true,nullable:true)
        submittedBy(blank:true,nullable:true)
        file(blank:true,nullable:true)
        study(blank:true,nullable:true)
        sop(blank:true,nullable:true)
    }
}
