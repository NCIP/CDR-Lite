
<%@ page import="nci.bbrb.cdr.forms.Demographics" %>
<g:set var="bodyclass" value="demographics show candidate" scope="request"/>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'demographics.label', default: 'Demographics for Candidate ')}" />
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
            <g:render template="/candidateRecord/candidateDetails" bean="${demographicsInstance.candidateRecord}" var="candidateRecord"/>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop"><td></td></tr>
                        <tr class="prop"><td></td></tr>
                        <input type='hidden' name="candidateRecord.id" value="${ demographicsInstance?.candidateRecord?.id}" />
                        <g:hiddenField name="BMI" value="${demographicsInstance?.BMI}" />
                        <g:hiddenField name="id" value="${demographicsInstance?.id}" />  
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;1.&nbsp;<g:message code="demographics.dateOfBirth.label" default="Date Of Birth" /></td>
                            
                            <td valign="top" class="value"> 
                            <g:if test="${session.LDS == true || session.DM==true}">
                                <g:formatDate format="MM/dd/yyyy"  date="${demographicsInstance?.dateOfBirth}" />
                            </g:if>
                             <g:else>
                                <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                            </g:else>
                            </td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;2.&nbsp;<g:message code="demographics.gender.label" default="Gender" /></td>
                            
                            <td valign="top" class="value">${demographicsInstance?.gender?.encodeAsHTML()}</td>
                            
                        </tr>
                        <g:if test="${demographicsInstance.otherGender}">
                             <tr class="prop">
                                 <td valign="top" class="name"><g:message code="demographics.otherGender.label" default="Other Gender" /></td>
                            
                                <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "otherGender")}</td>
                            
                            </tr>
                        </g:if>
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;3.&nbsp;<g:message code="demographics.height.label" default="Height" /> (inches)<span id="demographics.height" class="vocab-tooltip"></span></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "height")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;4.&nbsp;<g:message code="demographics.weight.label" default="Weight" /> (lbs)<span id="demographics.weight" class="vocab-tooltip"></span></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "weight")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;5.&nbsp;<g:message code="demographics.BMI.label" default="BMI" /><span id="demographics.bmi" class="vocab-tooltip"></span></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "BMI")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;6.&nbsp;<g:message code="demographics.race.label" default="Race" /><span id="demographics.race" class="vocab-tooltip"></span></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "race")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">&nbsp;7.&nbsp;<g:message code="demographics.ethnicity.label" default="Ethnicity" /><span id="demographics.ethnicity" class="vocab-tooltip"></span></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: demographicsInstance, field: "ethnicity")}</td>
                            
                        </tr>
                      
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:demographicsInstance, action:'resumeEditing']" method="POST" >
                            <g:hiddenField name="id" value="${demographicsInstance?.id}" />
                            <g:if test="${canModify}">
                            <span class="button"><g:actionSubmit class="edit" action="resumeEditing"  value="${message(code: 'default.button.resumeedit.label', default: 'Resume Edit')}" /></span>
                            </g:if>
                        </g:form>
                    </div>
                </div>
    </body>
</html>
