<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'tissueReceiptDissection.label', default: 'Tissue Receipt and Dissection Form')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
            <g:hasErrors bean="${tissueReceiptDissectionInstance}">
                <div class="errors">
                <g:renderErrors bean="${tissueReceiptDissectionInstance}" as="list" />
                </div>
            </g:hasErrors>


            <g:form url="[resource:tissueReceiptDissectionInstance, action:'save']" >
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
