package nci.bbrb.cdr

import grails.transaction.Transactional
import nci.bbrb.cdr.datarecords.*
import nci.bbrb.cdr.staticmembers.*

@Transactional
class ProcessingService {

   def activityEventService
    
     def saveProcessingEvent(rawHttpRequestBody)  {

        def errors
        def payload = new XmlSlurper().parseText(rawHttpRequestBody)
        //create new Processing event
        def processEvent = new ProcessingEvent(
            eventId: payload.'@id'.text(),
            eventType: payload.eventType.text(),
            processName: payload.processingSteps.processName.text()
        )

       if ("PROCESSINGEVENT".equals(payload.name().toUpperCase())) {
        if(processEvent.validate()) {
            def contents = payload.manifest.contents
            def comments = ""

            if("SLIDES".equals(payload.eventType.text().toUpperCase()) || "SLIDE".equals(payload.eventType.text().toUpperCase())) {
                def slideRecord
                contents.specimens.specimen.each {
                    def specimenId =  it.'@id'.text()                 
                   
                   
                    def   specimenRecord = SpecimenRecord.findBySpecimenId(specimenId)
                        it.derivatives.specimen.each {
                        slideRecord = addSlide(it.'@id'.text(), specimenId, payload.site.text().toUpperCase(),
                        comments, payload.site.text().toUpperCase(), rawHttpRequestBody)
                        slideRecord.addToProcessEvents(processEvent).save(flush:true)
                        processEvent.addToSlides(slideRecord).save(flush:true)
                        slideRecord.specimenRecord.addToProcessEvents(processEvent).save(flush:true)
                        }
                        processEvent.addToSpecimens(specimenRecord).save(flush:true)
                    }
                    processEvent.save(flush:true)
                } else if("IMAGES".equals(payload.eventType.text().toUpperCase()) || "IMAGE".equals(payload.eventType.text().toUpperCase())) {
                   def caseId
                   def additionalInfo2
                    contents.specimens.specimen.each {
                        def slideRecord = SlideRecord.findBySlideId(it.'@id'.text())
                       
                        if(slideRecord) {
                             caseId = slideRecord?.specimenRecord?.caseRecord?.caseId
                            def fixative = slideRecord?.specimenRecord?.fixative
                            additionalInfo2 = payload.processingSteps?.processName?.text() + "," + fixative
                            if (it.derivatives.specimen.size() > 1) {
                                log.error("imageRecord POST failed")
                                throwRuntimeError("Service error: Attempting to add more than one image to a slide.", rawHttpRequestBody)
                            }
                            attachImage(it.derivatives.specimen.getAt(0).'@id'?.text(), slideRecord, comments, rawHttpRequestBody)
                            slideRecord.specimenRecord.addToProcessEvents(processEvent).save(flush:true)                            
                            processEvent.addToSlides(slideRecord).save(flush:true)
                            processEvent.addToSpecimens(slideRecord.specimenRecord).save(flush:true)
                        } else {
                            log.error("slideRecord POST failed")
                            throwRuntimeError("Service error: Attempting to add images to slide(s) that do not exist in CDR yet.", rawHttpRequestBody)
                        }
                    }
                    processEvent.save(flush:true)
                     def study = Study.findByCode(payload.studyCode?.text()?.toUpperCase())
                def bssCode = ""
                def restEventId = payload.'@id'?.text()
                def initiator = payload.performedBy?.text()
                def sender = payload.performedBy?.text()
                def recipient = payload.performedBy?.text()
                def eventType = payload.eventType?.text()
                def eventDateTime = payload.eventDateTime?.text()
                def additionalInfo1 = eventType + "," + eventDateTime
                 activityEventService.createEvent(ActivityType.findByCode("PROCESSEVT"), caseId, study, bssCode, restEventId, initiator, additionalInfo1, additionalInfo2)
                
            } else {
                log.error("processEvent POST failed")
                throwRuntimeError(processEvent.errors, rawHttpRequestBody)
            } 
        } else {
                log.error("processEvent POST failed")
                throwRuntimeError("An event other than processing event was posted. Please post a processing event.", rawHttpRequestBody)
        }
       }
        return errors
    }

    
    def addSlide(slideId, specimenId, orgCode, comments, createdBy, xml) {
        def slideRecord
        if(slideId) {
            slideRecord = SlideRecord.findBySlideId(slideId)
            if(!slideRecord) {
                def specimenRecord = SpecimenRecord.findBySpecimenId(specimenId)
                if(specimenRecord) {
                    slideRecord = new SlideRecord(
                        specimenRecord: specimenRecord,
                        slideId: slideId,
                       // slideLocation: Organization.findByCode(orgCode),
                       // publicComments: comments,
                        caseId: specimenRecord.caseRecord.caseId,
                        createdBy: createdBy
                    )

                    if(slideRecord.validate()) {
                        slideRecord.save(flush:true)
                    } else {
                        log.error("slideRecord POST failed")
                        throwRuntimeError(slideRecord.errors, xml)
                    }
                } else {
                    log.error("slideRecord POST failed")
                    throwRuntimeError("Specimen [${specimenId}] does not exist.", xml)
                }
            } else {
                log.error("Slide [${slideId}] already exists.")
                throwRuntimeError("Slide [${slideId}] already exists.", xml)
            }
        } else {
            log.error("slideRecord POST failed")
            throwRuntimeError("No slide id provided.", xml)
        }

        return slideRecord
    }
    
    def attachImage(imageId, slideRecord, comments, xml) {
        if(imageId) {
            def imageRecord = ImageRecord.findBySlideRecord(slideRecord)
            if(!imageRecord) {
                //add image to parent slideRecord
                imageRecord = new ImageRecord(
                    slideRecord: slideRecord,
                    imageId: imageId,
                   // publicComments: comments
                )

                if(imageRecord.validate()) {
                    imageRecord.save(flush:true)
                } else {
                    log.error("imageRecord POST failed")
                    throwRuntimeError(imageRecord.errors, xml)
                }
            } else {
                log.error("imageRecord POST failed")
                throwRuntimeError("Image [${imageRecord?.imageId}] already exists for Slide [${slideRecord?.slideId}]", xml)
            }
        } else {
            log.info("No image provided for Slide [${slideRecord?.slideId}]")
        }
    }

    //[NOTE]: throw runtimeexeption is required to trigger rollback
    def throwRuntimeError(errors, xml, subject = "FAIL:") {
        log.error(errors)
       // sendMailService.sendServiceEventEmail(subject, errors.toString() +"\n\n"+ xml)

        throw new RuntimeException(
            "<?xml version='1.0'?><processingEvent><status>1</status><message>"
            + errors.toString()
            +"</message></processingEvent>"
        )
    }
    
}

