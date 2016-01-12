<%@ page import="nci.bbrb.cdr.forms.ScreeningEnrollment" %>
<!DOCTYPE html>
<html>
	 <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'screeningEnrollment.label', default: ' Candidate Screening Enrollment Form ')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
	<body>
            <input type='hidden' name="id" value="${screeningEnrollmentInstance?.id}" />
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
                <g:hasErrors bean="${screeningEnrollmentInstance}">
                    <div class="errors">
                        <g:renderErrors bean="${screeningEnrollmentInstance}" as="list" />
                    </div>
                </g:hasErrors>
		<g:form url="[resource:screeningEnrollmentInstance, action:'update']" >
		    <g:hiddenField name="version" value="${screeningEnrollmentInstance?.version}" />
                        <fieldset class="form">
                            <g:render template="form"/>
		        </fieldset>
                        <div class="buttons">
                            <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
                            <g:if test="${canSubmit == 'Yes'}">
                                <span class="button"><g:actionSubmit class="save" action="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}" onclick="return checkModification()" /></span>
                            </g:if>
                        </div>
		    </g:form>
		</div>
	</body>
</html>
