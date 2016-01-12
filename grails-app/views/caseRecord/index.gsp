
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="cahubTemplate">
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
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        
                        <table>
  <thead>
   
    <tr>
  
  
  <g:sortableColumn property="caseId" title="${message(code: 'caseRecord.caseId.label', default: 'Case ID')}" />                          
  <g:sortableColumn property="primaryTissueType" title="${message(code: 'caseRecord.caseId.label', default: 'Primary Organ')}" />                                      
  <g:sortableColumn property="bss" title="${message(code: 'caseRecord.BSS.label', default: 'BSS')}" />
  <th>Candidate ID</th>
  <th class="specimencount">Specimens</th>                            
  <g:sortableColumn property="caseStatus" title="${message(code: 'caseRecord.dateCreated.label', default: 'Case Status')}" /> 
  <g:sortableColumn property="dateCreated" class="dateentry" title="${message(code: 'caseRecord.dateCreated.label', default: 'Date Created')}" />
   
</tr>
</thead>
<tbody>
<g:if test="${caseRecordInstanceList}">
  <g:each in="${caseRecordInstanceList}" status="i" var="caseRecordInstance">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
   
    <td>
    <a href="/cdrlite/caseRecord/show/${caseRecordInstance.id}">${caseRecordInstance.caseId}</a>
    </td>                    
    <td>${caseRecordInstance.primaryTissueType}</td>                    
    <td><span class="ca-tooltip-nobg" data-msg="<b>${caseRecordInstance.bss.name}</b>">${caseRecordInstance.bss}</span></td>
    <td><a href="/cdrlite/candidateRecord/view/${caseRecordInstance.candidateRecord?.id}">${caseRecordInstance.candidateRecord?.candidateId}</a></td>
    <td>
       <g:if test="${specimenCount.get(caseRecordInstance.id)}">${specimenCount.get(caseRecordInstance.id)}</g:if><g:else>0</g:else> 
    </td>
    <td><span class="ca-tooltip-nobg home-case-status" data-msg="<b>${caseRecordInstance.caseStatus}</b>. ${caseRecordInstance.caseStatus.description}">${caseRecordInstance.caseStatus}</span>
    </td>
    
   
   
    <td style="white-space:nowrap"><g:formatDate date="${caseRecordInstance.dateCreated}" /></td>
    </tr>
  </g:each></g:if>
<g:else><tr><td colspan="7">No cases exist</td></tr></g:else>
</tbody>
</table>
                    
 
			
			<div class="paginateButtons">
				<g:paginate total="${caseRecordInstanceCount ?: 0}" /> | Total: ${caseRecordInstanceCount}
			</div>
		</div>
	</body>
</html>
