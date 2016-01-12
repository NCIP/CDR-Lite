package nci.bbrb.cdr.forms
import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.PhotoRecord

class TissueGrossEvaluation extends DataRecordBaseClass {

    CaseRecord caseRecord
       
    String tissueReceived
    String tissueNotReceivedReason
    Date dateTimeArrived
    String nameReceived
    
    String transportPerformed
    String transportComments
    Double roomTemperature
    String roomTemperatureUnit
    Double roomHumidity
    String nameEvaluated
    Double resectionH
    Double resectionW
    Double resectionD
    Double resectionWeight
    String diseaseObserved
    String diseaseComments
    String diagnosis
    String photoTaken
    String reasonNoPhoto
    String inkUsed
    String inkType
    String excessReleased
    String noReleaseReason
    Double excessH
    Double excessW
    Double excessD
    Double areaPercentage
    Double contentPercentage
    String appearance
    String normalAdjReleased
    Double normalAdjH
    Double normalAdjW
    Double normalAdjD
    String timeTransferred
    /* 
     //these ids are not required as of 10/21/15
    String tissueGrossId1
    String tissueGrossId2
    String secTissueCollect
    Double secTisH
    Double secTisW
    Double secTisD
    // second tissue fields 23, 24, 25
    Double stAreaPercentage
    Double stContentPercentage
    String stAppearance
    
    */
    String dimNoMeetCriteriaReas
    String  dimenMeetCriteria
    String transportSOP
    Date dateSubmitted
    String submittedBy
    //pmh new for cdr_lite. not in the original tissue gross form in CDR
    String tissueBankId
    
    
    
    static hasMany = [photos:PhotoRecord]
    
    static fetchMode = [photos:'eager']
    
  
    
    
    static belongsTo = CaseRecord
    
  
    
    String toString(){"$caseRecord.caseId"}
    
    static constraints = {
        caseRecord(blank:false, nullable:false)
        tissueReceived(blank:true, nullable:true)
        tissueNotReceivedReason(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        dateTimeArrived(blank:true, nullable:true)
        nameReceived(blank:true, nullable:true)
        transportSOP(blank:true, nullable:true)
        transportPerformed(blank:true, nullable:true)
        transportComments(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        roomTemperature(blank:true, nullable:true)
        roomTemperatureUnit(blank:true, nullable:true)
        roomHumidity(blank:true, nullable:true)
        nameEvaluated(blank:true, nullable:true)
        resectionH(blank:true, nullable:true)
        resectionW(blank:true, nullable:true)
        resectionD(blank:true, nullable:true)
        resectionWeight(blank:true, nullable:true)
        diseaseObserved(blank:true, nullable:true)
        diseaseComments(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        diagnosis(blank:true, nullable:true)
        photoTaken(blank:true, nullable:true)
        reasonNoPhoto(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        inkUsed(blank:true, nullable:true)
        inkType(blank:true, nullable:true)
        excessReleased(blank:true, nullable:true)
        noReleaseReason(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        excessH(blank:true, nullable:true)
        excessW(blank:true, nullable:true)
        excessD(blank:true, nullable:true)
        areaPercentage(blank:true, nullable:true)
        contentPercentage(blank:true, nullable:true)
        appearance(blank:true, nullable:true)
        normalAdjReleased(blank:true, nullable:true)
        normalAdjH(blank:true, nullable:true)
        normalAdjW(blank:true, nullable:true)
        normalAdjD(blank:true, nullable:true)
        timeTransferred(blank:true, nullable:true)
       /*
        secTisH(blank:true, nullable:true)
        secTisW(blank:true, nullable:true)
        secTisD(blank:true, nullable:true)
        secTissueCollect(blank:true, nullable:true)
        stAreaPercentage(blank:true, nullable:true)
        stContentPercentage(blank:true, nullable:true)
        stAppearance(blank:true, nullable:true)
        tissueGrossId1(blank:true, nullable:true)
        tissueGrossId2(blank:true, nullable:true)
        */
        
        
        dimNoMeetCriteriaReas(blank:true, nullable:true)
        dimenMeetCriteria(blank:true, nullable:true)
        tissueBankId(blank:true, nullable:true)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        
     
    }
    
    static mapping = {
        table 'form_tissue_gross_evaluation'
        id generator:'sequence', params:[sequence:'form_tissue_grs_evaluation_pk']
        
      photos cascade: "all-delete-orphan"

    }
}
