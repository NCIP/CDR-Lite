package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CaseCollectionTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=CaseCollectionType
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CaseCollectionType.list(params), model:[caseCollectionTypeInstanceCount: CaseCollectionType.count()]
    }

    def show(CaseCollectionType caseCollectionTypeInstance) {
        respond caseCollectionTypeInstance
    }

    def create() {
        respond new CaseCollectionType(params)
    }

    @Transactional
    def save(CaseCollectionType caseCollectionTypeInstance) {
        if (caseCollectionTypeInstance == null) {
            notFound()
            return
        }

        if (caseCollectionTypeInstance.hasErrors()) {
            respond caseCollectionTypeInstance.errors, view:'create'
            return
        }

        caseCollectionTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'caseCollectionType.label', default: 'CaseCollectionType'), caseCollectionTypeInstance.id])
                redirect caseCollectionTypeInstance
            }
            '*' { respond caseCollectionTypeInstance, [status: CREATED] }
        }
    }

    def edit(CaseCollectionType caseCollectionTypeInstance) {
        respond caseCollectionTypeInstance
    }

    @Transactional
    def update(CaseCollectionType caseCollectionTypeInstance) {
        if (caseCollectionTypeInstance == null) {
            notFound()
            return
        }

        if (caseCollectionTypeInstance.hasErrors()) {
            respond caseCollectionTypeInstance.errors, view:'edit'
            return
        }

        caseCollectionTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CaseCollectionType.label', default: 'CaseCollectionType'), caseCollectionTypeInstance.id])
                redirect caseCollectionTypeInstance
            }
            '*'{ respond caseCollectionTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CaseCollectionType caseCollectionTypeInstance) {

        if (caseCollectionTypeInstance == null) {
            notFound()
            return
        }

        caseCollectionTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CaseCollectionType.label', default: 'CaseCollectionType'), caseCollectionTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'caseCollectionType.label', default: 'CaseCollectionType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
