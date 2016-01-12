package nci.bbrb.cdr.staticmembers

class Study  extends StaticMemberBaseClass{
    
   // Date dateIRBApproved
   // Date dateIRBExpires
    
    static hasMany = [bssList:BSS, tissueTypeList:TissueType]
    
    static mapping = {
      table 'st_study'
      id generator:'sequence', params:[sequence:'st_study_pk']
    }
    
     static searchable ={
        only= ['name', 'code']
        'name' name:'studyName'
        'code' name:'studyCode'
        root false
    }

    static constraints = {
       // dateIRBApproved(blank:true, nullable:true)
       // dateIRBExpires(blank:true, nullable:true)
        bssList(blank:true,nullable:true)
        tissueTypeList(blank:true,nullable:true)
    }
}
