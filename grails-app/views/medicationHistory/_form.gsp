<%@ page import="nci.bbrb.cdr.forms.MedicationHistory" %>
<%@ page import="java.util.Calendar"%>


<div class="dialog">
    <table>
        <tbody>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="medicationName"><g:message code="medicationHistory.medicationName.label" default="Medication Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'medicationName', 'errors')}">
                <g:textField name="medicationName" value="${medicationHistoryInstance?.medicationName}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateofLastAdministration"><g:message code="medicationHistory.dateofLastAdministration.label" default="Date of Last Administration" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'dateofLastAdministration', 'errors')}">
            <%--    <g:datePicker name="dateofLastAdministration" precision="day"   value="${medicationHistoryInstance?.dateofLastAdministration}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }"/> --%>
             <g:jqDateTimePicker name="dateofLastAdministration" precision="day"  value="${medicationHistoryInstance?.dateofLastAdministration}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="source"><g:message code="medicationHistory.source.label" default="Source" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'source', 'errors')}">
                 <g:select name="source" from="${nci.bbrb.cdr.forms.MedicationHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.MedicationHistory$SourceType?.values()*.name()}" value="${medicationHistoryInstance?.source?.name()}" noSelection="['': '']" />


            </td>
        </tr>

        </tbody>
    </table>
</div>  
