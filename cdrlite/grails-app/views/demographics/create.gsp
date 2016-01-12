<!DOCTYPE html>
<g:set var="bodyclass" value="demographics create candidate" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'demographics.label', default: 'Candidate Demographics form')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript" src="/cdrlite/js/demographic.js"></script>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
        </div>
        <div id="container" class="clearfix">
           <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${demographicsInstance}">
                <div class="errors">
                    <g:renderErrors bean="${demographicsInstance}" as="list" />
                </div>
            </g:hasErrors>

            <g:form url="[resource:demographicsInstance, action:'save']" >
                <div class="dialog">
                    <g:render template="form"/>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
