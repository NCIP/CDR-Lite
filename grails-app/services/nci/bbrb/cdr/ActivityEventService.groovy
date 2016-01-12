package nci.bbrb.cdr

import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.util.ActivityEvent
import nci.bbrb.cdr.util.AppSetting
import grails.util.GrailsUtil
import nci.bbrb.cdr.staticmembers.BSS
//import nci.bbrb.cdr.util.querytracker.Query 


class ActivityEventService {

    static transactional = true
    //def prcReportService1 = new PrcReportService()
    def env = "production".equalsIgnoreCase(GrailsUtil.environment) ? "" : " [${GrailsUtil.environment}]"
    def sendMailService
   // def AppUsersService

    //def createEvent(activityType, caseId, study, bssCode, restEventId, initiator, additionalInfo1, additionalInfo2) {
        def createEvent(activityType, caseId, study, bssCode, restEventId, initiator, additionalInfo1, additionalInfo2) {
        new ActivityEvent(
            activityType: activityType, 
            caseId: caseId, 
            study: study,
            bssCode: bssCode,
            restEventId: restEventId, 
            initiator: initiator,
            additionalInfo1: additionalInfo1,
            additionalInfo2: additionalInfo2
        ).save(failOnError: false, flush: true)
        
        sendEmail(activityType, caseId, study, bssCode, restEventId, initiator, additionalInfo1, additionalInfo2)
    }
    
    
        def sendEmail(activityType, caseId, study, bssCode, restEventId, initiator, additionalInfo1, additionalInfo2) {
        def recipient
        def emailSubject
        def emailBody

        switch(activityType.code) {
            case "CASECREATE": 
                recipient = AppSetting.findByCode('CDRLITE_ADMIN_DISTRO')?.bigValue
                
                emailSubject = "CDR-Lite Alert: ${caseId} Created"
                emailBody = additionalInfo1
                break
             case "STATUSCHG": 
                recipient = AppSetting.findByCode('CDRLITE_ADMIN_DISTRO')?.bigValue
                emailSubject = "CDR-Lite Alert:$env Case status for ${caseId} was changed"
                emailBody = "Case status for ${caseId} was changed to ${additionalInfo2} by ${initiator}. Previous status was ${additionalInfo1}."
                break
            case "QUERY":
//                def bssEmailList = (getEmailList(bssCode).length() > 0) ? ',' + getEmailList(bssCode) : ''
                recipient = AppSetting.findByCode('NEW_QUERY_TRACKER_DISTRO')?.bigValue /* + bssEmailList */
//                println "recipient: " + recipient  
                emailSubject = "CDR Alert:$env New Query Tracker was created"
                if (caseId) {
                    emailBody = "New Query Tracker ${additionalInfo1} for ${caseId} was created." 
                } else {
                    emailBody = "New Query Tracker ${additionalInfo1} was created." 
                }
                break
                
             case "PROCESSEVT": 
                    recipient = AppSetting.findByCode('APERIO_IMAGE_DISTRO')?.bigValue
                        emailSubject = "CDR Alert:$env Aperio images for ${caseId} are ready."
                        emailBody = "Aperio images for ${caseId} are now available. CBR event ID: ${restEventId}. "
                break
             
        }
        
       sendMailService.sendActivityEventEmail(recipient, emailSubject, emailBody)
    }
    
    def getEmailList(orgCodePayload) {
        def orgCode = BSS.findByCode(orgCodePayload) ? BSS.findByCode(orgCodePayload)?.code : orgCodePayload
       // def emailList = AppUsersService.getEmailList(orgCode)  AppUsersService does not exist (yet) in CDR Lite. 
       //pmh : change this later. keep this for now
        def emailList = AppSetting.findByCode('CDRLITE_ADMIN_DISTRO')?.bigValue
//        def result = ''
//        println "emailList: " + emailList
//        for (i in emailList) {
//            println "i: " + i
//            result = result + ',' + i    
//        }
//        if (result && result.length() > 0) {
//            result = result.substring(1)
//        }
        
        return emailList
    }
}
