
<%@ page import="nci.bbrb.cdr.datarecords.SlideRecord" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'slideRecord.label', default: 'SlideRecord')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

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
                    <div class="dialog">
                        <table>
                            <tbody>
                                
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: slideRecordInstance, field: "id")}</td>
                            
                        </tr>
                    
                      <%--  <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.imageRecord.label" default="Image Record" /></td>
                            
                            <td valign="top" class="value"><g:link controller="imageRecord" action="show" id="${slideRecordInstance?.imageRecord?.id}">${slideRecordInstance?.imageRecord?.encodeAsHTML()}</g:link></td>
                            
                        </tr>--%>
                    
                      <%--  <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.prcReport.label" default="Prc Report" /></td>
                            
                            <td valign="top" class="value"><g:link controller="prcReport" action="show" id="${slideRecordInstance?.prcReport?.id}">${slideRecordInstance?.prcReport?.encodeAsHTML()}</g:link></td>
                            
                        </tr>--%>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${slideRecordInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${slideRecordInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                       <%-- <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.processEvents.label" default="Process Events" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${slideRecordInstance.processEvents}" var="p">
                                    <li><g:link controller="processingEvent" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>--%>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.slideId.label" default="Slide Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: slideRecordInstance, field: "slideId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="slideRecord.specimenRecord.label" default="Specimen Record" /></td>
                            
                            <td valign="top" class="value"><g:link controller="specimenRecord" action="show" id="${slideRecordInstance?.specimenRecord?.id}">${slideRecordInstance?.specimenRecord?.specimenId.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:slideRecordInstance, action:'edit']" method="POST" >
                            <g:hiddenField name="id" value="${slideRecordInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                           <%-- <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span> --%>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
