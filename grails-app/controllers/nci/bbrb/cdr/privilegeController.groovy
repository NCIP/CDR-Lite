package nci.bbrb.cdr

import grails.plugin.springsecurity.annotation.Secured

class privilegeController {

    def index = { }
    
    @Secured(['ROLE_SUPER','ROLE_ADMIN','ROLE_DM'])
    def toggleDM() {

//        println "params: " + params
//        println "request.forwardURI - request.contextPath: " + (request.forwardURI - request.contextPath)
//        println "request.requestURI:  " + request.requestURI
//        println "request.forwardURI:  " + request.forwardURI
//        println "request.contextPath: " + request.contextPath
//        params.returnPage = ((request.requestURI - request.contextPath) - "/grails")
     //put flag into session indicating a Data Manager is logged in
        if(session.DM == true){
            session.setAttribute("DM", new Boolean (false))
            flash.message = "DM flag disabled."
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)        
        }
        else{
            session.setAttribute("DM", new Boolean (true))
            flash.message = "DM flag enabled. You now have data manager access!"
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)      
      }
    }
   
    @Secured(['ROLE_SUPER','ROLE_ADMIN','ROLE_DM'])
    def togglePRC() {
        
     //put flag into session indicating a Data Manager is logged in
        if(session.PRC == true){
            session.setAttribute("PRC", new Boolean (false))
            flash.message = "PRC flag disabled."
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)     
        }

        else{
            session.setAttribute("PRC", new Boolean (true))
            flash.message = "PRC flag enabled. You now have PRC access!"
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)     
      }
    }

    @Secured(['ROLE_SUPER','ROLE_ADMIN','ROLE_LDS','ROLE_DM'])
    def toggleLDS() {
        
     //put flag into session indicating a Data Manager is logged in
        if(session.LDS == true){
            session.setAttribute("LDS", new Boolean (false))
            flash.message = "LDS flag disabled."
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)       
        }

        else{
            session.setAttribute("LDS", new Boolean (true))
            flash.message = "LDS flag enabled.  You have full LDS access!"            
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)     
      }
    }    

     @Secured(['ROLE_SUPER','ROLE_ADMIN','ROLE_QM'])
    def toggleQM() {

     //put flag into session indicating a quality Manager is logged in
        if(session.QM == true){
            session.setAttribute("QM", new Boolean (false))
            flash.message = "QM flag disabled."
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)        
        }
        else{
            session.setAttribute("QM", new Boolean (true))
            flash.message = "QM flag enabled. You now have Quality manager access!"
            //redirects don't work when method called by remotefunction
            redirect(uri:params.returnPage)      
      }
    }
    
}
