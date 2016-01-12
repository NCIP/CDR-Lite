
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<g:set var="bodyclass" value="prcreport home" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'caseRecord.label', default: 'CaseRecord')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
          </div>
      </div>
      <div id="container" class="clearfix">
            <h1>Case List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
              <g:form controller="textSearch" action="searchPrc">
                <input name="formtype" value="GTEX" type="hidden"></input>

                 <lable><b>Enter Search Criteria:</b></lable>
                  <input style="width:500px" id="query" type="text" name="query" value="${params.query}"/>
              <g:actionSubmit action="searchPrc" value="Go" />
         
              </g:form>
             
    
            </br>
          
            <div class="list">
               
                <g:render template="/caseRecord/caseRecordPrcTable_tmpl" bean="${caseList}" />  
               
            </div>
            <div class="paginateButtons">
                <g:paginate  total="${caseRecordInstanceTotal}" /> | Total: ${caseRecordInstanceTotal}
            </div>
        </div>
    </body>
</html>
