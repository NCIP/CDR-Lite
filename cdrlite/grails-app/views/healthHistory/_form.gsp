<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>


<div class="dialog">
    <table>
        <tbody>

      
        <tr class="prop">
            <td valign="top" class="name">
                <label for="source"><g:message code="healthHistory.source.label" default="Source" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: healthHistoryInstance, field: 'source', 'errors')}">
             <g:select name="source" from="${nci.bbrb.cdr.forms.HealthHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.HealthHistory$SourceType?.values()*.name()}" value="${healthHistoryInstance?.source?.name()}" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="historyOfCancer"><g:message code="healthHistory.historyOfCancer.label" default="History Of Cancer" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: healthHistoryInstance, field: 'historyOfCancer', 'errors')}">
             <g:select id="historyOfCancerYesNo" name="historyOfCancer" from="${nci.bbrb.cdr.forms.HealthHistory$YesNo?.values()}" keys="${nci.bbrb.cdr.forms.HealthHistory$YesNo.values()*.name()}" value="${healthHistoryInstance?.historyOfCancer?.name()}"  />

            </td>
        </tr>

         <%--
       
       <tr class="prop" style="display:${healthHistoryInstance?.historyOfCancer?.encodeAsHTML() =='Yes'?'display':'none'}" id="addCancerHistRow">
           <td valign="top" class="name">
                <label for="cancerHistories">Cancer History</label>
            </td>
            <td valign="top">
            
            <g:link controller="cancerHistory" action="create" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Add Cancer History</g:link>
           
            </td>
        </tr>
        
        
         <g:if test="${healthHistoryInstance?.dateCreated}">  
       <tr class="prop" >
            <td valign="top" class="name">
                <label for="cancerHistories">Other Medical History</label>
            </td>
            <td valign="top">
            
            <g:link controller="generalMedicalHistory" action="create" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Add General Medical History</g:link>
           
            </td>
        </tr>

       
<tr class="prop" >
            <td valign="top" class="name">
                <label for="cancerHistories">Medications History</label>
            </td>
            <td valign="top">
            
            <g:link controller="medicationHistory" action="create" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Add Medications History</g:link>
           
            </td>
        </tr>
        </g:if>  
        --%>

        </tbody>
    </table>
</div>  
