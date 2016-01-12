package nci.bbrb.cdr.forms

import nci.bbrb.cdr.CDRBaseClass
import nci.bbrb.cdr.staticmembers.*
//import nci.bbrb.cdr.datarecords.vocab.*
import nci.bbrb.cdr.datarecords.CandidateRecord

class MedicationHistory extends CDRBaseClass{

    String medicationName
    Date dateofLastAdministration
    SourceType source
    CandidateRecord candidateRecord
    
    Date dateSubmitted
    String submittedBy
    
    static mapping = {
        table 'form_med_history'
        id generator:'sequence', params:[sequence:'form_med_history_pk' ]
    }
    
    
    static constraints = {
        medicationName(nullable:true, blank:true)
        dateofLastAdministration(nullable:true, blank:true)
        source(nullable:true, blank:true)
        candidateRecord(nullable:true, blank:true)
         dateSubmitted(blank:true,nullable:true)
         submittedBy(blank:true,nullable:true)
    }
    
    
    enum SourceType {
        S("Self Report"),
        M("Medical Record"),
        F("Family Report")
     
        
        final String value

        SourceType(String value) {
            this.value = value;
        }
        String toString(){
            value;
        }
        String getKey(){
            name()
        }
        static list() {
            [S,M,F]
        }
    }
}
