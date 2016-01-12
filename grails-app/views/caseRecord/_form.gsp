<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<%@ page import="nci.bbrb.cdr.staticmembers.CaseStatus" %>

<div class="dialog">
    <table>
        <tbody>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="bss"><g:message code="caseRecord.bss.label" default="BSS" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'bss', 'error')}">
                ${caseRecordInstance?.bss?.name}
                <input type='hidden' name="bss.id" value="${caseRecordInstance?.bss?.id}" />
               <%-- <g:select id="bss" name="bss.id" from="${nci.bbrb.cdr.staticmembers.BSS.list()}" optionKey="id" required="" value="${caseRecordInstance?.bss?.id}" class="many-to-one"/>--%>
            </td>
        </tr>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="candidateRecord"><g:message code="caseRecord.candidateRecord.label" default="Candidate Record" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'candidateRecord', 'error')}">
               ${ caseRecordInstance?.candidateRecord?.candidateId}
               <input type='hidden' name="candidateRecord.id" value="${caseRecordInstance?.candidateRecord?.id}" />
                <%--<g:select id="candidateRecord" name="candidateRecord.id" from="${nci.bbrb.cdr.datarecords.CandidateRecord.list()}" optionKey="id" required="" value="${caseRecordInstance?.candidateRecord?.id}" class="many-to-one"/> --%>
            </td>
        </tr>

        <g:if test="${params.action!='create'}">
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseCollectionType"><g:message code="caseRecord.caseCollectionType.label" default="Case Collection Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'caseCollectionType', 'error')}">
                ${caseRecordInstance?.caseCollectionType?.name}
            </td>
        </tr>
      
        </g:if>
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseId"><g:message code="caseRecord.caseId.label" default="Case Id" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'caseId', 'error')}">
                <g:textField name="caseId" required="" value="${caseRecordInstance?.caseId}"/>
            </td>
        </tr>

         
        <tr class="prop">
            <td valign="top" class="name">
                <label for="caseStatus"><g:message code="caseRecord.caseStatus.label" default="Case Status" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'caseStatus', 'error')}">
                ${caseRecordInstance?.caseStatus?.name}
               <%-- <g:select id="caseStatus" name="caseStatus.id" from="${CaseStatus.list()}" optionKey="id" required="" value="${caseRecordInstance?.caseStatus?.id}" class="many-to-one" noSelection="['':'-Select one-']"/>--%>
            </td>
        </tr>
        
        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="primaryTissueType"><g:message code="caseRecord.primaryTissueType.label" default="Primary Tissue Type" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'primaryTissueType', 'error')}">
                <g:select id="primaryTissueType" name="primaryTissueType.id" from="${caseRecordInstance.study.tissueTypeList}" optionKey="id" required="" value="${caseRecordInstance?.primaryTissueType?.id}" class="many-to-one" noSelection="['':'-Select one-']"/>
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
                <label for="study"><g:message code="caseRecord.study.label" default="Study" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseRecordInstance, field: 'study', 'error')}">
                ${caseRecordInstance?.study?.code}
                <input type='hidden' name="study.id" value="${caseRecordInstance?.study?.id}" />
               <%-- <g:select id="study" name="study.id" from="${nci.bbrb.cdr.staticmembers.Study.list()}" optionKey="id" required="" value="${caseRecordInstance?.study?.id}" class="many-to-one"/> --%>
            </td>
        </tr>
       <%-- <g:if test="${caseRecordInstance.specimens}">
            <tr class="prop">
                <td valign="top" class="name formheader" colspan="3">Specimens (${caseRecordInstance.specimens.size()}):  
                </td>
            </tr>
            <tr>
                <td valign="top" class="value" colspan="3"> 
                    <div class="list">
                        <table class="nowrap">
                            <thead>
                                <tr>
                                    <th>Specimen Id</th>              
                                    <th>Tissue Type</th>        
                                    <th>Fixative</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${caseRecordInstance.specimens}" status="i" var="s">
                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="${s.specimenId.toUpperCase()}">
                                        <td class="itemid"><g:link action="show" controller="specimenRecord" id="${s.id}">${s.specimenId}</g:link></td>
                                        <td>${s.tissueType}</td>
                                        <td>${s.fixative}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </td>
            </tr>
        </g:if>--%>
            <tr>
                <td>
                %{-- <g:form controller="specimenRecord" action="create" params="${caseRecordInstance}"> <g:form url="[resource:caseRecordInstance, controller:specimenRecord, action:'edit']" method="POST" > --}%
                
                    
                %{-- </g:form> --}%
                </td>
            </tr>
        </tbody>
    </table>
</div>  
