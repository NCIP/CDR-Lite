package nci.bbrb.cdr.prc

import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.staticmembers.*


class PrcReport extends DataRecordBaseClass {
    
    SlideRecord slideRecord
    TissueType organOrigin
    String autolysis
    String comments
    TissueCategory tissueCategory
    Date dateSubmitted
    String submittedBy
    String status
    String diagnosis
    Float tumorDimension
    Float pctTumorArea
    Float pctTumorCellularity
    Float pctNecroticTissue
    Float pctViablTumor
    Float pctNecroticTumor
    Float pctViableNonTumor
    Float pctNonCellular
    Float hisTotal
    
    
    static mapping = {
      table 'prc_report'
      id generator:'sequence', params:[sequence:'prc_report_pk']
    }
    

    static constraints = {
        organOrigin(blank:true,nullable:true)
         autolysis(blank:true,nullable:true)
         tissueCategory(blank:true,nullable:true)
         comments(blank:true,nullable:true, maxSize:4000)
         dateSubmitted(blank:true,nullable:true)
         submittedBy(blank:true,nullable:true)
         status(blank:true,nullable:true)
         diagnosis(blank:true,nullable:true, maxSize:4000)
         tumorDimension(blank:true,nullable:true)
         pctTumorArea(blank:true,nullable:true)
         pctTumorCellularity(blank:true,nullable:true)
         pctNecroticTissue(blank:true,nullable:true)
         pctViablTumor(blank:true,nullable:true)
         pctNecroticTumor(blank:true,nullable:true)
         pctViableNonTumor(blank:true,nullable:true)
         pctNonCellular(blank:true,nullable:true)
         hisTotal(blank:true,nullable:true)
    }
}
