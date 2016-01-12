package nci.bbrb.cdr

import nci.bbrb.cdr.util.querytracker.Query
import nci.bbrb.cdr.util.querytracker.QueryAttachment
import nci.bbrb.cdr.util.FileUpload
import nci.bbrb.cdr.staticmembers.CaseAttachmentType
import nci.bbrb.cdr.staticmembers.ActivityType
import nci.bbrb.cdr.staticmembers.QueryStatus
import nci.bbrb.cdr.staticmembers.BSS
import nci.bbrb.cdr.util.AppSetting
import groovy.sql.*
import grails.util.GrailsUtil

class QueryService {

    static transactional = true
    def dataSource
    def activityEventService

    def upload(params, uploadedFile, username, orgCode) {   
        try {
            def queryInstance = Query.get(params.id)
            def fileUploadInstance = new FileUpload(params)
            
            def originalFileName = uploadedFile.originalFilename.replace(' ', '_') //replace whitespace with underscores
            def strippedFileName = originalFileName.substring(0, originalFileName.lastIndexOf('.'))                    
            def fileExtension = originalFileName.substring(originalFileName.lastIndexOf('.') + 1, originalFileName.toString().size())                         
            def current_time = (new Date()).getTime()           
            def newFileName = strippedFileName + "-" + current_time + "." + fileExtension
            def pathUploads = File.separator + 'var' + File.separator + 'storage' + File.separator + 'cdr-filestore' + File.separator + orgCode + File.separator + 'query_tracker' + File.separator + params.id
            File dir = new File(pathUploads)
            if (!dir.exists()) {
                dir.mkdirs()
            }
            uploadedFile.transferTo(new File(pathUploads, newFileName))
            
            fileUploadInstance.fileName = newFileName
            fileUploadInstance.filePath = pathUploads
            fileUploadInstance.uploadTime = new Date().getDateTimeString()
//            fileUploadInstance.hideFromBss = params.hideFromBss
            fileUploadInstance.save(flush:true)
            def queryAttachmentInstance = new QueryAttachment(fileUpload:fileUploadInstance, uploadedBy:username, query:queryInstance).save(flush:true)
            queryInstance.addToQueryAttachments(queryAttachmentInstance)
            queryInstance.save(flush:true)
        } catch (Exception e) {
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
    }
    
    def remove(params) {
        try {
            def queryAttachmentInstance = QueryAttachment.get(params.attachmentId)
            def path = queryAttachmentInstance?.fileUpload?.filePath + File.separator + queryAttachmentInstance?.fileUpload?.fileName
            def file = new File(path)
            if (file.exists()) {
                if (!file.delete()) {
                    throw new IOException("Failed to delete the query attachment file")
                }
            }
            queryAttachmentInstance?.delete(flush:true)
            queryAttachmentInstance?.fileUpload?.delete(flush:true)
        } catch (Exception e) {
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
    }
    
    def createFznRequest(organization, caseRecord, queryType, description, dueDate, openedBy) {
        def queryInstance = new Query(
            organization: organization,
            caseRecord: caseRecord,
            isDcf: 'No',
            isPr2: 'No',
            queryType: queryType,
            description: description,
            dueDate: dueDate,
            openedBy: openedBy,
            study: BSS.findByCode(organization?.code)?.study,
            queryStatus: QueryStatus.findByCode("ACTIVE"),
            task: 'FZN'
        )
        
        if (queryInstance.save(flush: true)) {
            def activityType = ActivityType.findByCode("QUERY")
            def caseId = queryInstance.caseRecord?.caseId
            def study = queryInstance.caseRecord?.study
            def bssCode = queryInstance.organization?.code
            def username = openedBy
            def orgCode = queryInstance.organization?.code
            activityEventService.createEvent(activityType, caseId, study, bssCode, null, username, queryInstance.id, orgCode)
        }
    }
    
    def createInfectiousDiseaseEntry(organization, caseRecord, queryType, description, dueDate, task) {
        def queryInstance = new Query(
            organization: organization,
            caseRecord: caseRecord,
            isDcf: 'No',
            isPr2: 'No',
            queryType: queryType,
            description: description,
            clinical: true,
            dueDate: dueDate,
            openedBy: 'auto',
            study: BSS.findByCode(organization?.code)?.study,
            queryStatus: QueryStatus.findByCode("ACTIVE"),
            task: task
        )
        
        if (queryInstance.save(flush: true)) {
            def activityType = ActivityType.findByCode("QUERY")
            def caseId = queryInstance.caseRecord?.caseId
            def study = queryInstance.caseRecord?.study
            def bssCode = queryInstance.caseRecord?.bss?.code
            def username = queryInstance.openedBy
            def orgCode = queryInstance.organization?.code
            activityEventService.createEvent(activityType, caseId, study, bssCode, null, username, queryInstance.id, orgCode)
        }
    }
    
    
    //Duration between Initial Site Response and Query Open Date. Taking the intital/first response out of several responses for a query
    def getDaysElapsedtoOpenQuery(idlist) {
        def resultMap = [:]
        def qid
        def days
        def sqlString
        //println idlist
       
        // do not include responses from these people for counting purpose 
        def query_response_exclude_str = (AppSetting.findByCode("QUERY_RESPONSE_DCC_DM")).bigValue
        def qrelist = "'" + query_response_exclude_str.replace(",", "','") + "'"
        
        if(idlist){
        
            sqlString = /* converting to postgreSQL syntax - Tabor */
            " select distinct q.id, round( cast( extract(epoch from  MAX(r.date_created - q.date_created) ) AS  integer ) ) as query_To_FirstRespnse_Days " +
            "   from query_response r, " +
            "        query q " +
            "  where q.id=r.query_id  and r.responder not in (" + qrelist + ") " +
            "  group by q.id order by q.id"
            /* old Oracle syntax: 
                " select distinct q.id, round(MAX(r.date_created - q.date_created)) as query_To_FirstRespnse_Days"+
                " from query_response r, query q "+
                " where q.id=r.query_id  and r.responder not in (" + qrelist + ") "+
                " and q.id IN (" + idlist + ") "+
                " group by q.id order by q.id"
                */
        }
        else{
            sqlString =
                " select distinct q.id, round( cast( extract(epoch from  MAX(r.date_created - q.date_created) ) AS  integer ) ) as query_To_FirstRespnse_Days"+
                " from query_response r, query q "+
                " where q.id=r.query_id  and r.responder not in (" + qrelist + ") "+
                " group by q.id order by q.id"
            /* old Oracle syntax: 
                " select distinct q.id, round(MAX(r.date_created - q.date_created)) as query_To_FirstRespnse_Days"+
                " from query_response r, query q "+
                " where q.id=r.query_id  and r.responder not in (" + qrelist + ") "+
                " group by q.id order by q.id"
            */
        }
        
        try{
            groovy.sql.Sql sql = new groovy.sql.Sql(dataSource)
        
            sql.eachRow(sqlString, { row ->
                    qid = row[0].toString()  // a map key must be a string when rendered in a .gsp
                    days = row[1]
              
                    resultMap.put(qid,days)
                    
                })
           
            sql.close()
        }catch(Exception e){
            e.printStackTrace()
        }

        return resultMap
    }
    
    
    //Duration between Query Open Date and Query Closure Date 
    def daysElapsedOpenToCloseQuery(idlist) {
        def resultMap = [:]
        def qid
        def days
        def sqlString
        //println idlist
       
        
        if(idlist){
        
            sqlString =
                " select id, date_created, date_closed,  " + 
                "        round( cast( extract(epoch from (date_closed - date_created) ) AS  integer)) as duration   "+ 
                "   from query  where id IN (" + idlist + ") order by id "
        }
        else{
            sqlString =
                  " select id, date_created, date_closed,  "+ 
                  "        round( cast( extract(epoch from (date_closed - date_created) ) AS  integer)) as duration   "+ 
                  "   from query  order by id "
            
        }
        
        try{
            groovy.sql.Sql sql = new groovy.sql.Sql(dataSource)
        
            sql.eachRow(sqlString, { row ->
                    qid = row[0].toString()  // a map key must be a string when rendered in a .gsp
                    days = row[3]
              
                    resultMap.put(qid,days)
                    
                })
           
            sql.close()
        }catch(Exception e){
            e.printStackTrace()
        }

        return resultMap
    }
    
}
