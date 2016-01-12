<%@ page import="nci.bbrb.cdr.staticmembers.Organization" %>
<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>
<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="organization.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${organizationInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="organization.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${organizationInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="organization.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${organizationInstance?.description}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="shippingAddress"><g:message code="organization.shippingAddress.label" default="Shipping Address" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'shippingAddress', 'error')}">
                <g:textArea name="shippingAddress" cols="40" rows="5" value="${organizationInstance?.shippingAddress}"/>

            </td>
        </tr>
       
        <g:if test="${params.action == 'edit' && organizationInstance?.isBss && CandidateRecord.findAllByBss(BSS.findByCode(organizationInstance.code), [max:1])}">
          <tr class="prop">
            <td valign="top" class="name">
                <label for="isBss"><g:message code="organization.isBss.label" default="Is BSS" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'isBss', 'error')}">
                <g:checkBox name="isBss" value="${organizationInstance?.isBss}" disabled="true"/>

            </td>
        </tr>
       </g:if>
       <g:else>
            <tr class="prop">
            <td valign="top" class="name">
                <label for="isBss"><g:message code="organization.isBss.label" default="Is Bss" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: organizationInstance, field: 'isBss', 'error')}">
                <g:checkBox name="isBss" value="${organizationInstance?.isBss}" />

            </td>
        </tr>
       </g:else>
        
        

        </tbody>
    </table>
</div>  
