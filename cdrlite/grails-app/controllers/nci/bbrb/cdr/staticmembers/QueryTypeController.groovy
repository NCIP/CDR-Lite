package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class QueryTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
def scaffold=QueryType
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond QueryType.list(params), model:[queryTypeInstanceCount: QueryType.count()]
    }

    def show(QueryType queryTypeInstance) {
        respond queryTypeInstance
    }

    def create() {
        respond new QueryType(params)
    }

    @Transactional
    def save(QueryType queryTypeInstance) {
        if (queryTypeInstance == null) {
            notFound()
            return
        }

        if (queryTypeInstance.hasErrors()) {
            respond queryTypeInstance.errors, view:'create'
            return
        }

        queryTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'queryType.label', default: 'QueryType'), queryTypeInstance.id])
                redirect queryTypeInstance
            }
            '*' { respond queryTypeInstance, [status: CREATED] }
        }
    }

    def edit(QueryType queryTypeInstance) {
        respond queryTypeInstance
    }

    @Transactional
    def update(QueryType queryTypeInstance) {
        if (queryTypeInstance == null) {
            notFound()
            return
        }

        if (queryTypeInstance.hasErrors()) {
            respond queryTypeInstance.errors, view:'edit'
            return
        }

        queryTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'QueryType.label', default: 'QueryType'), queryTypeInstance.id])
                redirect queryTypeInstance
            }
            '*'{ respond queryTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(QueryType queryTypeInstance) {

        if (queryTypeInstance == null) {
            notFound()
            return
        }

        queryTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'QueryType.label', default: 'QueryType'), queryTypeInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'queryType.label', default: 'QueryType'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
