package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.prc.*

class SlideRecord extends DataRecordBaseClass{
    SpecimenRecord specimenRecord
    String slideId
    String caseId
    String createdBy
    
    static hasMany = [processEvents:ProcessingEvent]
    static hasOne = [imageRecord:ImageRecord, prcReport:PrcReport]

    String toString(){"$slideId"}
    
    static constraints = {
        specimenRecord(blank:false)
        slideId(unique:true)
        caseId(blank:true,nullable:true)
        imageRecord(blank:true,nullable:true)
        prcReport(blank:true,nullable:true)
    }
    
    static mapping = {
        table 'dr_slide'
        id generator:'sequence', params:[sequence:'dr_slide_pk']
    }
}
