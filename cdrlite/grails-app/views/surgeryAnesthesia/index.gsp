
%{-- <%@ page import="nci.bbrb.cdr.forms.SurgeryAnesthesiaForm" %> --}%
<%@ page import="nci.bbrb.cdr.forms.SurgeryAnesthesia" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'surgeryAnesthesiaForm.label', default: 'SurgeryAnesthesiaForm')}" />
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
                                    
                                        <g:sortableColumn property="surgeryDate" title="${message(code: 'surgeryAnesthesiaForm.surgeryDate.label', default: 'Surgery Date')}" />
                                        
                                        <g:sortableColumn property="poSedDiv" title="${message(code: 'surgeryAnesthesiaForm.poSedDiv.label', default: 'Po Sed Div')}" />
                                        
                                        <g:sortableColumn property="poOpDiv" title="${message(code: 'surgeryAnesthesiaForm.poOpDiv.label', default: 'Po Op Div')}" />
                                        
                                        <g:sortableColumn property="poAntiemDiv" title="${message(code: 'surgeryAnesthesiaForm.poAntiemDiv.label', default: 'Po Antiem Div')}" />
                                        
                                        <g:sortableColumn property="poAntiAcDiv" title="${message(code: 'surgeryAnesthesiaForm.poAntiAcDiv.label', default: 'Po Anti Ac Div')}" />
                                        
                                        <g:sortableColumn property="poMedDiv" title="${message(code: 'surgeryAnesthesiaForm.poMedDiv.label', default: 'Po Med Div')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${surgeryAnesthesiaFormInstanceList}" status="i" var="surgeryAnesthesiaFormInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${surgeryAnesthesiaFormInstance.id}">${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "surgeryDate")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "poSedDiv")}</td>
                                        
                                        <td>${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "poOpDiv")}</td>
                                        
                                        <td>${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "poAntiemDiv")}</td>
                                        
                                        <td>${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "poAntiAcDiv")}</td>
                                        
                                        <td>${fieldValue(bean: surgeryAnesthesiaFormInstance, field: "poMedDiv")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${surgeryAnesthesiaFormInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
