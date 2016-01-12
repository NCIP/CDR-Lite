package nci.bbrb.cdr

import nci.bbrb.cdr.forms.SlideSection
import nci.bbrb.cdr.datarecords.SpecimenRecord
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.SlideRecord


class SlideSectionService {

    static transactional = true

    def saveForm(params, request){
        try {
            def slideSectionInstance = SlideSection.get(params.id)
        } catch(Exception e){
               e.printStackTrace()
               throw new RuntimeException(e.toString())
        }
    }
    
  
      def submitForm(slideSectionInstance, username) {
        // println("start save???")
        try{
            def caseRecord = slideSectionInstance.caseRecord
            //def caseId = caseRecord.caseId
            def caseId=caseRecord.id.toString()
            slideSectionInstance.dateSubmitted = new Date()
            slideSectionInstance.submittedBy=username
            slideSectionInstance.save(failOnError:true)
//            if(caseRecord?.bpvWorkSheet?.dateSubmitted){
                //def qcSample = caseRecord?.bpvWorkSheet?.qcAndFrozenSample?.sampleQc?.sample
                def slides = SlideRecord.findAllByCaseId(caseId)
                slides.each{
//                    def qcSample=null
//                    if(it.module?.code=='MODULE1'){
//                        qcSample = caseRecord?.bpvWorkSheet?.module1Sheet?.sampleQc?.sample
//                    }else if (it.module?.code=='MODULE2'){
//                        qcSample = caseRecord?.bpvWorkSheet?.module2Sheet?.sampleQc?.sample
//                    }else if(it.module?.code=='MODULE3N'){
//                       qcSample = caseRecord?.bpvWorkSheet?.module3NSheet?.sampleQc?.sample 
//                    }else if(it.module?.code=='MODULE4N'){
//                        qcSample = caseRecord?.bpvWorkSheet?.module4NSheet?.sampleQc?.sample 
//                    }else if (it.module?.code=='MODULE5'){
//                        qcSample = caseRecord?.bpvWorkSheet?.module5Sheet?.sampleQc?.sample 
//                    }else{
//                        
//                    }
//                    it.specimenRecord = qcSample
                    it.save(failOnError:true)
                }
//            }
          
        }catch(Exception e){
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
    }
    
    def updateForm(params){
         def msg=""
         def slideList =[]
        try {
            def slideSectionInstance = SlideSection.get(params.id)
            slideSectionInstance.properties = params
            slideSectionInstance.save(failOnError:true)
            params.each(){key, value->
                if(key.startsWith("slideId_")){
                    def sid = key.substring(8)
                    def slideRecord = SlideRecord.findById(sid)
                   
                    if( !value){
                    msg+=", slide id can't be empty"    
                    
                    } else if((SlideRecord.findBySlideId(value) && value != slideRecord.slideId)|| slideList.contains(value)){
                       msg+=", duplicated slide id " + value 
                    }else{
                        slideList.add(value)
                        slideRecord.slideId=value
//                        if(!slideRecord.specimenRecord ){
//                            def mid = params.get("module_" + sid)
//                            slideRecord.module=Module.findById(mid)
//                        }
                        slideRecord.save(failOnError:true)
                    }
                }
            }
        } catch(Exception e){
            e.printStackTrace()
            throw new RuntimeException(e.toString())
        }
        
        return msg
    }
}
