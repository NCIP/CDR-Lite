
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<g:set var="bodyclass" value="caserecord list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'caseRecord.label', default: 'CaseRecord')}" />
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
                                    
                                    <th><g:message code="caseRecord.bss.label" default="Bss" /></th>
                                        
                                    <th><g:message code="caseRecord.candidateRecord.label" default="Candidate Record" /></th>
                                        
                                    <th><g:message code="caseRecord.caseCollectionType.label" default="Case Collection Type" /></th>
                                        
                                        <g:sortableColumn property="caseId" title="${message(code: 'caseRecord.caseId.label', default: 'Case Id')}" />
                                        
                                    <th><g:message code="caseRecord.caseStatus.label" default="Case Status" /></th>
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'caseRecord.dateCreated.label', default: 'Date Created')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${caseRecordInstanceList}" status="i" var="caseRecordInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${caseRecordInstance.id}">${fieldValue(bean: caseRecordInstance, field: "bss")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: caseRecordInstance, field: "candidateRecord")}</td>
                                        
                                        <td>${fieldValue(bean: caseRecordInstance, field: "caseCollectionType")}</td>
                                        
                                        <td>${fieldValue(bean: caseRecordInstance, field: "caseId")}</td>
                                        
                                        <td>${fieldValue(bean: caseRecordInstance, field: "caseStatus")}</td>
                                        
                                        <td><g:formatDate date="${caseRecordInstance.dateCreated}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${caseRecordInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
