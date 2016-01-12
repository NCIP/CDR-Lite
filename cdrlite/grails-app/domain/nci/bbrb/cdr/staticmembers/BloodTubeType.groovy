package nci.bbrb.cdr.staticmembers

class BloodTubeType extends StaticMemberBaseClass {

    static mapping = {
        table 'st_blood_tube_type'
        id generator:'sequence', params:[sequence:'st_blood_tube_type_pk']
    }
}
