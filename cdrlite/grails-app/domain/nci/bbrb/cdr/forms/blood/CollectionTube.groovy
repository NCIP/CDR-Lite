package nci.bbrb.cdr.forms.blood

import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.staticmembers.*


class CollectionTube extends DataRecordBaseClass {

  Draw draw

  String collectionTubeId
  BloodTubeType collectionTubeType 
  Float volume
  BloodCollectionReason processedFor
  String volumeStr
  


  
  

     static mapping = {
        table 'blood_collection_tube'
        id generator:'sequence', params:[sequence:'blood_collection_tube_pk']
       
        sort dateCreated:"desc"  
    }
    
    
    
    static constraints = {
        draw(blank:false, nullable:false)
        collectionTubeId(blank:true, nullable:true)
        collectionTubeType(blank:true, nullable:true)
        volume(blank:true, nullable:true)
        volumeStr(blank:true, nullable:true)
        processedFor(blank:true, nullable:true)
       
     
    }
}
