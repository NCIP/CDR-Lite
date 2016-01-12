package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TissueTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TissueType.list(params), model:[tissueTypeInstanceCount: TissueType.count()]
    }

    def show(TissueType tissueTypeInstance) {
        respond tissueTypeInstance
    }

    def create() {
        respond new TissueType(params)
    }

    @Transactional
    def save(TissueType tissueTypeInstance) {
        if (tissueTypeInstance == null) {
            notFound()
            return
        }

        if (tissueTypeInstance.hasErrors()) {
            respond tissueTypeInstance.errors, view:'create'
            return
        }

        tissueTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tissueType.label', default: 'TissueType'), tissueTypeInstance.id])
                redirect tissueTypeInstance
            }
            '*' { respond tissueTypeInstance, [status: CREATED] }
        }
    }

    def edit(TissueType tissueTypeInstance) {
        respond tissueTypeInstance
    }

    @Transactional
    def update(TissueType tissueTypeInstance) {
        if (tissueTypeInstance == null) {
            notFound()
            return
        }

        if (tissueTypeInstance.hasErrors()) {
            respond tissueTypeInstance.errors, view:'edit'
            return
        }

        tissueTypeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TissueType.label', default: 'TissueType'), tissueTypeInstance.id])
                redirect tissueTypeInstance
            }
            '*'{ respond tissueTypeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(TissueType tissueTypeInstance) {

        if (tissueTypeInstance == null) {
            notFound()
            return
        }

        tissueTypeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TissueType.label', default: 'TissueType'), tissueTypeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tissueType.label', default: 'TissueType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
