package nci.bbrb.cdr.staticmembers



class PrcAcceptability extends StaticMemberBaseClass {

     static mapping = {
      table 'st_prc_acceptability'
      id generator:'sequence', params:[sequence:'st_prc_acceptability_pk']
    }
    
    static constraints = {
    }
}
