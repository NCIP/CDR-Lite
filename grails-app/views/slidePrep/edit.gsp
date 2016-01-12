<%@ page import="nci.bbrb.cdr.forms.SlidePrep" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'slidePrep.label', default: 'Slide Prep')}" />
         <g:set var="bodyclass" value="slideprep edit bps-study" scope="request"/>
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <script type="text/javascript" src="${resource(dir:'js/forms',file:'slidePrep.js')}?v<g:meta name='app.version'/>-${ts ?: ''}"></script>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>

            </div>
        </div>

        <div id="container" class="clearfix">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
           <g:hasErrors bean="${slidePrepInstance}">
                        <div class="errors">
                            <g:renderErrors bean="${slidePrepInstance}" as="list" />
                        </div>
                    </g:hasErrors>
            <g:form url="[resource:slidePrepInstance, action:'update']" method="POST" >
                <g:hiddenField name="version" value="${slidePrepInstance?.version}" />
                <input type="hidden" name="changed" value="N" id="changed"/>
                <fieldset class="form">
                    <g:render template="form"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                    <g:if test="${canSubmit}">
                        <g:actionSubmit class="save" action="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}" onclick="return sub()"/></span>
                    </g:if>

                </fieldset>
            </g:form>
        </div>
    </body>
</html>
