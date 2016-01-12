<%@ page import="nci.bbrb.cdr.forms.GeneralMedicalHistory" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'generalMedicalHistory.label', default: 'General Medical History')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
	<body>
		<div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>

		 <div id="container" class="clearfix">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${generalMedicalHistoryInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${generalMedicalHistoryInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:generalMedicalHistoryInstance, action:'update']" method="POST" >
				<g:hiddenField name="version" value="${generalMedicalHistoryInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
