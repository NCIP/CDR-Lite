
<%@ page import="nci.bbrb.cdr.forms.MedicationHistory" %>
<%@ page import="java.util.Calendar"%>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'medicationHistory.label', default: 'Medication History')}" />
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
                <h1>Medications History for candidate ${candidateInstance?.candidateId}</h1>
            <g:render template="/candidateRecord/candidateDetails" bean="${candidateInstance}" var="candidateRecord"/>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
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

                                <td> <g:if test='${(session.DM) || session.authorities?.contains("ROLE_DM") || session.authorities?.contains("ROLE_ADMIN")}'>
                                <g:formatDate date="${medicationHistoryInstance.dateofLastAdministration}" format="MM/dd/yyyy" />
                                </g:if>
                                <g:else>
                                    <span class="redactedMsg">REDACTED (No LDS privilege)</span>
                                </g:else></td>

                                <td>${fieldValue(bean: medicationHistoryInstance, field: "source")}</td>

                                <td><g:formatDate date="${medicationHistoryInstance.dateCreated}" format="MM/dd/yyyy"/></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>



<%-- add medication --%>
            <g:if test="${canAdd=='Yes' && session.DM}">              
                <div class="buttons">
                    <span class="button"><input type="button" value="Add" id ="addMed" /></span>
                </div>
            </g:if>
            <div id="formMed" style="display:none">
                <h2>Create Medication History </h2>
                <g:form url="[resource:medicationHistoryInstance, action:'save']" >
                    <g:hiddenField name="candidateRecord.id" value="${candId}" />

                    <table>
                        <tbody>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="medicationName"><g:message code="medicationHistory.medicationName.label" default="Medication Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'medicationName', 'error')}">
                                    <g:textField name="medicationName" value="${medicationHistoryInstance?.medicationName}"/>

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateofLastAdministration"><g:message code="medicationHistory.dateofLastAdministration.label" default="Date of Last Administration" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'dateofLastAdministration', 'error')}">
                                    <g:jqDateTimePicker name="dateofLastAdministration" precision="day"  value="${medicationHistoryInstance?.dateofLastAdministration}" default="none" noSelection="['': '']" years="${Calendar.instance.get(Calendar.YEAR)..1900 }"/>
                               
                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="source"><g:message code="medicationHistory.source.label" default="Source" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: medicationHistoryInstance, field: 'source', 'error')}">
                                    <g:select name="source" from="${nci.bbrb.cdr.forms.MedicationHistory$SourceType?.values()}" keys="${nci.bbrb.cdr.forms.MedicationHistory$SourceType?.values()*.name()}" value="${medicationHistoryInstance?.source?.name()}" noSelection="['': '']" />


                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <div class="buttons">

                        <span class="button"><g:actionSubmit class="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </div>
                </g:form>
            </div>
                                    <%--END  add medication--%>

        </div>
    </body>
</html>
