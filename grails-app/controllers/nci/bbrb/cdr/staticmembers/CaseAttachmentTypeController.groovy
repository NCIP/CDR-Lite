package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CaseAttachmentTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
 def scaffold = CaseAttachmentType
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CaseAttachmentType.list(params), model:[caseAttachmentTypeInstanceCount: CaseAttachmentType.count()]
    }

    def show(CaseAttachmentType caseAttachmentTypeInstance) {
        respond caseAttachmentTypeInstance
    }

    def create() {
        respond new CaseAttachmentType(params)
    }

    @Transactional
    def save(CaseAttachmentType caseAttachmentTypeInstance) {
        if (caseAttachmentTypeInstance == null) {
            notFound()
            return
        }

        if (caseAttachmentTypeInstance.hasErrors()) {
            respond caseAttachmentTypeInstance.errors, view:'create'
            return
        }

        caseAttachmentTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caseAttachmentType.label', default: 'CaseAttachmentType'), caseAttachmentTypeInstance.id])
                redirect caseAttachmentTypeInstance
            }
            '*' { respond caseAttachmentTypeInstance, [status: CREATED] }
        }
    }

    def edit(CaseAttachmentType caseAttachmentTypeInstance) {
        respond caseAttachmentTypeInstance
    }

    @Transactional
    def update(CaseAttachmentType caseAttachmentTypeInstance) {
        if (caseAttachmentTypeInstance == null) {
            notFound()
            return
        }

        if (caseAttachmentTypeInstance.hasErrors()) {
            respond caseAttachmentTypeInstance.errors, view:'edit'
            return
        }

        caseAttachmentTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CaseAttachmentType.label', default: 'CaseAttachmentType'), caseAttachmentTypeInstance.id])
                redirect caseAttachmentTypeInstance
            }
            '*'{ respond caseAttachmentTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CaseAttachmentType caseAttachmentTypeInstance) {

        if (caseAttachmentTypeInstance == null) {
            notFound()
            return
        }

        caseAttachmentTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CaseAttachmentType.label', default: 'CaseAttachmentType'), caseAttachmentTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caseAttachmentType.label', default: 'CaseAttachmentType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
