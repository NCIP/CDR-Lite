
<%@ page import="nci.bbrb.cdr.forms.TissueReceiptDissection" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'tissueReceiptDissection.label', default: 'TissueReceiptDissection')}" />
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
                                    
                                    <th><g:message code="tissueReceiptDissection.caseRecord.label" default="Case Record" /></th>
                                        
                                        <g:sortableColumn property="receiptDissectSOP" title="${message(code: 'tissueReceiptDissection.receiptDissectSOP.label', default: 'Receipt Dissect SOP')}" />
                                        
                                        <g:sortableColumn property="dateTimeTissueReceived" title="${message(code: 'tissueReceiptDissection.dateTimeTissueReceived.label', default: 'Date Time Tissue Received')}" />
                                        
                                        <g:sortableColumn property="tissueRecipient" title="${message(code: 'tissueReceiptDissection.tissueRecipient.label', default: 'Tissue Recipient')}" />
                                        
                                        <g:sortableColumn property="tissueReceiptComment" title="${message(code: 'tissueReceiptDissection.tissueReceiptComment.label', default: 'Tissue Receipt Comment')}" />
                                        
                                        <g:sortableColumn property="parentTissueDissectedBy" title="${message(code: 'tissueReceiptDissection.parentTissueDissectedBy.label', default: 'Parent Tissue Dissected By')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${tissueReceiptDissectionInstanceList}" status="i" var="tissueReceiptDissectionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${tissueReceiptDissectionInstance.id}">${fieldValue(bean: tissueReceiptDissectionInstance, field: "caseRecord")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: tissueReceiptDissectionInstance, field: "receiptDissectSOP")}</td>
                                        
                                        <td><g:formatDate date="${tissueReceiptDissectionInstance.dateTimeTissueReceived}" /></td>
                                        
                                        <td>${fieldValue(bean: tissueReceiptDissectionInstance, field: "tissueRecipient")}</td>
                                        
                                        <td>${fieldValue(bean: tissueReceiptDissectionInstance, field: "tissueReceiptComment")}</td>
                                        
                                        <td>${fieldValue(bean: tissueReceiptDissectionInstance, field: "parentTissueDissectedBy")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${tissueReceiptDissectionInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
