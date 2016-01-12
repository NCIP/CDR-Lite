package nci.bbrb.cdr

import grails.transaction.Transactional
import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.prc.*
import nci.bbrb.cdr.staticmembers.*

@Transactional
class PrcReportService {
    
    
     List getPrcCaseMaps(caseList){
         if(!caseList){
             return []
         }else{
        def result=[]
        def slide_map = [:]
        def slide_result= SlideRecord.executeQuery("select c.id, sl from SlideRecord sl inner join sl.specimenRecord sp inner join sp.caseRecord c where c in (:list) ", [list: caseList])
        slide_result.each(){
            def s_list = slide_map.get(it[0])
            if(!s_list){
                s_list = []
                slide_map.put(it[0], s_list)
            }
           
                s_list.add(it[1])
           
            
        }
         
        caseList.each(){
            def map = [:]
            map.put("id", it.id)
            map.put("caseId", it.caseId)
            //map.put("bss", caseRecord.bss?.name)
            map.put("primaryOrgan", it.primaryTissueType?.name )
            map.put("status", it.caseStatus)
            def slides = slide_map.get(it.id)
            map.put("slides", slides)
          
           
            result.add(map)
        }
          
        return result
         }
    }
     
    
    
    
    
    
    def createReport(prcReportInstance) { 
        try{
            prcReportInstance.status='Editing'
            prcReportInstance.save(failOnError:true)
        } catch(Exception e) {
            throw new RuntimeException(e.toString())
        }
    }
  
    
  
   
    
    
    
    def saveReport(prcReportInstance, params, request){
        try{
          
            
          
          
            prcReportInstance.save(failOnError:true)
            
          
          
           
            
     
            
            
        }catch(Exception e){
            e.printStackTrace()
           
            throw new RuntimeException(e.toString())
        }
    }
    
    
                     
     def submitReport(prcReportInstance, username) {   
         
        if(prcReportInstance)
        try {
            prcReportInstance.submittedBy=username
            prcReportInstance.dateSubmitted= new Date()
             prcReportInstance.status = "Submitted"
            prcReportInstance.save(failOnError:true)
            
            
           //activityEventService.createEvent(activityType, caseId, study, bssCode, null, username, null, null)
        } catch (Exception e) {
            e.printStackTrace()    
            throw new RuntimeException(e.toString())
        }
    }
    
    def startNew(prcReportInstance){
        try{
            prcReportInstance.status = 'Editing'
            prcReportInstance.dateSubmitted=null
            prcReportInstance.submittedBy = null
           
        }catch(Exception e){
             
            throw new RuntimeException(e.toString())
        }
        
    }
    
}
