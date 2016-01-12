<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'socialHistory.label', default: 'Social History')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'socialHistory.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script> 
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
                    <g:hasErrors bean="${socialHistoryInstance}">
                        <div class="errors">
                            <g:renderErrors bean="${socialHistoryInstance}" as="list" />
                        </div>
                    </g:hasErrors>


                    <g:form url="[resource:socialHistoryInstance, action:'save']" >
                         <g:hiddenField name="candidateRecord.id" value="${socialHistoryInstance?.candidateRecord?.id}" />
                        <div class="dialog">
                            <g:render template="/candidateRecord/candidateDetails" bean="${socialHistoryInstance.candidateRecord}" var="candidateRecord"/>
                            <g:render template="form"/>
                        </div>
                        <div class="buttons">

                            <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
                        </div>
                    </g:form>
            </div>
    </body>
</html>
