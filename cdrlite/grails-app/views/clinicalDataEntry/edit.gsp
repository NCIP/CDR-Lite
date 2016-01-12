<%@ page import="nci.bbrb.cdr.forms.ClinicalDataEntry" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'clinicalDataEntry.label', default: 'Clinical Data Entry Form ')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
	    <g:if test="${flash.message}">
	        <div class="message" role="status">${flash.message}</div>
	    </g:if>
	    <g:hasErrors bean="${clinicalDataEntryInstance}">
                <div class="errors">
                    <g:renderErrors bean="${clinicalDataEntryInstance}" as="list"/>
                </div>
            </g:hasErrors>
            <g:queryDesc caserecord="${clinicalDataEntryInstance?.caseRecord}" form="clinical" />
	    <g:form method="post" class="tdwrap tdtop" url="[resource:clinicalDataEntryInstance, action:'update']">
	        <g:hiddenField name="id" value="${clinicalDataEntryInstance?.id}"/>
                <g:hiddenField name="version" value="${clinicalDataEntryInstance?.version}" />
	        <g:hiddenField name="changed" value="N"/>
                <fieldset class="form">
	            <g:render template="form"/>
	        </fieldset>
	        <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                      <g:if test="${canSubmit == 'Yes'}">
                        <span class="button">
                        <g:actionSubmit class="save" action="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}"/></span>
                    </g:if>
                    <g:if test="${clinicalDataEntryInstance.caseRecord.caseStatus.code == 'QA' && session.DM == true && session.authorities.contains("ROLE_NCI-FREDERICK_CAHUB_DM") && !canSubmit}">
                        <span class="button"><g:actionSubmit class="save saveAction" action="forceSubmit" value="${message(code: 'default.button.submit.label', default: 'Force Submit')}" onclick="return checkModification()" /></span>
                    </g:if>                    
                    <span class="button"><input class="delete" type="button" value="Cancel" onclick="if(confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Discard unsaved data?')}'))window.location.href='${createLink(uri: '/')}${params.controller}/edit/${params.id}';"></input></span>
                </div>
            </g:form>
	</div>
    </body>
</html>
