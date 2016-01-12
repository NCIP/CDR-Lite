
<%@ page import="nci.bbrb.cdr.forms.TissueGrossEvaluation" %>
<g:set var="bodyclass" value="tissuegrosseval show bps-study" scope="request"/>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'tissueGrossEvaluation.label', default: 'Tissue Gross Evaluation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div id="show">
                <div class="dialog tdwrap tdtop">
                    <g:render template="form" />
                </div>
            </div>
            <div class="buttons">
                <g:form url="[resource:tissueGrossEvaluationInstance, action:'edit']" method="POST" >
                    <g:hiddenField name="id" value="${tissueGrossEvaluationInstance?.id}" />
                     <g:if test="${session.DM && tissueGrossEvaluationInstance?.dateSubmitted && tissueGrossEvaluationInstance?.caseRecord?.candidateRecord?.isEligible && tissueGrossEvaluationInstance?.caseRecord?.candidateRecord?.isConsented && canResume}">
                   <%--     <g:if test="${session.DM && tissueGrossEvaluationInstance?.dateSubmitted  && canResume}"> --%>
                         <span class="button"><g:actionSubmit class="edit" action="resumeEditing" value="${message(code: 'default.button.resumeEditing.label', default: 'Resume Editing')}" /></span>
                    <%--    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    --%>

                    </g:if>
                 

                </g:form>
            </div>
        </div>
    </body>
</html>