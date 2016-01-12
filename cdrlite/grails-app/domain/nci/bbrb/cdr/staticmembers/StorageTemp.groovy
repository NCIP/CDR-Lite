package nci.bbrb.cdr.staticmembers

class StorageTemp extends StaticMemberBaseClass{

    static constraints = {
    }
    
    
     def static searchable ={
         only= ['name', 'code']
        'name' name:'storageTempName'
        'code' name:'storageTempCode'
         root false
     }
    
     static mapping = {
      table 'st_storage_temp'
      id generator:'sequence', params:[sequence:'st_storage_temp_pk']
    }
}
