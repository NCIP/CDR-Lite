<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'clinicalDataEntry.label', default: 'Clinical Data Entry Form ')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
          <g:if test="${env != 'production'}">
          <%-- cache buster--%>
          <g:set var="d" value="${new Date()}" />
          <g:set var="ts" value="${d.format('yyyy-MM-dd:HH')}" />
        </g:if>      
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'clinical-data-entry.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script> 
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
             <g:hasErrors bean="${clinicalDataEntryInstance}">
                <div class="errors">
                    <g:renderErrors bean="${clinicalDataEntryInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:form url="[resource:clinicalDataEntryInstance, action:'save']"  class="tdwrap tdtop"> 
                <div class="dialog">
                    <g:hiddenField name="caseRecord.id" value="${params.caseRecord?.id}"/>
                    <g:render template="form"/>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
