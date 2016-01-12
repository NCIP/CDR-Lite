<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<%@ page import="nci.bbrb.cdr.util.AppSetting" %>
<g:set var="bodyclass" value="prchome home" scope="request"/>
<html>
    <head>
        <title><g:message code="default.page.title"/></title>
        <meta name="layout" content="cahubTemplate" />
    </head>
    <body>
       <div id="nav" class="clearfix">
          <div id="navlist">
            <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>  
           
            <g:if test="${session.authorities.contains('ROLE_NCI-FREDERICK_CAHUB_SUPER') || session.authorities.contains('ROLE_ADMIN')}">
                <g:link controller="backoffice" class="list" action="index">Back Office</g:link>
            </g:if>
            
          </div>
      </div>
      <div id="container" class="clearfix">
            <h1>PRC Home</h1>
             <g:if test='${flash.message}'><div id="message" class="redtext">${flash.message}</div></g:if>
    
     <div class="list">
          <ul class="one-to-many">
        <g:each in="${studyList}" var="study">
            <li><g:link controller="home" action="prc" id="${study.id}">${study?.name}</g:link></li>
        </g:each>
       
        </ul>
                           
      </div>
           
        </div>
    
    </body>
</html>
