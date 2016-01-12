
<%@ page import="nci.bbrb.cdr.forms.GeneralMedicalHistory" %>
<%@ page import="java.util.Calendar"%>
<g:set var="bodyclass" value="generalMedicalHistory list" scope="request"/>

<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'generalMedicalHistory.label', default: 'General Medical History')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'healthHistory.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                 <g:link class="list" controller="healthHistory" action="show" id="${healthInstanceId}">show Health History</g:link>

            </div>
        </div>
        <div id="container" class="clearfix"> 
             <h1>General Medical History for candidate ${candidateInstance?.candidateId}</h1>
            <g:render template="/candidateRecord/candidateDetails" bean="${candidateInstance}" var="candidateRecord"/>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'generalMedicalHistory.id.label', default: 'ID')}" />
                            <g:sortableColumn property="diseaseName" title="${message(code: 'generalMedicalHistory.diseaseName.label', default: 'Disease Name')}" />

                            <g:sortableColumn property="monthYearOfFirstDiagnosis" title="${message(code: 'generalMedicalHistory.monthYearOfFirstDiagnosis.label', default: 'Month Year Of First Diagnosis')}" />

                            <g:sortableColumn property="treatment" title="${message(code: 'generalMedicalHistory.treatment.label', default: 'Treatment')}" />

                            <g:sortableColumn property="monthYearOfLastTreatment" title="${message(code: 'generalMedicalHistory.monthYearOfLastTreatment.label', default: 'Month Year Of Last Treatment')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${generalMedicalHistoryList}" status="i" var="generalMedicalHistoryInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                                        
                                <td><a href="/cdrlite/generalMedicalHistory/show/${generalMedicalHistoryInstance.id}">${generalMedicalHistoryInstance.id}</a></td>                                   
                                <td>${fieldValue(bean: generalMedicalHistoryInstance, field: "diseaseName")}</td>

                                <td>
                               <g:if test='${(session.DM) || session.authorities?.contains("ROLE_DM") || session.authorities?.contains("ROLE_ADMIN")}'>
                                <g:formatDate date="${generalMedicalHistoryInstance.monthYearOfFirstDiagnosis}" format="MM/yyyy" />
                                </g:if>
                                <g:else>
                                    <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                </g:else>
                                </td>

                                <td>${fieldValue(bean: generalMedicalHistoryInstance, field: "treatment")}</td>

                                <td>  <g:if test='${(session.DM) || session.authorities?.contains("ROLE_DM") || session.authorities?.contains("ROLE_ADMIN")}'>
                                <g:formatDate date="${generalMedicalHistoryInstance.monthYearOfLastTreatment}" format="MM/yyyy" />
                                </g:if>
                                <g:else>
                                    <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                </g:else></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <g:if test="${canAdd=='Yes' && session.DM}">
            <div class="buttons">
                <span class="button"><input type="button" value="Add" id ="addGM" /></span>
            </div>
            </g:if>
<%-- show the create GM page now --%>
            <div id="formGM" style="display:none">
                <h2>Create General Medical History </h2>
                <g:form url="[resource:generalMedicalHistoryInstance, action:'save']" >
                <table>
                    <tbody>


                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="diseaseName"><g:message code="generalMedicalHistory.diseaseName.label" default="Disease Name" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'diseaseName', 'error')}">
                                <g:textField name="diseaseName" value="${generalMedicalHistoryInstance?.diseaseName}"/>

                            </td>
                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="monthYearOfFirstDiagnosis"><g:message code="generalMedicalHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'monthYearOfFirstDiagnosis', 'error')}">
                                <g:datePicker name="monthYearOfFirstDiagnosis" precision="month" value="${generalMedicalHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }" />

                            </td>
                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="treatment"><g:message code="generalMedicalHistory.treatment.label" default="Treatment" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'treatment', 'error')}">
                              <%--   <g:textField name="treatment" value="${generalMedicalHistoryInstance?.treatment}"/>--%>
                                <g:select id="treatmentYesNo" name="treatment" from="${nci.bbrb.cdr.forms.GeneralMedicalHistory$YesNo?.values()}" keys="${nci.bbrb.cdr.forms.GeneralMedicalHistory$YesNo.values()*.name()}" value="${generalMedicalHistoryInstance?.treatment?.name()}"  />

                            </td>
                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="monthYearOfLastTreatment"><g:message code="generalMedicalHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'monthYearOfLastTreatment', 'error')}">
                                <g:datePicker name="monthYearOfLastTreatment" precision="month" value="${generalMedicalHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }" />

                            </td>
                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="source"><g:message code="generalMedicalHistory.source.label" default="Source" /></label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean: generalMedicalHistoryInstance, field: 'source', 'error')}">

                                <g:select name="source" from="${nci.bbrb.cdr.forms.GeneralMedicalHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.GeneralMedicalHistory$SourceType?.values()*.name()}" value="${generalMedicalHistoryInstance?.source?.name()}" noSelection="['': '']" />

                            </td>
                        </tr>


                    </tbody>
                </table>
                
                 
                         <g:hiddenField name="candidateRecord.id" value="${candId}" />
                        
                        <div class="buttons">

                            <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                        </div>
                    </g:form>
                
                
            </div>  
           
            <%-- end create GM page --%>








        </div>
    </body>
</html>
