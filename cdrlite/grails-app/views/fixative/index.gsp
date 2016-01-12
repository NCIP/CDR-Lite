
<%@ page import="nci.bbrb.cdr.staticmembers.Fixative" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'fixative.label', default: 'Fixative')}" />
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

                            <g:sortableColumn property="name" title="${message(code: 'fixative.name.label', default: 'Name')}" />

                            <g:sortableColumn property="code" title="${message(code: 'fixative.code.label', default: 'Code')}" />

                            <g:sortableColumn property="description" title="${message(code: 'fixative.description.label', default: 'Description')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${fixativeInstanceList}" status="i" var="fixativeInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:link action="show" id="${fixativeInstance.id}">${fieldValue(bean: fixativeInstance, field: "name")}</g:link></td>

                                <td>${fieldValue(bean: fixativeInstance, field: "code")}</td>

                                <td>${fieldValue(bean: fixativeInstance, field: "description")}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${fixativeInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
