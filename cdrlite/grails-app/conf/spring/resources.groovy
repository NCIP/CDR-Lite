import nci.bbrb.cdr.context.CDRApplicationEvent
import grails.plugin.springsecurity.SpringSecurityUtils

beans = {
    securityEventListener(CDRApplicationEvent) {
        grailsApplication = ref('grailsApplication')
    }
}
