package nci.bbrb.cdr.forms
import nci.bbrb.cdr.CDRBaseClass
//import nci.bbrb.cdr.datarecords.vocab.*
import nci.bbrb.cdr.datarecords.CandidateRecord

class CancerHistory extends CDRBaseClass{
    String  primaryTumorSite
    
    Date monthYearOfFirstDiagnosis
    String treatments
    
    Date monthYearOfLastTreatment
   // YesNo medicalRecordExist
    
    boolean treatmentSurgery=false
    boolean treatmentRadiation=false
    boolean treatmentChemotherapy=false
    boolean treatmentOther=false
    boolean  treatmentNo =false
    boolean treatmentUnknown=false
    
    String otherTreatment
    SourceType source   // Medical Record, Self-Report, Family Report
   CandidateRecord candidateRecord
    Date dateSubmitted
    String submittedBy
        
    static mapping = {
        table 'form_cancer_history'
        id generator:'sequence', params:[sequence:'form_cancer_history_pk' ]
    }
    
    
    static constraints = {
        primaryTumorSite(nullable:true, blank:true)
        monthYearOfFirstDiagnosis(nullable:true, blank:true)
        treatments(nullable:true, blank:true)
        monthYearOfLastTreatment(nullable:true, blank:true)
       // medicalRecordExist(nullable:true, blank:true)
        otherTreatment (nullable:true, blank:true) 
        source(nullable:true, blank:true)
        //primaryTumorSiteCvocab(nullable:true, blank:true)
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
