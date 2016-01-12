package nci.bbrb.cdr.staticmembers

class BloodAliquotType extends StaticMemberBaseClass {

  static mapping = {
        table 'st_blood_aliquot_type'
        id generator:'sequence', params:[sequence:'st_blood_aliquot_type_pk']
    }
}
