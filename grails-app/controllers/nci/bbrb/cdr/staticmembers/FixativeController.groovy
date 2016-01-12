package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FixativeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Fixative.list(params), model:[fixativeInstanceCount: Fixative.count()]
    }

    def show(Fixative fixativeInstance) {
        respond fixativeInstance
    }

    def create() {
        respond new Fixative(params)
    }

    @Transactional
    def save(Fixative fixativeInstance) {
        if (fixativeInstance == null) {
            notFound()
            return
        }

        if (fixativeInstance.hasErrors()) {
            respond fixativeInstance.errors, view:'create'
            return
        }

        fixativeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fixative.label', default: 'Fixative'), fixativeInstance.id])
                redirect fixativeInstance
            }
            '*' { respond fixativeInstance, [status: CREATED] }
        }
    }

    def edit(Fixative fixativeInstance) {
        respond fixativeInstance
    }

    @Transactional
    def update(Fixative fixativeInstance) {
        if (fixativeInstance == null) {
            notFound()
            return
        }

        if (fixativeInstance.hasErrors()) {
            respond fixativeInstance.errors, view:'edit'
            return
        }

        fixativeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Fixative.label', default: 'Fixative'), fixativeInstance.id])
                redirect fixativeInstance
            }
            '*'{ respond fixativeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Fixative fixativeInstance) {

        if (fixativeInstance == null) {
            notFound()
            return
        }

        fixativeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Fixative.label', default: 'Fixative'), fixativeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fixative.label', default: 'Fixative'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
