
<%@ page import="nci.bbrb.cdr.staticmembers.Organization" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'organization.label', default: 'Organization')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
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
                            <td valign="top" class="name"><g:message code="organization.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: organizationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="organization.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: organizationInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="organization.code.label" default="Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: organizationInstance, field: "code")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="organization.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: organizationInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="organization.shippingAddress.label" default="Shipping Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: organizationInstance, field: "shippingAddress")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="organization.isBss.label" default="Is Bss" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${organizationInstance?.isBss}" /></td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:organizationInstance, action:'edit']" method="POST" >
                            <g:hiddenField name="id" value="${organizationInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
