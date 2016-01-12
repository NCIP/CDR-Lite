

import javax.servlet.http.HttpServletResponse

import org.springframework.security.access.annotation.Secured
//pmh added this 03/31/15
 import grails.plugin.springsecurity.SpringSecurityUtils

@Secured('permitAll')
class LogoutController {

	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
        // TODO  put any pre-logout code here
        session.setAttribute("logout", new Boolean (true))
        session.invalidate()

        if(SpringSecurityUtils.securityConfig.cas.active) {
            redirect url: "${SpringSecurityUtils.securityConfig.logout.afterLogoutUrl}&cas_logged_out=1"
        } else {
            redirect(controller:"login",action:"auth", params:[logged_out:1])
        }
    }
}
