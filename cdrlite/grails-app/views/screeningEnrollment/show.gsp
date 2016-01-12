
<%@ page import="nci.bbrb.cdr.forms.ScreeningEnrollment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'screeningEnrollment.label', default: ' Candidate Screening Enrollment Form ')}" />
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
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:render template="/candidateRecord/candidateDetails" bean="${screeningEnrollmentInstance.candidateRecord}" var="candidateRecord"/>
                    <div class="dialog">
                        <table>
                            <tbody>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><label for="nameCreateCandidate">1. Name of person who performed Screening:</label></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: screeningEnrollmentInstance, field: "nameCreateCandidate")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"> <label for="metCriteria">2. Does the Candidate meet all eligibility criteria defined within the Study Protocol?</label></td>
                            <td valign="top" class="value">${fieldValue(bean: screeningEnrollmentInstance, field: "metCriteria")}
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"> <label for="comments">3.&nbsp;<g:message code="screeningEnrollment.comments.label" default="Comments" /></label></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: screeningEnrollmentInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"> <label for="screeningDate">4.&nbsp;<g:message code="screeningEnrollment.screeningDate.label" default="Screening Date" /></label></td>
                            
                            <td valign="top" class="value">
                                <g:if test="${session.LDS == true || session.DM==true}">
                                    <g:formatDate format="MM-dd-yyyy" date="${screeningEnrollmentInstance?.screeningDate}" />
                                </g:if>
                                <g:else>
                                    <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                </g:else>
                            </td>
                        </tr>
                    
                       
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:screeningEnrollmentInstance, action:'resumeEditing']" method="POST" >
                            <g:hiddenField name="id" value="${screeningEnrollmentInstance?.id}" />
                            <g:if test="${canModify}">
                            <span class="button"><g:actionSubmit class="edit" action="resumeEditing"  value="${message(code: 'default.button.resumeedit.label', default: 'Resume Edit')}" /></span>
                            </g:if>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
