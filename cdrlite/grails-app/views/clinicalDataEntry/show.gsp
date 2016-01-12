<%@ page import="nci.bbrb.cdr.forms.ClinicalDataEntry" %>
<g:set var="bodyclass" value="clinicaldata show study" scope="request"/>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'clinicalDataEntry.label', default: 'Clinical Data Entry Form ')}" />
        <g:set var="caseId" value="${clinicalDataEntryInstance?.caseRecord?.caseId}"/>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:if test="${env != 'production'}">
          <%-- cache buster--%>
          <g:set var="d" value="${new Date()}" />
          <g:set var="ts" value="${d.format('yyyy-MM-dd:HH')}" />
        </g:if>      
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'clinical-data-entry.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script> 
    </head>
    <g:set var="canModify" value="${session.DM && true }" />
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
        </div>
        
         <div id="container" class="clearfix">
            <h1><g:message code="default.show.label.with.case.id" args="[entityName,caseId]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:queryDesc caserecord="${clinicalDataEntryInstance?.caseRecord}" form="clinical" />
            <div id="show">
                <div class="dialog tdwrap tdtop">
                    <g:render template="form" />
                </div>
            </div>
            <g:if test="${clinicalDataEntryInstance?.dateSubmitted &&
                clinicalDataEntryInstance?.caseRecord?.candidateRecord?.isEligible &&
                clinicalDataEntryInstance?.caseRecord?.candidateRecord?.isConsented &&
                canModify}">
                <div class="buttons">
                    <g:form class="tdwrap tdtop">
                        <g:hiddenField name="id" value="${clinicalDataEntryInstance?.id}"/>
                        <span class="button"><g:actionSubmit class="edit" action="resumeEditing" value="${message(code: 'default.button.resumeEditing.label', default: 'Resume Editing')}" /></span>
                    </g:form>
                </div>
            </g:if>
        </div>
        
        
    </body>
</html>
