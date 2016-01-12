package nci.bbrb.cdr.datarecords



import grails.test.mixin.*
import spock.lang.*

@TestFor(CaseRecordController)
@Mock(CaseRecord)
class CaseRecordControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.caseRecordInstanceList
            model.caseRecordInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.caseRecordInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def caseRecord = new CaseRecord()
            caseRecord.validate()
            controller.save(caseRecord)

        then:"The create view is rendered again with the correct model"
            model.caseRecordInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            caseRecord = new CaseRecord(params)

            controller.save(caseRecord)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/caseRecord/show/1'
            controller.flash.message != null
            CaseRecord.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def caseRecord = new CaseRecord(params)
            controller.show(caseRecord)

        then:"A model is populated containing the domain instance"
            model.caseRecordInstance == caseRecord
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def caseRecord = new CaseRecord(params)
            controller.edit(caseRecord)

        then:"A model is populated containing the domain instance"
            model.caseRecordInstance == caseRecord
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/caseRecord/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def caseRecord = new CaseRecord()
            caseRecord.validate()
            controller.update(caseRecord)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.caseRecordInstance == caseRecord

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            caseRecord = new CaseRecord(params).save(flush: true)
            controller.update(caseRecord)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/caseRecord/show/$caseRecord.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/caseRecord/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def caseRecord = new CaseRecord(params).save(flush: true)

        then:"It exists"
            CaseRecord.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(caseRecord)

        then:"The instance is deleted"
            CaseRecord.count() == 0
            response.redirectedUrl == '/caseRecord/index'
            flash.message != null
    }
}
