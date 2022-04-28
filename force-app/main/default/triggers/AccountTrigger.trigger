/*

trigger AccountTrigger on Account (after insert) {
    
    // in before insert we can make modification and will insert the data to the database and id will be generated 
    // and after that the data in Trigger.New became read only and we can't modify that using after insert 
     
    // insert -> BT ->        SAVE ->   AT ->      Commit 
    //         (Trigger.New          (Trigger.New
    //          is editable           became read only)
    //          directely)            (to update records in Trigger.New we need to fire explicit update statement)
    // to modify the data once the data save to the system we need to fire explict update statement
   
    // before insert
   //  for(Account acc : Trigger.New){
    //    acc.SLAExpirationDate__c = Date.today().addDays(180);
    //    acc.Active__c = 'Yes';
        
    //    System.debug(' >>> ' + acc.Id);
   // } 
    
    
    
    // after insert
    // fire explicit update once Trigger.New became read only in case of after insert
    
    List<Account> updateAccountList = new List<Account>();
    for(Account acc : Trigger.New){
       // acc.SLAExpirationDate__c = Date.today().addDays(180);
       // acc.Active__c = 'Yes';
       
       // just updating with above code will give the same error because the data of Trigger.New is read only if we will modify it will give us error
       // we have to make new instance and modify to that instance and update the record again the system
       
        Account newAcc = new Account();
        newAcc.Id = acc.Id;
        newAcc.Name = acc.Name;
        newAcc.Active__c = 'Yes';
        newAcc.SLAExpirationDate__c = Date.today().addDays(180);
        updateAccountList.add(newAcc);
    }
    if(updateAccountList.size() > 0){
        update updateAccountList;
    }
}*/

/*
trigger AccountTrigger on Account (after insert,after update) {
    
    
    
    // here we are doing after insert, after update
    // once the data will be save after insert and will be updated the (BT,save,AT) cycle will again execute and update
    // cycle will again execute again (BT,save,AT will again ececuted) this cycle will go 16 times and will through exceptin 
    // 
    // best practice : any time you need to update the reocrd which are present in the Trigger.New() -(user before trigger)
    // because No DML operation required
    // prevent recursive riggers if update is happening
    // 
    
    
    // if you need to use the reocrd Id in case of insert, we need to go always for after trigger
    
    List<Account> updateAccountList = new List<Account>();
    for(Account acc : Trigger.New){
        Account newAcc = new Account();
        newAcc.Id = acc.Id;
        newAcc.Name = acc.Name;
        newAcc.Active__c = 'Yes';
        newAcc.SLAExpirationDate__c = Date.today().addDays(180);
        updateAccountList.add(newAcc);
    }
    if(updateAccountList.size() > 0){
        update updateAccountList;
    }

}

*/

/*

// error- check (24 feb 2022)
trigger AccountTrigger on Account (after insert) {
    
    List<Account> updateAccountList = new List<Account>();
   // System.debug('testing account' + JSON.serialize(Trigger.New));
    
    for(Account acc : Trigger.New){

        Account newAcc = new Account();
        newAcc.Id = acc.Id;
        newAcc.Name = acc.Name;
        newAcc.Active__c = 'Yes';
        newAcc.SLAExpirationDate__c = Date.today().addDays(180);
        updateAccountList.add(newAcc);
    }
    if(updateAccountList.size() > 0){
        try{
            update updateAccountList;
            System.debug(updateAccountList);
        }catch(Exception e){
           System.debug(e.getMessage());
        }
        
    }
    
    // Scenario : Create Default opportunity record for each account getting created
    List<Opportunity> opportunityList = new List<Opportunity>();
    Id prepaidRedordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
    for(Account acc : updateAccountList){
        Opportunity opp = new Opportunity();
        opp.Name = acc.Name + '- Default Opportunity';
        
        System.debug(' >> sla exprition : ' + acc.SLAExpirationDate__c);
        System.debug('>>> active field : ' + acc.Active__c);
        System.debug('>>> Rating field : ' + acc.Rating);
        
       // opp.CloseDate = acc.SLAExpirationDate__c; // this is giving error (missing required field[closed Date])
        opp.CloseDate = Date.today().addDays(180); // working fine 
        opp.StageName = 'Prospecting';
        opp.AccountId = acc.Id;
        opp.RecordTypeId = prepaidRedordTypeId;
        
        opportunityList.add(opp);
      
    }
    if(opportunityList.size() > 0){
        insert opportunityList;
    } 
}
 */
// best practice:
// Trigger Name : ObjectNameTrigger (append Trigger at the end)
// we can crete multiple trigger on an object on an object but it is difficult to control the sequence of execution
// so as a best practice we just create one trigger per object & control the execution by calling the methods
// do not write entire trigger , rather create class like account trigger handler, student triger haldler etc
// 




trigger AccountTrigger on Account(before insert,after insert,before update,after update){
    // if(StaticConstants.tempAccountTrigger){  
    if(System.Label.runAccountTriggerLabel == 'Yes'){
         if(Trigger.isAfter){
            if(StaticConstants.runAccountTrigger){
                AccountTriggerHandler.populateSLAExpirationDateAfterInsert(Trigger.New);   
            }
        }
        if(Trigger.isBefore && Trigger.isInsert){
            AccountTriggerHandler.copyBillingToShipping(Trigger.New,Trigger.oldMap);
            AccountTriggerHandler.populateFavouriteColorUpdateInsert(Trigger.New,Trigger.OldMap);
            // AccountTriggerHandler.populateFavouriteColor(Trigger.New);
            // AccountTriggerHandler.populateSLAExpirationDate(Trigger.New);
        }
        if(Trigger.isBefore && Trigger.isUpdate){
            if(StaticConstants.runAccountTrigger){
                AccountTriggerHandler.copyBillingToShipping(Trigger.New,Trigger.oldMap);
                AccountTriggerHandler.populateFavouriteColorUpdateInsert(Trigger.New, Trigger.OldMap);   
            }
            //AccountTriggerHandler.populateFavouriteColor(Trigger.New,Trigger.OldMap);
        }
        
        if(Trigger.isAfter && Trigger.isInsert){
            AccountTriggerHandler.createDefaultOpportunity(Trigger.New);
        }
    }
}