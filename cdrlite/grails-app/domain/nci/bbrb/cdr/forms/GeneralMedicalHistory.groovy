package nci.bbrb.cdr.forms
import nci.bbrb.cdr.CDRBaseClass
//import nci.bbrb.cdr.datarecords.vocab.*
import nci.bbrb.cdr.datarecords.CandidateRecord

class GeneralMedicalHistory extends CDRBaseClass{
    String  diseaseName
    
    Date monthYearOfFirstDiagnosis
   
    YesNo treatment
    Date monthYearOfLastTreatment
    SourceType source   // Medical Record, Self-Report, Family Report
    CandidateRecord candidateRecord
    Date dateSubmitted
    String submittedBy
    
    static mapping = {
        table 'form_general_medical_history'
        id generator:'sequence', params:[sequence:'form_general_medcl_history_pk' ]
    }
    
    
    static constraints = {
        diseaseName(nullable:true, blank:true)
        monthYearOfFirstDiagnosis(nullable:true, blank:true)
        monthYearOfLastTreatment(nullable:true, blank:true)
        treatment(nullable:true, blank:true)
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

