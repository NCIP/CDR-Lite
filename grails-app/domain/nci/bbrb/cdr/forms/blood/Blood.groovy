package nci.bbrb.cdr.forms.blood

import nci.bbrb.cdr.datarecords.*

class Blood extends DataRecordBaseClass{
    CaseRecord caseRecord
    Date dateSubmitted
    String submittedBy
    String comments
   static hasMany = [draws:Draw]
    
     static mapping = {
        table 'form_blood'
        id generator:'sequence', params:[sequence:'form_blood_pk']
       
        sort dateCreated:"desc"  
    }
    
    static constraints = {
        
        caseRecord(unique:true, blank:false, nullable:false)
        dateSubmitted(blank:true, nullable:true)
        submittedBy(blank:true, nullable:true)
        draws(blank:true, nullable:true)
        comments(blank:true, nullable:true, maxSize:4000)
    }
}
