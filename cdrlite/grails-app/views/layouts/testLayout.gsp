<html>
        <head>
            <title><g:layoutTitle default="CDR-Lite"/></title>
       
        <script> function redirectToLogin(){
            window.location = '/cdrlite/logout';
            }
        </script>
        <g:layoutHead/>
    </head>
    <body>
<!-- this is for the section above the  nav bar list  -->
  <div class="headerDivLeft">
    <g:if test="${controllerName != 'login' && controllerName != 'logout' }">
      <div id="userInfo" class="clearfix">
      <div class="small"><span class="welcome">Welcome, ${session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()}</span> <a href="javascript:redirectToLogin();">Logout</a></div>
      <div class="small">Org: ${session.org?.name}</div>   
      <div id="countdown" class="countdown hasCountdown">Session expires in: <b><span class="minutesleft"></span>:<span class="secondsleft"></span></b></div>
      </div>
    </g:if>
  </div>
  
  <div class="headerDivRight">
    <g:if test="${controllerName != 'login' && controllerName != 'logout' }">
      <div id="userInfo" class="clearfix">
      <div class="small"><span class="welcome">Welcome, ${session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()}</span> <a href="javascript:redirectToLogin();">Logout</a></div>
      <div class="small">Org: ${session.org?.name}</div>   
      <div id="countdown" class="countdown hasCountdown">Session expires in: <b><span class="minutesleft"></span>:<span class="secondsleft"></span></b></div>
      </div>
    </g:if>
  </div>
  <!-- end of section above nav bar list -->
        
        <g:layoutBody/>
       
    </body>
</html>