package nci.bbrb.cdr

import grails.transaction.Transactional

@Transactional
class AccessPrivilegeService {

    def hasPrivilege(caseRecordInstance, session, action) {
       return hasPrivilegeCase(caseRecordInstance, session, action)
    }
    
     boolean   hasPrivilegeCase(caseRecordInstance, session, action) {
//        println "caseRecordInstance params: " + caseRecordInstance
//        println "session params:            " + session
//        println "action params:             " + action
        if (!caseRecordInstance) {
            return false
        }
        if (action.equals('edit')) {

//            println "caseRecordInstance.bss?.code:        " + caseRecordInstance.bss?.code
//            println "session.org?.code:                   " + session.org?.code
//            println "caseRecordInstance.caseStatus?.code: " + caseRecordInstance.caseStatus?.code
//            println "session.DM:                          " + session.DM
            if ((caseRecordInstance.bss?.code?.equals(session.org?.code) || session.org?.code?.equals('DCC')) && session.DM == true && 
                (caseRecordInstance.caseStatus?.code == 'INIT' || caseRecordInstance.caseStatus?.code == 'DATA'  || caseRecordInstance.caseStatus?.code == 'REMED')) { 
//                println "here?"
                return true
            } else {
                if (session.org?.code?.equals('DCC') && session.DM == true &&  caseRecordInstance.caseStatus?.code == 'QA') {
                    return true
                } else {
                    return false
                }
            } 
        }else if(action.equals('changeCaseStatus')){
            
             if ( session.DM == true && (session.org?.code?.equals('DCC') ||
                (caseRecordInstance.bss?.code?.equals(session.org?.code) && (caseRecordInstance.caseStatus?.code == 'DATACOMP' || caseRecordInstance.caseStatus?.code == 'DATA'  || caseRecordInstance.caseStatus?.code == 'REMED')))) { 
                return true
            } else {
               
               return false
            } 
            
            
        }else if (action.equals('show') ||  action.equals('view')) {
            
            if (caseRecordInstance.bss?.code?.equals(session.org?.code) || session.org?.code?.equals('DCC')){ 
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
            
    def hasPrivilegeCandi(candidateRecordInstance, session, action) {
        def caseList = candidateRecordInstance.caseList
        def hasPrivilege= true
        
        if(caseList){
            caseList.each(){
                if(!hasPrivilegeCase(it, session, action)){
                    hasPrivilege=false
                }
            }
            
        }else{
           if (action.equals('edit')) {

            if ((candidateRecordInstance.bss?.code?.equals(session.org?.code) || session.org?.code?.equals('DCC')) && session.DM == true ){ 
                return true
            } else {
               
               return false
            } 
           } else if (action.equals('show') ||  action.equals('view')) {
            
                if (candidateRecordInstance.bss?.code?.equals(session.org?.code) || session.org?.code?.equals('DCC')){ 

                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
                    
                    
                    
                    
                    
        }        
                
       
    }
            
    
}
