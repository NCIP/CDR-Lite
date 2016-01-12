
<%@ page import="nci.bbrb.cdr.prc.PrcReport" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'prcReport.label', default: 'PrcReport')}" />
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
                                    
                                        <g:sortableColumn property="comments" title="${message(code: 'prcReport.comments.label', default: 'Comments')}" />
                                        
                                        <g:sortableColumn property="dateSubmitted" title="${message(code: 'prcReport.dateSubmitted.label', default: 'Date Submitted')}" />
                                        
                                        <g:sortableColumn property="submittedBy" title="${message(code: 'prcReport.submittedBy.label', default: 'Submitted By')}" />
                                        
                                        <g:sortableColumn property="status" title="${message(code: 'prcReport.status.label', default: 'Status')}" />
                                        
                                    <th><g:message code="prcReport.caseRecord.label" default="Case Record" /></th>
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'prcReport.dateCreated.label', default: 'Date Created')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${prcReportInstanceList}" status="i" var="prcReportInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${prcReportInstance.id}">${fieldValue(bean: prcReportInstance, field: "comments")}</g:link></td>
                                        
                                        <td><g:formatDate date="${prcReportInstance.dateSubmitted}" /></td>
                                        
                                        <td>${fieldValue(bean: prcReportInstance, field: "submittedBy")}</td>
                                        
                                        <td>${fieldValue(bean: prcReportInstance, field: "status")}</td>
                                        
                                        <td>${fieldValue(bean: prcReportInstance, field: "caseRecord")}</td>
                                        
                                        <td><g:formatDate date="${prcReportInstance.dateCreated}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${prcReportInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
