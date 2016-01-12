<%@ page import="nci.bbrb.cdr.prc.PrcReport" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="comments"><g:message code="prcReport.comments.label" default="Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'comments', 'error')}">
                <g:textField name="comments" value="${prcReportInstance?.comments}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateSubmitted"><g:message code="prcReport.dateSubmitted.label" default="Date Submitted" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'dateSubmitted', 'error')}">
                <g:datePicker name="dateSubmitted" precision="day"  value="${prcReportInstance?.dateSubmitted}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="submittedBy"><g:message code="prcReport.submittedBy.label" default="Submitted By" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'submittedBy', 'error')}">
                <g:textField name="submittedBy" value="${prcReportInstance?.submittedBy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="status"><g:message code="prcReport.status.label" default="Status" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'status', 'error')}">
                <g:textField name="status" value="${prcReportInstance?.status}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseRecord"><g:message code="prcReport.caseRecord.label" default="Case Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: prcReportInstance, field: 'caseRecord', 'error')}">
                <g:select id="caseRecord" name="caseRecord.id" from="${nci.bbrb.cdr.datarecords.CaseRecord.list()}" optionKey="id" required="" value="${prcReportInstance?.caseRecord?.id}" class="many-to-one"/>

            </td>
        </tr>

        
        

        </tbody>
    </table>
</div>  
