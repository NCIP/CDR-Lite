
<%@ page import="nci.bbrb.cdr.staticmembers.Organization" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'organization.label', default: 'Organization')}" />
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
                                    
                                        <g:sortableColumn property="name" title="${message(code: 'organization.name.label', default: 'Name')}" />
                                        
                                        <g:sortableColumn property="code" title="${message(code: 'organization.code.label', default: 'Code')}" />
                                        
                                        <g:sortableColumn property="description" title="${message(code: 'organization.description.label', default: 'Description')}" />
                                        
                                        <g:sortableColumn property="shippingAddress" title="${message(code: 'organization.shippingAddress.label', default: 'Shipping Address')}" />
                                        
                                        <g:sortableColumn property="isBss" title="${message(code: 'organization.isBss.label', default: 'Is Bss')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${organizationInstanceList}" status="i" var="organizationInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${organizationInstance.id}">${fieldValue(bean: organizationInstance, field: "name")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: organizationInstance, field: "code")}</td>
                                        
                                        <td>${fieldValue(bean: organizationInstance, field: "description")}</td>
                                        
                                        <td>${fieldValue(bean: organizationInstance, field: "shippingAddress")}</td>
                                        
                                        <td><g:formatBoolean boolean="${organizationInstance.isBss}" /></td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${organizationInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
