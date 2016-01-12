<g:set var="bodyclass" value="login denied" scope="request"/>
<g:set var="waitSeconds" value="${params.additionalMessage ? '7': '5'}"/>

<html>
    <head>
        <meta name="layout" content="cahubTemplate"/>
        <title>Access Denied</title>
        <meta http-equiv="refresh" content="${waitSeconds}; url=/cdrlite/home/" />
    </head>
    <body>
      <div id="nav" class="clearfix">
         <div id="navlist"></div>
      </div>
      
      <div id="container" class="clearfix">
        <g:if test="${flash.message}">
           <div class="message">${flash.message}</div>
        </g:if>
        <div class="errors">
          <ul>
            <g:if test="${params.additionalMessage}">
              <li>${params.additionalMessage}</li>
            </g:if>
            <li>Sorry, you're not authorized to view this page or perform this operation. Redirecting to your home page in ${waitSeconds} seconds...</li>
          </ul>
        </div>
      </div>
    </body>
</html>