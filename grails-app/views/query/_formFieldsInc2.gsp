<g:if test="${params.action != 'create' && params.action != 'save'}">
    <table>
        <tbody>
            <tr class="prop">
                <td valign="top">
                  <div class="clearfix">
                    <dl class="formdetails left"><dt>Date opened:</dt><dd><g:formatDate format="MM/dd/yyyy" date="${queryInstance?.dateCreated}" /></dd></dl>
                    <dl class="formdetails left"><dt>Opened by:</dt><dd>${queryInstance?.openedBy}</dd></dl>
                    <dl class="formdetails left"><dt>Query status:</dt><dd>${queryInstance?.queryStatus}</dd></dl>
                    <dl class="formdetails left">
                      <dt>Query ID:</dt>
                      <dd><g:link class="list" action="show" id="${queryInstance.id}">${queryInstance?.id}</g:link></dd>
                    </dl>
                    <g:if test="${queryInstance?.queryStatus?.code.equalsIgnoreCase('CLOSED')}">
                        <dl class="formdetails left"><dt>Closed by:</dt><dd>${queryInstance?.closedBy}</dd></dl>
                        <dl class="formdetails left"><dt>Date closed:</dt><dd><g:formatDate format="MM/dd/yyyy" date="${queryInstance?.dateClosed}" /></dd></dl>
                    </g:if>
                    <g:if test="${queryInstance?.accessId}">
                        <dl class="formdetails left"><dt>Access ID:</dt><dd>${queryInstance?.accessId}</dd></dl>
                    </g:if>
                  </div>
                </td>
            </tr>  
            <tr class="prop">
                <td valign="top">
                  <div class="clearfix">
                    <dl class="formdetails left"><dt>Organization:</dt><dd>${(queryInstance?.organization?.id) ? (nci.bbrb.cdr.staticmembers.Organization.get(queryInstance.organization.id) ? (nci.bbrb.cdr.staticmembers.Organization.get(queryInstance.organization.id).name) : '') : ''}</dd></dl>
                    <g:if test="${queryInstance?.caseRecord}">
                      <dl class="formdetails left"><dt>Case Record:</dt><dd><g:displayCaseRecordLink caseRecord="${queryInstance.caseRecord}" session="${session}"/></dd></dl>
                    </g:if>
                    <g:elseif test="${queryInstance?.candidateRecord}">
                      <dl class="formdetails left"><dt>Candidate Record:</dt><dd><g:link controller="candidateRecord" action="view" id="${queryInstance?.candidateRecord?.id}">${queryInstance?.candidateRecord?.candidateId}</g:link></dd></dl>
                    </g:elseif>
                    <g:elseif test="${queryInstance?.interviewRecord}">
                      <dl class="formdetails left"><dt>Interview Record:</dt><dd><g:link controller="interviewRecord" action="show" id="${queryInstance?.interviewRecord?.id}">${queryInstance?.interviewRecord?.interviewId}</g:link></dd></dl>
                    </g:elseif>
                    <dl class="formdetails left"><dt>Due Date:</dt><dd><g:formatDate format="MM/dd/yyyy" date="${queryInstance?.dueDate}" /></dd></dl>
                  </div>
                </td>
            </tr>      
        </tbody>
    </table>
</g:if>

