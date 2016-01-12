<%@ page import="nci.bbrb.cdr.staticmembers.Study" %>
<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="study.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: studyInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${studyInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="study.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: studyInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${studyInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="study.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: studyInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${studyInstance?.description}"/>

            </td>
        </tr>

      
        <g:if test="${params.action == 'edit'}">
         <tr class="prop">
            <td valign="top" class="name">
                <label for="bssList"><g:message code="study.bssList.label" default="Bss List" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: studyInstance, field: 'bssList', 'error')}">
                 <g:each in="${nci.bbrb.cdr.staticmembers.BSS.list()}" status="i" var="bss">
                     <g:if test="${studyInstance.bssList?.contains(bss) && CandidateRecord.findAllByBss(bss, [max:1])}">
                      <g:checkBox type="checkbox" name="bss_${bss.name}"  id="bss_${bss.name}" value="${studyInstance.bssList?.contains(bss)}"  disabled="true" /><label for="bss_${bss.name}">${bss.name}</label> <br />
                     </g:if>
                     <g:else>
                         <g:checkBox type="checkbox" name ="bss_${bss.name}" id="bss_${bss.name}" value="${studyInstance.bssList?.contains(bss)}" /><label for="bss_${bss.name}">${bss.name}</label> <br />
                      </g:else>
                   </g:each>

            </td>
        </tr>
        
        
         <tr class="prop">
            <td valign="top" class="name">
                <label for="bssList"><g:message code="study.tissueTypeList.label" default="Tissue Type List" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: studyInstance, field: 'tissueTypeList', 'error')}">
                 <g:each in="${nci.bbrb.cdr.staticmembers.TissueType.list()}" status="i" var="tissueType">
                  
                         <g:checkBox type="checkbox" name ="tissuetype_${tissueType.code}" id="tissuetype_${tissueType.code}" value="${studyInstance.tissueTypeList?.contains(tissueType)}" /><label for="tissuetype_${tissueType.code}">${tissueType.name}</label> <br />
                   </g:each>

            </td>
        </tr>
        
        </g:if>

        </tbody>
    </table>
</div>  
