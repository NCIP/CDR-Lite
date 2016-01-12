
<%@ page import="nci.bbrb.cdr.forms.CancerHistory" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'cancerHistory.label', default: 'Cancer History')}" />
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
                <h1>Cancer History for candidate ${candidateFullID}</h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="${message(code: 'cancerHistory.id.label', default: 'ID')}" />

                            <g:sortableColumn property="primaryTumorSite" title="${message(code: 'cancerHistory.primaryTumorSite.label', default: 'Primary Tumor Site')}" />

                            <g:sortableColumn property="monthYearOfFirstDiagnosis" title="${message(code: 'cancerHistory.monthYearOfFirstDiagnosis.label', default: 'Month Year Of First Diagnosis')}" />

                            <g:sortableColumn property="treatments" title="${message(code: 'cancerHistory.treatments.label', default: 'Treatments')}" />

                            <g:sortableColumn property="monthYearOfLastTreatment" title="${message(code: 'cancerHistory.monthYearOfLastTreatment.label', default: 'Month Year Of Last Treatment')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cancerHistoryList}" status="i" var="cancerHistoryInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><a href="/cdrlite/cancerHistory/show/${cancerHistoryInstance.id}">${cancerHistoryInstance.id}</a></td>  

                                <td>${fieldValue(bean: cancerHistoryInstance, field: "primaryTumorSite")}</td>

                                <td> 
                                    <g:if test="${session.LDS != null && session.LDS == true }">
                                        <g:formatDate date="${cancerHistoryInstance.monthYearOfFirstDiagnosis}" format="MM/yyyy" />
                                    </g:if>
                                    <g:else>
                                        <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                    </g:else>
                                </td>

                                <td> <div>
                                        <g:checkBox disabled="true" name="treatmentSurgery" id="t1" value="${cancerHistoryInstance?.treatmentSurgery}" />&nbsp;<label for="t1">Surgery</label><br/>
                                        <g:checkBox disabled="true" name="treatmentRadiation" id="t2" value="${cancerHistoryInstance?.treatmentRadiation}" />&nbsp;<label for="t2">Radiation</label><br/>
                                        <g:checkBox disabled="true" name="treatmentChemotherapy" id="t3" value="${cancerHistoryInstance?.treatmentChemotherapy}" />&nbsp;<label for="t3">Chemotherapy</label><br/>
                                        <g:checkBox disabled="true" name="treatmentOther" id="t4" value="${cancerHistoryInstance?.treatmentOther}" />&nbsp;<label for="t4">Other</label><br/>
                                        <g:checkBox  disabled="true" name="treatmentNo" id="t5" value="${cancerHistoryInstance?.treatmentNo}" />&nbsp;<label for="t5">None</label><br/>
                                        <g:checkBox disabled="true"  name="treatmentUnknown" id="t6" value="${cancerHistoryInstance?.treatmentUnknown}" />&nbsp;<label for="t6">Unknown</label><br/>
                                    </div>
                                </td>

                                <td>
                                    <g:if test="${session.LDS != null && session.LDS == true }">
                                        <g:formatDate date="${cancerHistoryInstance.monthYearOfLastTreatment}" format="MM/yyyy" />
                                    </g:if>
                                    <g:else>
                                        <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                    </g:else>

                                </td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <g:if test="${canAdd=='Yes'}">
                <div class="buttons">
                    <span class="button"><input type="button" value="Add" id ="addCancer" /></span>
                </div>
            </g:if>
          <%-- add cancer history --%>
            <div id="formCancer" style="display:none">
                <h2>Create Cancer History </h2>
                <g:form url="[resource:cancerHistoryInstance, action:'save']" >
                    <g:hiddenField name="candidateRecord.id" value="${candId}" />

                    <table>
                        <tbody>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="primaryTumorSite"><g:message code="cancerHistory.primaryTumorSite.label" default="Primary Tumor Site" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'primaryTumorSite', 'error')}">
                                    <g:textField name="primaryTumorSite" value="${cancerHistoryInstance?.primaryTumorSite}"/>

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="monthYearOfFirstDiagnosis"><g:message code="cancerHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'monthYearOfFirstDiagnosis', 'error')}">

                                    <g:datePicker name="monthYearOfFirstDiagnosis" precision="month" value="${cancerHistoryInstance?.monthYearOfFirstDiagnosis}" default="none" noSelection="['': '']" years="${1900..2099}" />
                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="treatments"><g:message code="cancerHistory.treatments.label" default="History of any treatments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'treatments', 'errors')}">
                                    <div>
                                        <g:checkBox name="treatmentSurgery" id="t1" value="${cancerHistoryInstance?.treatmentSurgery}" />&nbsp;<label for="t1">Surgery</label><br/>
                                        <g:checkBox name="treatmentRadiation" id="t2" value="${cancerHistoryInstance?.treatmentRadiation}" />&nbsp;<label for="t2">Radiation</label><br/>
                                        <g:checkBox name="treatmentChemotherapy" id="t3" value="${cancerHistoryInstance?.treatmentChemotherapy}" />&nbsp;<label for="t3">Chemotherapy</label><br/>
                                        <g:checkBox name="treatmentOther" id="t4" value="${cancerHistoryInstance?.treatmentOther}" />&nbsp;<label for="t4">Other</label><br/>
                                        <g:checkBox name="treatmentNo" id="t5" value="${cancerHistoryInstance?.treatmentNo}" />&nbsp;<label for="t5">None</label><br/>
                                        <g:checkBox name="treatmentUnknown" id="t6" value="${cancerHistoryInstance?.treatmentUnknown}" />&nbsp;<label for="t6">Unknown</label><br/>
                                    </div>
                                </td>
                            </tr>
                            <g:if test="${cancerHistoryInstance?.treatmentOther}">
                                <tr class="prop"  id="ot" >
                                    <td valign="top" class="name">
                                        <label for="otherTreatment"><g:message code="cancerHistory.otherTreatment.label" default="If Other, specify:" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'otherTreatment', 'errors')}">
                                        <g:textField name="otherTreatment" value="${cancerHistoryInstance?.otherTreatment}" />
                                    </td>
                                </tr>
                            </g:if>
                            <g:else>
                                <tr class="prop"  id="ot" style="display:none">
                                    <td valign="top" class="name">
                                        <label for="otherTreatment"><g:message code="cancerHistory.otherTreatment.label" default="If Other, specify:" /></label>
                                    </td>
                                    <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'otherTreatment', 'errors')}">
                                        <g:textField name="otherTreatment" value="${cancerHistoryInstance?.otherTreatment}" />
                                    </td>
                                </tr>
                            </g:else>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="monthYearOfLastTreatment"><g:message code="cancerHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'monthYearOfLastTreatment', 'error')}">
                                    <g:datePicker name="monthYearOfLastTreatment" precision="month" value="${cancerHistoryInstance?.monthYearOfLastTreatment}" default="none" noSelection="['': '']" years="${1900..2099}" />
                                </td>
                            </tr>




                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="source"><g:message code="cancerHistory.source.label" default="Source" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cancerHistoryInstance, field: 'source', 'error')}">
                                    <g:select name="source" from="${nci.bbrb.cdr.forms.CancerHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.CancerHistory$SourceType?.values()*.name()}" value="${cancerHistoryInstance?.source?.name()}" noSelection="['': '']" />

                                </td>
                            </tr>


                        </tbody>

                    </table>

                    <div class="buttons">

                        <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </div>
                </g:form>
            </div>                   

<%--   END cancer history    --%>




        </div>
    </body>
</html>
