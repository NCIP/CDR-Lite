<%@ page import="nci.bbrb.cdr.datarecords.SpecimenRecord" %>
<g:set var="labelNumber" value="${1}"/>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'specimenRecord.label', default: 'SpecimenRecord')}" />
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
            <g:hasErrors bean="${specimenRecordInstance}">
                <div class="errors">
                    <g:renderErrors bean="${specimenRecordInstance}" as="list" />
                </div>
            </g:hasErrors>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr>
                            <td colspan="2">
                                <g:render template="/caseRecord/caseDetails" bean="${specimenRecordInstance.caseRecord}" var="caseRecord"/>
                            </td>
                        </tr>
                        %{--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="specimenRecord.parentSpecimen.label" default="Parent Specimen" /></td>
                            <td valign="top" class="value"><g:link controller="specimenRecord" action="show" id="${specimenRecordInstance?.parentSpecimen?.id}">${specimenRecordInstance?.parentSpecimen?.encodeAsHTML()}</g:link></td>
                        </tr>
                        --}%
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.grossId.label" default="Gross Id" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "grossId")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.specimenId.label" default="Specimen Id" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "specimenId")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.tissueType.label" default="Tissue Type" /></td>
                            <td valign="top" class="value"><g:link controller="tissueType" action="show" id="${specimenRecordInstance?.tissueType?.id}">${specimenRecordInstance?.tissueType?.encodeAsHTML()}</g:link></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.tissueLocation.label" default="Tissue Location" /></td>
                            %{-- <td valign="top" class="value"><g:link controller="tissueLocation" action="show" id="${specimenRecordInstance?.tissueLocation?.id}">${specimenRecordInstance?.tissueLocation?.encodeAsHTML()}</g:link></td> --}%
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "tissueLocation")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.fixative.label" default="Fixative" /></td>
                            <td valign="top" class="value"><g:link controller="fixative" action="show" id="${specimenRecordInstance?.fixative?.id}">${specimenRecordInstance?.fixative?.encodeAsHTML()}</g:link></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.containerType.label" default="Container Type" /></td>
                            <td valign="top" class="value"><g:link controller="containerType" action="show" id="${specimenRecordInstance?.containerType?.id}">${specimenRecordInstance?.containerType?.encodeAsHTML()}</g:link></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.preservationTime.label" default="Preservation Time" /></td>
                            <td valign="top" class="value"><g:formatDate date="${specimenRecordInstance?.preservationTime}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.processingPerson.label" default="Processing Person" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "processingPerson")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.slides.label" default="Slides" /></td>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${specimenRecordInstance.slides}" var="s">
                                    <li><g:link controller="slideRecord" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.storagePerson.label" default="Storage Person" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "storagePerson")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.storageTemp.label" default="Storage Temp" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "storageTemp")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.storageTime.label" default="Storage Time" /></td>
                            <td valign="top" class="value"><g:formatDate date="${specimenRecordInstance?.storageTime}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.tissueSize.label" default="Tissue Size" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "tissueSize")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.tissueSizeUnits.label" default="Tissue Size Units" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "tissueSizeUnits")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.comments.label" default="Comments" /></td>
                            <td valign="top" class="value">${fieldValue(bean: specimenRecordInstance, field: "comments")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.dateCreated.label" default="Date Created" /></td>
                            <td valign="top" class="value"><g:formatDate date="${specimenRecordInstance?.dateCreated}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.lastUpdated.label" default="Last Updated" /></td>
                            <td valign="top" class="value"><g:formatDate date="${specimenRecordInstance?.lastUpdated}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.processEvents.label" default="Process Events" /></td>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${specimenRecordInstance.processEvents}" var="p">
                                    <li><g:link controller="processingEvent" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form url="[resource:specimenRecordInstance, action:'edit']" method="POST" >
                    <g:hiddenField name="id" value="${specimenRecordInstance?.id}" />
                    <g:hiddenField name="caseRecord.id" value="${specimenRecordInstance?.caseRecord?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
