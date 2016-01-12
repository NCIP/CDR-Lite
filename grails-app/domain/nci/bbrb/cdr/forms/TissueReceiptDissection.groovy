package nci.bbrb.cdr.forms

import nci.bbrb.cdr.datarecords.DataRecordBaseClass
import nci.bbrb.cdr.datarecords.*

class TissueReceiptDissection extends DataRecordBaseClass {

    CaseRecord caseRecord
    Date dateSubmitted
    String submittedBy
    
    String receiptDissectSOP
    Date dateTimeTissueReceived
    String tissueRecipient
    String tissueReceiptComment

    String parentTissueDissectedBy
    String parentTissueDissectBegan
    String parentTissueDissectEnded
    String grossAppearance
    String otherGrossAppearance
    String tumorSource
    String collectionProcedure
    String otherCollectionProcedure

    String fixativeType
    String otherFixativeType
    String fixativeFormula
    String fixativePH
    String fixativeManufacturer
    String fixativeLotNum
    Date dateFixativeLotNumExpired
    String fixativeProductNum
    String fixativeProductType
    String otherFixativeProductType
    String parentTissueSopComment
    
    static constraints = {
        caseRecord(blank:false, nullable:false)
        receiptDissectSOP(blank:true, nullable:true)
        dateTimeTissueReceived(blank:true, nullable:true)
        tissueRecipient(blank:true, nullable:true)
        tissueReceiptComment(blank:true, nullable:true, widget:'textarea', maxSize:4000)

        parentTissueDissectedBy(blank:true, nullable:true)
        parentTissueDissectBegan(blank:true, nullable:true)
        parentTissueDissectEnded(blank:true, nullable:true)
        otherGrossAppearance(blank:true, nullable:true)
        grossAppearance(blank:true, nullable:true)
        tumorSource(blank:true, nullable:true)
        collectionProcedure(blank:true, nullable:true)
        otherCollectionProcedure(blank:true, nullable:true)

        fixativeType(blank:true, nullable:true)
        otherFixativeType(blank:true, nullable:true)
        fixativeFormula(blank:true, nullable:true)
        fixativePH(blank:true, nullable:true)
        fixativeManufacturer(blank:true, nullable:true)
        fixativeLotNum(blank:true, nullable:true)
        dateFixativeLotNumExpired(blank:true, nullable:true)
        fixativeProductNum(blank:true, nullable:true)
        fixativeProductType(blank:true, nullable:true)
        otherFixativeProductType(blank:true, nullable:true)
        parentTissueSopComment(blank:true, nullable:true, widget:'textarea', maxSize:4000)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        
    }
    
    static belongsTo = [caseRecord: CaseRecord]

    //String toString(){"$caseRecord.caseId"}
    
    static mapping = {
        table 'form_tissue_receipt_dissect'
        id generator:'sequence', params:[sequence:'form_tissue_receipt_dissect_pk']
    }
    
    
}
