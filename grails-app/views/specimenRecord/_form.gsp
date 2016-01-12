<%@ page import="nci.bbrb.cdr.datarecords.SpecimenRecord" %>
<%@ page import="nci.bbrb.cdr.staticmembers.TissueType" %>
<%@ page import="nci.bbrb.cdr.staticmembers.StorageTemp" %>

<g:set var="labelNumber" value="${1}"/>
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
            <td valign="top" class="name">
                <label for="caseRecord"><g:message code="specimenRecord.caseRecord.label" default="Case Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'caseRecord', 'error')}">
                <g:link controller="caseRecord" action="show" id="${specimenRecordInstance.caseRecord?.id}">${specimenRecordInstance.caseRecord?.caseId}</g:link>
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="parentSpecimen"><g:message code="specimenRecord.parentSpecimen.label" default="Parent Specimen" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'parentSpecimen', 'error')}">
                <g:select id="parentSpecimen" name="parentSpecimen.id" from="${nci.bbrb.cdr.datarecords.SpecimenRecord.list()}" optionKey="id" value="${specimenRecordInstance?.parentSpecimen?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr>
        --}%

        <tr class="prop">
            <td valign="top" class="name">
                <label for="grossId">${labelNumber++}. <g:message code="specimenRecord.grossId.label" default="Gross Id:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'grossId', 'errors')}">
                <g:textField name="grossId" required="" value="${specimenRecordInstance?.grossId}"/>
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="specimenId">${labelNumber++}. <g:message code="specimenRecord.specimenId.label" default="Specimen Id:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'specimenId', 'errors')}">
                <g:textField name="specimenId" required="" value="${specimenRecordInstance?.specimenId}"/>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueType">${labelNumber++}. <g:message code="specimenRecord.tissueType.label" default="Tissue Type:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'tissueType', 'errors')}">
                %{-- 
                <g:select id="tissueType" name="tissueType" from="${specimenRecordInstance.caseRecord.primaryTissueType}" optionKey="id" required="" 
                          value="${specimenRecordInstance.tissueType?.id}" class="many-to-one" noSelection="['':'-Select one-']"
                          onChange="${remoteFunction(controller:'SpecimenRecord', 
                                                     action:'getTissueLocation', 
                                                     params: 'id=' + this.value,
                                                     update: 'tissueLocation'
                                                 )}"/>
                --}%
                <g:select id="tissueType" name="tissueType" from="${specimenRecordInstance.caseRecord.primaryTissueType}" optionKey="id" required="" 
                          value="${specimenRecordInstance?.tissueType?.id}" class="many-to-one" noSelection="['':'-Select one-']"/> 
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueLocation">${labelNumber++}. <g:message code="specimenRecord.tissueLocation.label" default="Tissue Location:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'tissueLocation', 'errors')}">
                %{-- 
                <g:select id="tissueLocation" name="tissueLocation.id" from="${[]}" optionKey="id" value="${specimenRecordInstance?.tissueLocation?.id}" class="many-to-one" noSelection="['null': '']"/>
                --}%
                <g:textField name="tissueLocation" required="" value="${specimenRecordInstance?.tissueLocation}"/>
                
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="fixative">${labelNumber++}. <g:message code="specimenRecord.fixative.label" default="Fixative:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'fixative', 'errors')}">
                <g:select id="fixative" name="fixative.id" from="${nci.bbrb.cdr.staticmembers.Fixative.list()}" optionKey="id" value="${specimenRecordInstance?.fixative?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="containerType">${labelNumber++}. <g:message code="specimenRecord.containerType.label" default="Container Type:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'containerType', 'errors')}">
                <g:select id="containerType" name="containerType.id" from="${nci.bbrb.cdr.staticmembers.ContainerType.list()}" optionKey="id" value="${specimenRecordInstance?.containerType?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="preservationTime">${labelNumber++}. <g:message code="specimenRecord.preservationTime.label" default="Preservation Time:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'preservationTime', 'errors')}">
                <g:jqDateTimePicker LDSOverlay="${bodyclass ?: ''}" name="preservationTime" value="${specimenRecordInstance?.preservationTime}" />
            </td>
        </tr>

        %{--
        <tr class="prop">
            <td valign="top" class="name">
                <label for="processEvents"><g:message code="specimenRecord.processEvents.label" default="Process Events" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'processEvents', 'errors')}">
                <g:select name="processEvents" from="${nci.bbrb.cdr.datarecords.ProcessingEvent.list()}" multiple="multiple" optionKey="id" size="5" value="${specimenRecordInstance?.processEvents*.id}" class="many-to-many"/>
            </td>
        </tr>
        --}%

        <tr class="prop">
            <td valign="top" class="name">
                <label for="processingPerson">${labelNumber++}. <g:message code="specimenRecord.processingPerson.label" default="Processing Person:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'processingPerson', 'errors')}">
                <g:textField name="processingPerson" required="" value="${specimenRecordInstance?.processingPerson}"/>
            </td>
        </tr>

        <g:if test="${specimenRecordInstance?.slides}">
        <tr class="prop">
            <td valign="top" class="name">
                <label for="slides">${labelNumber++}. <g:message code="specimenRecord.slides.label" default="Slides:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'slides', 'errors')}">
                
                <ul class="one-to-many">
                <g:each in="${specimenRecordInstance?.slides?}" var="s">
                    <li><g:link controller="slideRecord" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                <g:link controller="slideRecord" action="create" params="['specimenRecord.id': specimenRecordInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'slideRecord.label', default: 'SlideRecord')])}</g:link>
                </li>
                </ul>
            </td>
        </tr>
        </g:if>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="storagePerson">${labelNumber++}. <g:message code="specimenRecord.storagePerson.label" default="Storage Person:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'storagePerson', 'errors')}">
                <g:textField name="storagePerson" required="" value="${specimenRecordInstance?.storagePerson}"/>
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="storageTemp">${labelNumber++}. <g:message code="specimenRecord.storageTemp.label" default="Storage Temp:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'storageTemp', 'errors')}">
                %{-- <g:select name="storageTemp" from="${nci.bbrb.cdr.staticmembers.StorageTemp.list()}" optionKey="id" size="5" value="${specimenRecordInstance?.storageTemp*.id}" class="many-to-many"/> --}%
                <%
                def i = 1
                %>
                <g:radioGroup name="storageTemp"
                              labels="${StorageTemp.list()}"
                              values="${StorageTemp.findAll().id}"
                              value="${specimenRecordInstance.storageTemp?.id}"
                              >
                              %{-- <%  out.print("<p> ${it.radio}  ${it.label} </p>")  %> --}%
                                  <p>${it.radio}  ${it.label} </p>
                </g:radioGroup>
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="storageTime">${labelNumber++}. <g:message code="specimenRecord.storageTime.label" default="Storage Time:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'storageTime', 'errors')}">
                <g:jqDateTimePicker name="storageTime" value="${specimenRecordInstance?.storageTime}" />
            </td>
        </tr>
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueSize">${labelNumber++}. <g:message code="specimenRecord.tissueSize.label" default="Tissue Size:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'tissueSize', 'errors')}">
                <g:textField name="tissueSize" required="" value="${specimenRecordInstance?.tissueSize}"/>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="tissueSizeUnits">${labelNumber++}. <g:message code="specimenRecord.tissueSizeUnits.label" default="Tissue Size Units:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'tissueSizeUnits', 'errors')}">
                <g:textField name="tissueSizeUnits" required="" value="${specimenRecordInstance?.tissueSizeUnits}"/>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="comments">${labelNumber++}. <g:message code="specimenRecord.comments.label" default="Comments:" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: specimenRecordInstance, field: 'comments', 'errors')}">
                <g:textArea name="comments" cols="40" rows="5" maxlength="4000" value="${specimenRecordInstance?.comments}"/>
            </td>
        </tr>

        <g:if test="${specimenRecordInstance?.processEvents}">
        <tr class="prop">
            <td valign="top" class="name">${labelNumber++}. <g:message code="specimenRecord.processEvents.label" default="Process Events:" /></td>
            <td valign="top" style="text-align: left;" class="value">
                <ul>
                <g:each in="${specimenRecordInstance.processEvents}" var="p">
                    <li><g:link controller="processingEvent" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                </g:each>
                </ul>
            </td>
        </tr>
        </g:if>
        </tbody>
    </table>
</div>  
