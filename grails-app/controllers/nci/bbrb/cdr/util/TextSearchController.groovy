package nci.bbrb.cdr.util

import nci.bbrb.cdr.datarecords.*

import nci.bbrb.cdr.staticmembers.*

import nci.bbrb.cdr.util.querytracker.*

import org.apache.commons.logging.LogFactory


class TextSearchController {
    def textSearchService
    def prcReportService
    def queryService
    
    private static final log = LogFactory.getLog(this)

    def searchhome={
        
    }
    
   
    def search = {
      
        if(params.query){
            
            def query = params.query
            def offset = params.offset
            def studyCode=session.study?.code
            
          
            if(!offset)
            offset=0
                 
           
            def q= "(" + params.query + ")"
            def q2='';
            def q3=' (studyCode:'+studyCode+')'
          
          
              def bss = BSS.findByCode(session.org.code)
              if(bss){
                  q2="(BSSCode:" + bss.code + ")"
              }

        
           
            def size=0
            def count = 0
            def caseRecordInstanceList=[]
             def specimenCount=[:]
            def queryCount=[:]
            
            try{
                def map  = CaseRecord.search(
                    q + q2 + q3,
                    [offset:offset, max:25, sort:"CaseRecord.caseId", order:"desc"]
                )
                
                count = map.total
              
                caseRecordInstanceList = map.results
            
                if( caseRecordInstanceList){
                    size=caseRecordInstanceList.size()
                }
                
                caseRecordInstanceList = map.results
                def list = []
                for(cd in caseRecordInstanceList){
                    list.add(cd.id)
                }
            
                def listDB =[]
                if(list){
                    listDB=CaseRecord.getAll(list)
                }
               
                if(listDB){
                    def count_result = SpecimenRecord.executeQuery("select c.id, count(*) from SpecimenRecord s inner join s.caseRecord c where c in (:list) group by c.id",  [list: listDB])
                    count_result.each(){
                        specimenCount.put(it[0], it[1])
                    }
                }
                
                if(listDB){
                      queryCount = getQueryCountMap(listDB)
                }
                
               //  println("size:  " + size)
                [caseRecordInstanceList:listDB, specimenCount:specimenCount, queryCount:queryCount, total:count, query:query, size:size, msg:""]
                
               // [caseRecordInstanceList:caseRecordInstanceList, total:count, query:query, size:size, msg:""]    
            }catch (Exception e){
                //def msg=e.toString()
                def msg="There was a problem with your Search Criteria."
                log.error((new Date()).toString() + " " + e.toString())
                [caseRecordInstanceList:caseRecordInstanceList, specimenCount:specimenCount, queryCount:queryCount, total:count, query:query, size:size, msg:msg]
            }
            
        //  render "done"
            
           
         
        }
    }
    
    
    
    def searchPrc = {
      
        if(params.query){
            
            def query = params.query
            def offset = params.offset
            def studyCode=session.study?.code
            
          
            if(!offset)
            offset=0
                 
           
            def q= "(" + params.query + ")"
            def q2='';
            def q3=' (studyCode:'+studyCode+')'
          
          
            
        
           
            def size=0
            def count = 0
            def caseRecordInstanceList=[]
         
             def caseList=[]
         
            
            try{
                def map  = CaseRecord.search(
                    q + q2 + q3,
                    [offset:offset, max:25, sort:"CaseRecord.caseId", order:"desc"]
         
                )
                
                count = map.total
              
                caseRecordInstanceList = map.results
          
            
                if( caseRecordInstanceList){
                    size=caseRecordInstanceList.size()
                }
            
                
                  caseRecordInstanceList = map.results
            
            
               
       
            
                def list = []
                for(cd in caseRecordInstanceList){
                    list.add(cd.id)
                }
        
            
                def listDB =[]
                if(list){
                    listDB=CaseRecord.getAll(list)
                }
            
            
               
                
               if(listDB){
                 caseList = prcReportService.getPrcCaseMaps(listDB)
               }
                
            
                // [caseRecordInstanceList:listDB, total:count, query:query, size:size]*/
            
                
               //  println("size:  " + size)
                [caseList:caseList,  total:count, query:query, size:size, msg:""]
                
                
             //  
               // [caseRecordInstanceList:caseRecordInstanceList, total:count, query:query, size:size, msg:""]    
            }catch (Exception e){
                //def msg=e.toString()
                def msg="Wrong Search Criteria."
                log.error((new Date()).toString() + " " + e.toString())
                [caseList:caseList,  total:count, query:query, size:size, msg:msg]
            }
            
        //  render "done"
            
           
         
        }
    }
    
    
    
    
    
      def index_all = {
        textSearchService.index_all()
        render("bulk index started in a background thread.")
    } 

    
   
    
    def getQueryCountMap(caseRecordInstanceList) {
        
        def queryCount = [:]
        if (caseRecordInstanceList) {
            def activeStatus = QueryStatus.findByCode("ACTIVE")
            def countResult
            if (session.org?.code == 'DCC') {
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s where c in (:list) and s.id = :activeStatus group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id])
            } else {
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and s.id = :activeStatus and o.code like :org group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id, org:session.org?.code + "%"])
            }
            countResult.each() {
                queryCount.put(it[0], it[1]) 
            }
        }
            
        return queryCount
    }

    def searchQt = {
      
        if(params.query){
          
            def query = params.query
            def offset = params.offset
            
            // println("offset: " + offset)
            if(!offset)
            offset=0
                 
            //def q="+" + params.query
            def q= "(" + params.query + ")" 
            def q2=""
            def q3 = ""
            if(session.org.code != 'OBBR'){
                q2= " (orgCode:" + session.org.code + "*)" 
                q3 = " (qtStatusCode:[* TO *])"
            }

           
            def size=0
            def count = 0
            def qtInstanceList=[]
            def listDB =[]
            
            try{
                def map  = Query.search(
                    q + q2 + q3,
                    [offset:offset, max:25, sort:"Query.dateCreated", order:"desc"]
         
                )
              
       
                count = map.total
                // println("count: " + count)
 
                qtInstanceList = map.results
          
            
                if( qtInstanceList){
                    size=qtInstanceList.size()
                }
            
                
                def list = []
                for(qt in qtInstanceList){
                    list.add(qt.id)
                }
        
            
                //Duration between Initial Site Response and Query Open Date
                def daysMap1=[:]
                //Duration between Query Open Date and Query Closure Date 
                def daysMap2=[:]
                
                if(list){
                    listDB=Query.getAll(list)
                    daysMap1=queryService.getDaysElapsedtoOpenQuery(list?.join(','))
                }
                daysMap2 = queryService.daysElapsedOpenToCloseQuery(list?.join(','))
                [queryInstanceList:listDB, total:count, query:query, size:size, msg:"",daysMap1:daysMap1,daysMap2:daysMap2]    
          
            }catch (Exception e){
                //def msg=e.toString()
                def msg="Wrong Search Criteria."
                log.error((new Date()).toString() + " " + e.toString())
                [queryInstanceList:listDB, total:count, query:query, size:size, msg:msg]
             
            }
            
         
           
         
        }
        
      
        
    }
    
}
