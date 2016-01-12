package nci.bbrb.cdr.staticmembers



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StorageTempController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
def scaffold=StorageTemp
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond StorageTemp.list(params), model:[storageTempInstanceCount: StorageTemp.count()]
    }

    def show(StorageTemp storageTempInstance) {
        respond storageTempInstance
    }

    def create() {
        respond new StorageTemp(params)
    }

    @Transactional
    def save(StorageTemp storageTempInstance) {
        if (storageTempInstance == null) {
            notFound()
            return
        }

        if (storageTempInstance.hasErrors()) {
            respond storageTempInstance.errors, view:'create'
            return
        }

        storageTempInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'storageTemp.label', default: 'StorageTemp'), storageTempInstance.id])
                redirect storageTempInstance
            }
            '*' { respond storageTempInstance, [status: CREATED] }
        }
    }

    def edit(StorageTemp storageTempInstance) {
        respond storageTempInstance
    }

    @Transactional
    def update(StorageTemp storageTempInstance) {
        if (storageTempInstance == null) {
            notFound()
            return
        }

        if (storageTempInstance.hasErrors()) {
            respond storageTempInstance.errors, view:'edit'
            return
        }

        storageTempInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'StorageTemp.label', default: 'StorageTemp'), storageTempInstance.id])
                redirect storageTempInstance
            }
            '*'{ respond storageTempInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(StorageTemp storageTempInstance) {

        if (storageTempInstance == null) {
            notFound()
            return
        }

        storageTempInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'StorageTemp.label', default: 'StorageTemp'), storageTempInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'storageTemp.label', default: 'StorageTemp'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
