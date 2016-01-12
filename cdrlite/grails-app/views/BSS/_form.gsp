<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>


<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="BSS.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: BSSInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${BSSInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="BSS.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: BSSInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${BSSInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="BSS.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: BSSInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${BSSInstance?.description}"/>

            </td>
        </tr>

        
     <%--   <tr class="prop">
            <td valign="top" class="name">
                <label for="IRBprotocol"><g:message code="BSS.IRBprotocol.label" default="IRB protocol" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: BSSInstance, field: 'IRBprotocol', 'error')}">
                <g:textField name="IRBprotocol" value="${BSSInstance?.IRBprotocol}"/>

            </td>
        </tr>--%>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="timeZone"><g:message code="BSS.timeZone.label" default="Time Zone" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: BSSInstance, field: 'timeZone', 'error')}">
                <g:textField name="timeZone" value="${BSSInstance?.timeZone}"/>

            </td>
        </tr>

        
       

        
        

        </tbody>
    </table>
</div>  
