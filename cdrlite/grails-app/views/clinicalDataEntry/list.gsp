
<%@ page import="nci.bbrb.cdr.forms.ClinicalDataEntry" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'clinicalDataEntry.label', default: 'ClinicalDataEntry')}" />
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
                                    
                                    <th><g:message code="clinicalDataEntry.caseRecord.label" default="Case Record" /></th>
                                        
                                        <g:sortableColumn property="dateSubmitted" title="${message(code: 'clinicalDataEntry.dateSubmitted.label', default: 'Date Submitted')}" />
                                        
                                        <g:sortableColumn property="submittedBy" title="${message(code: 'clinicalDataEntry.submittedBy.label', default: 'Submitted By')}" />
                                        
                                        <g:sortableColumn property="prevMalignancy" title="${message(code: 'clinicalDataEntry.prevMalignancy.label', default: 'Prev Malignancy')}" />
                                        
                                        <g:sortableColumn property="prevCancerDiagDt" title="${message(code: 'clinicalDataEntry.prevCancerDiagDt.label', default: 'Prev Cancer Diag Dt')}" />
                                        
                                        <g:sortableColumn property="prevCancerDiagEst" title="${message(code: 'clinicalDataEntry.prevCancerDiagEst.label', default: 'Prev Cancer Diag Est')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${clinicalDataEntryInstanceList}" status="i" var="clinicalDataEntryInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${clinicalDataEntryInstance.id}">${fieldValue(bean: clinicalDataEntryInstance, field: "caseRecord")}</g:link></td>
                                        
                                        <td><g:formatDate date="${clinicalDataEntryInstance.dateSubmitted}" /></td>
                                        
                                        <td>${fieldValue(bean: clinicalDataEntryInstance, field: "submittedBy")}</td>
                                        
                                        <td>${fieldValue(bean: clinicalDataEntryInstance, field: "prevMalignancy")}</td>
                                        
                                        <td><g:formatDate date="${clinicalDataEntryInstance.prevCancerDiagDt}" /></td>
                                        
                                        <td>${fieldValue(bean: clinicalDataEntryInstance, field: "prevCancerDiagEst")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${clinicalDataEntryInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
