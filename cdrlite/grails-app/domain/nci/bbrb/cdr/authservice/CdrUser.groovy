package nci.bbrb.cdr.authservice

import nci.bbrb.cdr.staticmembers.Organization

class CdrUser {

    transient springSecurityService

    
    String email
    String fname
    String lname

    def org //Save for later: hidden from user admin screens, set during security filter based on authenticated role
    Date lastLoginDate //Save for later
    Date passwordChangeDate
    
    
    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    
    Organization organization
    String orgCode

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        fname blank:true, nullable:true
        lname blank:true, nullable:true
        org blank:true, nullable:true
        lastLoginDate blank:true, nullable:true
        passwordChangeDate blank:true, nullable:true
        email blank:true, nullable:true
        organization blank:true, nullable:true
        orgCode blank:true, nullable:true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<CdrRole> getAuthorities() {
        CdrUserRole.findAllByCdrUser(this).collect { it.cdrRole }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }
}
