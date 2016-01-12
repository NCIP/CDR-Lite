package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.forms.blood.*
import nci.bbrb.cdr.forms.SurgeryAnesthesia
import nci.bbrb.cdr.forms.TissueReceiptDissection
import nci.bbrb.cdr.forms.TissueProcessEmbed
import nci.bbrb.cdr.forms.SlideSection
import nci.bbrb.cdr.forms.ClinicalDataEntry
import nci.bbrb.cdr.forms.TissueGrossEvaluation
import nci.bbrb.cdr.forms.SlidePrep

class CaseRecord extends DataRecordBaseClass {
    
    String caseId 
    CandidateRecord candidateRecord
    CaseStatus caseStatus
    Date statusDate
    CaseCollectionType caseCollectionType
    TissueType primaryTissueType
    BSS bss
    Study study
    String finalSurgicalPath
    Date dateFspUploaded
    String fspUploadedBy
    
    String toString(){"$caseId"}    
    
    static hasMany = [specimens:SpecimenRecord]
    
    static hasOne = [blood:Blood, surgeryAnesthesia:SurgeryAnesthesia, tissueGrossEvaluation:TissueGrossEvaluation, tissueReceiptsAndDissection:TissueReceiptDissection, tissueProcessEmbed:TissueProcessEmbed, slideSection: SlideSection, clinicalDataEntry:ClinicalDataEntry, slidePrep:SlidePrep]
    
    
    static constraints = {
        caseId(unique:true, blank:false, nullable:false)
        blood(blank:true, nullable:true)
        caseStatus(blank:true, nullable:true)
        statusDate(blank:true, nullable:true)
        caseCollectionType(blank:true, nullable:true)
        surgeryAnesthesia(blank:true, nullable:true)
        tissueReceiptsAndDissection(blank:true, nullable:true)
        tissueProcessEmbed(blank:true, nullable:true)
        clinicalDataEntry(nullable:true, blank:true)
        tissueGrossEvaluation(nullable:true, blank:true)
        slideSection(nullable:true, blank:true)
        slidePrep(nullable:true, blank:true)
        finalSurgicalPath(nullable:true, blank:true)
        dateFspUploaded(nullable:true, blank:true)
        fspUploadedBy(nullable:true, blank:true)
    }
    
    
    static mapping = {
        table 'dr_case'
        id generator:'sequence', params:[sequence:'dr_case_pk']
       
        sort dateCreated:"desc"  
    }
    
    static searchable = {
        only=['caseId', 'id', 'dateCreated']
          
         'dateCreated'  name:'caseDateCreated', format: "yyyy-MM-dd HH:mm"
        
        caseStatus component: true
        caseCollectionType component: true
        bss component: true
        study component: true
        primaryTissueType component: true
        candidateRecord component: true
      
    }
}
