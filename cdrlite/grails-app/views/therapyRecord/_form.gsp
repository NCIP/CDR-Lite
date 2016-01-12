<%@ page import="nci.bbrb.cdr.forms.TherapyRecord" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="typeOfTherapy"><g:message code="therapyRecord.typeOfTherapy.label" default="Type Of Therapy" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'typeOfTherapy', 'error')}">
                <g:textField name="typeOfTherapy" value="${therapyRecordInstance?.typeOfTherapy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="descTherapy"><g:message code="therapyRecord.descTherapy.label" default="Desc Therapy" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'descTherapy', 'error')}">
                <g:textArea name="descTherapy" cols="40" rows="5" maxlength="4000" value="${therapyRecordInstance?.descTherapy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="therapyDate"><g:message code="therapyRecord.therapyDate.label" default="Therapy Date" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'therapyDate', 'error')}">
                <g:datePicker name="therapyDate" precision="day"  value="${therapyRecordInstance?.therapyDate}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="howLongAgo"><g:message code="therapyRecord.howLongAgo.label" default="How Long Ago" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'howLongAgo', 'error')}">
                <g:field name="howLongAgo" value="${fieldValue(bean: therapyRecordInstance, field: 'howLongAgo')}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hbcForm"><g:message code="therapyRecord.hbcForm.label" default="Hbc Form" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'hbcForm', 'error')}">
                <g:select name="hbcForm" from="${nci.bbrb.cdr.forms.TherapyRecord$HBCForm?.values()}" keys="${nci.bbrb.cdr.forms.TherapyRecord$HBCForm.values()*.name()}" value="${therapyRecordInstance?.hbcForm?.name()}"  noSelection="['': '']"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="specOtherHBCForm"><g:message code="therapyRecord.specOtherHBCForm.label" default="Spec Other HBCF orm" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'specOtherHBCForm', 'error')}">
                <g:textField name="specOtherHBCForm" value="${therapyRecordInstance?.specOtherHBCForm}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="durationMonths"><g:message code="therapyRecord.durationMonths.label" default="Duration Months" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'durationMonths', 'error')}">
                <g:field name="durationMonths" value="${fieldValue(bean: therapyRecordInstance, field: 'durationMonths')}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="noOfYearsStopped"><g:message code="therapyRecord.noOfYearsStopped.label" default="No Of Years Stopped" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'noOfYearsStopped', 'error')}">
                <g:field name="noOfYearsStopped" value="${fieldValue(bean: therapyRecordInstance, field: 'noOfYearsStopped')}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hrtForm"><g:message code="therapyRecord.hrtForm.label" default="Hrt Form" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'hrtForm', 'error')}">
                <g:select name="hrtForm" from="${nci.bbrb.cdr.forms.TherapyRecord$HRTForm?.values()}" keys="${nci.bbrb.cdr.forms.TherapyRecord$HRTForm.values()*.name()}" value="${therapyRecordInstance?.hrtForm?.name()}"  noSelection="['': '']"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="specOtherHRTForm"><g:message code="therapyRecord.specOtherHRTForm.label" default="Spec Other HRTF orm" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'specOtherHRTForm', 'error')}">
                <g:textField name="specOtherHRTForm" value="${therapyRecordInstance?.specOtherHRTForm}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="hrtType"><g:message code="therapyRecord.hrtType.label" default="Hrt Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'hrtType', 'error')}">
                <g:select name="hrtType" from="${nci.bbrb.cdr.forms.TherapyRecord$HRTType?.values()}" keys="${nci.bbrb.cdr.forms.TherapyRecord$HRTType.values()*.name()}" value="${therapyRecordInstance?.hrtType?.name()}"  noSelection="['': '']"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="clinicalDataEntry"><g:message code="therapyRecord.clinicalDataEntry.label" default="Clinical Data Entry" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: therapyRecordInstance, field: 'clinicalDataEntry', 'error')}">
                <g:select id="clinicalDataEntry" name="clinicalDataEntry.id" from="${nci.bbrb.cdr.forms.ClinicalDataEntry.list()}" optionKey="id" value="${therapyRecordInstance?.clinicalDataEntry?.id}" class="many-to-one" noSelection="['null': '']"/>

            </td>
        </tr>

        
        

        </tbody>
    </table>
</div>  
