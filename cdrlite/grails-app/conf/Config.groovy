grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination


// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    //form:          'application/x-www-form-urlencoded',
    //pmh 05/07/15: use this to make dynamic scaffold work. comment out the above line
    form:          ['application/x-www-form-urlencoded','multipart/form-data'],
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}

// New for grails 2.4.4 -- output from the jqueryDatePicker tag lib no longer binds to Date attributes on a domain class, unless you update the default binding strategy
grails.databinding.dateFormats = ['MM/dd/yyyy', 'yyyy-MM-dd HH:mm:ss.S', "yyyy-MM-dd'T'hh:mm:ss'Z'", 'MM/dd/yyyy HH:mm']

grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com"
    }
}


//pmh this is required for emails etc..

environments {
    development {
        grails.logging.jul.usebridge = true
        grails.mail.host = "mailfwd.nih.gov"
        grails.mail.port="25"
        grails.mail.default.from="noreply@cahub.ncifcrf.gov"
    }
    production {
        grails.logging.jul.usebridge = false
        // TODO: grails.serverURL = "http://www.changeme.com" : not sure about this yet 
        //TODO: pmh: set up mail.host info for PROD
    }
}

grails.plugin.springsecurity.filterChain.chainMap = [
   '/rest/**': 'JOINED_FILTERS,-exceptionTranslationFilter',
   '/**': 'JOINED_FILTERS,-basicAuthenticationFilter,-basicExceptionTranslationFilter'
]

grails.plugin.springsecurity.useBasicAuth = true
grails.plugin.springsecurity.basic.realmName = "CDR Data Services"

grails.plugin.springsecurity.ui.register.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugin.springsecurity.ui.forgotPassword.emailFrom ='noreply@cahub.ncifcrf.gov'
grails.plugin.springsecurity.ui.register.emailSubject = 'CDR-Lite Password Reset'

grails.plugin.springsecurity.ui.forgotPassword.emailBody = 'Dear $user.username,<br/><br/>You recently requested that your CDR-Lite password be reset.<br/><br/>Please click <a href="$url">here</a> to reset your password, if you did request a password change. Otherwise, ignore this email and no change will be applied to your account.<br/><br/>CDR-Lite Administrator'
grails.plugin.springsecurity.ui.forgotPassword.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugin.springsecurity.ui.forgotPassword.emailSubject = 'CDR-Lite Account Password Reset'

grails.plugin.springsecurity.ui.expiredPassword.emailBody = 'Dear $username,<br/><br/>Your CDR-Lite account password is expired.<br/><br/>Please click <a href="$url">here</a> to change your password.<br/><br/>CDR-Lite Administrator'
grails.plugin.springsecurity.ui.expiredPassword.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugin.springsecurity.ui.expiredPassword.emailSubject = 'CDR-Lite Account Password Expired'

grails.plugin.springsecurity.ui.expiredPassword.reminder.emailBody = 'Dear $username,<br/><br/>Your CDR-Lite account password expires on $expireDate, which is $daysRemain from today.<br/><br/>Please click <a href="$url">here</a> to change your password before it expires.<br/><br/>CDR-Lite Administrator'
grails.plugin.springsecurity.ui.expiredPassword.reminder.emailFrom = 'noreply@cahub.ncifcrf.gov'
grails.plugin.springsecurity.ui.expiredPassword.reminder.emailSubject = 'Reminder: CDR-Lite Account Password Expiration'
//pessimistic lockdown setting, so you need to ALLOW all roles on URLs
grails.plugin.springsecurity.rejectIfNoRule = true

//pmh 04/02/15 testing the @secured annotations 
grails.plugin.springsecurity.securityConfigType = "Annotation"

grails.assets.bundle=true
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
    //system setting controllers
    '/user/**': ['ROLE_ADMIN','ROLE_SUPER'],
    '/role/**': ['ROLE_ADMIN','ROLE_SUPER'],
    '/userRole/**': ['ROLE_ADMIN','ROLE_SUPER'],
    '/securityInfo/**': ['ROLE_ADMIN','ROLE_SUPER'],
    '/controllers.gsp':['ROLE_ADMIN','ROLE_SUPER'],
    '/backoffice/**':['ROLE_ADMIN','ROLE_SUPER'],
    '/auditLogEvent/**':['ROLE_ADMIN','ROLE_SUPER'],
    '/userLogin/**': ['ROLE_ADMIN','ROLE_SUPER','ROLE_DM'],
    '/privilege/**':['ROLE_ADMIN','ROLE_SUPER','ROLE_DM','ROLE_PRC','ROLE_LDS'],
    '/tissueType/**':['ROLE_ADMIN','ROLE_SUPER','ROLE_DM'],
    
    //leave these alone.  these rules are needed for everyting to work properly
    '/login/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/logout/**': ['IS_AUTHENTICATED_FULLY'],
    '/register/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/plugins/**': ['IS_AUTHENTICATED_ANONYMOUSLY', 'IS_AUTHENTICATED_FULLY'],
    '/images/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/css/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/js/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
	//webapp controllers
    '/home/**': ['ROLE_BSS', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/appSetting/**': ['ROLE_ADMIN'],
    '/caseRecord/**': ['ROLE_BSS', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/candidateRecord/**': ['ROLE_BSS', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/specimenRecord/**': ['ROLE_BSS', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/slideRecord/**': ['ROLE_BSS', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/study/**': ['ROLE_DCC'],
    '/study/edit': ['ROLE_ADMIN', 'ROLE_DM'],
    '/organization/**': ['ROLE_DCC'],
    '/organization/edit': ['ROLE_DM', 'ROLE_ADMIN'],
    '/bss/**': ['ROLE_DCC'],
    '/bss/edit': ['ROLE_DM', 'ROLE_ADMIN'],
    '/user/**': ['ROLE_ADMIN'],
    '/role/**': ['ROLE_ADMIN'],
    '/activityType/**':['ROLE_DM', 'ROLE_ADMIN'],
    '/activityEvent/**': ['ROLE_DCC'],
    '/activitycenter/**': ['ROLE_DCC'],
    '/textSearch/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/textSearch/index_all': ['ROLE_ADMIN'],
    '/query/**': ['ROLE_DCC','ROLE_BSS'],
    '/deviation/**': ['ROLE_DCC','ROLE_ADMIN','ROLE_DM','ROLE_BSS'],
    '/fileUpload/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/caseAttachmentType/**':['ROLE_ADMIN', 'ROLE_DM'],
    '/prcReport/**': ['ROLE_PRC','ROLE_ADMIN'],
    '/prcReport/view': ['ROLE_ADMIN', 'ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/localPathReview/**': ['ROLE_DCC', 'ROLE_BSS', 'ROLE_PRC'], // inserted by umkis 12/24/2015
    '/healthHistory/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/socialHistory/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/surgeryAnesthesia/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/tissueGrossEvaluation/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/slidePrep/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/tissueProcessEmbed/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/generalMedicalHistory/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/cancerHistory/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/medicationHistory/**': ['ROLE_BSS', 'ROLE_DCC'],
    '/screeningEnrollment/**': ['ROLE_DCC','ROLE_BSS'],
    '/consentVerification/**': ['ROLE_DCC','ROLE_BSS'],
    '/demographics/**': ['ROLE_DCC','ROLE_BSS'],
    '/containerType/**': ['ROLE_DCC','ROLE_BSS'],
    '/blood/**': ['ROLE_DCC','ROLE_BSS'], 
    '/bloodAliquotType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/bloodCollectionReason/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/bloodTubeType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/bloodDrawTech/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/bloodDrawType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/caseCollectionType/**': ['ROLE_DM', 'ROLE_ADMIN'],
     '/queryStatus/**': ['ROLE_DM', 'ROLE_ADMIN'],
     '/queryType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/storageTemp/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/tissueCategory/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/caseStatus/**': ['ROLE_DM', 'ROLE_ADMIN'],
     '/tissueReceiptDissection/**': ['ROLE_DCC','ROLE_BSS'],
     '/slideSection/**': ['ROLE_DCC','ROLE_BSS'],
     '/clinicalDataEntry/**': ['ROLE_DCC','ROLE_BSS'],
    '/containerType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/fixative/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/tissueLocation/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/tissueType/**': ['ROLE_DM', 'ROLE_ADMIN'],
    '/caseAttachmentType/**': ['ROLE_DM', 'ROLE_ADMIN'],
     '/rest/**': ['ROLE_ADMIN', 'ROLE_SERVICE'], // add 'ROLE_SERVICE' by umkis 12/24/2015
    '/home/opshome':['ROLE_DCC'],
    '/home/prchome':['ROLE_DCC', 'ROLE_PRC'], // add 'ROLE_PRC' by umkis 12/24/2015
    '/home/vocabhome':['ROLE_DCC'],
    '/home/prc':['ROLE_PRC','ROLE_ADMIN']
   
]



// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'nci.bbrb.cdr.authservice.CdrUser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'nci.bbrb.cdr.authservice.CdrUserRole'
grails.plugin.springsecurity.authority.className = 'nci.bbrb.cdr.authservice.CdrRole'

//grails.plugin.springsecurity.userLookup.userDomainClassName = 'nci.bbrb.cdr.authservice.User'
//grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'nci.bbrb.cdr.authservice.UserRole'
//grails.plugin.springsecurity.authority.className = 'nci.bbrb.cdr.authservice.Role'



grails.plugin.springsecurity.fii.rejectPublicInvocations = false


grails.plugin.springsecurity.useSecurityEventListener = true
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/home'
// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate',
           'nci.bbrb.cdr.util.CDRSessionListener'
}




