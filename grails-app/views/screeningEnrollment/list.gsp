
<%@ page import="nci.bbrb.cdr.forms.ScreeningEnrollment" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'screeningEnrollment.label', default: 'ScreeningEnrollment')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix"> 
                       <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                        <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    
                                    <th><g:message code="screeningEnrollment.candidateRecord.label" default="Candidate Record" /></th>
                                        
                                        <g:sortableColumn property="nameCreateCandidate" title="${message(code: 'screeningEnrollment.nameCreateCandidate.label', default: 'Name Create Candidate')}" />
                                        
                                        <g:sortableColumn property="metCriteria" title="${message(code: 'screeningEnrollment.metCriteria.label', default: 'Met Criteria')}" />
                                        
                                        <g:sortableColumn property="comments" title="${message(code: 'screeningEnrollment.comments.label', default: 'Comments')}" />
                                        
                                        <g:sortableColumn property="screeningDate" title="${message(code: 'screeningEnrollment.screeningDate.label', default: 'Screening Date')}" />
                                        
                                        <g:sortableColumn property="dateSubmitted" title="${message(code: 'screeningEnrollment.dateSubmitted.label', default: 'Date Submitted')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${screeningEnrollmentInstanceList}" status="i" var="screeningEnrollmentInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${screeningEnrollmentInstance.id}">${fieldValue(bean: screeningEnrollmentInstance, field: "candidateRecord.candidateId")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: screeningEnrollmentInstance, field: "nameCreateCandidate")}</td>
                                        
                                        <td>${fieldValue(bean: screeningEnrollmentInstance, field: "metCriteria")}</td>
                                        
                                        <td>${fieldValue(bean: screeningEnrollmentInstance, field: "comments")}</td>
                                        
                                        <td><g:formatDate date="${screeningEnrollmentInstance.screeningDate}" /></td>
                                        
                                        <td><g:formatDate date="${screeningEnrollmentInstance.dateSubmitted}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${screeningEnrollmentInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
