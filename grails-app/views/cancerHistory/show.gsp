
<%@ page import="nci.bbrb.cdr.forms.CancerHistory" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'cancerHistory.label', default: 'Cancer History')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                    <g:link controller="cancerHistory" action="list" id="${cancerHistoryInstance?.candidateRecord?.id}">List Cancer History</g:link>
          
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
                            <td valign="top" class="name"><g:message code="cancerHistory.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: cancerHistoryInstance, field: "id")}</td>
                            
                        </tr>
                    
                        
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.primaryTumorSite.label" default="Primary Tumor Site" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: cancerHistoryInstance, field: "primaryTumorSite")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.monthYearOfFirstDiagnosis.label" default="Month Year Of First Diagnosis" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${cancerHistoryInstance?.monthYearOfFirstDiagnosis}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatments.label" default="Treatments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: cancerHistoryInstance, field: "treatments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.monthYearOfLastTreatment.label" default="Month Year Of Last Treatment" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${cancerHistoryInstance?.monthYearOfLastTreatment}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.otherTreatment.label" default="Other Treatment" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: cancerHistoryInstance, field: "otherTreatment")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.source.label" default="Source" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: cancerHistoryInstance, field: "source")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${cancerHistoryInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                       
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${cancerHistoryInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentChemotherapy.label" default="Treatment Chemotherapy" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentChemotherapy}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentNo.label" default="Treatment No" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentNo}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentOther.label" default="Treatment Other" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentOther}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentRadiation.label" default="Treatment Radiation" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentRadiation}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentSurgery.label" default="Treatment Surgery" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentSurgery}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="cancerHistory.treatmentUnknown.label" default="Treatment Unknown" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${cancerHistoryInstance?.treatmentUnknown}" /></td>
                            
                        </tr>
                    
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:cancerHistoryInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${cancerHistoryInstance?.id}" />
                            <g:if test="${session.DM}">
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </g:if>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
