<%@ page import="nci.bbrb.cdr.staticmembers.TissueType" %>



<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="TissueType.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueTypeInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${tissueTypeInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="TissueType.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueTypeInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${tissueTypeInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="TissueType.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: tissueTypeInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${tissueTypeInstance?.description}"/>

            </td>
        </tr>

        

        </tbody>
    </table>
</div>  

