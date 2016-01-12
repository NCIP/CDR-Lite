
<%@ page import="nci.bbrb.cdr.util.FileUpload" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'fileUpload.label', default: 'FileUpload')}" />
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
                                    
                                    <th><g:message code="fileUpload.caseRecord.label" default="Case Record" /></th>
                                        
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
                                        
                                        <td><g:link action="show" id="${fileUploadInstance.id}">${fieldValue(bean: fileUploadInstance, field: "caseRecord")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: fileUploadInstance, field: "caseId")}</td>
                                        
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
