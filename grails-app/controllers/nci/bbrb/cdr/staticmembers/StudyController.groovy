package nci.bbrb.cdr.staticmembers


import nci.bbrb.cdr.datarecords.CandidateRecord
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StudyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Study.list(params), model:[studyInstanceCount: Study.count()]
    }

    def show(Study studyInstance) {
        respond studyInstance
    }

    def create() {
        respond new Study(params)
    }

    @Transactional
    def save(Study studyInstance) {
        if (studyInstance == null) {
            notFound()
            return
        }

        if (studyInstance.hasErrors()) {
            respond studyInstance.errors, view:'create'
            return
        }

        studyInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'study.label', default: 'Study'), studyInstance.id])
                redirect studyInstance
            }
            '*' { respond studyInstance, [status: CREATED] }
        }
    }

    def edit(Study studyInstance) {
        respond studyInstance
    }

    @Transactional
    def update(Study studyInstance) {
        
        def bssList=[]
        def tissueTypeList=[]
        params.each{key,value->
            if(key.startsWith('bss_') && value=='on'){
                def nameofbss= key.substring(4)
                bssList.add(BSS.findByName(nameofbss))
            }
            
            if(key.startsWith('tissuetype_') && value=='on'){
                def code= key.substring(11)
                tissueTypeList.add(TissueType.findByCode(code))
            }
            
        }
        
      
       
        if (studyInstance == null) {
            notFound()
            return
        }

        if (studyInstance.hasErrors()) {
            respond studyInstance.errors, view:'edit'
            return
        }
        
        def existingList =studyInstance.bssList
        def removeList=[]
        existingList.each(){
            if(!bssList.contains(it) && !CandidateRecord.findAllByBss(it, [max:1])){
                removeList.add(it)
            }
        }
        
        def addList=[]
        bssList.each(){
            if(!existingList.contains(it)){
                addList.add(it)
            }
        }
        
        removeList.each(){
            studyInstance.removeFromBssList(it)
        }
        
        addList.each(){
            studyInstance.addToBssList(it)
        }
        
        def existingListT =studyInstance.tissueTypeList
        def removeListT=[]
        existingListT.each(){
            if(!tissueTypeList.contains(it)){
                removeListT.add(it)
            }
        }
        
        def addListT=[]
        tissueTypeList.each(){
            if(!existingListT.contains(it)){
                addListT.add(it)
            }
        }
        
        removeListT.each(){
            studyInstance.removeFromTissueTypeList(it)
        }
        
        addListT.each(){
            studyInstance.addToTissueTypeList(it)
        }
        
        studyInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Study.label', default: 'Study'), studyInstance.id])
                redirect studyInstance
            }
            '*'{ respond studyInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Study studyInstance) {

        if (studyInstance == null) {
            notFound()
            return
        }

        studyInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Study.label', default: 'Study'), studyInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'study.label', default: 'Study'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
