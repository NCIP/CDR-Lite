package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.SlideRecord

class SlidePrep extends DataRecordBaseClass{
    
    String heTimeInOven
    String heTimeInOvenOs
    String heOvenTemp
    String heOvenTempOs
    String heDeParrafinMethod
    String heDeParrafinMethodOs
    String heStainMethod
    String heStainMethodOs
    String heClearingMethod
    String heClearingMethodOs
    String heCoverSlipping
    String heCoverSlippingOs
    String heEquipMaint
    String heEquipMaintOs
    String heComments
    CaseRecord caseRecord
    
    
    Date dateSubmitted
    String submittedBy
    
    static hasMany = [slideList:SlideRecord]
    
    static constraints = {
        heTimeInOven(blank:true,nullable:true)
        heTimeInOvenOs(blank:true,nullable:true)
        heOvenTemp(blank:true,nullable:true)
        heOvenTempOs(blank:true,nullable:true)
        heDeParrafinMethod(blank:true,nullable:true)
        heDeParrafinMethodOs(blank:true,nullable:true)
        heStainMethod(blank:true,nullable:true)
        heStainMethodOs(blank:true,nullable:true)
        heClearingMethod(blank:true,nullable:true)
        heClearingMethodOs(blank:true,nullable:true)
        heCoverSlipping(blank:true,nullable:true)
        heCoverSlippingOs(blank:true,nullable:true)
        heEquipMaint(blank:true,nullable:true)
        heEquipMaintOs(blank:true,nullable:true,widget:'textarea',maxSize:4000)
        heComments(blank:true,nullable:true,widget:'textarea',maxSize:4000)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        slideList(blank:true,nullable:true)
    }
    
    static mapping = {
         table 'form_slide_prep'
         id generator:'sequence', params:[sequence:'form_slide_prep_pk']
    }
}
