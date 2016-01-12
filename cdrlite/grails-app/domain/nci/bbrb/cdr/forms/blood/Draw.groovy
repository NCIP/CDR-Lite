package nci.bbrb.cdr.forms.blood

import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.staticmembers.*

class Draw  extends DataRecordBaseClass{
     Blood blood
     String minimumReqMet
     BloodDrawType bloodDrawType
     Date dateTimeDraw
     BloodDrawTech bloodDrawBy
     String personName
     String hasIssue
     String bloodDrawIssues
     String collectionComments
     Date dateTimeReceived
     String receivedBy
     Float temperature
     String temperatureStr
     Float humidity
     String humidityStr
     String processedBy
     Date dateTimeProcessingStart
     Date dateTimeProcessingEnd
     String aliquotsProcessedBy
     String aliquotTransferredBy
     String procesingAccodSop
     String processingComments
     String wasClotting
     String grossHemolysis
     String storageIssue
     String clottingTubeIds
     String hemolysisTubeIds
     
     static hasMany = [collectionTubes:CollectionTube,aliquots:Aliquot]
    
     static mapping = {
        table 'blood_draw'
        id generator:'sequence', params:[sequence:'blood_draw_pk']
       
        sort dateCreated:"desc"  
    }
    
    
    static constraints = {
        blood (blank:false, nullable:false)
        minimumReqMet(blank:true, nullable:true)
        bloodDrawType(blank:true, nullable:true)
        dateTimeDraw(blank:true, nullable:true)
        personName(blank:true, nullable:true)
        hasIssue(blank:true, nullable:true)
        bloodDrawIssues(blank:true, nullable:true, maxSize:4000)
        bloodDrawBy(blank:true, nullable:true)
        collectionComments(blank:true, nullable:true, maxSize:4000)
        collectionTubes(blank:true, nullable:true)
        dateTimeReceived(blank:true, nullable:true)
        receivedBy(blank:true, nullable:true)
        temperature(blank:true, nullable:true)
        temperatureStr(blank:true, nullable:true)
        humidity(blank:true, nullable:true)
        humidityStr(blank:true, nullable:true)
        processedBy(blank:true, nullable:true)
        dateTimeProcessingStart(blank:true, nullable:true)
        dateTimeProcessingEnd(blank:true, nullable:true)
        aliquots(blank:true, nullable:true)
        aliquotsProcessedBy(blank:true, nullable:true)
        aliquotTransferredBy(blank:true, nullable:true)
        procesingAccodSop(blank:true, nullable:true)
        processingComments(blank:true, nullable:true, maxSize:4000)
        wasClotting(blank:true, nullable:true)
        grossHemolysis(blank:true, nullable:true)
        storageIssue(blank:true, nullable:true, maxSize:4000)
        clottingTubeIds(blank:true, nullable:true, maxSize:4000)
        hemolysisTubeIds(blank:true, nullable:true, maxSize:4000)
    }
}
