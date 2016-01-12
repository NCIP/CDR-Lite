
<%@ page import="nci.bbrb.cdr.forms.TherapyRecord" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'therapyRecord.label', default: 'TherapyRecord')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
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
                            <td valign="top" class="name"><g:message code="therapyRecord.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.typeOfTherapy.label" default="Type Of Therapy" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "typeOfTherapy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.descTherapy.label" default="Desc Therapy" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "descTherapy")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.therapyDate.label" default="Therapy Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${therapyRecordInstance?.therapyDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.howLongAgo.label" default="How Long Ago" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "howLongAgo")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.hbcForm.label" default="Hbc Form" /></td>
                            
                            <td valign="top" class="value">${therapyRecordInstance?.hbcForm?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.specOtherHBCForm.label" default="Spec Other HBCF orm" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "specOtherHBCForm")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.durationMonths.label" default="Duration Months" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "durationMonths")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.noOfYearsStopped.label" default="No Of Years Stopped" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "noOfYearsStopped")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.hrtForm.label" default="Hrt Form" /></td>
                            
                            <td valign="top" class="value">${therapyRecordInstance?.hrtForm?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.specOtherHRTForm.label" default="Spec Other HRTF orm" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: therapyRecordInstance, field: "specOtherHRTForm")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.hrtType.label" default="Hrt Type" /></td>
                            
                            <td valign="top" class="value">${therapyRecordInstance?.hrtType?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.clinicalDataEntry.label" default="Clinical Data Entry" /></td>
                            
                            <td valign="top" class="value"><g:link controller="clinicalDataEntry" action="show" id="${therapyRecordInstance?.clinicalDataEntry?.id}">${therapyRecordInstance?.clinicalDataEntry?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${therapyRecordInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="therapyRecord.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${therapyRecordInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:therapyRecordInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${therapyRecordInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
