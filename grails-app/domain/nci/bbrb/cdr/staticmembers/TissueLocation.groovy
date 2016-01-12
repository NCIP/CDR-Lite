package nci.bbrb.cdr.staticmembers

class TissueLocation extends StaticMemberBaseClass{
    
    static belongsTo = TissueType
    static hasMany = [tissueTypes:TissueType]
    
    static mapping = {
      table 'st_tissue_loc'
      id generator:'sequence', params:[sequence:'st_tissue_loc_pk']
    }
    
    static constraints = {
    }
}