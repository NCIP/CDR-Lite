<%@ page import="nci.bbrb.cdr.util.AppSetting" %>

<g:set var="homeTitle" value="caHUB" scope="request"/>
<g:set var="bodyclass" value="gtexbsshome home" scope="request"/>


<head>
  <meta name='layout' content='cahubTemplate' />
</head>
<body>
 <div id="nav" class="clearfix">
    <div id="navlist">
     <a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>    
    </div>
 </div>
 <div id="container" class="clearfix">
  <h1>Project Home</h1>
    <g:if test='${flash.message}'><div id="message" class="redtext">${flash.message}</div></g:if>
    
     <div class="list">
          <ul class="one-to-many">
        <g:each in="${studyList.sort{it.id}}" var="study">
            <li><g:link controller="home" action="project" id="${study.id}">${study?.name}</g:link></li>
        </g:each>
       
        </ul>
                           
      </div>
 </div><!-- end container --> 
</body>
