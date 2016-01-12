
<%@ page import="nci.bbrb.cdr.util.FileUpload" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'fileUpload.label', default: 'FileUpload')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>

        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                 
                       </div>
                       </div>

                   <div id="container" class="clearfix">
                   <h1><g:message code="default.show.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="dialog">
                        <table>
                            <tbody>
                                
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.caseRecord.label" default="Case Record" /></td>
                            
                            <td valign="top" class="value"><g:link controller="caseRecord" action="show" id="${fileUploadInstance?.caseRecord?.id}">${fileUploadInstance?.caseRecord?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.caseId.label" default="Case Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "caseId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.fileName.label" default="File Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "fileName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.filePath.label" default="File Path" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "filePath")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "comments")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.uploadTime.label" default="Upload Time" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "uploadTime")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.bssCode.label" default="Bss Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: fileUploadInstance, field: "bssCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value"><g:link controller="caseAttachmentType" action="show" id="${fileUploadInstance?.category?.id}">${fileUploadInstance?.category?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.study.label" default="Study" /></td>
                            
                            <td valign="top" class="value"><g:link controller="study" action="show" id="${fileUploadInstance?.study?.id}">${fileUploadInstance?.study?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    %{--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.hideFromBss.label" default="Hide From Bss" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fileUploadInstance?.hideFromBss}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="fileUpload.dmUseOnly.label" default="Dm Use Only" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${fileUploadInstance?.dmUseOnly}" /></td>
                            
                        </tr>
                    --}%
                            </tbody>
                        </table>
                    </div>
                    <div class="buttons">
                        <g:form url="[resource:fileUploadInstance, action:'delete']" method="POST" >
                            <g:hiddenField name="id" value="${fileUploadInstance?.id}" />
                            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                        </g:form>
                    </div>
            </div>
    </body>
</html>
