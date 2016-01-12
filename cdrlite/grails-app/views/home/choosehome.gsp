<%@ page import="nci.bbrb.cdr.datarecords.CandidateRecord" %>
<%@ page import="nci.bbrb.cdr.datarecords.CaseRecord" %>
<%@ page import="nci.bbrb.cdr.util.AppSetting" %> 
<g:set var="bodyclass" value="choosehome" scope="request"/>
<html>
    <head>
        <title><g:message code="default.page.title"/></title>
        <meta name="layout" content="cahubTemplate" />
        <script type="text/javascript" src="${resource(dir:'js',file:'reflection.js')}" ></script>
    </head>
    <body>     
       <div id="nav" class="clearfix">
          <div id="navlist">
            <g:if test="${session.authorities?.contains('ROLE_ADMIN')}">
                <g:link controller="backoffice" class="list" action="index">Back Office</g:link>             
            </g:if> 
            <g:if test="${session.authorities?.contains('ROLE_DM') || session.DM}">
               <g:link controller="query" class="list" action="list">Query Tracker</g:link>
                <g:link controller="deviation" class="list" action="list">Deviation List</g:link>               
            </g:if> 

          </div>
      </div>
      <div id="container" class="clearfix">
	<div id="homemenu">
          <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
          </g:if>
          <div class="inner ui-corner-all">
            <h1>Choose your Destination</h1>
            <div class="clearfix">
               
              <div class="cahubthumbmenu">
                <g:if test="${'BPV' in blockedStudyList}">
                  <img src="${resource(dir:'images',file:'brnthumb.jpg')}" class="reflect rheight33" /><span>Project Home</span>
                  <span>Study Home</span>         
                </g:if>
                <g:else>
                  <g:link controller="home" action="projecthome"><img src="${resource(dir:'images',file:'brnthumb.jpg')}" class="reflect rheight33" /><span>Project Home</span></g:link>
                 
                </g:else>
              </div>
              
              
              
               <div class="cahubthumbmenu">
               <g:if test="${session.PRC == true}">
                  <g:link controller="home" action="prchome"><img src="${resource(dir:'images',file:'prcthumb2.jpg')}" class="reflect rheight33" /><span>PRC Home</span></g:link>
               </g:if>
               <g:else>
                  <img src="${resource(dir:'images',file:'prcthumb2.jpg')}" class="reflect rheight33" /><span>PRC Home</span>                          
               </g:else>
              </div>      
              
              
              <div class="cahubthumbmenu">
              <g:if test="${session.DM == true}">
                 <g:link controller="home" action="opshome"><img src="${resource(dir:'images',file:'opsthumb1.jpg')}" class="reflect rheight33" /><span>DM Home</span></g:link>
              </g:if>
              <g:else>
                 <img src="${resource(dir:'images',file:'opsthumb1.jpg')}" class="reflect rheight33" /><span>DM Home</span>
              </g:else>                            
              </div>
             
              <%--
              <div class="cahubthumbmenu">
                <g:if test="${session.QM == true}">
                 <g:link controller="home" action="qmhome"><img src="${resource(dir:'images',file:'qmthumb2.jpg')}" class="reflect rheight33" /><span>QM Home</span></g:link>
              </g:if>
              <g:else>
                 <img src="${resource(dir:'images',file:'qmthumb1.jpg')}" class="reflect rheight33" /><span>QM Home</span>
              </g:else>    
              </div>
            </div>
            --%>
     </div>
   </div>
   </div>
   </div><!-- end container --> 
  </body>
</html>
