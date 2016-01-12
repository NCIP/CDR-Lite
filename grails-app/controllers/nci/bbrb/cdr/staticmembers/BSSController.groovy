package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BSSController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BSS.list(params), model:[BSSInstanceCount: BSS.count()]
    }

    def show(BSS BSSInstance) {
        respond BSSInstance
    }

    def create() {
        respond new BSS(params)
    }

    @Transactional
    def save(BSS BSSInstance) {
        if (BSSInstance == null) {
            notFound()
            return
        }

        if (BSSInstance.hasErrors()) {
            respond BSSInstance.errors, view:'create'
            return
        }

        BSSInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'BSS.label', default: 'BSS'), BSSInstance.id])
                redirect BSSInstance
            }
            '*' { respond BSSInstance, [status: CREATED] }
        }
    }

    def edit(BSS BSSInstance) {
        println "params: " + params
        respond BSSInstance
    }

    @Transactional
    def update(BSS BSSInstance) {
        if (BSSInstance == null) {
            notFound()
            return
        }

        if (BSSInstance.hasErrors()) {
            respond BSSInstance.errors, view:'edit'
            return
        }

        BSSInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BSS.label', default: 'BSS'), BSSInstance.id])
                redirect BSSInstance
            }
            '*'{ respond BSSInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BSS BSSInstance) {

        if (BSSInstance == null) {
            notFound()
            return
        }

        BSSInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BSS.label', default: 'BSS'), BSSInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'BSS.label', default: 'BSS'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
