
<%@ page import="nci.bbrb.cdr.forms.SlideSection" %>
<g:set var="bodyclass" value="bpvslideprep show bpv-study" scope="request"/>

<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        %{-- <g:set var="entityName" value="${slideSectionInstance?.formMetadata?.cdrFormName}" /> --}%
        <g:set var="caseId" value="${slideSectionInstance?.caseRecord?.caseId}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
        </div>
        <div id="container" class="clearfix">
            <h1><g:message code="default.show.label.with.case.id" args="['Slide Section Form',caseId]" /></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:queryDesc caserecord="${slideSectionInstance?.caseRecord}" form="slideSection" />
            <div id="show" class="dialog">
                <g:render template="formFieldsInc" />
            </div>
            <g:if test="${slideSectionInstance?.dateSubmitted &&
                slideSectionInstance?.caseRecord?.candidateRecord?.isEligible &&
                    slideSectionInstance?.caseRecord?.candidateRecord?.isConsented &&
                        canResume}">
                <div class="buttons">
                    <g:form>
                        <g:hiddenField name="id" value="${slideSectionInstance?.id}"/>
                        <span class="button">
                            <g:actionSubmit class="edit" action="resumeEditing" value="${message(code: 'default.button.resumeEditing.label', default: 'Resume Editing')}"/>
                        </span>
                    </g:form>
                </div>
            </g:if>
        </div>
    </body>
</html>