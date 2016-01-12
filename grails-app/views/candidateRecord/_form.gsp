<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="bss"><g:message code="candidateRecord.bss.label" default="BSS" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'bss', 'error')}">
                <g:set  var="bss" value="${BSS.findByCode(session.org?.code)}"/>
                <g:if test="${bss}">
                    <g:select id="bss" name="bss.id" from="${[bss]}" optionKey="id"  optionValue="name" required="" value="${candidateRecordInstance?.bss?.id}" class="many-to-one"/> 
                    
                </g:if>
                <g:else>
                <g:select id="bss" name="bss.id" from="${candidateRecordInstance?.study?.bssList}" optionKey="id" optionValue="name" required="" value="${candidateRecordInstance?.bss?.id}" class="many-to-one"/>
                </g:else>

            </td>
        </tr>
        
        
          <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments">Comments:*</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" cols="40" rows="5" value="${candidateRecordInstance?.comments}" />
                                    <br /><span class="no-phi-note">*No PHI allowed in this field</span>
                                </td>
                            </tr>                        

        <g:if test="${params.action != 'create'}">
        <tr class="prop">
            <td valign="top" class="name">
                <label for="candidateId"><g:message code="candidateRecord.candidateId.label" default="Candidate Id" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'candidateId', 'error')}">
                <g:textField name="candidateId" required="" value="${candidateRecordInstance?.candidateId}"/>

            </td>
        </tr>
       
           <g:if test="${params.action != 'edit'}">
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseList"><g:message code="candidateRecord.caseList.label" default="Case List" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'caseList', 'error')}">
                
<ul class="one-to-many">
<g:each in="${candidateRecordInstance?.caseList}" var="c">
    <li><g:link controller="caseRecord" action="show" id="${c.id}">${c?.caseId}</g:link></li>
</g:each>
<li class="add">
<g:if test="${candidateRecordInstance?.caseList}">
<g:link controller="caseRecord" action="create" params="['candidateRecord.id': candidateRecordInstance?.id]" onclick="return confirm('There are cases for this candidate, are you sure that you want to add another case?');">${message(code: 'default.add.label', args: [message(code: 'caseRecord.label', default: 'CaseRecord')])}</g:link>
</g:if>
<g:else>
    <g:link controller="caseRecord" action="create" params="['candidateRecord.id': candidateRecordInstance?.id]" >${message(code: 'default.add.label', args: [message(code: 'caseRecord.label', default: 'CaseRecord')])}</g:link>
</g:else>
</li>
</ul>


            </td>
        </tr>

        <tr class="prop">
                            <td valign="top" class="name"> Health History</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:if test="${candidateRecordInstance.healthHistory}">
                                    <li><g:link controller="healthHistory" action="show" id="${candidateRecordInstance.healthHistory?.id}">show health history</g:link></li>
                                    </g:if>
                                    <g:else>
                                         <li><g:link controller="healthHistory" action="create" params="['candidateRecord.id': candidateRecordInstance?.id]" >Add health history</g:link></li>
                                        </g:else>
                                </ul>
                                
                            </td>
       </g:if>                 
        
        </g:if> 
        <tr class="prop">
            <td valign="top" class="name">
                <label for="study"><g:message code="candidateRecord.study.label" default="Study" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: candidateRecordInstance, field: 'study', 'error')}">
                ${candidateRecordInstance?.study?.code}

            </td>
        </tr>

        <g:if test="${params.action == 'create'}">
         <input type='hidden' name='study.id' value='${candidateRecordInstance?.study?.id}'>
        </g:if>

        </tbody>
    </table>
</div>  
