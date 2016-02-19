grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.fork = [
    // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
    //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

    // configure settings for the test-app JVM, uses the daemon by default
    test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
    // configure settings for the run-app JVM
    run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the run-war JVM
    war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
    // configure settings for the Console UI JVM
    console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        mavenLocal()
        grailsCentral()
        mavenCentral()
        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories

        mavenRepo "http://repository.codehaus.org"
        mavenRepo "http://download.java.net/maven/2/"
        mavenRepo "http://repository.jboss.com/maven2/"
        mavenRepo "http://repo.grails.org/grails/repo/"
        mavenRepo "http://repo.grails.org/grails/core"
        mavenRepo "http://repo.grails.org/grails/plugins"

    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        // runtime 'mysql:mysql-connector-java:5.1.29'
        // runtime 'mysql:mysql-connector-java:5.1.35'
        // runtime 'org.postgresql:postgresql:9.3-1101-jdbc41'
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
        runtime "postgresql:postgresql:9.1-901.jdbc4"
       

        test "org.grails:grails-datastore-test-support:1.0.2-grails-2.4"
//        compile ":audit-logging:1.0.5"
        
        //pmh 05/07/15: as per grails 2.4.4 release notes, this is required for auto timestamping to work
       // compile "javax.validation:validation-api:1.1.0.Final"
    //runtime "org.hibernate:hibernate-validator:5.0.3.Final"
        
    }

    plugins {
        // plugins for the build system only
        build ":tomcat:7.0.55"

        // plugins for the compile step
        compile ":scaffolding:2.1.2"
        compile ':cache:1.1.8'
        compile ":asset-pipeline:2.1.5"
        //added on 03/30/15 pmh
        compile ':spring-security-core:2.0-RC4'
        compile ":spring-security-acl:2.0-RC2"
        
        //pmh 05/27/15 added this for user and role interface (  USER/ROLE CRUD pages)
        compile ":spring-security-ui:1.0-RC2"
        //compile ":spring-security-role-generator:0.2"
        // Tabor 8/19/2015:
        compile ":audit-logging:1.0.5"
        // plugins needed at runtime but not for compilation
       // runtime ":hibernate4:4.3.6.1" // or ":hibernate:3.6.10.18"
        runtime ":hibernate:3.6.10.18"
        runtime ":database-migration:1.4.0"
        runtime ":jquery:1.11.1"
        
        runtime ":searchable:0.6.9"
         
//        compile ":app-info:1.1.1" 
//        compile ":app-info-hibernate:0.4.1"

//        compile ":grails-melody:1.57.0"
        
        // Uncomment these to enable additional asset-pipeline capabilities
        //compile ":sass-asset-pipeline:1.9.0"
        //compile ":less-asset-pipeline:1.10.0"
        //compile ":coffee-asset-pipeline:1.8.0"
        //compile ":handlebars-asset-pipeline:1.3.0.3"
        
        compile ':quartz:1.0.1'
       // compile ":google-visualization-1.0.2"
    }
}
