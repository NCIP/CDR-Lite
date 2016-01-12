<%@ page import="nci.bbrb.cdr.forms.ConsentVerification" %>
                    
<g:render template="/candidateRecord/candidateDetails" bean="${consentVerificationInstance.candidateRecord}" var="candidateRecord"/>
<div class="dialog">
    <table>
        <tbody>
            <%
                def labelNumber = 1
            %>
        <tr class="prop"><td></td></tr>
        <input type='hidden' name="candidateRecord.id" value="${ consentVerificationInstance?.candidateRecord?.id}" />
        <g:hiddenField name="id" value="${consentVerificationInstance?.id}" />  
        <tr class="prop">
            <td valign="top" class="name">
                <label for="protocolSiteNum">${labelNumber++}.&nbsp;<g:message code="consentVerification.protocolSiteNum.label" default="Site Protocol Number" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'protocolSiteNum', 'errors')}">
                <g:textField  name="protocolSiteNum" value="${consentVerificationInstance?.protocolSiteNum}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="consentor">${labelNumber++}.&nbsp;<g:message code="consentVerification.consentor.label" default="Person obtaining consent" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'consentor', 'errors')}">
                <g:textField name="consentor" value="${consentVerificationInstance?.consentor}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="consentorRelationship">${labelNumber++}.&nbsp;<g:message code="consentVerification.consentorRelationship.label" default="Relationship to donor" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'consentorRelationship', 'errors')}">
                <g:select name="consentorRelationship" from="${nci.bbrb.cdr.forms.ConsentVerification$ConsentorRelationship?.values()}" keys="${nci.bbrb.cdr.forms.ConsentVerification$ConsentorRelationship?.values()*.name()}" value="${consentVerificationInstance?.consentorRelationship}" noSelection="['': '']" /><br/>    
                 <g:textField name="otherConsentRelation" value="${consentVerificationInstance?.otherConsentRelation}"/>
            </td>
           
        </tr>
        <script>   
            function showhide()
            {
                var selectedValue = $("#consentorRelationship").val();
                if (selectedValue == 'OTH') {
                    $('#otherConsentRelation').show();
                }
                else {
                        $('#otherConsentRelation').val('')
                        $('#otherConsentRelation').hide();
                }
            }

            showhide();

            $('#consentorRelationship').change(function() {
                showhide();
            });                                                                          
        </script> 
        <tr class="prop">
            <td valign="top" class="name">
                <label for="isEligible">${labelNumber++}.&nbsp;<g:message code="consentVerification.isEligible.label" default="Does candidate meet all eligibility criteria within the study Protocol" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'isEligible', 'errors')}">
                 <g:bpvYesNoRadioPicker  name="isEligible"  checked="${consentVerificationInstance?.isEligible}"/>
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="consentObtained">${labelNumber++}.&nbsp;<g:message code="consentVerification.consentObtained.label" default="Was Consent Obtained" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'consentObtained', 'errors')}">
                <g:bpvYesNoRadioPicker  name="consentObtained"  checked="${consentVerificationInstance?.consentObtained}"/>
            </td>
        </tr>

        <script>   
            function show()
            {
               
                    $('#dateConsentedRow').show();
                    $('#meetAgeRow').show();
                    $('#dateWitnessedRow').show();
                    $('#dateVerifiedRow').show();
                
                        
            }

            function hide()
            {
                $('#dateConsented').val('')
                $('#dateConsentedRow').hide();
                $('#meetAge').val('')
                $('#meetAgeRow').hide();
                $('#dateWitnessed').val('')
                $('#dateWitnessedRow').hide();
                $('#dateVerified').val('')
                $('#dateVerifiedRow').hide();
            }
            show();
            hide();

            $("#consentObtained_yes").change(function() {
                show();
            });

             $("#consentObtained_no").change(function() {
                hide();
            });   
        </script> 
        
        <tr class="prop"  id="dateConsentedRow" style="display:${consentVerificationInstance?.consentObtained == 'Yes'?'display':'none'}">
            <td valign="top" class="name">
                <label for="dateConsented">${labelNumber++}.&nbsp;<g:message code="consentVerification.dateConsented.label" default="Date Consent Obtained" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'dateConsented', 'errors')}">
                <g:jqDatePicker  name="dateConsented" precision="day"  value="${consentVerificationInstance?.dateConsented}"  />

            </td>
        </tr>
        
        <tr class="prop" id="meetAgeRow" style="display:${consentVerificationInstance?.consentObtained == 'Yes'?'display':'none'}">
            <td valign="top" class="name">
                <label for="meetAge">${labelNumber++}.&nbsp;<g:message code="consentVerification.meetAge.label" default="Does the candidate meet the Age of Majority for Institution State" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'meetAge', 'errors')}">
                 <g:bpvYesNoRadioPicker  name="meetAge"  checked="${consentVerificationInstance?.meetAge}"/>
            </td>
        </tr>

        
        <tr class="prop" id="dateWitnessedRow" style="display:${consentVerificationInstance?.consentObtained == 'Yes'?'display':'none'}">
            <td valign="top" class="name">
                <label for="dateWitnessed">${labelNumber++}.&nbsp;<g:message code="consentVerification.dateWitnessed.label" default="Date of Witness of Consent" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'dateWitnessed', 'errors')}">
                <g:jqDatePicker  name="dateWitnessed" precision="day"  value="${consentVerificationInstance?.dateWitnessed}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop" id="dateVerifiedRow" style="display:${consentVerificationInstance?.consentObtained == 'Yes'?'display':'none'}">
            <td valign="top" class="name">
                <label for="dateVerified">${labelNumber++}.&nbsp;<g:message code="consentVerification.dateVerified.label" default="Date of Consent Verification" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'dateVerified', 'errors')}">
                <g:jqDatePicker  name="dateVerified" precision="day"  value="${consentVerificationInstance?.dateVerified}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="institutionICDVersion">${labelNumber++}.&nbsp;<g:message code="consentVerification.institutionICDVersion.label" default="Institutional version of Informed Consent Document" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'institutionICDVersion', 'errors')}">
                <g:textField name="institutionICDVersion" value="${consentVerificationInstance?.institutionICDVersion}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateIRBApproved">${labelNumber++}.&nbsp;<g:message code="consentVerification.dateIRBApproved.label" default="IRB Approval Date" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'dateIRBApproved', 'errors')}">
                <g:jqDatePicker name="dateIRBApproved" precision="day"  value="${consentVerificationInstance?.dateIRBApproved}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="dateIRBExpires">${labelNumber++}.&nbsp;<g:message code="consentVerification.dateIRBExpires.label" default="IRB Expiration Date" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'dateIRBExpires', 'errors')}">
                <g:jqDatePicker  name="dateIRBExpires" precision="day"  value="${consentVerificationInstance?.dateIRBExpires}" default="none" noSelection="['': '']" />

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="willingForOtherStudy">${labelNumber++}.&nbsp;<g:message code="consentVerification.willingForOtherStudy.label" default="Willingness to be contacted for Other Studies" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'willingForOtherStudy', 'errors')}">
                 <g:bpvYesNoRadioPicker  name="willingForOtherStudy"  checked="${consentVerificationInstance?.willingForOtherStudy}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="specifiedLimitations">${labelNumber++}.&nbsp;<g:message code="consentVerification.specifiedLimitations.label" default="Specify Limitations if any" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'specifiedLimitations', 'errors')}">
                <g:textArea name="specifiedLimitations" cols="40" rows="5" maxlength="4000" value="${consentVerificationInstance?.specifiedLimitations}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="comments">${labelNumber++}.&nbsp;<g:message code="consentVerification.comments.label" default="Comments" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: consentVerificationInstance, field: 'comments', 'errors')}">
                <g:textArea name="comments" cols="40" rows="5" maxlength="4000" value="${consentVerificationInstance?.comments}"/>

            </td>
        </tr>

        </tbody>
    </table>
</div>  
