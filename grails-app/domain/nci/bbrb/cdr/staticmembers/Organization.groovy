package nci.bbrb.cdr.staticmembers

class Organization extends StaticMemberBaseClass{

    String shippingAddress
    Boolean isBss
    String toString(){"$code"}
        
    static constraints = {
        shippingAddress(blank:true,nullable:true,widget:'textarea')
        isBss(blank:true,nullable:true)
    }
    
     static mapping = {
      table 'st_organization'
      id generator:'sequence', params:[sequence:'st_organization_pk']
    }

       static searchable = {
        only = ['name', 'code']
        'name' name:'orgName'
        'code' name:'orgCode'
        root false
    }

    
}
