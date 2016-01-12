
<%@ page import="nci.bbrb.cdr.forms.GeneralMedicalHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'generalMedicalHistory.label', default: 'General Medical History')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                <g:link class="list" action="list" id="${generalMedicalHistoryInstance.candidateRecord?.id}"><g:message code="default.list.label" args="[entityName]" /></g:link>

            </div>
        </div>

        <div id="container" class="clearfix">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.id.label" default="Id" /></td>

                            <td valign="top" class="value">${fieldValue(bean: generalMedicalHistoryInstance, field: "id")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.diseaseName.label" default="Disease Name" /></td>

                            <td valign="top" class="value">${fieldValue(bean: generalMedicalHistoryInstance, field: "diseaseName")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></td>

                            <td valign="top" class="value"><g:formatDate date="${generalMedicalHistoryInstance?.monthYearOfFirstDiagnosis}" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.treatment.label" default="Treatment" /></td>

                            <td valign="top" class="value">${generalMedicalHistoryInstance?.treatment?.encodeAsHTML()}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></td>

                            <td valign="top" class="value"><g:formatDate date="${generalMedicalHistoryInstance?.monthYearOfLastTreatment}" /></td>

                        </tr>



                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.source.label" default="Source" /></td>

                            <td valign="top" class="value">${fieldValue(bean: generalMedicalHistoryInstance, field: "source")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.dateCreated.label" default="Date Created" /></td>

                            <td valign="top" class="value"><g:formatDate date="${generalMedicalHistoryInstance?.dateCreated}" /></td>

                        </tr>




                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="generalMedicalHistory.lastUpdated.label" default="Last Updated" /></td>

                            <td valign="top" class="value"><g:formatDate date="${generalMedicalHistoryInstance?.lastUpdated}" /></td>

                        </tr>


                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form url="[resource:generalMedicalHistoryInstance, action:'delete']" method="POST" >
                    <g:hiddenField name="id" value="${generalMedicalHistoryInstance?.id}" />
                    <g:if test="${session.DM}">
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>
                </g:form>
            </div>
        </div>
    </body>
</html>
