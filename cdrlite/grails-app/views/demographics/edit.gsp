<%@ page import="nci.bbrb.cdr.forms.Demographics" %>
<g:set var="bodyclass" value="demographics edit candidate" scope="request"/>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'demographics.label', default: 'Demographics for Candidate ')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
                <g:hasErrors bean="${demographicsInstance}">
                    <div class="errors">
                        <g:renderErrors bean="${demographicsInstance}" as="list" />
                    </div>
                </g:hasErrors>
		<g:form url="[resource:demographicsInstance, action:'update']" method="POST" >
		        <g:hiddenField name="version" value="${demographicsInstance?.version}" />
			<fieldset class="form">
			    <g:render template="form"/>
			</fieldset>
			<fieldset class="buttons">
			    <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                                <g:if test="${canSubmit == 'Yes'}">
                                    <span class="button"><g:actionSubmit class="save" action="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}"/></span>
                                </g:if>
			</fieldset>
			</g:form>
		</div>
	</body>
</html>
