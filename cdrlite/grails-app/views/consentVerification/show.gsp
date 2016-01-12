
<%@ page import="nci.bbrb.cdr.forms.ConsentVerification" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'consentVerification.label', default: 'Consent Verification Form')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <g:set var="canModify" value="${session.DM && true }" />
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
            </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:render template="/candidateRecord/candidateDetails" bean="${consentVerificationInstance.candidateRecord}" var="candidateRecord"/>
                    <div class="dialog">
                        <table>
                            <tbody>
                        
        
                        <input type='hidden' name="candidateRecord.id" value="${ consentVerificationInstance?.candidateRecord?.id}" />
                        
                        <tr class="prop">
                            <td valign="top" class="name">1.&nbsp;<g:message code="consentVerification.protocolSiteNum.label" default="Site Protocol Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "protocolSiteNum")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">2.&nbsp;<g:message code="consentVerification.consentor.label" default="Person obtaining consent" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "consentor")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">3.&nbsp;<g:message code="consentVerification.consentorRelationship.label" default="Relationship to donor" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "consentorRelationship")}</td>
                            
                        </tr>
                        <g:if test="${consentVerificationInstance.otherConsentRelation}">
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="consentVerification.otherConsentRelation.label" default="Other Consent Relation" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "otherConsentRelation")}</td>
                            
                        </tr>
                        </g:if>
                        
                        <tr class="prop">
                            <td valign="top" class="name">4.&nbsp;<g:message code="consentVerification.isEligible.label" default="Does candidate meet all eligibility criteria within the study Protocol" /></td>
                            
                            <td valign="top" class="value">${consentVerificationInstance?.isEligible?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        
                        <tr class="prop">
                            <td valign="top" class="name">5.&nbsp;<g:message code="consentVerification.consentObtained.label" default="Was Consent Obtained" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "consentObtained")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">6.&nbsp;<g:message code="consentVerification.dateConsented.label" default="Date Consent Obtained" /></td>
                            
                            <td valign="top" class="value">
                            <g:if test="${session.LDS == true || session.DM==true}">
                                <g:formatDate format="MM-dd-yyyy" date="${consentVerificationInstance?.dateConsented}" />
                             </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">7.&nbsp;<g:message code="consentVerification.meetAge.label" default="Does the candidate meet the Age of Majority for Institution State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "meetAge")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">8.&nbsp;<g:message code="consentVerification.dateWitnessed.label" default="Date of Witness of Consent" /></td>
                            
                            <td valign="top" class="value">
                            <g:if test="${session.LDS == true || session.DM==true}">
                                <g:formatDate format="MM-dd-yyyy" date="${consentVerificationInstance?.dateWitnessed}" />
                             </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">9.&nbsp;<g:message code="consentVerification.dateVerified.label" default="Date of Consent Verification" /></td>
                            
                            <td valign="top" class="value">
                            <g:if test="${session.LDS == true || session.DM==true}">
                                 <g:formatDate format="MM-dd-yyyy" date="${consentVerificationInstance?.dateVerified}" />
                             </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">10.&nbsp;<g:message code="consentVerification.institutionICDVersion.label" default="Institutional version of ICD ersion" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "institutionICDVersion")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">11.&nbsp;<g:message code="consentVerification.dateIRBApproved.label" default="IRB Approval Date" /></td>
                            
                            <td valign="top" class="value">
                            <g:if test="${session.LDS == true || session.DM==true}">
                                 <g:formatDate format="MM-dd-yyyy" date="${consentVerificationInstance?.dateIRBApproved}" />
                             </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">12.&nbsp;<g:message code="consentVerification.dateIRBExpires.label" default="IRB Expiration Date" /></td>
                            
                            <td valign="top" class="value">
                            <g:if test="${session.LDS == true || session.DM==true}">
                                <g:formatDate format="MM-dd-yyyy" date="${consentVerificationInstance?.dateIRBExpires}" />
                             </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">13.&nbsp;<g:message code="consentVerification.willingForOtherStudy.label" default="Willingness to be contacted for Other Studies" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "willingForOtherStudy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">14.&nbsp;<g:message code="consentVerification.specifiedLimitations.label" default="Specified Limitations" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "specifiedLimitations")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">15.&nbsp;<g:message code="consentVerification.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: consentVerificationInstance, field: "comments")}</td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:consentVerificationInstance, action:'resumeEditing']" method="POST" >
                            <g:hiddenField name="id" value="${consentVerificationInstance?.id}" />
                            <g:if test="${canModify}">
                                <span class="button"><g:actionSubmit class="edit" action="resumeEditing"  value="${message(code: 'default.button.resumeedit.label', default: 'Resume Edit')}" /></span>
                            </g:if>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
