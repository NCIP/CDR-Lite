
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<g:set var="bodyclass" value="caserecord list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'candidateRecord.label', default: 'CandidateRecord')}" />
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
                                    
                                    <th><g:message code="candidateRecord.bss.label" default="Bss" /></th>
                                        
                                        <g:sortableColumn property="candidateId" title="${message(code: 'candidateRecord.candidateId.label', default: 'Candidate Id')}" />
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'candidateRecord.dateCreated.label', default: 'Date Created')}" />
                                        
                                        <g:sortableColumn property="isConsented" title="${message(code: 'candidateRecord.isConsented.label', default: 'Is Consented')}" />
                                        
                                        <g:sortableColumn property="isEligible" title="${message(code: 'candidateRecord.isEligible.label', default: 'Is Eligible')}" />
                                        
                                        <g:sortableColumn property="lastUpdated" title="${message(code: 'candidateRecord.lastUpdated.label', default: 'Last Updated')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${candidateRecordInstanceList}" status="i" var="candidateRecordInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${candidateRecordInstance.id}">${fieldValue(bean: candidateRecordInstance, field: "bss")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: candidateRecordInstance, field: "candidateId")}</td>
                                        
                                        <td><g:formatDate date="${candidateRecordInstance.dateCreated}" /></td>
                                        
                                        <td><g:formatBoolean boolean="${candidateRecordInstance.isConsented}" /></td>
                                        
                                        <td><g:formatBoolean boolean="${candidateRecordInstance.isEligible}" /></td>
                                        
                                        <td><g:formatDate date="${candidateRecordInstance.lastUpdated}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${candidateRecordInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
