<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'healthHistory.label', default: 'HealthHistory')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                <g:link class="list" controller="healthHistory" action="show" id="${healthHistoryInstance.id}">show Health History</g:link>
               

            </div>
        </div>

        <div id="container" class="clearfix">

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <h2> SECTION A: Health History</h2>
            <div class="dialog">
                <table>
                    <tbody>



                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="healthHistory.candidateRecord.label" default="Candidate Record" /></td>

                            <td valign="top" class="value"><g:link controller="candidateRecord" action="show" id="${healthHistoryInstance?.candidateRecord?.id}">${healthHistoryInstance?.candidateRecord?.candidateId}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="healthHistory.source.label" default="Source" /></td>

                            <td valign="top" class="value">${fieldValue(bean: healthHistoryInstance, field: "source")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="healthHistory.historyOfCancer.label" default="History Of Cancer" /></td>

                            <td valign="top" class="value">${healthHistoryInstance?.historyOfCancer?.encodeAsHTML()}</td>

                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="healthHistory.dateCreated.label" default="Date Created" /></td>

                            <td valign="top" class="value">
                               <g:if test='${(session.DM) || session.authorities?.contains("ROLE_DM") || session.authorities?.contains("ROLE_ADMIN")}'>
                                    <g:formatDate date="${healthHistoryInstance?.dateCreated}" format="MM/dd/yyyy" />
                                </g:if>
                                <g:else>
                                    <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                </g:else>
                            </td>

                        </tr>



                    </tbody>
                </table>
            </div>  <!-- end div dialog start cancer history-->
            <%-- cancer history not required as of now. pmh :10/29/15
            <h2> SECTION B: Cancer History</h2>
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

                        <td><g:formatDate date="${cancerHistoryInstance.monthYearOfFirstDiagnosis}" format="MM/yyyy"/></td>

                        <td>${fieldValue(bean: cancerHistoryInstance, field: "treatments")}</td>

                        <td><g:formatDate date="${cancerHistoryInstance.monthYearOfLastTreatment}" format="MM/yyyy"/></td>

                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
                  --%>
             <!-- end div list now start general medical history-->
            <h2> SECTION B: General Medical History</h2> 
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
                                        <g:formatDate date="${generalMedicalHistoryInstance.monthYearOfFirstDiagnosis}" format="MM/yyyy"/>
                                    </g:if>
                                    <g:else>
                                        <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                    </g:else>
                                </td>

                                <td>${fieldValue(bean: generalMedicalHistoryInstance, field: "treatment")}</td>

                                <td><g:formatDate date="${generalMedicalHistoryInstance.monthYearOfLastTreatment}" format="MM/yyyy"/></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>


 <!-- end div list next is medications history-->
            <h2> SECTION C: Medications History</h2>  
            <div class="list">
                <table>
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="${message(code: 'medicationHistory.id.label', default: 'ID')}" />
                            <g:sortableColumn property="medicationName" title="${message(code: 'medicationHistory.medicationName.label', default: 'Medication Name')}" />

                            <g:sortableColumn property="dateofLastAdministration" title="${message(code: 'medicationHistory.dateofLastAdministration.label', default: 'Dateof Last Administration')}" />

                            <g:sortableColumn property="source" title="${message(code: 'medicationHistory.source.label', default: 'Source')}" />

                            <g:sortableColumn property="dateCreated" title="${message(code: 'medicationHistory.dateCreated.label', default: 'Date Created')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${medicationHistoryList}" status="i" var="medicationHistoryInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><a href="/cdrlite/MedicationHistory/show/${medicationHistoryInstance.id}">${medicationHistoryInstance.id}</a></td>                                     
                                <td>${fieldValue(bean: medicationHistoryInstance, field: "medicationName")}</td>

                                <td>
                                    <g:if test='${(session.DM) || session.authorities?.contains("ROLE_DM") || session.authorities?.contains("ROLE_ADMIN")}'>
                                        <g:formatDate date="${medicationHistoryInstance.dateofLastAdministration}" />
                                    </g:if>
                                    <g:else>
                                        <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                    </g:else>
                                </td>

                                <td>${fieldValue(bean: medicationHistoryInstance, field: "source")}</td>

                                <td><g:formatDate date="${medicationHistoryInstance.dateCreated}" /></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div><!-- end div list -->




        </div>
    </body>
</html>
