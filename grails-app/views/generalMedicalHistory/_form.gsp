<%@ page import="nci.bbrb.cdr.forms.GeneralMedicalHistory" %>
<%@ page import="java.util.Calendar"%>

<div class="dialog">
    <table>
        <tbody>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="diseaseName"><g:message code="generalMedicalHistory.diseaseName.label" default="Disease Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'diseaseName', 'errors')}">
                <g:textField name="diseaseName" value="${generalMedicalHistoryInstance?.diseaseName}"/>

            </td>
        </tr>

        
        
         <tr class="prop">
            <td valign="top" class="name">
                <label for="monthYearOfFirstDiagnosis"><g:message code="generalMedicalHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'monthYearOfFirstDiagnosis', 'errors')}">
               <g:datePicker name="monthYearOfFirstDiagnosis" precision="month" value="${generalMedicalHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="treatment"><g:message code="generalMedicalHistory.treatment.label" default="Treatment" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'treatment', 'errors')}">
                <%--   <g:textField name="treatment" value="${generalMedicalHistoryInstance?.treatment}"/>  --%>
                <g:select id="treatmentYesNo" name="treatment" from="${nci.bbrb.cdr.forms.GeneralMedicalHistory$YesNo?.values()}" keys="${nci.bbrb.cdr.forms.GeneralMedicalHistory$YesNo.values()*.name()}" value="${generalMedicalHistoryInstance?.treatment?.name()}"  />


            </td>
        </tr>

       
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="monthYearOfLastTreatment"><g:message code="generalMedicalHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'monthYearOfLastTreatment', 'errors')}">
               <g:datePicker name="monthYearOfLastTreatment" precision="month" value="${generalMedicalHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="source"><g:message code="generalMedicalHistory.source.label" default="Source" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'source', 'errors')}">
               
                 <g:select name="source" from="${nci.bbrb.cdr.forms.GeneralMedicalHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.GeneralMedicalHistory$SourceType?.values()*.name()}" value="${generalMedicalHistoryInstance?.source?.name()}" noSelection="['': '']" />

            </td>
        </tr>

       
        </tbody>
    </table>
</div>  
