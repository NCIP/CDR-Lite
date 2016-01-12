package nci.bbrb.cdr.forms



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ConsentVerificationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def accessPrivilegeService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ConsentVerification.list(params), model:[consentVerificationInstanceCount: ConsentVerification.count()]
    }

    def show(ConsentVerification consentVerificationInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(consentVerificationInstance.candidateRecord, session, 'show')){
           redirect(controller: "login", action: "denied")
            return
        }
        respond consentVerificationInstance
    }

    def create() {
        def consentVerification = new ConsentVerification(params)
        respond consentVerification
    }

    @Transactional
    def save(ConsentVerification consentVerificationInstance) {
        if (consentVerificationInstance == null) {
            notFound()
            return
        }

        if(consentVerificationInstance.save(flush:true))
        {
            setConsentOnCandidateRecord(consentVerificationInstance)
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'consentVerification.label', default: 'Consent Verification Form for Candidate '), consentVerificationInstance.candidateRecord.candidateId])
                    redirect(action: "edit", id: consentVerificationInstance.id) 
                }
            '*' { respond consentVerificationInstance, [status: CREATED] }
            }
        }
        else
        {
             render(view: "create", model: [consentVerificationInstance: consentVerificationInstance])
        }
    }

    def edit(ConsentVerification consentVerificationInstance) {
        def canSubmit = 'No'
        consentVerificationInstance=consentVerificationInstance.get(params.id)
        if(!accessPrivilegeService.hasPrivilegeCandi(consentVerificationInstance.candidateRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }

        def errorMap= checkError(consentVerificationInstance)
        errorMap.each() {key, value ->
            consentVerificationInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() == 0) {
            canSubmit = 'Yes'
        }
        render(view: "edit", model: [consentVerificationInstance: consentVerificationInstance, canSubmit: canSubmit]) 
       
    }

    @Transactional
    def update(ConsentVerification consentVerificationInstance) {
        if (consentVerificationInstance == null) {
            notFound()
            return
        }

        if (consentVerificationInstance.hasErrors()) {
            respond consentVerificationInstance.errors, view:'edit'
            return
        }

        consentVerificationInstance.save flush:true
        setConsentOnCandidateRecord(consentVerificationInstance)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ConsentVerification.label', default:'Consent Verification Form for Candidate '), consentVerificationInstance.candidateRecord.candidateId])
                redirect (action: 'edit', id: consentVerificationInstance.id) 
            }
            '*'{ respond consentVerificationInstance, [status: OK] }
        }
    }

    def submit = {
        def consentVerificationInstance = ConsentVerification.get(params.id)
        consentVerificationInstance.dateSubmitted= new Date()
        consentVerificationInstance.submittedBy=session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        def errorMap = checkError(consentVerificationInstance)
        errorMap.each() {key, value ->
            consentVerificationInstance.errors.rejectValue(key, value)
        }
        if (!consentVerificationInstance.hasErrors() && consentVerificationInstance.save(flush:true)) {
            setConsentOnCandidateRecord(consentVerificationInstance)
            flash.message = message(code: 'default.submitted.message', args: [message(code: 'ConsentVerification.label', default:'Consent Verification Form for Candidate '), consentVerificationInstance.candidateRecord.candidateId])
            redirect(controller: "candidateRecord", action: "show", id: consentVerificationInstance.candidateRecord.id)
        }
        else {
            consentVerificationInstance.discard()
            respond consentVerificationInstance.errors, view:'edit'
            return
        }
    }
    
    def resumeEditing = {
        def consentVerificationInstance = ConsentVerification.get(params.id)
        consentVerificationInstance.dateSubmitted = null
        consentVerificationInstance.submittedBy = null
        if (consentVerificationInstance.save(flush: true)) {
            redirect(action: "edit", id: consentVerificationInstance.id)
        }
        else {
            render(view: "show", model: [consentVerificationInstance: consentVerificationInstance])
        }
    }
    
    @Transactional
    def delete(ConsentVerification consentVerificationInstance) {

        if (consentVerificationInstance == null) {
            notFound()
            return
        }

        consentVerificationInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ConsentVerification.label', default: 'ConsentVerification'), consentVerificationInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'consentVerification.label', default: 'ConsentVerification'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    static  Map checkError(consentVerificationInstance){
        def result = [:]
        def siteProtocolNumber = consentVerificationInstance.protocolSiteNum
        if(!siteProtocolNumber){
            result.put('protocolSiteNum', 'consentVerification.protocolSiteNum.blank')
        }
        def consentor = consentVerificationInstance.consentor
        
        if(!consentor){
            result.put('consentor', 'consentVerification.consentor.blank')
        }        
        
        def consentorRelationship =   consentVerificationInstance.consentorRelationship
        if(!consentorRelationship){
            result.put('consentorRelationship', 'consentVerification.consentorRelationship.blank')
        }
        //println("   consentorRelationship.toString()  ="+ consentorRelationship.toString() )
        if(consentorRelationship && consentorRelationship.toString() == "Other, Specify."){
            def otherConsentorRelationship = consentVerificationInstance.otherConsentRelation
            if(!otherConsentorRelationship){
                result.put('consentorRelationship','consentVerification.otherConsentorRelation.blank')
            }
        }
        if (consentVerificationInstance.isEligible != 'Yes' && consentVerificationInstance.isEligible != 'No') {
            result.put('isEligible', 'consentVerification.isEligible.blank')
        }
        
        if (consentVerificationInstance.consentObtained != 'Yes' && consentVerificationInstance.consentObtained != 'No') {
            result.put('consentObtained', 'consentVerification.consentObtained.blank')
        } 
        
        if (consentVerificationInstance.consentObtained == 'Yes')
        {
            def dateConsented =   consentVerificationInstance.dateConsented
            if(!dateConsented){
                result.put('dateConsented', 'consentVerification.dateConsented.blank')
            }

            if (consentVerificationInstance.meetAge != 'Yes' && consentVerificationInstance.meetAge != 'No') {
                result.put('meetAge', 'consentVerification.meetAge.blank')
            }
            def dateWitnessed =   consentVerificationInstance.dateWitnessed
            if(!dateWitnessed){
                result.put('dateWitnessed', 'consentVerification.dateWitnessed.blank')
            }
            def dateVerified =   consentVerificationInstance.dateVerified
            if(!dateVerified){
                result.put('dateVerified', 'consentVerification.dateVerified.blank')
            }
        
        }
        def institutionICDVersion= consentVerificationInstance.institutionICDVersion
        if(!institutionICDVersion){
            result.put('institutionICDVersion', 'consentVerification.institutionICDVersion.blank')
        }
        
        def dateIRBApproved =   consentVerificationInstance.dateIRBApproved
        if(!dateIRBApproved){
            result.put('dateIRBApproved', 'consentVerification.dateIRBApproved.blank')
        }
        def dateIRBExpires =   consentVerificationInstance.dateIRBExpires
        if(!dateIRBExpires){
            result.put('dateIRBExpires', 'consentVerification.dateIRBExpires.blank')
        }
        
        return result
    }
    def setConsentOnCandidateRecord(consentobj){

        if(consentobj.consentObtained == 'Yes'){
            
            consentobj.candidateRecord.isConsented = true
        }
        else{
       
            consentobj.candidateRecord.isConsented = false
        }    
    }
}
