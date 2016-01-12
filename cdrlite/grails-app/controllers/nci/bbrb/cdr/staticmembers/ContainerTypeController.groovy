package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ContainerTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ContainerType.list(params), model:[containerTypeInstanceCount: ContainerType.count()]
    }

    def show(ContainerType containerTypeInstance) {
        respond containerTypeInstance
    }

    def create() {
        respond new ContainerType(params)
    }

    @Transactional
    def save(ContainerType containerTypeInstance) {
        if (containerTypeInstance == null) {
            notFound()
            return
        }

        if (containerTypeInstance.hasErrors()) {
            respond containerTypeInstance.errors, view:'create'
            return
        }

        containerTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'containerType.label', default: 'ContainerType'), containerTypeInstance.id])
                redirect containerTypeInstance
            }
            '*' { respond containerTypeInstance, [status: CREATED] }
        }
    }

    def edit(ContainerType containerTypeInstance) {
        respond containerTypeInstance
    }

    @Transactional
    def update(ContainerType containerTypeInstance) {
        if (containerTypeInstance == null) {
            notFound()
            return
        }

        if (containerTypeInstance.hasErrors()) {
            respond containerTypeInstance.errors, view:'edit'
            return
        }

        containerTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'ContainerType.label', default: 'ContainerType'), containerTypeInstance.id])
                redirect containerTypeInstance
            }
            '*'{ respond containerTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(ContainerType containerTypeInstance) {

        if (containerTypeInstance == null) {
            notFound()
            return
        }

        containerTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'ContainerType.label', default: 'ContainerType'), containerTypeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'containerType.label', default: 'ContainerType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
