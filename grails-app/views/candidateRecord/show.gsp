
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'candidateRecord.label', default: 'CandidateRecord')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:set var="canModify" value="${session.DM == true }" />
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1>View Candidate Record Details for ${candidateRecordInstance.candidateId}</h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="dialog">
                        <table>
                            <tbody>
                        
                       <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.candidateId.label" default="Candidate Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: candidateRecordInstance, field: "candidateId")}
                             <g:if test="${session.DM}">
                                  <g:link controller="candidateRecord" action="edit" params="['id': candidateRecordInstance.id]" >(Edit)</g:link>
                             </g:if>
                            </td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.study.label" default="Study" /></td>
                            
                            <td valign="top" class="value">${candidateRecordInstance?.study?.encodeAsHTML()}</td>
                            
                        </tr>
                       
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.bss.label" default="Bss" /></td>
                            
                            <td valign="top" class="value">${candidateRecordInstance?.bss.name} (${candidateRecordInstance?.bss?.code})</td>
                            
                        </tr>
                    
                      
                    
                        
                        
                       

                        
                        
                        
                       
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${candidateRecordInstance?.dateCreated}" /></td>
                            
                        </tr>
                    <tr class="prop">
                            <td valign="top" class="name">
                              <label>Screening Enrollment Form:</label>
                            </td>
                            <td>
                          <g:if test="${!candidateRecordInstance.screeningEnrollment}">
                            <span class="no">Not Started</span>
                            <g:if test="${canModify}">
                              <a href="/cdrlite/screeningEnrollment/create?candidateRecord.id=${candidateRecordInstance.id}">(Start)</a>
                            </g:if>
                          </g:if>
                          <g:elseif test="${!candidateRecordInstance.screeningEnrollment.dateSubmitted}">
                            <span class="incomplete">In Progress</span>
                            <g:if test="${canModify}">
                              <g:link controller="screeningEnrollment" action="edit" id="${candidateRecordInstance.screeningEnrollment.id}">(Edit)</g:link>
                            </g:if>
                            <g:else>
                              <g:link controller="screeningEnrollment" action="show" id="${candidateRecordInstance.screeningEnrollment.id}">(View)</g:link>
                            </g:else>
                          </g:elseif>
                          <g:else>
                            <span class="yes">Completed</span>
                            <g:link controller="screeningEnrollment" action="show" id="${candidateRecordInstance.screeningEnrollment.id}">(View)</g:link>
                          </g:else>
                          </td>                   
                        
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                              <label>Consent Verification Form:</label>
                            </td>
                            <td>
                          <g:if test="${!candidateRecordInstance.consentVerification}">
                            <span class="no">Not Started</span>
                            <g:if test="${canModify}">
                              <a href="/cdrlite/consentVerification/create?candidateRecord.id=${candidateRecordInstance.id}">(Start)</a>
                            </g:if>
                          </g:if>
                          <g:elseif test="${!candidateRecordInstance.consentVerification.dateSubmitted}">
                            <span class="incomplete">In Progress</span>
                            <g:if test="${canModify}">
                              <g:link controller="consentVerification" action="edit" id="${candidateRecordInstance.consentVerification.id}">(Edit)</g:link>
                            </g:if>
                            <g:else>
                              <g:link controller="consentVerification" action="show" id="${candidateRecordInstance.consentVerification.id}">(View)</g:link>
                            </g:else>
                          </g:elseif>
                          <g:else>
                            <span class="yes">Completed</span>
                            <g:link controller="consentVerification" action="show" id="${candidateRecordInstance.consentVerification.id}">(View)</g:link>
                          </g:else>
                          </td>                   
                        
                        </tr>
                      
                       
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.isConsented.label" default="Is Consented" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${candidateRecordInstance?.isConsented}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.isEligible.label" default="Is Eligible" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${candidateRecordInstance?.isEligible}" /></td>
                            
                        </tr>
                        <%-- show health & social history forms only if candidate is eligible and consented --%>
                        <g:if test="${candidateRecordInstance?.isEligible == true && candidateRecordInstance?.isConsented == true}">
                           
                         <tr class="prop">
                            <td valign="top" class="name">
                              <label>Demographics Form:</label>
                            </td>
                            <td>
                          <g:if test="${!candidateRecordInstance.demographics}">
                            <span class="no">Not Started</span>
                            <g:if test="${canModify}">
                              <a href="/cdrlite/demographics/create?candidateRecord.id=${candidateRecordInstance.id}">(Start)</a>
                            </g:if>
                          </g:if>
                            <g:elseif test="${!candidateRecordInstance.demographics.dateSubmitted}">
                            <span class="incomplete">In Progress</span>
                            <g:if test="${canModify}">
                              <g:link controller="demographics" action="edit" id="${candidateRecordInstance.demographics.id}">(Edit)</g:link>
                            </g:if>
                            <g:else>
                              <g:link controller="demographics" action="show" id="${candidateRecordInstance.demographics.id}">(View)</g:link>
                            </g:else>
                          </g:elseif>
                          <g:else>
                            <span class="yes">Completed</span>
                            <g:link controller="demographics" action="show" id="${candidateRecordInstance.demographics.id}">(View)</g:link>
                          </g:else>
                          </td>                   
                        
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                              <label>Health History Form:</label>
                            </td>
                            <td>
                          <g:if test="${!candidateRecordInstance.healthHistory}">
                            <span class="no">Not Started</span>
                            <g:if test="${canModify}">
                              <a href="/cdrlite/healthHistory/create?candidateRecord.id=${candidateRecordInstance.id}">(Start)</a>
                            </g:if>
                          </g:if>
                            <g:elseif test="${!candidateRecordInstance.healthHistory.dateSubmitted}">
                            <span class="incomplete">In Progress</span>
                            <g:if test="${canModify}">
                              <g:link controller="healthHistory" action="show" id="${candidateRecordInstance.healthHistory.id}">(Edit)</g:link>
                            </g:if>
                            <g:else>
                              <g:link controller="healthHistory" action="display" id="${candidateRecordInstance.healthHistory.id}">(View)</g:link>
                            </g:else>
                          </g:elseif>
                          <g:else>
                            <span class="yes">Completed</span>
                            <g:link controller="healthHistory" action="show" id="${candidateRecordInstance.healthHistory.id}">(View)</g:link>
                          </g:else>
                          </td>                   
                        
                        </tr>
                        
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                              <label>Social History Form:</label>
                            </td>
                            <td>
                          <g:if test="${!candidateRecordInstance.socialHistory}">
                            <span class="no">Not Started</span>
                            <g:if test="${canModify}">
                              <a href="/cdrlite/socialHistory/create?candidateRecord.id=${candidateRecordInstance.id}">(Start)</a>
                            </g:if>
                          </g:if>
                            <g:elseif test="${!candidateRecordInstance.socialHistory.dateSubmitted}">
                            <span class="incomplete">In Progress</span>
                            <g:if test="${canModify}">
                              <g:link controller="socialHistory" action="edit" id="${candidateRecordInstance.socialHistory.id}">(Edit)</g:link>
                            </g:if>
                            <g:else>
                              <g:link controller="socialHistory" action="show" id="${candidateRecordInstance.socialHistory.id}">(View)</g:link>
                            </g:else>
                          </g:elseif>
                          <g:else>
                            <span class="yes">Completed</span>
                            <g:link controller="socialHistory" action="show" id="${candidateRecordInstance.socialHistory.id}">(View)</g:link>
                          </g:else>
                          </td>                   
                        
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="caseList"><g:message code="candidateRecord.caseList.label" default="Case List" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'caseList', 'error')}">

                            <ul class="one-to-many">
                            <g:each in="${candidateRecordInstance?.caseList}" var="c">
                                <li><g:link controller="caseRecord" action="show" id="${c.id}">${c?.caseId}</g:link></li>
                            </g:each>
                            <li class="add">
                            <g:if test="${candidateRecordInstance?.caseList}">
                            <g:link controller="caseRecord" action="create" params="['candidateRecord.id': candidateRecordInstance?.id]" onclick="return confirm('There are cases for this candidate, are you sure that you want to add another case?');">${message(code: 'default.add.label', args: [message(code: 'caseRecord.label', default: 'CaseRecord')])}</g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="caseRecord" action="create" params="['candidateRecord.id': candidateRecordInstance?.id]" >${message(code: 'default.add.label', args: [message(code: 'caseRecord.label', default: 'CaseRecord')])}</g:link>
                            </g:else>
                            </li>
                            </ul>


                            </td>
                        </tr>
                        </g:if>
                        
                           
                    
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="candidateRecord.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${candidateRecordInstance?.comments}</td>
                            
                        </tr>
                    
                       
                    
                            </tbody>
                        </table>
                    </div>
                    
            </div>
    </body>
</html>
