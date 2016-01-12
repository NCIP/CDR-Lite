<%@ page import="nci.bbrb.cdr.staticmembers.TissueLocation" %>



<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="TissueLocation.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueLocationInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${tissueLocationInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="TissueLocation.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueLocationInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${tissueLocationInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="TissueLocation.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueLocationInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${tissueLocationInstance?.description}"/>

            </td>
        </tr>

        

        </tbody>
    </table>
</div>  

