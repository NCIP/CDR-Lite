package nci.bbrb.cdrlite
import grails.plugin.springsecurity.ui.*
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import groovy.text.SimpleTemplateEngine
import java.util.*;
import groovy.time.*

//import grails.validation.Validateable

class RegisterController extends grails.plugin.springsecurity.ui.RegisterController {
    
    def forgotPassword() {

        if (!request.post) {
            // show the form
            return
        }

        String username = params.username
                
        if (!username) {
            flash.error = message(code: 'spring.security.ui.forgotPassword.username.missing')
            redirect action: 'forgotPassword'
            return
        }

        String usernameFieldName = SpringSecurityUtils.securityConfig.userLookup.usernamePropertyName
        def user = lookupUserClass().findWhere((usernameFieldName): username)
                
        if (!user) {
            flash.error = message(code: 'spring.security.ui.forgotPassword.user.notFound')
            redirect action: 'forgotPassword'
            return
        }

        def registrationCode = new RegistrationCode(username: user."$usernameFieldName")
        registrationCode.save(flush: true)

        String url = generateLink('resetPassword', [t: registrationCode.token])

        def conf = SpringSecurityUtils.securityConfig
        def body = conf.ui.forgotPassword.emailBody
        if (body.contains('$')) {
            body = evaluate(body, [user: user, url: url])
        }
               
                
        mailService.sendMail {
            to user.email
            from conf.ui.forgotPassword.emailFrom
            subject conf.ui.forgotPassword.emailSubject
            html body.toString()
        }
                
        [emailSent: true]
                
        //redirect action: 'passwordReset'
        //	return
                
		
    }
        
    

    def resetPassword(ResetPasswordCommand command) {
        
        String token = params.t
        String fromForm=params.fromForm
      
        def registrationCode = token ? RegistrationCode.findByToken(token) : null
        if (!registrationCode) {
            flash.error = message(code: 'spring.security.ui.resetPassword.badCode')
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
            return
        }

        if (!request.post) {
            return [token: token, command: new ResetPasswordCommand()]
        }

        command.username = registrationCode.username
      if(!fromForm){
        def dateNow=new Date()
       // println registrationCode.dateCreated.toString() +" is token create date"
        use (TimeCategory) {
            if (dateNow < registrationCode.dateCreated + 24.hours) {
                //println " more than 24 hours. create a token again"
                flash.error = message(code: 'spring.security.ui.resetPassword.badCode')
                redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
                return
            }
            else{
                //println " token issued within 24 hours. this is valid"
            }
        }
      }
        command.validate()

        if (command.hasErrors()) {
            return [token: token, command: command]
        }

        String salt = saltSource instanceof NullSaltSource ? null : registrationCode.username
        RegistrationCode.withTransaction { status ->
            String usernameFieldName = SpringSecurityUtils.securityConfig.userLookup.usernamePropertyName
            def user = lookupUserClass().findWhere((usernameFieldName): registrationCode.username)
            user.password = springSecurityUiService.encodePassword(command.password, salt)
            user.passwordChangeDate=new Date()
            user.save()
            registrationCode.delete()
        }

        springSecurityService.reauthenticate registrationCode.username

        flash.message = message(code: 'spring.security.ui.resetPassword.success')

        def conf = SpringSecurityUtils.securityConfig
        String postResetUrl = conf.ui.register.postResetUrl ?: conf.successHandler.defaultTargetUrl
        println "going to this URL after paswd reset: "+postResetUrl
        redirect uri: postResetUrl
    }
    
}


class ResetPasswordCommand {
	String username
	String password
	String password2

	static constraints = {
		password blank: false, validator: RegisterController.passwordValidator
		password2 validator: RegisterController.password2Validator
	}
}
