<div class="dialog">
    <table>
        <tbody>

            
        <tr class="prop">
            <td valign="top" class="name">
                <label for="name"><g:message code="caseStatus.name.label" default="Name" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseStatusInstance, field: 'name', 'error')}">
                <g:textField name="name" required="" value="${caseStatusInstance?.name}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="code"><g:message code="caseStatus.code.label" default="Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseStatusInstance, field: 'code', 'error')}">
                <g:textField name="code" required="" value="${caseStatusInstance?.code}"/>

            </td>
        </tr>

        
        <tr class="prop">
            <td valign="top" class="name">
                <label for="description"><g:message code="caseStatus.description.label" default="Description" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: caseStatusInstance, field: 'description', 'error')}">
                <g:textArea name="description" cols="40" rows="5" maxlength="4000" value="${caseStatusInstance?.description}"/>

            </td>
        </tr>

       
       

        
        

        </tbody>
    </table>
</div>  




