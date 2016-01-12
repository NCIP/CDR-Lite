package nci.bbrb.cdr

import grails.transaction.Transactional
import nci.bbrb.cdr.forms.blood.*
import java.text.SimpleDateFormat
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.datarecords.*

@Transactional
class BloodService {

    def saveDraw(draw) {
        
          try{
           // def draw = new Draw(params)
           
              
            draw.save(failOnError:true)
              
           
        } catch(Exception e) {
            throw new RuntimeException(e.toString())
        }

    }
    
  def  updateDraw(params){
        
      try{
                SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");

              def drawInstance = Draw.get(params.id)
            
             if(params.dateTimeDraw=='Select Date'){
                 params.dateTimeDraw=''
             }
            
             if(params.dateTimeReceived=='Select Date'){
                 params.dateTimeReceived=''
             }
            if(params.dateTimeProcessingStart=='Select Date'){
                 params.dateTimeProcessingStart=''
            }
            
            if(params.dateTimeProcessingEnd=='Select Date'){
                 params.dateTimeProcessingEnd=''
            }
            
            
              drawInstance.properties = params
              def  dateTimeDrawStr = params.dateTimeDraw
              if(dateTimeDrawStr && isDate(dateTimeDrawStr)){
                
                 drawInstance.dateTimeDraw=df.parse(dateTimeDrawStr)
              }else{
                 
               
                   drawInstance.dateTimeDraw=null
              }

             //drawInstance.dateTimeDraw=null
            def dateTimeReceivedStr=params.dateTimeReceived
            if(dateTimeReceivedStr && isDate(dateTimeReceivedStr)){
                 drawInstance.dateTimeReceived=df.parse(dateTimeReceivedStr)
              }else{
                  drawInstance.dateTimeReceived=null
              }
            def dateTimeProcessingStartStr=params.dateTimeProcessingStart
            if(dateTimeProcessingStartStr && isDate(dateTimeProcessingStartStr)){
                drawInstance.dateTimeProcessingStart=df.parse(dateTimeProcessingStartStr)
            }else{
                drawInstance.dateTimeProcessingStart=null
            }
            def dateTimeProcessingEndStr=params.dateTimeProcessingEnd
             if(dateTimeProcessingEndStr && isDate(dateTimeProcessingEndStr)){
                drawInstance.dateTimeProcessingEnd=df.parse(dateTimeProcessingEndStr)
            }else{
                drawInstance.dateTimeProcessingEnd=null
            }



            
             drawInstance.save(failOnError:true)
             
             
            for(int i=1; i<= 3; i++){
                def new_id = params.get("new_id"+i)
                def new_type=params.get("new_type" + i)
                def new_reason=params.get("new_reason"+i)
                def new_volume=params.get("new_volume"+i)
                
                if(new_id){
                    def collectionTube= new CollectionTube()
                    collectionTube.draw=drawInstance
                    collectionTube.collectionTubeId=new_id
                    collectionTube.collectionTubeType=BloodTubeType.findById(new_type)
                    collectionTube.processedFor=BloodCollectionReason.findById(new_reason)
                    collectionTube.volumeStr=new_volume
                    if(isFloat(new_volume)){
                        collectionTube.volume=Float.parseFloat(new_volume)
                    }else{
                        collectionTube.volume=null
                    }
                    
                    
                   collectionTube.save(failOnError:true)
                }
            }
            
            params.each(){key, value->
                def ctid
                if(value=='isctid'){
                    ctid=key.substring(7)

                   def collectionTube=CollectionTube.get(ctid)
                   collectionTube.collectionTubeId=params.get("ctid_" +ctid)
                   collectionTube.collectionTubeType=BloodTubeType.findById(params.get("cttype_" + ctid))
                   collectionTube.processedFor=BloodCollectionReason.findById(params.get("ctreason_" + ctid ))
                   collectionTube.volumeStr=params.get("ctvolume_" + ctid)

                   if(isFloat(params.get("ctvolume_" + ctid))){
                           collectionTube.volume=Float.parseFloat(params.get("ctvolume_" + ctid))
                   }else{
                           collectionTube.volume=null
                   }
                }
                
            }
            
           
            
             for(int i=1; i<= 5; i++){
                def new_source = params.get("new_source"+i)
                def new_aq_id=params.get("new_aq_id" + i)
                def new_aq_type=params.get("new_aq_type"+i)
                def new_aq_volume=params.get("new_aq_volume"+i)
                def new_scan_f_id=params.get("new_scan_f_id"+i)
                def time_frozen=params.get("time_frozen_"+i)
                def new_scan_t_id=params.get("new_scan_t_id"+i)
                def time_trans=params.get("time_trans_"+i)
                
                if(new_aq_id){
                    def aliquot= new Aliquot()
                    aliquot.draw=drawInstance
                    aliquot.aliquotId=new_aq_id
                    aliquot.collectionTube=CollectionTube.get(new_source)
                    aliquot.aliquotType=BloodAliquotType.findById(new_aq_type)
                    aliquot.volumeStr=new_aq_volume
                    
                     if(isFloat(new_aq_volume)){
                        aliquot.volume=Float.parseFloat(new_aq_volume)
                    }else{
                        aliquot.volume=null
                    }
                    aliquot.scannedId4Frozen=new_scan_f_id
                    
                    aliquot.dateTimeFrozenStr=time_frozen
                    
                    if(isDate(time_frozen)){
                        aliquot.dateTimeFrozen=parseDate(time_frozen)
                    }else{
                        aliquot.dateTimeFrozen=null
                    }
                    
                    aliquot.scannedId4Trans=new_scan_t_id
                     aliquot.dateTimeTransStr=time_trans
                    
                    if(isDate(time_trans)){
                        aliquot.dateTimeTrans=parseDate(time_trans)
                    }else{
                        aliquot.dateTimeTrans=null
                    }
                    
                    
                    
                   aliquot.save(failOnError:true)
                }
            }
            
            
            
             params.each(){key, value->
                def aqid
                if(value=='isaqid'){
                    aqid=key.substring(7)
                   
                   def aliquot= Aliquot.get(aqid)
                   aliquot.aliquotId=params.get("aqid_" +aqid)
                   aliquot.collectionTube=CollectionTube.findById(params.get("aqctid_" +aqid))
                   aliquot.aliquotType=BloodAliquotType.findById(params.get("aqtype_" +aqid))
                   aliquot.volumeStr=params.get("aqvolume_" +aqid)
                    if(isFloat(params.get("aqvolume_" +aqid))){
                        aliquot.volume=Float.parseFloat(params.get("aqvolume_" +aqid))
                    }else{
                        aliquot.volume=null
                    }
                    
                    aliquot.scannedId4Frozen=params.get("scanid1_" +aqid)
                    aliquot.dateTimeFrozenStr=params.get("timef_" +aqid)
                    
                    if(isDate(params.get("timef_" +aqid))){
                        aliquot.dateTimeFrozen=parseDate(params.get("timef_" +aqid))
                    }else{
                        aliquot.dateTimeFrozen=null
                    }
                    
                     aliquot.scannedId4Trans=params.get("scanid2_" +aqid)
                     aliquot.dateTimeTransStr=params.get("timet_" +aqid)
                    
                    if(isDate(params.get("timet_" +aqid))){
                        aliquot.dateTimeTrans=parseDate(params.get("timet_" +aqid))
                    }else{
                        aliquot.dateTimeTrans=null
                    }
                    
                    aliquot.save(failOnError:true)
                   
                }
                
            }
            
            
              def delete_aq_id = params.delete_aq
            if(delete_aq_id){
               def deleteAliquot=Aliquot.get(delete_aq_id)
                deleteAliquot.delete(failOnError:true)
            }
            
            
             def delete_ct_id = params.delete_ct
            if(delete_ct_id){
               def deleteTube=CollectionTube.get(delete_ct_id)
               def count=Aliquot.countByCollectionTube(deleteTube)
               if(!count){
                deleteTube.delete(failOnError:true)
               }
            }
        
           
            
        } catch(Exception e) {
            throw new RuntimeException(e.toString())
        }
        
        
    }
    
    
      def getCollectionTubes(blood) { 
        try{
            def result=[]
          
            
            result = CollectionTube.executeQuery("from CollectionTube ct where ct.draw.blood.id=?", [blood.id])
            
            return result
       
        }catch(Exception e){
            e.printStackTrace()
           
            throw new RuntimeException(e.toString())
        }
        

    }
    
    
    def getAliquots(blood) { 
        try{
            def result=[]
          
            
            result = Aliquot.executeQuery("from Aliquot aq where aq.draw.blood.id=?", [blood.id])
            
            return result
       
        }catch(Exception e){
            e.printStackTrace()
           
            throw new RuntimeException(e.toString())
        }
        

    }
    
    def submitForm(bloodInstance, username){
        try{
           def draws = bloodInstance.draws
           draws.each(){
               def aliquots=it.aliquots
               aliquots.each(){it2->
                   def aliquotId=it2.aliquotId
                   def specimenRecord
                   if(it2.specimenRecord){
                       specimenRecord=it2.specimenRecord
                   }else{
                       specimenRecord= new SpecimenRecord()
                   }
                   specimenRecord.specimenId=aliquotId
                   specimenRecord.caseRecord=bloodInstance.caseRecord
                   specimenRecord.tissueType=TissueType.findByCode("BLOOD")
                   specimenRecord.save(failOnError:true)
                   if(!it2.specimenRecord){
                    it2.specimenRecord=specimenRecord
                    it2.save(failOnError:true)
                   }
               }
           }
       
           bloodInstance.dateSubmitted=new Date()
           bloodInstance.submittedBy= username
           bloodInstance.save(failOnError:true)
        }catch(Exception e){
            e.printStackTrace()
           
            throw new RuntimeException(e.toString())
        }
        
    }
     boolean isFloat(floatStr){
          boolean result=false
        if(!floatStr)
        return false
        
        try{
            Float.parseFloat(floatStr)
            result = true
        }catch (Exception e){
             
        }
        return result    
    }
    
    
    boolean isDate(dateStr){
        boolean result=false
        if(!dateStr)
        return false
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        df.setLenient(false);
        try{
        
            def date = df.parse(dateStr)
            result=true
        }catch (Exception e){
             
        }
         
        return result
        
        
    }
    
    
    Date parseDate(dateStr){
        
        if(!dateStr)
        return false
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        df.setLenient(false);
        try{
        
            def date = df.parse(dateStr)
            return date
        }catch (Exception e){
             
        }
          
        return null
        
        
    }
}
