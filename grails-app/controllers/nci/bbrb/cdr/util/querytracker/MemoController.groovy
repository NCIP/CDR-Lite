package nci.bbrb.cdr.util.querytracker
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.util.querytracker.*



class MemoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def memoService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 25, 100)
       // params.sort="startDate"
       // params.order="desc"
         def total 
         def list
        if (session.org?.code == 'DCC') {
            total=Memo.count()
            list = Memo.list(params)
     
        }else{
             total = Memo.createCriteria().count {
                   bssList {
                   eq('code', session.org?.code)
                }
                isNotNull("dateSubmitted")
             }

              list = Memo.createCriteria()list(params) {
                   bssList {
                   eq('code', session.org?.code)
                }
                isNotNull("dateSubmitted")
             }
         
        }
         [memoInstanceList: list, memoInstanceTotal: total]
        
       // [memoInstanceList: Memo.list(params), memoInstanceTotal: Memo.count()]
    }

    def create = {
        def memoInstance = new Memo()
        memoInstance.properties = params
        return [memoInstance: memoInstance]
    }

    def save = {
        def memoInstance = new Memo(params)
        if (memoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'memo.label', default: 'Memo'), memoInstance.id])}"
            redirect(action: "edit", id: memoInstance.id)
        }
        else {
            render(view: "create", model: [memoInstance: memoInstance])
        }
    }

    def show = {
        def memoInstance = Memo.get(params.id)
        if (!memoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
            redirect(action: "list")
        }
        else {
            [memoInstance: memoInstance]
        }
    }

    def edit = {
        def memoInstance = Memo.get(params.id)
        if (!memoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
            redirect(action: "list")
        }
        else {
           
            def canSub=false
            if(memoInstance.version > 0){
                def result= checkError(memoInstance)
                  if(result){
                        result.each(){key,value->
                            memoInstance.errors.rejectValue(key, value)
                        }
                   }else{
                       canSub=true
                   }
            }
            return [memoInstance: memoInstance, canSub:canSub]
        }
    }

    def update = {
        
        def memoInstance = Memo.get(params.id)
        if (memoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (memoInstance.version > version) {
                    
                    memoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'memo.label', default: 'Memo')] as Object[], "Another user has updated this Memo while you were editing")
                    render(view: "edit", model: [memoInstance: memoInstance])
                    return
                }
            }
            memoInstance.properties = params
            
            def uploadedFile
            
            if(params.fileDeleted=='Yes'){
                uploadedFile = request.getFile("new_file2")
            }else{
                uploadedFile = request.getFile("new_file")
            }
            
           
            try{
            memoService.updateMemo(params, uploadedFile)
             flash.message = "${message(code: 'default.updated.message', args: [message(code: 'memo.label', default: 'Memo'), memoInstance.id])}"
            redirect(action: "edit", id: memoInstance.id)
            }catch(Exception e){
            flash.message="Failed: " + e.toString()  
             redirect(action: "edit", id: memoInstance.id)
            
         
            }
            /**if (!memoInstance.hasErrors() && memoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'memo.label', default: 'Memo'), memoInstance.id])}"
                redirect(action: "show", id: memoInstance.id)
            }
            else {
                render(view: "edit", model: [memoInstance: memoInstance])
            }**/
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
            redirect(action: "list")
        }
    }

    def cancel = {
         redirect(action: "edit", id: params.id)
    }
    
    
     static Map checkError(memoInstance){
         def result=[:]
         if(!memoInstance.file){
             result.put("file", "Please upload Memo file")
         }
        
        def len=0
        if(memoInstance.memoNumber){
            len +=memoInstance.memoNumber.length()
        }
        
        if(memoInstance.title){
           len += memoInstance.title.length()
        }
        
        if(len > 3999){
             result.put("title", "The length of concatenation of memo number and title can NOT be greater than 3999")
        }
        
        return result
     }
    
    
    
     def submit = {
         def memoInstance = Memo.get(params.id)
              
         def user =  session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
         
        def deleteList = memoService.submitMemo(params, user)
        if(deleteList){
          
           def str ="need delete case/memo mapping: "
           deleteList.each(){
               str+=" " + it.caseRecord.caseId + "/" + it.memo.memoNumber
           }
            flash.message= str
        }
        redirect(action: "show", id: memoInstance.id) 
       
            
      
    }
    
     def resume_editing = {
         def memoInstance = Memo.get(params.id)
              
         memoInstance.dateSubmitted = null
         memoInstance.submittedBy=null
         memoInstance.save(failOnError:true)
         redirect(action: "edit", id: memoInstance.id) 
       
            
      
    }
    
    def delete = {
        def memoInstance = Memo.get(params.id)
        if (memoInstance) {
            try {
                memoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'memo.label', default: 'Memo'), params.id])}"
            redirect(action: "list")
        }
    }
}
