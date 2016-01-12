
<%@ page import="nci.bbrb.cdr.forms.ConsentVerification" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'consentVerification.label', default: 'ConsentVerification')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix"> 
                       <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                        <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    
                                    <th><g:message code="consentVerification.candidateRecord.label" default="Candidate Record" /></th>
                                        
                                        <g:sortableColumn property="protocolSiteNum" title="${message(code: 'consentVerification.protocolSiteNum.label', default: 'Protocol Site Num')}" />
                                        
                                        <g:sortableColumn property="consentor" title="${message(code: 'consentVerification.consentor.label', default: 'Consentor')}" />
                                        
                                        <g:sortableColumn property="consentorRelationship" title="${message(code: 'consentVerification.consentorRelationship.label', default: 'Consentor Relationship')}" />
                                        
                                        <g:sortableColumn property="otherConsentRelation" title="${message(code: 'consentVerification.otherConsentRelation.label', default: 'Other Consent Relation')}" />
                                        
                                        <g:sortableColumn property="meetAge" title="${message(code: 'consentVerification.meetAge.label', default: 'Meet Age')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${consentVerificationInstanceList}" status="i" var="consentVerificationInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${consentVerificationInstance.id}">${fieldValue(bean: consentVerificationInstance, field: "candidateRecord")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: consentVerificationInstance, field: "protocolSiteNum")}</td>
                                        
                                        <td>${fieldValue(bean: consentVerificationInstance, field: "consentor")}</td>
                                        
                                        <td>${fieldValue(bean: consentVerificationInstance, field: "consentorRelationship")}</td>
                                        
                                        <td>${fieldValue(bean: consentVerificationInstance, field: "otherConsentRelation")}</td>
                                        
                                        <td>${fieldValue(bean: consentVerificationInstance, field: "meetAge")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${consentVerificationInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
