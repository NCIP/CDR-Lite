<%@ page import="nci.bbrb.cdr.util.querytracker.Query" %>
<g:if test="${env != 'production'}">
    <%-- cache buster--%>
    <g:set var="d" value="${new Date()}" />
    <g:set var="ts" value="${d.format('yyyy-MM-dd:HH')}" />
</g:if>
<g:set var="bodyclass" value="query show" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'query.label', default: 'Query')}" />
        <script type="text/javascript" src="${resource(dir:'js',file:'query.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
            <g:if test="${queryInstance?.caseRecord}">
                <a class="list" href="/cdrlite/query/listByCase?caseRecord.id=${queryInstance?.caseRecord?.id}">Query List for ${queryInstance?.caseRecord?.caseId}</a>
            </g:if>
            <g:elseif test="${queryInstance?.candidateRecord}">
                <a class="list" href="/cdrlite/query/listByCandidate?candidateRecord.id=${queryInstance?.candidateRecord?.id}">Query List for ${queryInstance?.candidateRecord?.candidateId}</a>
            </g:elseif>
            <g:elseif test="${queryInstance?.interviewRecord}">
                <a class="list" href="/cdrlite/query/listByInterview?interviewRecord.id=${queryInstance?.interviewRecord?.id}">Query List for ${queryInstance?.interviewRecord?.interviewId}</a>
            </g:elseif>
            <g:if test="${queryInstance}"><g:link class="list" action="show" id="${queryInstance.id}">Show Query</g:link></g:if>
        </div>
      </div>
      <div id="container" class="clearfix">
            <h1><g:message code="default.show.label" args="[entityName]" /> Time Duration</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div id="show">
                <div class="dialog">
                    <g:render template="formFieldsInc2" />
                </div>
            </div>
            <g:if test="${ (errorMessage) && (errorMessage.trim().length() > 0) }">
                <div class="err"><font color="red">${errorMessage}</font></div>
            </g:if>
            <div id="list">
                <table class="listTable">
                    <thead>
                        <tr>
                            <th>Study</th>
                            <th>Active Date</th>
                            <th>Active Actor</th>
                            <th>Addressed Date</th>
                            <th>Addressed Actor</th>
                            <th>Time Duration (Days)</th>
                        </tr>
                    </thead>
                    <tbody>
                      <g:each in="${instanceList}" status="i" var="instance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                          <td>${instance.get(0)}</td>
                          <td>${instance.get(3)}</td>
                          <td>${instance.get(1)}</td>
                          <td>${instance.get(4)}</td>
                          <td>${instance.get(2)}</td>
                          <td>${instance.get(5)}</td>
                        </tr>
                      </g:each>
                    </tbody>
                </table>
            </div>
            
        </div>
    </body>
</html>
