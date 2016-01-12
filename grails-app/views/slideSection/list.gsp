<%@ page import="nci.bbrb.cdr.forms.SlideSection" %>
<g:set var="bodyclass" value="bpvslideprep list bpv-study" scope="request"/>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        %{-- <g:set var="entityName" value="${slideSectionInstance?.formMetadata?.cdrFormName}" /> --}%
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'slideSection.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="slideSectionTech" title="${message(code: 'slideSection.slideSectionTech.label', default: 'Slide Prep Tech')}" />
                        
                            <g:sortableColumn property="microtome" title="${message(code: 'slideSection.microtome.label', default: 'Microtome')}" />
                        
                            <g:sortableColumn property="microtomeBladeType" title="${message(code: 'slideSection.microtomeBladeType.label', default: 'Microtome Blade Type')}" />
                        
                            <g:sortableColumn property="microtomeBladeTypeOs" title="${message(code: 'slideSection.microtomeBladeTypeOs.label', default: 'Microtome Blade Type Os')}" />
                        
                            <g:sortableColumn property="microtomeBladeAge" title="${message(code: 'slideSection.microtomeBladeAge.label', default: 'Microtome Blade Age')}" />
                        
                            <g:sortableColumn property="microtomeBladeAgeOs" title="${message(code: 'slideSection.microtomeBladeAgeOs.label', default: 'Microtome Blade Age Os')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${slideSectionInstanceList}" status="i" var="slideSectionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${slideSectionInstance.id}">${fieldValue(bean: slideSectionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "slideSectionTech")}</td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "microtome")}</td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "microtomeBladeType")}</td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "microtomeBladeTypeOs")}</td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "microtomeBladeAge")}</td>
                        
                            <td>${fieldValue(bean: slideSectionInstance, field: "microtomeBladeAgeOs")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${slideSectionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
