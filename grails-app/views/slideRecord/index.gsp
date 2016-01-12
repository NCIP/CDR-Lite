
<%@ page import="nci.bbrb.cdr.datarecords.SlideRecord" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'slideRecord.label', default: 'SlideRecord')}" />
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
                                    
                                    <th><g:message code="slideRecord.imageRecord.label" default="Image Record" /></th>
                                        
                                    <th><g:message code="slideRecord.prcReport.label" default="Prc Report" /></th>
                                        
                                        <g:sortableColumn property="dateCreated" title="${message(code: 'slideRecord.dateCreated.label', default: 'Date Created')}" />
                                        
                                        <g:sortableColumn property="lastUpdated" title="${message(code: 'slideRecord.lastUpdated.label', default: 'Last Updated')}" />
                                        
                                        <g:sortableColumn property="slideId" title="${message(code: 'slideRecord.slideId.label', default: 'Slide Id')}" />
                                        
                                    <th><g:message code="slideRecord.specimenRecord.label" default="Specimen Record" /></th>
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${slideRecordInstanceList}" status="i" var="slideRecordInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${slideRecordInstance.id}">${fieldValue(bean: slideRecordInstance, field: "imageRecord")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: slideRecordInstance, field: "prcReport")}</td>
                                        
                                        <td><g:formatDate date="${slideRecordInstance.dateCreated}" /></td>
                                        
                                        <td><g:formatDate date="${slideRecordInstance.lastUpdated}" /></td>
                                        
                                        <td>${fieldValue(bean: slideRecordInstance, field: "slideId")}</td>
                                        
                                        <td valign="top" class="value"><g:link controller="specimenRecord" action="show" id="${slideRecordInstance?.specimenRecord?.id}">${slideRecordInstance?.specimenRecord?.specimenId.encodeAsHTML()}</g:link></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${slideRecordInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
