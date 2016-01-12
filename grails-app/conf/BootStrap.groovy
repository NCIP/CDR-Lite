import nci.bbrb.cdr.staticmembers.*
import nci.bbrb.cdr.authservice.*
import nci.bbrb.cdr.util.AppSetting

class BootStrap {

    def init = { servletContext ->
        //set roles, admin user, organization DCC
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_ADMIN').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_DCC').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_PRC').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_LDS').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_DM').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_BSS').save(failOnError: false, flush: true)
        new nci.bbrb.cdr.authservice.CdrRole(authority: 'ROLE_SERVICE').save(failOnError: false, flush: true)
        
        def dccOrg = new Organization(code: "DCC", name: "Data Coordinating Center").save(failOnError: false, flush: true)
        

        new nci.bbrb.cdr.authservice.CdrUser(username: 'admin', enabled: true, password: 'admin',organization:Organization.findByCode('DCC'), orgCode:'DCC' ).save(failOnError: false, flush: true)
     
        
        CdrUserRole.create(nci.bbrb.cdr.authservice.CdrUser.findByUsername('admin'), nci.bbrb.cdr.authservice.CdrRole.findByAuthority('ROLE_ADMIN'), true)
        CdrUserRole.create(nci.bbrb.cdr.authservice.CdrUser.findByUsername('admin'), nci.bbrb.cdr.authservice.CdrRole.findByAuthority('ROLE_DCC'), true)

         
        //AppSetting
      
        new AppSetting(code: "HELP_EMAIL", name: "HELP_EMAIL", value: "pushpa.hariharan@nih.gov", bigValue: "").save(failOnError: false, flush: true)
        new AppSetting(code: "loginbulletin", name: "loginbulletin", value: "see big value", bigValue: "this is the login bulletin message").save(failOnError: false, flush: true)
        new AppSetting(code: "CDRLITE_USER_DENY_DISEASE", name: "Deny user access for Disease study. ", value: "see big value", bigValue: "testDUser").save(failOnError: false, flush: true)
        new AppSetting(code: "CDRLITE_ADMIN_DISTRO", name: "CDRLITE_ADMIN_DISTRO", value: "see big value", bigValue: "pushpa.hariharan@nih.gov").save(failOnError: false, flush: true)
        new AppSetting(code: "QUERY_RESPONSE_DCC_DM", name: "QUERY_RESPONSE_DCC_DM", value: "see big value", description: "Exclude responses from local DCC DM users in this list from being counted in the AR query tracker report", bigValue: "admin").save(failOnError: false, flush: true)
        new AppSetting(code: "NEW_QUERY_TRACKER_DISTRO", name: "NEW_QUERY_TRACKER_DISTRO", value: "see big value", bigValue: "david.tabor@nih.gov").save(failOnError: false, flush: true)
        new AppSetting(code: "APERIO_IMAGE_DISTRO", name: "APERIO_IMAGE_DISTRO", value: "see big value", bigValue: "qili@mail.nih.gov").save(failOnError: false, flush: true)
        new AppSetting(code: "APERIO_URL", name: "APERIO_URL", value: "https://microscopy.vai.org/ViewImage.php?ImageId=").save(failOnError: false, flush: true)
     
        new AppSetting(code: "TUMOR_STAGE_KIDNEY", name: "TUMOR_STAGE_KIDNEY", value: "see big value", bigValue: "Stage I,Stage II,Stage III,Stage IV,Not Available").save(failOnError: false, flush: true)
        new AppSetting(code: "TUMOR_STAGE_LUNG", name: "TUMOR_STAGE_LUNG", value: "see big value", bigValue: "Occult carcinoma,Stage 0,Stage IA,Stage IB,Stage IIA,Stage IIB,Stage IIIA,Stage IIIB,Stage IV,Not Available").save(failOnError: false, flush: true)
        new AppSetting(code: "TUMOR_STAGE_COLON", name: "TUMOR_STAGE_COLON", value: "see big value", bigValue: "Occult carcinoma,Stage 0,Stage I,Stage IIA,Stage IIB,Stage IIC,Stage IIIA,Stage IIIB,Stage IIIC,Stage IVA,Stage IVB,Not Available").save(failOnError: false, flush: true)
        new AppSetting(code: "TUMOR_STAGE_OVARY", name: "TUMOR_STAGE_OVARY", value: "see big value", bigValue: "Stage IA,Stage IA1,Stage IA2,Stage IB,Stage IB1,Stage IB2,Stage IC,Stage IIA,Stage IIA1,Stage IIA2, Stage IIB,Stage IIC,Stage IIIA,Stage IIIB,Stage IIIC,Stage IVA,Stage IVB,Not Available").save(failOnError: false, flush: true)
        new AppSetting(code: "TUMOR_STAGE_UTERUS", name: "TUMOR_STAGE_UTERUS", value: "see big value", bigValue: "Stage IA,Stage IA1,Stage IA2,Stage IB,Stage IB1,Stage IB2,Stage IC,Stage IIA,Stage IIA1,Stage IIA2, Stage IIB,Stage IIC,Stage IIIA,Stage IIIB,Stage IIIC,Stage IVA,Stage IVB,Not Available").save(failOnError: false, flush: true)
        new AppSetting(code: "TUMOR_STAGE_AJCC_OVARY", name: "TUMOR_STAGE_OVARY", value: "see big value", bigValue: "Stage IA,Stage IA1,Stage IA2,Stage IB,Stage IB1,Stage IB2,Stage IC,Stage IIA,Stage IIA1,Stage IIA2,Stage IIB,Stage IIC,Stage IIIA,Stage IIIB,Stage IIIC,Stage IVA,Stage IVB,Not Available").save(failOnError: false, flush: true)
        //Collection Type
        new CaseCollectionType(code: 'POSTM', name:'Postmortem').save(failOnError: false, flush: true)
        new CaseCollectionType(code: 'OPO', name:'Organ Donor (OPO)').save(failOnError: false, flush: true)
        new CaseCollectionType(code: 'SURGI', name:'Surgical').save(failOnError: false, flush: true)
        
        //Case Status
        new CaseStatus(code:'INIT', name:'Initialized', description: '').save(failOnError: false, flush: true)
        new CaseStatus(code:'COLL', name:'Collected', description: 'Tissue collection complete').save(failOnError: false, flush: true)
        new CaseStatus(code:'DATA', name:'Data Entry Underway', description: 'Data entry underway at BSS.').save(failOnError: false, flush: true)
        new CaseStatus(code:'DATACOMP', name:'Data Entry Complete', description: 'Data Entry Complete').save(failOnError: false, flush: true)
        new CaseStatus(code:'QA', name:'QA Review', description: 'Case under QA review.').save(failOnError: false, flush: true)
        new CaseStatus(code:'COMP', name:'Complete', description: 'Case is done processing.').save(failOnError: false, flush: true)
        new CaseStatus(code:'RELE', name:'Released', description: 'Case has been validated and released to data warehouse.').save(failOnError: false, flush: true)
        new CaseStatus(code:'REMED', name:'Remediation', description: 'Issues exist, case under remediation, data entry screens unlocked for BSS.').save(failOnError: false, flush: true)
        new CaseStatus(code:'INVA', name:'Invalidated', description: 'Case is Invalidated.').save(failOnError: false, flush: true)
        new CaseStatus(code:'WITHDR', name:'Case Recalled', description: 'Case is Invalidated.').save(failOnError: false, flush: true)
        new CaseStatus(code:'BSSQACOMP', name:'BSS QA Review Complete', description: 'QA review at BSS is complete. Case is locked from further data entry.').save(failOnError: false, flush: true)
        new CaseStatus(code:'WDCPROG', name:'Case Recall in Progress', description: 'Case Recall in Progress').save(failOnError: false, flush: true)

        //Tissue Type
        new TissueType(code:'KIDNEY', name:'Kidney' ).save(failOnError: false, flush: true)
        new TissueType(code:'COLON', name:'Colon' ).save(failOnError: false, flush: true)
        new TissueType(code:'LUNG', name:'Lung' ).save(failOnError: false, flush: true)
        new TissueType(code:'OVARY', name:'Ovary' ).save(failOnError: false, flush: true)
        new TissueType(code:'BLOOD', name:'Blood' ).save(failOnError: false, flush: true)

        //Container Type
        new ContainerType(code:'CASSETTE',  name:'Tissue Cassette' ).save(failOnError: false, flush: true)
        new ContainerType(code:'TRAY',      name:'Tray' ).save(failOnError: false, flush: true)
        new ContainerType(code:'CRYOSETTE', name:'Cryosette' ).save(failOnError: false, flush: true)
        new ContainerType(code:'MODULE',    name:'Module' ).save(failOnError: false, flush: true)
        new ContainerType(code:'BUCKET',    name:'Bucket' ).save(failOnError: false, flush: true)
        new ContainerType(code:'ENVELOPE',  name:'Envelope' ).save(failOnError: false, flush: true)

        new ContainerType(code:'SST',       name:'SST Vacutainer' ).save(failOnError: false, flush: true)
        new ContainerType(code:'LAVEDTA',   name:'Lavender EDTA' ).save(failOnError: false, flush: true)
        new ContainerType(code:'CRYOV',     name:'Cryovial' ).save(failOnError: false, flush: true)
        new ContainerType(code:'CONCENT',   name:'Concentric Tube' ).save(failOnError: false, flush: true)
        new ContainerType(code:'CONICT',    name:'Conical Tube' ).save(failOnError: false, flush: true)
        new ContainerType(code:'DNAPAX',    name:'PAXgene DNA Vacutainer').save(failOnError: false, flush: true)
        new ContainerType(code:'RNAPAX',    name:'PAXgene RNA Vacutainer').save(failOnError: false, flush: true)
        new ContainerType(code:'ACD',       name:'ACD Vacutainer' ).save(failOnError: false, flush: true)
        //Fixative
        new Fixative(code:"OCT",    name:"OCT Embedded").save(failOnError: false, flush: true)
        new Fixative(code:"FFPE",   name:"FFPE").save(failOnError: false, flush: true)
        new Fixative(code:"LN2VAP", name:"LN2 Vapor Phase").save(failOnError: false, flush: true)
        new Fixative(code:"XG",     name:"PAXgene").save(failOnError: false, flush: true)
        new Fixative(code:"RL",     name:"RNALater").save(failOnError: false, flush: true)
        new Fixative(code:"PA",     name:"Formalin").save(failOnError: false, flush: true)
        new Fixative(code:"FR",     name:"LN2").save(failOnError: false, flush: true)
        new Fixative(code:"CM",     name:"Culture Medium").save(failOnError: false, flush: true)
        new Fixative(code:"DICE",   name:"Dry Ice").save(failOnError: false, flush: true)
        new Fixative(code:"FROZEN", name:"Frozen").save(failOnError: false, flush: true)
        new Fixative(code:"FRESH",  name:"Fresh").save(failOnError: false, flush: true)
        new Fixative(code:"NONE",   name:"None").save(failOnError: false, flush: true)
//        new Fixative(code:"OTHER",  name:"Other - specify").save(failOnError: false, flush: true)
        def fix = Fixative.findByCode("OTHER")
        if (fix) {
            fix.delete()
        }
        

        // for Tissue Form -- Storage Temp (Tabor)
        new StorageTemp(code:"AMBIENT",  name:"Ambient").save(failOnError: false, flush: true)
        new StorageTemp(code:"4DEG",     name:"4 Degrees").save(failOnError: false, flush: true)
        new StorageTemp(code:"MINUS20",  name:"-20 Degrees").save(failOnError: false, flush: true)
        new StorageTemp(code:"MINUS80",  name:"-80 Degrees").save(failOnError: false, flush: true)
        new StorageTemp(code:"LN2VAP",   name:"-80 Degrees").save(failOnError: false, flush: true)
//        new StorageTemp(code:"OTHER",    name:"Other - specify").save(failOnError: false, flush: true)
        def st = StorageTemp.findByCode("OTHER")
        if (st) {
            st.delete()
        }
        //Activity Type
        new ActivityType(code:'CASECREATE', name:'New Case' ).save(failOnError: false, flush: true)
        new ActivityType(code:'CASEUPDATE', name:'Case Updated' ).save(failOnError: false, flush: true)
        new ActivityType(code:'STATUSCHG', name:'Case Status Change' ).save(failOnError: false, flush: true)
        new ActivityType(code:'FILEUPLOAD', name:'File Upload' ).save(failOnError: false, flush: true)
        new ActivityType(code:'QUERY', name:'New Query Tracker' ).save(failOnError: false, flush: true)
        new ActivityType(code:'PROCESSEVT', name:'Processing event' ).save(failOnError: false, flush: true)

        //Query Type
        new QueryType(code:'MISS',    name:'Missing Data' ).save(failOnError: false, flush: true)
        new QueryType(code:'DISCREP', name:'Discrepant Data' ).save(failOnError: false, flush: true)
        new QueryType(code:'VERIFY',  name:'Verify Data' ).save(failOnError: false, flush: true)
        new QueryType(code:'ACTION',  name:'Action' ).save(failOnError: false, flush: true)

        //Query Status
        new QueryStatus(code:'ACTIVE', name:'Active').save(failOnError: false, flush: true)
        new QueryStatus(code:'ADDRESSED', name:'Addressed').save(failOnError: false, flush: true)
        new QueryStatus(code:'RESOLVED', name:'Resolved').save(failOnError: false, flush: true)
        new QueryStatus(code:'CLOSED', name:'Closed').save(failOnError: false, flush: true)
        new QueryStatus(code:'OPEN', name:'Open').save(failOnError: false, flush: true)
        new QueryStatus(code:'PROGRESS', name:'In Progress').save(failOnError: false, flush: true)
        new QueryStatus(code:'INVALID', name:'Invalidated').save(failOnError: false, flush: true)
        new QueryStatus(code:'UNRESOLVED', name:'Unresolved').save(failOnError: false, flush: true)

        //file type
        new CaseAttachmentType(code:'MEMO', name:'MEMO', description:'MEMO' ).save(failOnError: false, flush: true)
        new CaseAttachmentType(code:'DCF', name:'DCF', description:'DCF' ).save(failOnError: false, flush: true)
        new CaseAttachmentType(code:'OTHER', name:'OTHER', description:'OTHER' ).save(failOnError: false, flush: true)
        
        //PRc acceptability
        new PrcAcceptability(code:'ACCP', name:'Acceptable' ).save(failOnError: false, flush: true)
        new PrcAcceptability(code:'UNACC', name:'Unacceptable' ).save(failOnError: false, flush: true)
        new PrcAcceptability(code:'QUAR', name:'Quarantine/Issues Pending' ).save(failOnError: false, flush: true)
        new PrcAcceptability(code:'INVAL', name:'Invalidated' ).save(failOnError: false, flush: true)
        
        //Tissue Category
         new TissueCategory(code:'Normal', name:'Normal' ).save(failOnError: false, flush: true)
         new TissueCategory(code:'DISEASED', name:'Diseased' ).save(failOnError: false, flush: true)
         new TissueCategory(code:'TUMOR', name:'Tumor' ).save(failOnError: false, flush: true)
        
         
         new BloodDrawType(code:'T1', name:'Pre-operative (Pre Anesthesia)').save(failOnError: false, flush: true)
         new BloodDrawType(code:'T2', name:'Post-operative').save(failOnError: false, flush: true)
       
        new BloodAliquotType(code:'T1', name:'Plasma').save(failOnError: false, flush: true)
        new BloodAliquotType(code:'T2', name:'Serum').save(failOnError: false, flush: true)
        new BloodAliquotType(code:'T3', name:'Whole Cell Pellet').save(failOnError: false, flush: true)
        new BloodAliquotType(code:'T4', name:'Unprocessed blood').save(failOnError: false, flush: true)
        
        new BloodDrawTech(code:'T1', name:'Anesthesiologist').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T2', name:'Consent or Research Analyst/Coordinator').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T3', name:'Nurse').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T4', name:'Nurse Anesthetist').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T5', name:'OR Technician').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T6', name:'Phlebotomist').save(failOnError: false, flush: true)
        new BloodDrawTech(code:'T7', name:'Unknown').save(failOnError: false, flush: true)
        
        
        new BloodTubeType(code:'T1', name:'DNA PAXgene').save(failOnError: false, flush: true)
        new BloodTubeType(code:'T2', name:'RNA PAXgene').save(failOnError: false, flush: true)
        new BloodTubeType(code:'T3', name:'SST').save(failOnError: false, flush: true)
        new BloodTubeType(code:'T4', name:'BD Vacutainer EDTA').save(failOnError: false, flush: true)
        new BloodTubeType(code:'T5', name:'BD Vacutainer 3.2% sodium citrate').save(failOnError: false, flush: true)
        new BloodTubeType(code:'T6', name:'HTI SCAT-II, sodium citrate with protease inhibitor').save(failOnError: false, flush: true)
        
        new BloodCollectionReason(code:'R1', name:'Plasma').save(failOnError: false, flush: true)
        new BloodCollectionReason(code:'R2', name:'Serum').save(failOnError: false, flush: true)
        new BloodCollectionReason(code:'R3', name:'DNA').save(failOnError: false, flush: true)
        new BloodCollectionReason(code:'R4', name:'RNA').save(failOnError: false, flush: true)
         
       
       
        
      
    }
    
    def destroy = {
    }
}