<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <g:set var="entityName" value="${message(code: 'screeningEnrollment.label', default: ' Candidate Screening Enrollment Form ')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="nav" class="clearfix">
            <div id="navlist">
                <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
                   <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                       </div>
                       </div>
                       <div id="container" class="clearfix">
                       <h1><g:message code="default.create.label" args="[entityName]" /></h1>
                    <g:if test="${flash.message}">
                        <div class="message">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${screeningEnrollmentInstance}">
                        <div class="errors">
                            <g:renderErrors bean="${screeningEnrollmentInstance}" as="list" />
                        </div>
                    </g:hasErrors>


                    <g:form url="[resource:screeningEnrollmentInstance, action:'save']" >

                        <div class="dialog">
                             
                            <g:render template="form"/>
                        </div>
                        <div class="buttons">
                           <span class="button"><g:actionSubmit class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" /></span>
                            <span class="button"><input class="delete" type="button" value="Cancel" onclick="if(confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Discard unsaved data?')}'))history.go(-1);"></input></span>
                        </div>
                    </g:form>
            </div>
    </body>
</html>
