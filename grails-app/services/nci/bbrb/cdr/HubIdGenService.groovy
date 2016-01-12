package nci.bbrb.cdr

import grails.transaction.Transactional

@Transactional



class HubIdGenService {

    def genCandidateId(code) {
            def uuid = genUUID()
        
        def crc32id = genCRC32(uuid) 
        
        def candidateId = code + '-' + crc32id + '-C'
        
        return candidateId
          //return 'abc' 
          
    }
    
    
     def genUUID() {

        def newUUID

        newUUID = java.util.UUID.randomUUID().toString()

        return newUUID

        //a uuid that CRC32s to 7 chars
        //return "a31e5559-2688-4f03-80dc-78260155e464"

    }

     def genCRC32(uuid){
        def newCRC32
        def str

        newCRC32 = new java.util.zip.CRC32()

        newCRC32.update(uuid.getBytes())
        
        str = Long.toHexString(newCRC32.getValue())

        if(str.size() == 7){ //CRC32 can generate checksums of 7 chars.  we always need 8.
            str = "0" + str //append a 0 to make CRC 8 if size is 7
        }

        return str.toUpperCase()

    }
    
    //FileUpload filename supplemental ID generation
    def genFilenameKey(){
        
        def uuid = genUUID()
        
        def crc32id = genCRC32(uuid) 
        
        def filenameKey = crc32id
        
        return filenameKey
        
    }    
}
