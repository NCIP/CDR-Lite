
<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>
<g:set var="bodyclass" value="healthhistory home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'healthHistory.label', default: 'HealthHistory')}" />
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
                                    
                                        <g:sortableColumn property="internalComments" title="${message(code: 'healthHistory.internalComments.label', default: 'Internal Comments')}" />
                                        
                                        <g:sortableColumn property="publicComments" title="${message(code: 'healthHistory.publicComments.label', default: 'Public Comments')}" />
                                        
                                    <th><g:message code="healthHistory.caseRecord.label" default="Case Record" /></th>
                                        
                                        <g:sortableColumn property="source" title="${message(code: 'healthHistory.source.label', default: 'Source')}" />
                                        
                                        <g:sortableColumn property="historyOfCancer" title="${message(code: 'healthHistory.historyOfCancer.label', default: 'History Of Cancer')}" />
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'healthHistory.dateCreated.label', default: 'Date Created')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${healthHistoryInstanceList}" status="i" var="healthHistoryInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${healthHistoryInstance.id}">${fieldValue(bean: healthHistoryInstance, field: "internalComments")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "publicComments")}</td>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "caseRecord")}</td>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "source")}</td>
                                        
                                        <td>${fieldValue(bean: healthHistoryInstance, field: "historyOfCancer")}</td>
                                        
                                        <td><g:formatDate date="${healthHistoryInstance.dateCreated}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${healthHistoryInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
