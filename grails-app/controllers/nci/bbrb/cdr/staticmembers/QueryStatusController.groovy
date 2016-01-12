package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QueryStatusController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=QueryStatus
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond QueryStatus.list(params), model:[queryStatusInstanceCount: QueryStatus.count()]
    }

    def show(QueryStatus queryStatusInstance) {
        respond queryStatusInstance
    }

    def create() {
        respond new QueryStatus(params)
    }

    @Transactional
    def save(QueryStatus queryStatusInstance) {
        if (queryStatusInstance == null) {
            notFound()
            return
        }

        if (queryStatusInstance.hasErrors()) {
            respond queryStatusInstance.errors, view:'create'
            return
        }

        queryStatusInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'queryStatus.label', default: 'QueryStatus'), queryStatusInstance.id])
                redirect queryStatusInstance
            }
            '*' { respond queryStatusInstance, [status: CREATED] }
        }
    }

    def edit(QueryStatus queryStatusInstance) {
        respond queryStatusInstance
    }

    @Transactional
    def update(QueryStatus queryStatusInstance) {
        if (queryStatusInstance == null) {
            notFound()
            return
        }

        if (queryStatusInstance.hasErrors()) {
            respond queryStatusInstance.errors, view:'edit'
            return
        }

        queryStatusInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QueryStatus.label', default: 'QueryStatus'), queryStatusInstance.id])
                redirect queryStatusInstance
            }
            '*'{ respond queryStatusInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(QueryStatus queryStatusInstance) {

        if (queryStatusInstance == null) {
            notFound()
            return
        }

        queryStatusInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QueryStatus.label', default: 'QueryStatus'), queryStatusInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'queryStatus.label', default: 'QueryStatus'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
