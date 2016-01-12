package nci.bbrb.cdr
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.util.*
import nci.bbrb.cdr.study.*
import nci.bbrb.cdr.util.querytracker.Query

/* created by: pmh 05/12/15*/


class HomeController {
 
    def prcReportService

 String maxView ='10'
    
     def choosehome = {
        
     
    }
    
    def homedispatcher = {      
     
        def bss = BSS.findByCode(session.org?.code)
        
        if(bss && bss.code !='DCC'){
           //redirect(action: "bsshome")
           redirect(action: "projecthome")
        }else if(session.chosenHome=="projecthome"){
            
              redirect(action: "projecthome")
         
        }else if(session.chosenHome=="project"){
              def study=session.study
              if(!study){
                  redirect(action: "projecthome")
              }else{
              redirect(action: "project", params:[id:study.id])
              }
         
        }else if(session.chosenHome=="prchome"){
              redirect(action: "prchome")
       
        }else if(session.chosenHome=="prc"){
            def study=session.study
              if(!study){
                  redirect(action: "prchome")
              }else{
              redirect(action: "prc", params:[id:study.id])
              }
           
            
        }else if(session.chosenHome=="opshome"){
              redirect(action: "opshome")
        }
        else if(session.chosenHome == 'VOCAB'){
                redirect(action: "vocabhome")
            }
        
        else {
            redirect(action: "choosehome")
        }
    }
    
    
    def projecthome={
        session.chosenHome="projecthome"
         def bss = BSS.findByCode(session.org?.code)
         def studyList
          if(bss && bss.code !='DCC'){
              studyList = bss.studyList
          }else{
              studyList=Study.findAll()
          }
          if(studyList?.size() ==1){
              def study = studyList[0]
               redirect(action: "project", params:[id:study.id])
               return
              
          }
        return [studyList: studyList]
    }
   
    def project={
        session.chosenHome="project"
        def study=Study.get(params.id)
        session.study=study
         def bss = BSS.findByCode(session.org?.code)
         
        if(bss){
        def bssStudyList = bss.studyList
        if(!bssStudyList.contains(study)){
             redirect(controller: "login", action: "denied")
            return
        }
        }
         def candidateList
         if(bss && bss.code !='DCC'){
            candidateList = CandidateRecord.findAllByStudyAndBss(study, bss, [max:maxView])
         }else{
             candidateList = CandidateRecord.findAllByStudy(study, [max:maxView]) 
         }
       // def caseList = CaseRecord.findAllByStudy(Study.findByCode('BPVLIKE'), [max:maxView])
       
        def caseList
         if(bss && bss.code !='DCC'){
            caseList = CaseRecord.findAllByStudyAndBss(study, bss, [max:maxView])
         }else{
            caseList = CaseRecord.findAllByStudy(study, [max:maxView]) 
         }
        
        def specimenCount=[:]
        if(caseList){
             def count_result = SpecimenRecord.executeQuery("select c.id, count(*) from SpecimenRecord s inner join s.caseRecord c where c in (:list) group by c.id",  [list: caseList])
            count_result.each(){
                specimenCount.put(it[0], it[1])
             
            }
        }
        
        def queryCount = getQueryCountMap(caseList)
        def queryCountCandidate = getQueryCountMapCandidate(candidateList)
        
        return [caseRecordInstanceList:caseList, candidateRecordInstanceList:candidateList, specimenCount:specimenCount, queryCount:queryCount, queryCountCandidate:queryCountCandidate, studyId:params.id]
    }
    
    
    def prchome={
         session.chosenHome="prchome" 
         def studyList=Study.findAll()
         
        if(studyList?.size() ==1){
              def study = studyList[0]
               redirect(action: "prc", params:[id:study.id])
               return
              
          }
        
        
         return [studyList:studyList]
       
    }
    
    def prc={
        session.chosenHome="prc" 
         def study=Study.get(params.id)
        session.study=study
        def caseList=[]
        def all = CaseRecord.findAllByStudy(study,[max:25])
        
        caseList = prcReportService.getPrcCaseMaps(all)
        return [caseList:caseList]
     
    }
    
    def generic={
        def  title = "Activity Center"
        def    bodyclass = "recentactivity"
        def   navigation = "/cdrlite;home;Home"
        def   divs = "recentactivity"
        def   h1studysession = true
        return[title:title,bodyclass:bodyclass,navigation:navigation,divs:divs,h1studysession:h1studysession]
    }
    
    def opshome = {
        
        session.setAttribute("chosenHome", "opshome")
        
    }
    
   
    def vocabhome = {
        session.setAttribute("chosenHome", "VOCAB")
        
    }
 
    def getQueryCountMap(caseRecordInstanceList) {
        def queryCount = [:]
        if (caseRecordInstanceList) {
            
            def activeStatus = QueryStatus.findByCode("ACTIVE")
            def countResult
            if (session.org?.code == 'DCC') {
//                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s where c in (:list) and s.id = :activeStatus group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id])
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s where c in (:list) group by c.id",  [list:caseRecordInstanceList])
            } else {
//                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and s.id = :activeStatus and o.code like :org group by c.id",  [list:caseRecordInstanceList, activeStatus:activeStatus.id, org:session.org?.code + "%"])
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.caseRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and o.code like :org group by c.id",  [list:caseRecordInstanceList, org:session.org?.code + "%"])
            }
            countResult.each() {
                queryCount.put(it[0], it[1]) 
            }
        }
            
        return queryCount
    }
    
    def getQueryCountMapCandidate(candidateRecordInstanceList) {
        def queryCountCandidate = [:]
        if (candidateRecordInstanceList) {
            def activeStatus = QueryStatus.findByCode("ACTIVE")
            def countResult
            if (session.org?.code == 'DCC') {
//                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.candidateRecord c inner join i.queryStatus s where c in (:list) and s.id = :activeStatus group by c.id",  [list:candidateRecordInstanceList, activeStatus:activeStatus.id])
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.candidateRecord c inner join i.queryStatus s where c in (:list) group by c.id",  [list:candidateRecordInstanceList])
            } else {
//                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.candidateRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and s.id = :activeStatus and o.code like :org group by c.id",  [list:candidateRecordInstanceList, activeStatus:activeStatus.id, org:session.org?.code + "%"])
                countResult= Query.executeQuery("select c.id, count(*) from Query i inner join i.candidateRecord c inner join i.queryStatus s inner join i.organization o where c in (:list) and o.code like :org group by c.id",  [list:candidateRecordInstanceList, org:session.org?.code + "%"])
            }
            countResult.each() {
                queryCountCandidate.put(it[0], it[1]) 
            }
        }

        return queryCountCandidate
    }
}
