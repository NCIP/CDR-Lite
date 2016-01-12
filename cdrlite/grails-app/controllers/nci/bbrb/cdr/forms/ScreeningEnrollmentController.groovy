package nci.bbrb.cdr.forms



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ScreeningEnrollmentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def accessPrivilegeService
    
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ScreeningEnrollment.list(params), model:[screeningEnrollmentInstanceCount: ScreeningEnrollment.count()]
    }
    
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
        [screeningEnrollmentInstanceList: ScreeningEnrollment.list(params), screeningEnrollmentInstanceTotal: ScreeningEnrollment.count()]
    }
    
    def show(ScreeningEnrollment screeningEnrollmentInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(screeningEnrollmentInstance.candidateRecord, session, 'show')){
           redirect(controller: "login", action: "denied")
            return
        }

        respond screeningEnrollmentInstance
    }

    def create() {
        def screeningEnrollment =new ScreeningEnrollment(params)
        respond screeningEnrollment
    }

    @Transactional
    def save(ScreeningEnrollment screeningEnrollmentInstance) {
        if (screeningEnrollmentInstance == null) {
            notFound()
            return new ScreeningEnrollment(params)
        }

        if (screeningEnrollmentInstance.hasErrors()) {
            respond screeningEnrollmentInstance.errors, view:'create'
            return
        }

        screeningEnrollmentInstance.save flush:true
        setIsEligibleInCandidateRecord(screeningEnrollmentInstance)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'screeningEnrollment.label', default: 'Screening Enrollment form for Candidate'), screeningEnrollmentInstance.candidateRecord.candidateId])
                //redirect(action:"index")
                redirect (action: 'edit', id: screeningEnrollmentInstance.id)
            }
            '*' { respond screeningEnrollmentInstance, [status: SAVED] }
        }
    }

    def edit() {
        def canSubmit = 'No'
        def screeningEnrollmentInstance = ScreeningEnrollment.get(params.id)
        if(!accessPrivilegeService.hasPrivilegeCandi(screeningEnrollmentInstance.candidateRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }

        def errorMap = checkError(screeningEnrollmentInstance)
        errorMap.each() {key, value ->
        screeningEnrollmentInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() == 0) {
            canSubmit = 'Yes'
        }
        render(view: "edit", model: [screeningEnrollmentInstance: screeningEnrollmentInstance, canSubmit: canSubmit])
    }
   
    @Transactional
    def update(ScreeningEnrollment screeningEnrollmentInstance) {
        
        if (screeningEnrollmentInstance == null) {
            notFound()
            return screeningEnrollmentInstance
        }
        if (screeningEnrollmentInstance.hasErrors()) {
            if ((!params.screeningDate)||(params.screeningDate.toLowerCase().indexOf('select') >= 0)) screeningEnrollmentInstance.screeningDate = null
            respond screeningEnrollmentInstance.errors, view:'edit'
            return
        }
        screeningEnrollmentInstance.save flush:true
        setIsEligibleInCandidateRecord(screeningEnrollmentInstance)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ScreeningEnrollment.label', default: 'ScreeningEnrollment'), screeningEnrollmentInstance.candidateRecord.candidateId])
                redirect (action: 'edit', id: screeningEnrollmentInstance.id)
            }
            '*'{ respond screeningEnrollmentInstance, [status: OK] }
        }
    }
    
    def submit = {
        def screeningEnrollmentInstance = ScreeningEnrollment.get(params.id)
        screeningEnrollmentInstance.dateSubmitted= new Date()
        screeningEnrollmentInstance.submittedBy=session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        def errorMap = checkError(screeningEnrollmentInstance)
        errorMap.each() {key, value ->
            screeningEnrollmentInstance.errors.rejectValue(key, value)
        }
        if (!screeningEnrollmentInstance.hasErrors() && screeningEnrollmentInstance.save(flush:true)) {
            setIsEligibleInCandidateRecord(screeningEnrollmentInstance)
            flash.message = message(code: 'default.submitted.message', args: [message(code: 'ScreeningEnrollment.label', default: 'ScreeningEnrollment'), screeningEnrollmentInstance.candidateRecord.candidateId])
            redirect(controller: "candidateRecord", action: "show", id: screeningEnrollmentInstance.candidateRecord.id)
        }
        else {
            screeningEnrollmentInstance.discard()
            respond screeningEnrollmentInstance.errors, view:'edit'
            return
        }
    }
    
    def resumeEditing = {
        def screeningEnrollmentInstance = ScreeningEnrollment.get(params.id)
        screeningEnrollmentInstance.dateSubmitted = null
        screeningEnrollmentInstance.submittedBy = null
        if (screeningEnrollmentInstance.save(flush: true)) {
            redirect(action: "edit", id: screeningEnrollmentInstance.id)
        }
        else {
            render(view: "show", model: [screeningEnrollmentInstance: screeningEnrollmentInstance])
        }
    }
    
    @Transactional
    def delete(ScreeningEnrollment screeningEnrollmentInstance) {
        if (screeningEnrollmentInstance == null) {
            notFound()
            return
        }
        screeningEnrollmentInstance.delete flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ScreeningEnrollment.label', default: 'ScreeningEnrollment'), screeningEnrollmentInstance.id])
                redirect action:"list"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'screeningEnrollment.label', default: 'ScreeningEnrollment'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    
    def setIsEligibleInCandidateRecord(screeningInstance) {
        if (screeningInstance.metCriteria == 'Yes') {
            screeningInstance.candidateRecord.isEligible = true
        } else {
            screeningInstance.candidateRecord.isEligible = false
        }    
    }
    
    Map checkError(screeningEnrollmentInstance) {
        def errorMap = [:]
        
        if (!screeningEnrollmentInstance.nameCreateCandidate) {
            errorMap.put('nameCreateCandidate', 'screening.person.blank')
        }
        if (screeningEnrollmentInstance.metCriteria != 'Yes' && screeningEnrollmentInstance.metCriteria != 'No') {
            errorMap.put('metCriteria', 'screening.option.blank')
        }
        if (!screeningEnrollmentInstance.screeningDate) {
            errorMap.put('screeningDate', 'screening.screeningDate.blank')
        }
        return errorMap
    }
}
