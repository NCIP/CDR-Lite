package nci.bbrb.cdr.staticmembers

class TissueCategory extends StaticMemberBaseClass{
    
     static mapping = {
      table 'st_tissue_category'
      id generator:'sequence', params:[sequence:'st_tissue_category_pk']
    }

    static constraints = {
    }
}
