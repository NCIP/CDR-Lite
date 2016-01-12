package nci.bbrb.cdr.datarecords

import nci.bbrb.cdr.staticmembers.*

class SpecimenRecord extends DataRecordBaseClass{
    
    CaseRecord caseRecord
    SpecimenRecord parentSpecimen
    String specimenId
    String grossId
    Fixative fixative
    ContainerType containerType
    TissueType tissueType
//    TissueLocation tissueLocation
    String tissueLocation
    String processingPerson
    Date preservationTime
    String tissueSize
    String tissueSizeUnits
    StorageTemp storageTemp
    Date storageTime
    String storagePerson
    String comments
    Date dateSubmitted
    String submittedBy
        
    static hasMany = [slides:SlideRecord, processEvents:ProcessingEvent]
   
    static mapping = {

        table 'dr_specimen'
        id generator:'sequence', params:[sequence:'dr_specimen_pk']
        //tissueLocations column:'dr_specimen_st_acquis_loc'
   
    }    

    static constraints = {
        caseRecord(blank:false,nullable:false)
        parentSpecimen(blank:true,nullable:true)
        specimenId(blank:false,nullable:false,unique:true)
        grossId(blank:true,nullable:true)
        fixative(blank:true,nullable:true)
        containerType(blank:true,nullable:true)
        tissueType(blank:false,nullable:false)
        tissueLocation(blank:true,nullable:true)
        processingPerson(blank:true,nullable:true)
        preservationTime(blank:true,nullable:true)
        tissueSize(blank:true,nullable:true)
        tissueSizeUnits(blank:true,nullable:true)
        storageTemp(blank:true,nullable:true)
        storageTime(blank:true,nullable:true)
        storagePerson(blank:true,nullable:true)
        comments(blank:true,nullable:true, widget:'textarea', maxSize:4000)
        dateSubmitted(blank:true,nullable:true)
        submittedBy(blank:true,nullable:true)
    }
}
