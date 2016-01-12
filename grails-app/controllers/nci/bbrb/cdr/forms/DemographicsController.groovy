package nci.bbrb.cdr.forms



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
class DemographicsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    def accessPrivilegeService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Demographics.list(params), model:[demographicsInstanceCount: Demographics.count()]
    }

    def show(Demographics demographicsInstance) {
        if(!accessPrivilegeService.hasPrivilegeCandi(demographicsInstance.candidateRecord, session, 'show')){
           redirect(controller: "login", action: "denied")
            return
        }
        respond demographicsInstance
    }

    def create() {
        def demographics = new Demographics(params)
        respond demographics
    }

    @Transactional
    def save(Demographics demographicsInstance) {
        if (demographicsInstance == null) {
            notFound()
            return
        }
        //println(" params while saving "+params)
        setRace(demographicsInstance)
        if(demographicsInstance.save(flush:true))
        {
            request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'demographics.label', default: 'Demographics form for candidate'), demographicsInstance.candidateRecord.candidateId])
                redirect(action: "edit", id: demographicsInstance.id)
            }
            '*' { respond demographicsInstance, [status: CREATED] }
        }
        }
        else
        {
             render(view: "create", model: [demographicsInstance: demographicsInstance])
        }
    }

    def edit(Demographics demographicsInstance) {
        def canSubmit = 'No'
        demographicsInstance=demographicsInstance.get(params.id)
        if(!accessPrivilegeService.hasPrivilegeCandi(demographicsInstance.candidateRecord, session, 'edit')){
            redirect(controller: "login", action: "denied")
            return
        }

        def errorMap= checkError(demographicsInstance)
        errorMap.each() {key, value ->
            demographicsInstance.errors.rejectValue(key, value)
        }
        if (errorMap.size() == 0) {
            canSubmit = 'Yes'
        }
        render(view: "edit", model: [demographicsInstance: demographicsInstance, canSubmit: canSubmit]) 
        // println(" in Edit .. ")
    }

    @Transactional
    def update(Demographics demographicsInstance) {
        if (demographicsInstance == null) {
            notFound()
            return
        }
        setRace(demographicsInstance)
        if (demographicsInstance.hasErrors()) {
            respond demographicsInstance.errors, view:'edit'
            return
        }
        
        demographicsInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Demographics.label', default: 'Demographics form for candidate '), demographicsInstance.candidateRecord.candidateId])
                redirect (action: 'edit', id: demographicsInstance.id)
            }
            '*'{ respond demographicsInstance, [status: OK] }
        }
    }
    def submit = {
        def demographicsInstance = Demographics.get(params.id)
        demographicsInstance.dateSubmitted= new Date()
        demographicsInstance.submittedBy=session.SPRING_SECURITY_CONTEXT?.authentication?.principal?.getUsername()
        def errorMap = checkError(demographicsInstance)
        errorMap.each() {key, value ->
            demographicsInstance.errors.rejectValue(key, value)
        }
        if (!demographicsInstance.hasErrors() && demographicsInstance.save(flush:true)) {
            flash.message = message(code: 'default.submitted.message', args: [message(code: 'Demographics.label', default: 'Demographics form for Candidate '), demographicsInstance.candidateRecord.candidateId])
            redirect(controller: "candidateRecord", action: "show", id: demographicsInstance.candidateRecord.id)
        }
        else {
            demographicsInstance.discard()
            respond demographicsInstance.errors, view:'edit'
            return
        }
    }
    
    def resumeEditing = {
        def demographicsInstance = Demographics.get(params.id)
        demographicsInstance.dateSubmitted = null
        demographicsInstance.submittedBy = null
        if (demographicsInstance.save(flush: true)) {
            redirect(action: "edit", id: demographicsInstance.id)
        }
        else {
            render(view: "show", model: [demographicsInstance: demographicsInstance])
        }
    }
    
    @Transactional
    def delete(Demographics demographicsInstance) {

        if (demographicsInstance == null) {
            notFound()
            return
        }

        demographicsInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Demographics.label', default: 'Demographics'), demographicsInstance.id])
                redirect action:"index"
				
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'demographics.label', default: 'Demographics'), params.id])
                redirect action:"index"
				
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    static  Map checkError(demographicsInstance){
        def result = [:]
        def gender = demographicsInstance.gender
        
        if(!gender){
            result.put('gender', 'demographics.gender.blank')
        }        
        
        def dateOfBirth =   demographicsInstance.dateOfBirth
        if(!dateOfBirth){
            result.put('dateOfBirth', 'demographics.dateOfBirth.blank')
        }
        
        if(gender && gender.toString() == "Other"){
            def otherGender = demographicsInstance.otherGender
            if(!otherGender){
                result.put('otherGender','demographics.otherGender.blank')
            }
        }
        def height = demographicsInstance.height
        if(height == 0){
            result.put('height','demographics.height.blank')
        }
       
        if(height < 0 ){
            result.put('height','demographics.height.notValid')
        }
         height=height+""
         if(height.contains(" ") || height.find(/[A-Z]/))
         {
               result.put('height','demographics.height.notValid')
         }
        
        def weight = demographicsInstance.weight
        if(weight == 0){
            result.put('weight','demographics.weight.blank')
        }
        
        if(weight < 0  ){
            result.put('weight','demographics.weight.notValid')
        }
        weight = weight +""
        if(weight.contains(" ") || weight.find(/[A-Z]/)){
                result.put('weight','demographics.weight.notValid')
        }
        /* def race =  demographicsInstance.race
        if(!race){
        result.add("The Race is a required field")
        }*/
        def raceWhite=demographicsInstance.raceWhite
        def raceAsian=demographicsInstance.raceAsian
        def raceBlackAmerican=demographicsInstance.raceBlackAmerican
        def raceIndian=demographicsInstance.raceIndian
        def raceHawaiian=demographicsInstance.raceHawaiian
        def raceUnknown=demographicsInstance.raceUnknown
        
        if(!raceWhite && !raceAsian && !raceBlackAmerican && !raceIndian && !raceHawaiian && !raceUnknown){
            result.put('race', 'demographics.race.blank')
        }
        
        def ethnicity = demographicsInstance.ethnicity
        if(!ethnicity){
            result.put('ethnicity', 'demographics.ethnicity.blank')
        }
        //println("result size:" + result.size())
        return result
    }
    
    def setRace(demographicsInstance)
    {
        boolean raceWhite=demographicsInstance.raceWhite
        boolean raceAsian=demographicsInstance.raceAsian
        boolean raceBlackAmerican=demographicsInstance.raceBlackAmerican
        boolean raceIndian=demographicsInstance.raceIndian
        boolean raceHawaiian=demographicsInstance.raceHawaiian
        boolean raceUnknown=demographicsInstance.raceUnknown
        /*println(" raceWhite = "+raceWhite)
        println(" raceAsian = "+raceAsian)
        println(" raceBlackAmerican = "+raceBlackAmerican)
        println(" raceIndian = "+raceIndian)
        println(" raceHawaiian = "+raceHawaiian)
        println(" raceUnknown = "+raceUnknown)
     */
        String race=''
        if(raceWhite){
            race = race+ ",White"
        }
        if(raceAsian){
            race = race+ ",Asian"
        }
        if(raceBlackAmerican){
            race= race+ ",Black or African American"
        }
        if(raceIndian){
            race= race +",American Indian or Alaska Native"
        }
        if(raceHawaiian){
            race= race +",Native Hawaiian or other Pacific Islander"
        }
        if(raceUnknown){
            race= race +",Unknown"
        }

        if(race && race.length() > 0){
            race=race.substring(1)
        }
        //pmh CDRQA:560 05/13/13
        //demographicsInstance.race=race
       // if(demographicsInstance.version > 0){
            demographicsInstance.race=race
        //}
        //println("  demographicsInstance.race ="+ demographicsInstance.race)
    }
}
