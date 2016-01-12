package nci.bbrb.cdr.staticmembers

class Fixative extends StaticMemberBaseClass{
    
      static constraints = {
      }
    
     static mapping = {
      table 'st_fixative'
      id generator:'sequence', params:[sequence:'Fixative_pk']
    }

}
