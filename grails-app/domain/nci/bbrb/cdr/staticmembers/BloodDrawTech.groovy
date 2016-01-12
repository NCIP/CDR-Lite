package nci.bbrb.cdr.staticmembers

class BloodDrawTech extends StaticMemberBaseClass{

    static mapping = {
        table 'st_blood_draw_tech'
        id generator:'sequence', params:[sequence:'st_blood_draw_tech_pk']
    }
    
    
}
