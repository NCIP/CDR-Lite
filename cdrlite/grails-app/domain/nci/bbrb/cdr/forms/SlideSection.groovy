package nci.bbrb.cdr.forms

import nci.bbrb.cdr.CDRBaseClass
import nci.bbrb.cdr.datarecords.CaseRecord
import nci.bbrb.cdr.datarecords.SpecimenRecord
import nci.bbrb.cdr.datarecords.DataRecordBaseClass

class SlideSection extends CDRBaseClass {
    CaseRecord caseRecord
    String slideSectionTech
    String siteSOPSlideSection
    String microtome
    String microtomeOs
    String microtomeBladeType
    String microtomeBladeTypeOs
    String microtomeBladeAge
    String microtomeBladeAgeOs
    String facedBlockPrep
    String facedBlockPrepOs
    String sectionThickness
    String sectionThicknessOs
    String slideCharge
    String slideChargeOs
    String waterBathTemp
    String waterBathTempOs
    String microtomeDailyMaint
    String microtomeDailyMaintOs
    String waterbathMaint
    String waterbathMaintOs
    String FFPEComments
    Date   dateSubmitted
    String submittedBy
    
    static hasMany = [specimens:SpecimenRecord]
    
    static constraints = {
        slideSectionTech(blank:true,nullable:true)
        siteSOPSlideSection(blank:true,nullable:true)
        microtome(blank:true,nullable:true)
        microtomeOs(blank:true,nullable:true)
        microtomeBladeType(blank:true,nullable:true)
        microtomeBladeTypeOs(blank:true,nullable:true)
        microtomeBladeAge(blank:true,nullable:true)
        microtomeBladeAgeOs(blank:true,nullable:true)
        facedBlockPrep(blank:true,nullable:true)
        facedBlockPrepOs(blank:true,nullable:true)
        sectionThickness(blank:true,nullable:true)
        sectionThicknessOs(blank:true,nullable:true)
        slideCharge(blank:true,nullable:true)
        slideChargeOs(blank:true,nullable:true)
        waterBathTemp(blank:true,nullable:true)
        waterBathTempOs(blank:true,nullable:true)
        microtomeDailyMaint(blank:true,nullable:true)
        microtomeDailyMaintOs(blank:true,nullable:true,widget:'textarea',maxSize:4000)
        waterbathMaint(blank:true,nullable:true)
        waterbathMaintOs(blank:true,nullable:true,widget:'textarea',maxSize:4000)
        FFPEComments(blank:true,nullable:true,widget:'textarea',maxSize:4000)
        dateSubmitted(blank:true,nullable:true)
        submittedBy(blank:true,nullable:true)
    }

    static mapping = {
         table 'form_slide_section'
         id generator:'sequence', params:[sequence:'form_slide_section_pk']
    }
}