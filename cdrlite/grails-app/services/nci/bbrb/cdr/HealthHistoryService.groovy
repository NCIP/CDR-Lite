package nci.bbrb.cdr
import nci.bbrb.cdr.datarecords.CandidateRecord
import nci.bbrb.cdr.forms.*

import java.text.SimpleDateFormat
import java.text.DateFormat
import grails.transaction.Transactional

@Transactional
class HealthHistoryService {


    def saveReport(healthHistoryInstance, params, request){
    
        try{
          
            // main history form
            if(params.historyOfCancer){
                healthHistoryInstance.historyOfCancer= params.historyOfCancer
             
            }
            if(params.source){
                healthHistoryInstance.source= params.source
            }
          
            healthHistoryInstance.save(failOnError:true)
           
            
            // cancer history form details
            if(params.historyOfCancer == 'No'){
                // delete cancer history if exists
                def cancerHistoryList=CancerHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candId))
                cancerHistoryList.each(){it->
                    it.delete()
                }
            }
            else{
            
                def cancerHistoryList=CancerHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candId))
                cancerHistoryList.each(){it->
                
              
                    if(params.get("editch_primaryTumorSite_"+it.id)){
                        
                        if(it.primaryTumorSite || params.get("editch_primaryTumorSite_"+it.id) ){
                            it.primaryTumorSite=params.get("editch_primaryTumorSite_"+it.id)
                           
                        }
                    
                    }   
                    if(params.get("editch_source_"+it.id)){
                      
                        if(it.source || params.get("editch_source_"+it.id)){
                            it.source=params.get("editch_source_"+it.id)
                           
                        }
                    
                    }   
                
                    if(params.get("editch_treatments_"+it.id)){
                       
                        if(it.treatments || params.get("editch_treatments_"+it.id)){
                            it.treatments=params.get("editch_treatments_"+it.id)
                            
                        }
                    
                    }   
                
                    if(params.get("editch_monthYearOfFirstDiagnosis_"+it.id)){
                    
                        it.monthYearOfFirstDiagnosis=Date.parse( "MM/dd/yyyy",params.get("editch_monthYearOfFirstDiagnosis_"+it.id)  )
                        
                    } 
                
                    if(params.get("editch_monthYearOfLastTreatment_"+it.id)){
                                             
                        it.monthYearOfLastTreatment=Date.parse( "MM/dd/yyyy",params.get("editch_monthYearOfLastTreatment_"+it.id)  )
                        
                    
                    }  
                    it.save(failOnError:true)
                }
            }
            
            // General Medical History changes details here
            
            def generamlMedicalHistoryList=GeneralMedicalHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candId))
            generamlMedicalHistoryList.each(){it->
                
              
                if(params.get("editgmh_diseaseName_"+it.id)){
                        
                    if(it.diseaseName || params.get("editgmh_diseaseName_"+it.id) ){
                        it.diseaseName=params.get("editgmh_diseaseName_"+it.id)
                           
                    }
                    
                }   
                if(params.get("editgmh_source_"+it.id)){
                      
                    if(it.source || params.get("editgmh_source_"+it.id)){
                        it.source=params.get("editgmh_source_"+it.id)
                           
                    }
                    
                }   
                
                if(params.get("editgmh_treatments_"+it.id)){
                       
                    if(it.treatments || params.get("editgmh_treatments_"+it.id)){
                        it.treatments=params.get("editgmh_treatments_"+it.id)
                            
                    }
                    
                }   
                
                if(params.get("editgmh_monthYearOfFirstDiagnosis_"+it.id)){
                    
                    it.monthYearOfFirstDiagnosis=Date.parse( "MM/dd/yyyy",params.get("editgmh_monthYearOfFirstDiagnosis_"+it.id)  )
                        
                } 
                
                if(params.get("editgmh_monthYearOfLastTreatment_"+it.id)){
                                             
                    it.monthYearOfLastTreatment=Date.parse( "MM/dd/yyyy",params.get("editgmh_monthYearOfLastTreatment_"+it.id)  )
                        
                    
                }  
                it.save(failOnError:true)
            }
                
            // Medication history changes details here
            
            def medicationList=MedicationHistory.findAllByCandidateRecord(CandidateRecord.findById(params.candId))
            medicationList.each(){it->
                
              
                if(params.get("editmed_medicationName_"+it.id)){
                        
                    if(it.medicationName || params.get("editmed_medicationName_"+it.id) ){
                        it.medicationName=params.get("editmed_medicationName_"+it.id)
                           
                    }
                    
                }   
                if(params.get("editmed_source_"+it.id)){
                      
                    if(it.source || params.get("editmed_source_"+it.id)){
                        it.source=params.get("editmed_source_"+it.id)
                           
                    }
                    
                }   
                
                    
                
                if(params.get("editmed_dateofLastAdministration_"+it.id)){
                    
                    it.dateofLastAdministration=Date.parse( "MM/dd/yyyy",params.get("editmed_dateofLastAdministration_"+it.id)  )
                        
                        
                } 
                
                    
                it.save(failOnError:true)
            }
                
            // end of form changes
             
             
        }catch(Exception e){
            e.printStackTrace()
           
            throw new RuntimeException(e.toString())
        }
    }
    
    def saveCancerHistory(cancerHistoryInstance,username){
       // println("in saveCancerHistory")
        if(cancerHistoryInstance){
            try{
                cancerHistoryInstance.submittedBy=username
                cancerHistoryInstance.dateSubmitted= new Date()
          
                cancerHistoryInstance.save(failOnError:true)
            }
            catch (Exception e) {
                e.printStackTrace()    
                throw new RuntimeException(e.toString())
            }
        }
    }
    
    
    
    def saveGeneralMedicalHistory(generalMedicalHistoryInstance,username){
        //println("in saveGeneralMedicalHistory")
        if(generalMedicalHistoryInstance){
            try{
                generalMedicalHistoryInstance.submittedBy=username
                generalMedicalHistoryInstance.dateSubmitted= new Date()
          
                generalMedicalHistoryInstance.save(failOnError:true)
            }
            catch (Exception e) {
                e.printStackTrace()    
                throw new RuntimeException(e.toString())
            }
        }
    }
    
    def saveMedicationHistory(medicationHistoryInstance,username){
       // println("in saveMedicationHistory")
        if(medicationHistoryInstance){
            try{
                medicationHistoryInstance.submittedBy=username
                medicationHistoryInstance.dateSubmitted= new Date()
          
                medicationHistoryInstance.save(failOnError:true)
            }
            catch (Exception e) {
                e.printStackTrace()    
                throw new RuntimeException(e.toString())
            }
        }
    }
                     
    def submitReport(healthHistoryInstance, username) {   
         
       // println("in submit report")
        if(healthHistoryInstance)
        
        try {
            healthHistoryInstance.submittedBy=username
            healthHistoryInstance.dateSubmitted= new Date()
          
            healthHistoryInstance.save(failOnError:true)
            
            
            //activityEventService.createEvent(activityType, caseId, study, bssCode, null, username, null, null)
        } catch (Exception e) {
            e.printStackTrace()    
            throw new RuntimeException(e.toString())
        }
    }
}
