package nci.bbrb.cdr.staticmembers

/*
 * BSS = Biospecimen Source Site
 *
 */
class BSS extends StaticMemberBaseClass{

    //String IRBprotocol
    String timeZone // selected from enum TimeZones
    String toString(){"$code"}

    static hasMany = [studyList:Study]
    
    static belongsTo = [Study]
    
    static constraints = {
        //IRBprotocol(blank:true,nullable:true)
        timeZone(blank:true,nullable:true)
        studyList(blank:true,nullable:true)
       
    }
    
    static searchable ={
        only= ['name', 'code']
        'name' name:'BSSName'
        'code' name:'BSSCode'
        root false
    }
     
    //pmh: CDRQA:1114 
    enum TimeZones {
        
        HAWAII("Hawaii Time"),
        ALASKA("Alaska Time"),
        PACIFIC("Pacific Time"),
        MOUNTAIN("Mountain Time"),
        CENTRAL("Central Time"),
        EASTERN("Eastern Time")

        final String value;

        TimeZones(String value) {
            this.value = value;
        }

        String toString() {
            value;
        }

        String getKey() {
            name()
        }

        static list() {
            [HAWAII,ALASKA,PACIFIC,MOUNTAIN,CENTRAL,EASTERN]
        }
    }
      static mapping = {
      table 'st_bss'
      id generator:'sequence', params:[sequence:'st_bss_pk']
    }
}
