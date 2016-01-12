
<%@ page import="nci.bbrb.cdr.forms.SlideSection" %>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>
<!DOCTYPE html>
<html>
    <head>

        <meta name="layout" content="cahubTemplate">
        <g:set var="entityName" value="${message(code: 'slideSection.label', default: 'SlideSection')}" />
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
                                    
                                        <g:sortableColumn property="internalComments" title="${message(code: 'slideSection.internalComments.label', default: 'Internal Comments')}" />
                                        
                                        <g:sortableColumn property="publicComments" title="${message(code: 'slideSection.publicComments.label', default: 'Public Comments')}" />
                                        
                                        <g:sortableColumn property="slideSectionTech" title="${message(code: 'slideSection.slideSectionTech.label', default: 'Slide Prep Tech')}" />
                                        
                                        <g:sortableColumn property="siteSOPSlideSection" title="${message(code: 'slideSection.siteSOPSlideSection.label', default: 'Site SOPS lide Prep')}" />
                                        
                                        <g:sortableColumn property="microtome" title="${message(code: 'slideSection.microtome.label', default: 'Microtome')}" />
                                        
                                        <g:sortableColumn property="microtomeOs" title="${message(code: 'slideSection.microtomeOs.label', default: 'Microtome Os')}" />
                                        
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${slideSectionInstanceList}" status="i" var="slideSectionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td><g:link action="show" id="${slideSectionInstance.id}">${fieldValue(bean: slideSectionInstance, field: "internalComments")}</g:link></td>
                                        
                                        <td>${fieldValue(bean: slideSectionInstance, field: "publicComments")}</td>
                                        
                                        <td>${fieldValue(bean: slideSectionInstance, field: "slideSectionTech")}</td>
                                        
                                        <td>${fieldValue(bean: slideSectionInstance, field: "siteSOPSlideSection")}</td>
                                        
                                        <td>${fieldValue(bean: slideSectionInstance, field: "microtome")}</td>
                                        
                                        <td>${fieldValue(bean: slideSectionInstance, field: "microtomeOs")}</td>
                                        
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginateButtons">
                        <g:paginate total="${slideSectionInstanceCount ?: 0}" />
                    </div>
            </div>
    </body>
</html>
