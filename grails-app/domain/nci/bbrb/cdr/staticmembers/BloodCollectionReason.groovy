package nci.bbrb.cdr.staticmembers

class BloodCollectionReason extends StaticMemberBaseClass{

     static mapping = {
        table 'st_blood_collection_reason'
        id generator:'sequence', params:[sequence:'st_blood_collection_reason_pk']
    }
    
    static constraints = {
    }
}
