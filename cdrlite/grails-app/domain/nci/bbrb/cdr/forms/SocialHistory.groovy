package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.CandidateRecord


class SocialHistory extends DataRecordBaseClass{
    
    CandidateRecord candidateRecord
    String alcoholConsum
    String tobaccoSmHist
    String smokeAgeStart
    String numYrsAlcCon
    String smokeYears
    String smokePackWeek
    String yrSinceLastSmoke
    String numPackYearsSm
    String secHandSmHist1
    String secHandSmHist2
    String secHandSmHist3
    
    Date dateSubmitted
    String submittedBy
    String comments
    
    
    //static belongsTo = CandidateRecord

    static constraints = {
        candidateRecord(nullable:true, blank:true)
        alcoholConsum(nullable:true, blank:true)
        numYrsAlcCon(nullable:true, blank:true)
        tobaccoSmHist(nullable:true, blank:true)
        smokeAgeStart(nullable:true, blank:true)
        smokeYears(blank:true, nullable:true)
        smokePackWeek(blank:true, nullable:true)
        yrSinceLastSmoke(blank:true, nullable:true)
        numPackYearsSm(blank:true, nullable:true)
        secHandSmHist1(blank:true, nullable:true)
        secHandSmHist2(blank:true, nullable:true)
        secHandSmHist3(blank:true, nullable:true)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        
        
        comments(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        
    }
    
    static mapping = {
        table 'form_social_history'
        id generator:'sequence', params:[sequence:'form_social_history_pk']
    }
}
