
<%@ page import="nci.bbrb.cdr.forms.MedicationHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'medicationHistory.label', default: 'Medication History')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                  <g:link class="list" action="list" id="${medicationHistoryInstance.candidateRecord?.id}"><g:message code="default.list.label" args="[entityName]" /></g:link>
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
                            <td valign="top" class="name"><g:message code="medicationHistory.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: medicationHistoryInstance, field: "id")}</td>
                            
                        </tr>
                    
                      
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="medicationHistory.medicationName.label" default="Medication Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: medicationHistoryInstance, field: "medicationName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="medicationHistory.dateofLastAdministration.label" default="Dateof Last Administration" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${medicationHistoryInstance?.dateofLastAdministration}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="medicationHistory.source.label" default="Source" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: medicationHistoryInstance, field: "source")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="medicationHistory.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${medicationHistoryInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                       
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="medicationHistory.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${medicationHistoryInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:medicationHistoryInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${medicationHistoryInstance?.id}" />
                            <g:if test="${session.DM}">
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                            </g:if>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
