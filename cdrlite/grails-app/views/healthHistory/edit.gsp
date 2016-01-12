<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'healthHistory.label', default: 'Health History')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'healthHistory.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>


            </div>
        </div>

        <div id="container" class="clearfix">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${healthHistoryInstance}">
                <div class="errors">
                    <g:renderErrors bean="${healthHistoryInstance}" as="list" />
                </div>
            </g:hasErrors>
            <g:form url="[resource:healthHistoryInstance, action:'update']" method="POST" >
                <g:hiddenField name="version" value="${healthHistoryInstance?.version}" />
                <fieldset class="form">
                    <g:render template="/candidateRecord/candidateDetails" bean="${healthHistoryInstance.candidateRecord}" var="candidateRecord"/>
                    <g:render template="form"/>
                </fieldset>

                <fieldset class="buttons">
                    <g:actionSubmit class="save" action="update" value="Save" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
