package nci.bbrb.cdr.forms
import nci.bbrb.cdr.CDRBaseClass
import nci.bbrb.cdr.datarecords.CandidateRecord


class HealthHistory extends CDRBaseClass  {
   SourceType source // Medical Record, Self-Report, Family Report
   YesNo historyOfCancer
  // YesNo histOtherDisease
   CandidateRecord candidateRecord
  // static hasMany = [cancerHistories:CancerHistory, generalMedicalHistories:GeneralMedicalHistory,medicationHistory:MedicationHistory]
  
    Date dateSubmitted
    String submittedBy
    
     static mapping = {
      table 'form_health_history'
      id generator:'sequence', params:[sequence:'form_health_history_pk']
    }
    static constraints = {
        candidateRecord(nullable:true, blank:true)
         source(nullable:true, blank:true)
         historyOfCancer(nullable:true, blank:true)
         //histOtherDisease(nullable:true, blank:true)
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
    
     enum YesNo {
        No("No"),
        Yes("Yes"),
        Unknown("Unknown")


        final String value;

        YesNo(String value) {
            this.value = value;
        }
        String toString(){
            value;
        }
        String getKey(){
            name()
        }
        static list() {
            [Yes, No, Unknown]
        }
    }
}
