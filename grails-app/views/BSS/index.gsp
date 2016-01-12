
<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'BSS.label', default: 'BSS')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                <%--   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link> --%>
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
                                    
                                        <g:sortableColumn property="name" title="${message(code: 'BSS.name.label', default: 'Name')}" />
                                        
                                        <g:sortableColumn property="code" title="${message(code: 'BSS.code.label', default: 'Code')}" />
                                        
                                        <g:sortableColumn property="description" title="${message(code: 'BSS.description.label', default: 'Description')}" />
                                        
                                      <%--  <g:sortableColumn property="IRBprotocol" title="${message(code: 'BSS.IRBprotocol.label', default: 'IRB protocol')}" /> --%>
                                        
                                        <g:sortableColumn property="timeZone" title="${message(code: 'BSS.timeZone.label', default: 'Time Zone')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${BSSInstanceList}" status="i" var="BSSInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${BSSInstance.id}">${fieldValue(bean: BSSInstance, field: "name")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: BSSInstance, field: "code")}</td>
                                        
                                        <td>${fieldValue(bean: BSSInstance, field: "description")}</td>
                                        
                                     <%--   <td>${fieldValue(bean: BSSInstance, field: "IRBprotocol")}</td> --%>
                                        
                                        <td>${fieldValue(bean: BSSInstance, field: "timeZone")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${BSSInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
