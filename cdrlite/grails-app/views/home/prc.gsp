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
            <h1>${session.study?.code} PRC Home</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
        
             <g:render template="/textSearch/searchFormPrc"  />

            <div class="list">

              
              <g:render template="/caseRecord/caseRecordPrcTable_tmpl" />
              <div class="clearfix tablefooter"><div class="left">Most recently created on top</div><div class="right"><a href="/cdrlite/prcReport/caselist">View all Cases &gt;&gt;</a></div></div>
                      
            </div>

        </div>
    </div>
    </body>
</html>
