package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.forms.TissueGrossEvaluation

class PhotoRecord extends DataRecordBaseClass {

    String fileName
    String filePath
    String comments
    TissueGrossEvaluation tissueGrossEvaluation
    String rmFlg
   
    static belongsTo = [tissueGrossEvaluation:TissueGrossEvaluation]
    
    static constraints = {
        fileName(blank:true,nullable:true)
        filePath(blank:true,nullable:true)
        comments(blank:true,nullable:true)
        tissueGrossEvaluation(blank:true,nullable:true)
        rmFlg(blank:true,nullable:true)
      
    }
    
    static mapping = {
        table 'dr_photo'
        id generator:'sequence', params:[sequence:'dr_photo_pk']
    } 
}
