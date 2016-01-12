package nci.bbrb.cdr.staticmembers

class BloodDrawType extends StaticMemberBaseClass {

    static mapping = {
        table 'st_blood_draw_type'
        id generator:'sequence', params:[sequence:'st_blood_draw_type_pk']
    }
    
    static constraints = {
    }
}
