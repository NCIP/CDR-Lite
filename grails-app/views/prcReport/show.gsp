
<%@ page import="nci.bbrb.cdr.prc.PrcReport" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'prcReport.label', default: 'PrcReport')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="dialog">
                        <table>
                            <tbody>
                                
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: prcReportInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: prcReportInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.dateSubmitted.label" default="Date Submitted" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${prcReportInstance?.dateSubmitted}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.submittedBy.label" default="Submitted By" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: prcReportInstance, field: "submittedBy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: prcReportInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.caseRecord.label" default="Case Record" /></td>
                            
                            <td valign="top" class="value"><g:link controller="caseRecord" action="show" id="${prcReportInstance?.caseRecord?.id}">${prcReportInstance?.caseRecord?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${prcReportInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="prcReport.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${prcReportInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:prcReportInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${prcReportInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
