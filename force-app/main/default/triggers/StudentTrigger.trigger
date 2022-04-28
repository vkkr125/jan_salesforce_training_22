trigger StudentTrigger on Student__c (after insert,after update,after delete,after undelete) {
    
    // Test.isrunningTest()
    Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'Demo Profile'];
    if(p.Id == userInfo.getProfileId()){
         StudentTriggerHandaler.updateCountQueryFromStudent(Trigger.New,Trigger.oldMap);
    }
   
    
    
    
    // just for testing is hitting gorverner limit or not
   /* if(Trigger.isInsert){
        for(Integer i=0 ; i <60 ; i++){
            List<Account> accList = [SELECT Id, Name FROM Account]; 
        }   	
    }

    if(Trigger.isUpdate){
        for(Integer i=0 ; i <70 ; i++){
            List<Account> accList = [SELECT Id, Name FROM Account]; 
        }   	
    } */
    
    
    
}