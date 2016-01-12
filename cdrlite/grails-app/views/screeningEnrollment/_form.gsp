<%@ page import="nci.bbrb.cdr.forms.ScreeningEnrollment" %>

<g:render template="/candidateRecord/candidateDetails" bean="${screeningEnrollmentInstance.candidateRecord}" var="candidateRecord"/>
<div class="list">
    <table class="tdwrap">
        <tbody>
        <input type='hidden' name="candidateRecord.id" value="${ screeningEnrollmentInstance?.candidateRecord?.id}" />   
        <tr class="prop">
            <td valign="top" class="name">
                <label for="nameCreateCandidate">1. Name of person who performed Screening:</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: screeningEnrollmentInstance, field: 'nameCreateCandidate', 'errors')}">
                <g:textField name="nameCreateCandidate" value="${screeningEnrollmentInstance?.nameCreateCandidate}"/>

            </td>
        </tr>
    
        <tr class="prop">
            <td valign="top" class="name">
                <label for="metCriteria">2. Does the Candidate meet all eligibility criteria defined within the Study Protocol?</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: screeningEnrollmentInstance, field: 'metCriteria', 'errors')}">
               <g:bpvYesNoRadioPicker  name="metCriteria"  checked="${screeningEnrollmentInstance?.metCriteria}"/>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="comments">3.&nbsp;<g:message code="screeningEnrollment.comments.label" default="Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: screeningEnrollmentInstance, field: 'comments', 'error')}">
                <g:textArea name="comments" cols="40" rows="5" maxlength="4000" value="${screeningEnrollmentInstance?.comments}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="screeningDate">4.&nbsp;<g:message code="screeningEnrollment.screeningDate.label" default="Screening Date" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: screeningEnrollmentInstance, field: 'screeningDate', 'errors')}">
                 <g:jqDatePicker   name="screeningDate" value="${screeningEnrollmentInstance?.screeningDate}"  />

            </td>
        </tr>
      </tbody>
    </table>
</div>  
