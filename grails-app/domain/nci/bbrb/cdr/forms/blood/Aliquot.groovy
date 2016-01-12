package nci.bbrb.cdr.forms.blood

import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.staticmembers.*

class Aliquot extends DataRecordBaseClass {
    Draw draw
    CollectionTube collectionTube
    SpecimenRecord specimenRecord
    String aliquotId
    BloodAliquotType aliquotType
    Float volume
    String volumeStr
    String scannedId4Frozen
    String scannedId4Trans
    Date dateTimeFrozen
    String dateTimeFrozenStr
    Date dateTimeTrans
    String dateTimeTransStr
    
    static mapping = {
        table 'blood_aliquot'
        id generator:'sequence', params:[sequence:'blood_blood_aliquot_pk']
       
        sort dateCreated:"desc"  
    }
    static constraints = {
        draw (blank:false, nullable:false)
        collectionTube(blank:false, nullable:false)
        specimenRecord(blank:true, nullable:true)
        aliquotId(blank:true, nullable:true)
        aliquotType(blank:true, nullable:true)
        volume(blank:true, nullable:true)
        volumeStr(blank:true, nullable:true)
        scannedId4Frozen(blank:true, nullable:true)
        scannedId4Trans(blank:true, nullable:true)
        dateTimeFrozen(blank:true, nullable:true)
        dateTimeFrozenStr(blank:true, nullable:true)
        dateTimeTrans(blank:true, nullable:true)
        dateTimeTransStr(blank:true, nullable:true)
        
    }
}
