<%@ page import="nci.bbrb.cdr.staticmembers.Fixative" %>

<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="fixative.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: fixativeInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${fixativeInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="fixative.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: fixativeInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${fixativeInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="fixative.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: fixativeInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${fixativeInstance?.description}"/>

            </td>
        </tr>

        

        </tbody>
    </table>
</div>  




