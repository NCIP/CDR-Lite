
<%@ page import="nci.bbrb.cdr.staticmembers.CaseStatus" %>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'CaseStatus.label', default: 'Case Status')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
                  
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
                            <td valign="top" class="name"><g:message code="CaseStatus.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: caseStatusInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="CaseStatus.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: caseStatusInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="CaseStatus.code.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: caseStatusInstance, field: "code")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="CaseStatus.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: caseStatusInstance, field: "description")}</td>
                            
                        </tr>
                    
                       
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:caseStatusInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${caseStatusInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>

