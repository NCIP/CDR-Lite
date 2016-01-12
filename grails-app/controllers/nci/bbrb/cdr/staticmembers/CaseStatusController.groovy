package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CaseStatusController {

    def scaffold=CaseStatus
    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
 
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CaseStatus.list(params), model:[caseStatusInstanceCount: CaseStatus.count()]
    }

    def show(CaseStatus caseStatusInstance) {
        respond caseStatusInstance
    }

    def create() {
        respond new CaseStatus(params)
    }

    @Transactional
    def save(CaseStatus caseStatusInstance) {
        if (caseStatusInstance == null) {
            notFound()
            return
        }

        if (caseStatusInstance.hasErrors()) {
            respond caseStatusInstance.errors, view:'create'
            return
        }

        caseStatusInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caseStatus.label', default: 'CaseStatus'), caseStatusInstance.id])
                redirect caseStatusInstance
            }
            '*' { respond caseStatusInstance, [status: CREATED] }
        }
    }

    def edit(CaseStatus caseStatusInstance) {
        respond caseStatusInstance
    }

    @Transactional
    def update(CaseStatus caseStatusInstance) {
        if (caseStatusInstance == null) {
            notFound()
            return
        }

        if (caseStatusInstance.hasErrors()) {
            respond caseStatusInstance.errors, view:'edit'
            return
        }

        caseStatusInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CaseStatus.label', default: 'CaseStatus'), caseStatusInstance.id])
                redirect caseStatusInstance
            }
            '*'{ respond caseStatusInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CaseStatus caseStatusInstance) {

        if (caseStatusInstance == null) {
            notFound()
            return
        }

        caseStatusInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CaseStatus.label', default: 'CaseStatus'), caseStatusInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caseStatus.label', default: 'CaseStatus'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
