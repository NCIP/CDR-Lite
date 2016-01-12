

<%@ page import="nci.bbrb.cdr.forms.SlidePrep" %>
<g:set var="labelNumber" value="${1}"/>
<g:render template="/caseRecord/caseDetails" bean="${slidePrepInstance?.caseRecord}" var="caseRecord" />


<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'slidePrep.label', default: 'Slide Prep Form')}" />
        <g:set var="bodyclass" value="slideprep show bps-study" scope="request"/>
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
                <g:form url="[resource:slidePrepInstance, action:'edit']" method="POST" >
                    <g:hiddenField name="id" value="${slidePrepInstance?.id}" />
                   
                       <g:if test="${session.DM && slidePrepInstance?.dateSubmitted && slidePrepInstance?.caseRecord?.candidateRecord?.isEligible && slidePrepInstance?.caseRecord?.candidateRecord?.isConsented && canResume}">
                         <span class="button"><g:actionSubmit class="edit" action="resumeEditing" value="${message(code: 'default.button.resumeEditing.label', default: 'Resume Editing')}" /></span>
                    

                    </g:if>
                 

                </g:form>
            </div>
        </div>
    </body>
</html>
