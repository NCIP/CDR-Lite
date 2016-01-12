
<%@ page import="nci.bbrb.cdr.util.FileUpload" %>
<g:set var="bodyclass" value="new_page_enter_lowercase_folder_name_here list" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'fileUpload.label', default: 'File Upload')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix"> 
                       <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                        <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    
                                   <%-- <th><g:message code="fileUpload.caseRecord.label" default="Case Record" /></th> 
                                        <th>ID</th>--%>
                                        <g:sortableColumn property="caseId" title="${message(code: 'fileUpload.caseId.label', default: 'Case Id')}" />
                                        
                                        <g:sortableColumn property="fileName" title="${message(code: 'fileUpload.fileName.label', default: 'File Name')}" />
                                        
                                        <g:sortableColumn property="filePath" title="${message(code: 'fileUpload.filePath.label', default: 'File Path')}" />
                                        
                                        <g:sortableColumn property="comments" title="${message(code: 'fileUpload.comments.label', default: 'Comments')}" />
                                        
                                        <g:sortableColumn property="uploadTime" title="${message(code: 'fileUpload.uploadTime.label', default: 'Upload Time')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${fileUploadInstanceList}" status="i" var="fileUploadInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                      <g:if test="${fileUploadInstance.caseRecord} ">
                                        <td>  <a href="/cdrlite/caseRecord/show/${fileUploadInstance.caseRecord?.id}">${fileUploadInstance.caseId}</a></td>
                                        </g:if>
                                        <g:else>
                                        <td>${fieldValue(bean: fileUploadInstance, field: "caseId")}</td>
                                        </g:else>
                                        
                                        <td>${fieldValue(bean: fileUploadInstance, field: "fileName")}</td>
                                        
                                        <td>${fieldValue(bean: fileUploadInstance, field: "filePath")}</td>
                                        
                                        <td>${fieldValue(bean: fileUploadInstance, field: "comments")}</td>
                                        
                                        <td>${fieldValue(bean: fileUploadInstance, field: "uploadTime")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${fileUploadInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
