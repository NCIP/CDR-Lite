<%@ page import="nci.bbrb.cdr.staticmembers.ContainerType" %>

<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="containerType.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: containerTypeInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${containerTypeInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="containerType.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: containerTypeInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${containerTypeInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="containerType.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: containerTypeInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${containerTypeInstance?.description}"/>

            </td>
        </tr>

        <%--
        <tr class="prop">
            <td valign="top" class="name">
                <label for="IRBprotocol"><g:message code="containerType.IRBprotocol.label" default="IRB protocol" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: containerTypeInstance, field: 'IRBprotocol', 'error')}">
                <g:textField name="IRBprotocol" value="${containerTypeInstance?.IRBprotocol}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="timeZone"><g:message code="containerType.timeZone.label" default="Time Zone" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: containerTypeInstance, field: 'timeZone', 'error')}">
                <g:textField name="timeZone" value="${containerTypeInstance?.timeZone}"/>

            </td>
        </tr>

        --%>
       

        
        

        </tbody>
    </table>
</div>  


