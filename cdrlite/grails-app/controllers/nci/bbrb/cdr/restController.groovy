package nci.bbrb.cdr
import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.datarecords.*

import grails.rest.RestfulController


class restController extends RestfulController {

   
    def processingService    

    def test={
         render(contentType:"text/xml"){
              mkp.xmlDeclaration()
                    processingEvent{
                        status('0')
                        message( ' processing event successfully saved.')
                    }
         }
    }
    def processingEventRestActions = {
        println("called??????")
        switch(request.method){
            case "POST":
            //Get raw HTTP request body.
            def rawHttpRequestBody = request.reader.text
            //Put body into XmlSlurper, assuming it's XML
            
            def payload = new XmlSlurper().parseText(rawHttpRequestBody)
            
            def errors //result from service.  Returns map of errors
            def typeFlag = payload.manifest.contents.'@type' //remember what content type was sent
            def contents = payload.manifest.contents
            def cbrApiEventType = ""
            
         
            if ("".equals(payload.eventType.text().toUpperCase())) {
                //log.error("processingEvent POST failed")
                    render(contentType:"text/xml"){
                    mkp.xmlDeclaration()
                    processingEvent{
                        status('-1')
                        message(typeFlag.text() + ' processing event failed. Event type is missing in the processing event.')
                    }
                }
                sendMailService.sendServiceEventEmail('FAIL:', rawHttpRequestBody)
                break
            }  else if (!("SLIDES".equals(payload.eventType.text().toUpperCase())) && !("IMAGES".equals(payload.eventType.text().toUpperCase())) 
                && !("SLIDE".equals(payload.eventType.text().toUpperCase())) && !("IMAGE".equals(payload.eventType.text().toUpperCase()))
                ) {
                    render(contentType:"text/xml"){
                    mkp.xmlDeclaration()
                    processingEvent{
                            status('-1')
                            message(typeFlag.text() + ' processing event failed. Unknown event type for a processing event.')
                        }
                    }
                    sendMailService.sendServiceEventEmail('FAIL:', rawHttpRequestBody)
                    break
                   }
            errors = processingService.saveProcessingEvent(rawHttpRequestBody)
            
            if(!errors){
                response.status = 201 // Created
         
                
                render(contentType:"text/xml"){
                    mkp.xmlDeclaration()
                    processingEvent{
                        status('0')
                        message(typeFlag.text() + ' processing event successfully saved.')
                    }
                }
            }  else {                
                response.status = 500 // Not Found
                sendMailService.sendServiceEventEmail('FAIL:', rawHttpRequestBody)
                log.error(errors.toString())                
                    render(contentType:"text/xml"){
                    mkp.xmlDeclaration()
                    processingEvent{
                        status('-1')
                        message(typeFlag.text() + " processing event failed. Please check the server's log files for specific information.")
                    }
                }
            }
           
            
    }    

    
    }

    

    
}