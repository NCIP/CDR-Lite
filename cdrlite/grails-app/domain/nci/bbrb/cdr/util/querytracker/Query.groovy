package nci.bbrb.cdr.util.querytracker

import nci.bbrb.cdr.CDRBaseClass
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.CandidateRecord
import nci.bbrb.cdr.staticmembers.Study
import nci.bbrb.cdr.staticmembers.Organization
import nci.bbrb.cdr.staticmembers.QueryStatus
import nci.bbrb.cdr.staticmembers.QueryType

class Query extends CDRBaseClass {

    CaseRecord caseRecord
    CandidateRecord candidateRecord
    String other
    Study study
    Organization organization
    String openedBy
    QueryStatus queryStatus
    String isDcf
    String dcfId
    QueryType queryType
    String description
    Date dueDate
    String closedBy
    Date dateClosed
    String formName
    Integer accessId
    String task
    
    static hasMany = [queryAttachments:QueryAttachment, queryResponses:QueryResponse]
    
    static belongsTo = [deviation:Deviation]
    
    static searchable = {
        only=['description', 'id', 'accessId', 'dateCreated', 'other']
        organization component: true
        study component: true
        caseRecord component: true
        candidateRecord component: true
        'dateCreated'  name:'qtDateCreated', format: "yyyy-MM-dd HH:mm"
        'id' name: 'qtId'
        'description' name: 'qtDescription'
        'other' name: 'qtTitle'
        queryStatus component: true
        queryType component: true
    }
    
    static constraints = {
        caseRecord(nullable:true, blank:true)
        candidateRecord(nullable:true, blank:true)
        other(nullable:true, blank:true)
        study(nullable:true, blank:true)
        organization(nullable:true, blank:true)
        openedBy(nullable:true, blank:true)
        queryStatus(nullable:true, blank:true)
        isDcf(nullable:true, blank:true)
        dcfId(nullable:true, blank:true)
        queryType(nullable:true, blank:true)
        description(nullable:true, blank:true, widget:'textarea', maxSize:4000)
        dueDate(nullable:true, blank:true)
        closedBy(nullable:true, blank:true)
        dateClosed(nullable:true, blank:true)
        accessId(unique:true, nullable:true, blank:true)
        task(nullable:true, blank:true)
        deviation(nullable:true, blank:true)
    }
    
    static mapping = {
        table 'query'
        id generator:'sequence', params:[sequence:'query_pk']
        sort dateCreated:'desc'
        queryAttachments sort:'dateCreated'
        queryResponses sort:'dateCreated'
    } 
}
