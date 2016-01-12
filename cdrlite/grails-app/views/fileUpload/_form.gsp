<%@ page import="nci.bbrb.cdr.util.FileUpload" %>
<%@ page import="nci.bbrb.cdr.staticmembers.BSS" %>

<div class="dialog">
    <table>
        <tbody>

            <g:if test="${fileUploadInstance.caseRecord}">
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="caseId"><g:message code="fileUpload.caseId.label" default="Case Id:" /></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'caseId', 'errors')}">
                        <g:link controller="caseRecord" action="display" id="${fileUploadInstance?.caseRecord?.id}">${fileUploadInstance?.caseRecord?.caseId}</g:link>
                        <g:hiddenField name="caseRecord.id" value="${fileUploadInstance?.caseRecord?.id}" />

                    </td>
                </tr>
            </g:if>
            <g:if test="${editPage == 'Yes'}">

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fileName">File Name</label>
                    </td>
                    <td>                  
                        ${fileUploadInstance.fileName}
                    </td>
                </tr>
            </g:if>
            <g:else>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="fileName">File Name</label>
                    </td>
                    <td>                  
                        <input type="file" name="nameOfFile"  size="25"  value=""/> ${fileUploadInstance.fileName}
                    </td>
                </tr>
            </g:else>
            %{-- 
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="filePath"><g:message code="fileUpload.filePath.label" default="File Path" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'filePath', 'error')}">
                    <g:textField name="filePath" value="${fileUploadInstance?.filePath}"/>
    
                </td>
            </tr>
    
     <tr class="prop">
                <td valign="top" class="name">
                    <label for="uploadTime"><g:message code="fileUpload.uploadTime.label" default="Upload Time" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'uploadTime', 'error')}">
                    <g:textField name="uploadTime" value="${fileUploadInstance?.uploadTime}"/>
    
                </td>
            </tr>
            
            
            
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="bss"><g:message code="fileUpload.bss.label" default="BSS" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'bss', 'error')}">
                     <g:set  var="bss" value="${BSS.findByCode(session.org?.code)}"/>
                    <g:if test="${bss}">
                        <g:select id="bss" name="bss.id" from="${[bss]}" optionKey="id" required="" value="${fileUploadInstance?.bss?.id}" class="many-to-one"/> 
                    </g:if>
                    <g:else>
                    <g:select id="bss" name="bss.id" from="${nci.bbrb.cdr.staticmembers.BSS.list()}" optionKey="id" required="" value="${fileUploadInstance?.bss?.id}" class="many-to-one"/>
                    </g:else>
    
                </td>
            </tr>
    
           
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="study"><g:message code="fileUpload.study.label" default="Study" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'study', 'error')}">
                    <g:select id="study" name="study.id" from="${nci.bbrb.cdr.staticmembers.Study.list()}" optionKey="id" value="${fileUploadInstance?.study?.id}" class="many-to-one" noSelection="['null': '']"/>
    
                </td>
            </tr>
    
     <tr class="prop">
                <td valign="top" class="name">
                    <label for="hideFromBss"><g:message code="fileUpload.hideFromBss.label" default="Hide From Bss" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'hideFromBss', 'error')}">
                    <g:checkBox name="hideFromBss" value="${fileUploadInstance?.hideFromBss}" />
    
                </td>
            </tr>
    
     <tr class="prop">
                <td valign="top" class="name">
                    <label for="dmUseOnly"><g:message code="fileUpload.dmUseOnly.label" default="Dm Use Only" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'dmUseOnly', 'error')}">
                    <g:checkBox name="dmUseOnly" value="${fileUploadInstance?.dmUseOnly}" />
    
                </td>
            </tr>
     --}%

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="category"><g:message code="fileUpload.category.label" default="Category" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'category', 'error')}">
                    <g:select id="category" name="category.id" from="${gencatList}" optionKey="id" value="${fileUploadInstance?.category?.id}" class="many-to-one" noSelection="['null': '']"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="comments"><g:message code="fileUpload.comments.label" default="Comments" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: fileUploadInstance, field: 'comments', 'error')}">
                    <g:textArea name="comments" cols="40" rows="5" maxlength="4000" value="${fileUploadInstance?.comments}"/>
                </td>
            </tr>
        </tbody>
    </table>
</div>  
