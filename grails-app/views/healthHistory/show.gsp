
<%@ page import="nci.bbrb.cdr.forms.HealthHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'healthHistory.label', default: 'Health History')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

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


                            <td>
                                
                                <g:formatDate date="${healthHistoryInstance?.dateCreated}" format="MM/dd/yyyy" />
                               
                            </td>
                        </tr>
<%--
                        <tr class="prop" style="display:${healthHistoryInstance?.historyOfCancer?.encodeAsHTML() =='Yes'?'display':'none'}" id="addCancerHistRow">
                            <td valign="top" class="name">
                                <g:link controller="cancerHistory" action="list" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Show Cancer History</g:link>
                                </td>
                                <td valign="top">
                                    <%-- add anything here ???--%>
<%--
                            </td>
                        </tr>

--%>
                        <g:if test="${healthHistoryInstance?.dateCreated}">  
                            <tr class="prop" >
                                <td valign="top" class="name">
                                 <%--   <g:link controller="generalMedicalHistory" action="list" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Show General Medical History</g:link> --%>
                                    <g:link controller="generalMedicalHistory" action="list" id="${healthHistoryInstance?.candidateRecord?.id}">Show General Medical History</g:link>
                                </td>
                                    <td valign="top">



                                </td>
                            </tr>


                            <tr class="prop" >
                                <td valign="top" class="name">
                                  <%--  <g:link controller="medicationHistory" action="list" params="['candidateRecord.id': healthHistoryInstance?.candidateRecord?.id]" >Show Medications History</g:link> --%>
                                    <g:link controller="medicationHistory" action="list" id="${healthHistoryInstance?.candidateRecord?.id}">Show Medications History</g:link>
                                </td>
                                    <td valign="top">



                                </td>
                            </tr>
                        </g:if>  

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form url="[resource:healthHistoryInstance, action:'save']" method="POST" >
                    <g:hiddenField name="id" value="${healthHistoryInstance?.id}" />

                    <g:if test="${!healthHistoryInstance?.dateSubmitted  && session.DM }">
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="Edit" /></span>
                        <span class="button"><g:actionSubmit class="edit" action="submit" value="Submit" /></span>
                    </g:if>
                    <g:if test="${healthHistoryInstance?.dateSubmitted && session.DM }">
                        <span class="button"><g:actionSubmit class="edit" action="update" value="Resume Editing" /></span>
                    </g:if>
                    <span class="button"><g:actionSubmit class="edit" action="display" value="Display Full Report" /></span>
                  <%--  <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span> --%>
                </g:form>
            </div>
        </div>
    </body>
</html>
