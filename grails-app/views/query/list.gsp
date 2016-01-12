<%@ page import="nci.bbrb.cdr.util.querytracker.Query" %>
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<g:if test="${env != 'production'}">
    <%-- cache buster--%>
    <g:set var="d" value="${new Date()}" />
    <g:set var="ts" value="${d.format('yyyy-MM-dd:HH')}" />
</g:if>
<g:set var="bodyclass" value="query list xtrawide" scope="request"/>

<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'query.label', default: 'Query')}" />
        <script type="text/javascript" src="${resource(dir:'js',file:'query.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script>
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <%-- <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>--%>
            <g:if test="${session.org?.code == 'DCC' && session.DM}">
                <g:if test="${params.caseRecord?.id}">
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                    <a class="create" href="/cdrlite/query/create?caseRecord.id=${params.caseRecord?.id}"><g:message code="default.new.label" args="[entityName]" /></a>
                </g:if>
                <g:elseif test="${params.candidateRecord?.id}">
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                    <a class="create" href="/cdrlite/query/create?candidateRecord.id=${params.candidateRecord?.id}"><g:message code="default.new.label" args="[entityName]" /></a>
                </g:elseif>
                <g:else>
                    <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                </g:else>
                <g:link class="list" action="reportFilter">Report</g:link>
            </g:if>
            
            <%--pmh added this for cdrqa 1576--%>
            <g:if test="${session.org.code == 'DCC' && session.DM == true && session.QM == true }">
                  <!-- no link for now -->
                </g:if>
            <g:elseif test="${session.org.code == 'DCC' && session.DM == true}">
                   <a class="home"  href="${createLink(uri: '/home/opshome')}">DM Home</a>
                </g:elseif>
            <g:elseif test="${session.org.code == 'DCC' && session.QM == true}">
                 <a class="home" href="${createLink(uri: '/home/qmhome')}">QM Home</a>
                </g:elseif>
                <%--END cdrqa 1576--%>
        </div>
      </div>
      <div id="container" class="clearfix">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
            </g:if>
            <g:if test='${ (errMessage) }'>
              <div id="pageErrs" class="errors"><font color="red"><b>${ (errMessage) }</b></font></div>
            </g:if>
            <g:if test="${params.search?.equalsIgnoreCase('yes')}">
              <div id="search">
                <form action='/cdrlite/query/search/1' method='POST' id='queryTrackerSearch'>
                      <input type="hidden" name="search" value="yes"/>
                      <table style="border-style: none">
                        <tr><td colspan="3" style="border-style: none"><b>Query Tracker Search:</b></td></tr>
                        <tr>
                          <td style="border-style: none"><b>ID category:</b></td>
                          <td style="text-align: right;border-style: none">
                            <g:radio name="category" id="category_case" value="case" checked="${ (params?.category?.equalsIgnoreCase('case')) }"/>&nbsp;<label for="category_case">Case ID</label>&nbsp;&nbsp;&nbsp;
                            <g:radio name="category" id="category_candidate" value="candidate" checked="${ (params?.category?.equalsIgnoreCase('candidate')) }"/>&nbsp;<label for="category_candidate">Candidate ID</label>&nbsp;&nbsp;&nbsp;
                          </td>
                          <td style="border-style: none">ID : <g:textField name="idvalue" value="${params?.idvalue}" /></td>
                        </tr>
                        <tr>
                          <td colspan="3" style="border-style: none"><input type="submit" id="submitButton" class="button" value="Search" /> </td>
                        </tr>
                      </table>   
                </form>
              </div>
            </g:if>
            %{-- <div class="tableheader clearfix">
                <div class="left">IS = Issue status</div>
                <br> <br><div class="left">Report in excel format &nbsp;&nbsp;</div><a href="${nci.bbrb.cdr.util.AppSetting.findByCode('CDRAR_HOSTNAME')?.value}/cdrlite/report/queryRptExcel" title="Excel Format" target="_blank" class="uibutton borderless removepadding"><span class="ui-icon ui-icon-excel"></span></a> 
            </div> --}%
            <g:if test="${params.caseRecord?.id}">
                <g:render template="/caseRecord/caseDetails" bean="${CaseRecord.get(params.caseRecord?.id)}" var="caseRecord"/>
            </g:if>
            <g:elseif test="${params.candidateRecord?.id}">
                <g:render template="/candidateRecord/candidateDetails" bean="${CandidateRecord.get(params.candidateRecord?.id)}" var="candidateRecord"/>
            </g:elseif>
            <g:else>
                <g:render template="/textSearch/searchQtForm" />             
                <br/>
            </g:else>
            <div class="list">
                <table class="listTable">
                    <thead>
                        <tr>
                            <g:if test="${!params.caseRecord?.id && !params.candidateRecord?.id}">
                                <g:sortableColumn property="id" title="ID" />
                                <th>Associated With</th>
                                <g:sortableColumn property="caseRecord.caseStatus" title="Case Status" />
                                <g:sortableColumn property="isDcf" title="Issue Type" />
                                <th>Description</th>
                                <g:if test="${session.org?.code == 'DCC'}">
                                    <g:sortableColumn property="organization.code" title="Organization" />
                                </g:if>
                                <g:sortableColumn property="queryStatus" title="Query Status" />
                                <g:sortableColumn property="queryType.code" title="Query Type" />
                                <g:sortableColumn property="dateCreated" title="Date Opened" />
                                <g:sortableColumn property="openedBy" title="Opened By" />
                                <g:sortableColumn property="dueDate" title="Due Date" />
                                <g:sortableColumn property="dateClosed" title="Date Closed" />
                                <g:sortableColumn property="closedBy" title="Closed By" />
                                <th >Initial Site Response <br>to Query Open Date <br>Duration</th>
                                <th >Query Open Date <br>to Query Close Date <br>Duration</th>
                                <th>View</th>
                                
                            </g:if>
                            <g:else>
                                <th>ID</th>
                                <th>Issue type</th>
                                <th>Description</th>
                                <g:if test="${session.org?.code == 'DCC'}">
                                    <th>Organization</th>
                                </g:if>
                                <th>IS</th>
                                <th>Query type</th>
                                <th>Date opened</th>
                                <th>Opened by</th>
                                <th>Due Date</th>
                                <th>Date closed</th>
                                <th>Closed by</th>
                                 <th >Initial Site Response <br>to Query Open Date <br>Duration</th>
                                <th >Query Open Date <br>to Query Close Date <br>Duration</th>
                                <th>View</th>
                                
                            </g:else>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${queryInstanceList}" status="i" var="queryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${queryInstance.id}</td>
                            <g:if test="${!params.caseRecord?.id && !params.candidateRecord?.id}">
                                <g:if test="${queryInstance.caseRecord}">
                                    <td>
                                        <nobr>
                                            <g:displayCaseRecordLink caseRecord="${queryInstance.caseRecord}" session="${session}"/>
                                            %{-- <g:link controller="caseRecord" action="display" id="${queryInstance.caseRecord?.id}">${queryInstance.caseRecord}</g:link> --}%
                                        </nobr>
                                    </td>
                                </g:if>
                                <g:elseif test="${queryInstance.candidateRecord}">
                                    <td><nobr><g:link controller="candidateRecord" action="show" id="${queryInstance.candidateRecord?.id}">${queryInstance.candidateRecord.candidateId}</g:link></nobr></td>
                                </g:elseif>
                                <g:elseif test="${queryInstance.other}">
                                    <td><nobr>${queryInstance.other}</nobr></td>
                                </g:elseif>
                                <g:else>
                                    <td></td>
                                </g:else>
                                <td>${queryInstance.caseRecord?.caseStatus}</td>
                            </g:if>
                            <td>
                                <g:if test="${queryInstance.isDcf == 'Yes'}">DCF</g:if>
                                <g:elseif test="${queryInstance.queryType?.code == 'ACTION'}">Other</g:elseif>
                                <g:else>DM Query</g:else>
                            </td>
                            <td>
                                <g:if test="${queryInstance.description?.size() <= 10}">${queryInstance.description}</g:if>
                                <g:else><span class="ca-tooltip-nobg" data-msg="${queryInstance.description?.replace('\n', '<br />')?.replace('\"', '\'')}">${queryInstance.description?.substring(0, 10)}&nbsp;&hellip;</span></g:else>
                            </td>
                            <g:if test="${session.org?.code == 'DCC'}">
                                <td>${queryInstance.organization}</td>
                            </g:if>
                            <td>${queryInstance.queryStatus}</td>
                            <td>${queryInstance.queryType}</td>
                            <td><g:formatDate format="MM/dd/yyyy" date="${queryInstance.dateCreated}" /></td>
                            <td>${queryInstance.openedBy}</td>
                            <td id="dueDateTD_${queryInstance.id}" class="dueDateTD">
                                <div id="dueDateHoverWrap_${queryInstance.id}" class="${session.org?.code == 'DCC' && session.DM && queryInstance?.queryStatus?.code != 'CLOSED' ? 'dueDateHoverWrap' : ''} clearfix">
                                    <span id="dueDateDisplay_${queryInstance.id}" class="dueDateDisplay left"><g:formatDate format="MM/dd/yyyy" date="${queryInstance.dueDate}" /></span>
                                    <span id="dueDateEdit_${queryInstance.id}" class="dueDateEdit ui-icon ui-icon-pencil right hide" title="Click to edit"></span>
                                </div>
                                <span id="dueDatePicker_${queryInstance.id}" class="dueDatePicker hide"><g:jqDatePicker class="dueDate" name="dueDate_${queryInstance.id}" value="${queryInstance.dueDate}" /></span>
                            </td>
                            <td><g:formatDate format="MM/dd/yyyy" date="${queryInstance.dateClosed}" /></td>
                            <td>${queryInstance.closedBy}</td>
                                                       
                             <td> <g:if test="${daysMap1?.get(queryInstance.id?.toString())}"> ${daysMap1?.get(queryInstance.id?.toString())}</g:if><g:else></g:else></td>
                              <td> <g:if test="${daysMap2?.get(queryInstance.id?.toString())}"> ${daysMap2?.get(queryInstance.id?.toString())}</g:if><g:else></g:else></td>
                            <td class="textcenter"><g:link action="show" id="${queryInstance.id}"><img src="/cdrlite/images/magGlass16x16.png" alt="View" width="12" height="12" /></g:link></td>
                            
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!params.caseRecord?.id && !params.candidateRecord?.id}">
                <div class="paginateButtons">
                    <g:paginate total="${queryInstanceTotal}" />
                </div>
            </g:if>
            <g:else>
              
               <div class="paginateButtons">
                Total: ${queryInstanceTotal ? queryInstanceTotal:0}
            </div>
            </g:else>
        </div>
    </body>
</html>
