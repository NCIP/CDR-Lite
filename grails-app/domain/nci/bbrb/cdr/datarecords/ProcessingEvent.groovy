package nci.bbrb.cdr.datarecords

import nci.obbr.cahub.staticmembers.*

class ProcessingEvent extends DataRecordBaseClass {

    String eventId    
    String toString(){"$eventId"}
    String eventType
    String processName

    static hasMany = [slides:SlideRecord, specimens:SpecimenRecord]
    static belongsTo = [SlideRecord, SpecimenRecord]

    static constraints = {
        eventId(blank:false,nullable:false)
       // slides(blank:true,nullable:true)
       // specimens(blank:true,nullable:true)
        eventType(blank:true,nullable:true)
        processName(blank:true,nullable:true)
      //  derivatives(blank:true,nullable:true)
    }
    
    static mapping = {
      table 'dr_processevt'
      id generator:'sequence', params:[sequence:'dr_processevt_pk']
      
      sort id:"desc"  
        
    }
}
