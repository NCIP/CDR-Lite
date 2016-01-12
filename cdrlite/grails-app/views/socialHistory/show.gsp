
<%@ page import="nci.bbrb.cdr.forms.SocialHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'socialHistory.label', default: 'Social History')}" />
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
                            <td valign="top" class="name"><g:message code="socialHistory.candidateRecord.label" default="Candidate Record" /></td>

                            <td valign="top" class="value"><g:link controller="candidateRecord" action="show" id="${socialHistoryInstance?.candidateRecord?.id}">${socialHistoryInstance?.candidateRecord?.candidateId.encodeAsHTML()}</g:link></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.alcoholConsum.label" default="Alcohol Consumption" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "alcoholConsum")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.numYrsAlcCon.label" default="Years of Aclcohol Consumption" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "numYrsAlcCon")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.tobaccoSmHist.label" default="Tobacco Smoking History" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "tobaccoSmHist")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.smokeAgeStart.label" default="Age Smoking started" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "smokeAgeStart")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.smokeYears.label" default="Years smoked" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "smokeYears")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.smokePackWeek.label" default="Pack per week smoked" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "smokePackWeek")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.yrSinceLastSmoke.label" default="Years since last smoked" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "yrSinceLastSmoke")}</td>

                        </tr>




                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.secHandSmHist1.label" default="Exposed to second hand smoking" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "secHandSmHist1")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.secHandSmHist2.label" default="Second hand smoking Exposure 1" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "secHandSmHist2")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.secHandSmHist3.label" default="Second hand smoking Exposure 2" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "secHandSmHist3")}</td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.dateCreated.label" default="Date Created" /></td>

                            <td valign="top" class="value"><g:formatDate date="${socialHistoryInstance?.dateCreated}" format="MM/dd/yyyy" /></td>

                        </tr>


                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.lastUpdated.label" default="Last Updated" /></td>

                            <td valign="top" class="value"><g:formatDate date="${socialHistoryInstance?.lastUpdated}" format="MM/dd/yyyy" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.dateSubmitted.label" default="Date Submitted" /></td>

                            <td valign="top" class="value"><g:formatDate date="${socialHistoryInstance?.dateSubmitted}" format="MM/dd/yyyy" /></td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="socialHistory.submittedBy.label" default="Submitted By" /></td>

                            <td valign="top" class="value">${fieldValue(bean: socialHistoryInstance, field: "submittedBy")}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form url="[resource:socialHistoryInstance, action:'edit']" method="POST" >
                    <g:hiddenField name="id" value="${socialHistoryInstance?.id}" />
                    <g:if test="${session.DM}">

                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>

                </g:form>
            </div>
        </div>
    </body>
</html>
