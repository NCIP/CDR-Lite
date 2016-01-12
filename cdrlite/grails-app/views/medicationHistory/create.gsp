<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'medicationHistory.label', default: 'Medication History')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                  <g:link class="list" action="list" id="${medicationHistoryInstance.candidateRecord?.id}"><g:message code="default.list.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix">
                       <h1><g:message code="default.create.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${medicationHistoryInstance}">
                        <div class="errors">
                            <g:renderErrors bean="${medicationHistoryInstance}" as="list" />
                        </div>
                    </g:hasErrors>


                    <g:form url="[resource:medicationHistoryInstance, action:'save']" >
                        <g:hiddenField name="candidateRecord.id" value="${medicationHistoryInstance?.candidateRecord?.id}" />
                        <div class="dialog">
                            <g:render template="form"/>
                        </div>
                        <div class="buttons">

                            <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                        </div>
                    </g:form>
            </div>
    </body>
</html>
