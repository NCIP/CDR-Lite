<%@ page import="nci.bbrb.cdr.forms.TissueProcessEmbed" %>
<g:set var="bodyclass" value="tissueprocess list" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${nci.bbrb.cdr.forms.TissueProcessEmbedController.CDR_FORM_NAME}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        </div>
      </div>
      <div id="container" class="clearfix">
            <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'bpvTissueProcessEmbed.id.label', default: 'Id')}"/>
                            <th><g:message code="tissueProcessEmbedInstance.caseRecord.label" default="Case Record"/></th>
                            <g:sortableColumn property="caseRecord.tissueBankId" title="Tissue Bank ID"/>
                            <g:sortableColumn property="expKeyBarcodeId" title="Experimental Key Barcode ID"/>
                            <g:sortableColumn property="parentBarcodeId" title="Parent Sample Barcode ID"/>
                            <g:sortableColumn property="processingSop" title="Processing SOP"/>
                            <g:sortableColumn property="tissProcessorMdl" title="Make and Model of Tissue Processor"/>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${tissueProcessEmbedInstanceList}" status="i" var="tissueProcessEmbedInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td><g:link action="show" id="${tissueProcessEmbedInstance.id}">${fieldValue(bean: tissueProcessEmbedInstance, field: "id")}</g:link></td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "caseRecord")}</td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "caseRecord.tissueBankId")}</td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "expKeyBarcodeId")}</td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "parentBarcodeId")}</td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "processingSop")}</td>
                                <td>${fieldValue(bean: tissueProcessEmbedInstance, field: "tissProcessorMdl")}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${tissueProcessEmbedInstanceTotal}"/>
            </div>
        </div>
    </body>
</html>