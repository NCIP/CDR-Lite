package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.CandidateRecord

class ConsentVerification extends DataRecordBaseClass{

    CandidateRecord candidateRecord
    String protocolSiteNum
    String consentor //person obtaining consent/approaching candidate
    ConsentorRelationship consentorRelationship
    String otherConsentRelation
    //4
    String isEligible
    String consentObtained
    Date dateConsented
    String meetAge
    Date dateWitnessed
    Date dateVerified
    String institutionICDVersion
    Date dateIRBApproved  // 
    Date dateIRBExpires
    String willingForOtherStudy
    String specifiedLimitations
    String comments
    Date dateSubmitted
    String submittedBy
    
    static constraints = {
        candidateRecord(nullable:false, blank:false, unique:true)
        protocolSiteNum(nullable:true, blank:true)
        consentor(nullable:true, blank:true)          
        consentorRelationship(nullable:true, blank:true)        
        otherConsentRelation(nullable:true, blank:true)
        isEligible(nullable:true, blank:true)
        consentObtained(nullable:true, blank:true)
        dateConsented(nullable:true, blank:true)
        meetAge(blank:true, nullable:true)
        dateWitnessed(blank:true, nullable:true)
        dateVerified(blank:true, nullable:true)
        institutionICDVersion(nullable:true, blank:true)
        dateIRBApproved(nullable:true, blank:true)
        dateIRBExpires(nullable:true, blank:true)
        willingForOtherStudy(blank:true, nullable:true)
        specifiedLimitations(nullable:true,blank:true,maxSize:4000)
        comments(nullable:true, blank:true, maxSize:4000)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
       
    }
    
    static mapping = {
        table 'form_consent_verification'
        id generator:'sequence', params:[sequence:'form_consent_verification_pk']
    }
    
    enum YesNo {
            No("No"),
            Yes("Yes")

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
                [Yes, No]
            }
    }
    
    enum ConsentorRelationship {
          
        SELF("Self"),
        SPO("Spouse"),
        PAR("Parent"),
        CHI("Child"),
        SIB("Sibling"),
        OTH("Other, Specify.")
        
        final String value;

        ConsentorRelationship(String value) {
            this.value = value;
        }
        String toString(){
            value;
        }
        String getKey(){
            name()
        }
        static list() {
            [SELF,SPO,PAR,CHI,SIB,OTH]
        }                      
    }    
    
 
    
}
