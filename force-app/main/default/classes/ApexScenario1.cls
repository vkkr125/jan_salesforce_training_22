public class ApexScenario1 {
   
    public void SolutionUsingSet(){
    /*    List<Account> accountUpdateList = new List<Account>();
        for(Contact con : [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE Name LIKE 'Contact Demo%'
                           AND AccountId != NULL]){
                               
                               // alternate way of updating the records
                               Account acc = new Account();
                               acc.Id = con.AccountId;
                               acc.Active__c = 'Yes';
                               accountUpdateList.add(acc);
                           }
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
            System.debug(accountUpdateList.size());
        }
        */
        
       // the above code will give error coz list contains duplicate accounts(based on id)
       // and DML operation can not be perforemed on duplicates id's 
        List<Account> accountUpdateList = new List<Account>();
        Set<Id> accountIdSet = new Set<Id>();
        
        for(Contact con : [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE Name like 'Contact Demo%'
                           AND AccountId != NULL]){
                               
                             
                               if(!accountIdSet.contains(con.AccountId)){  // check if accountIdSet contains AccountId or Not
                                   // if it do not contains it ,Add the Account to the list and also add Id to the set to avoide duplicates
                                   Account acc = new Account();
                                   acc.Id = con.AccountId;
                                   Acc.Active__c = 'No';
                                   accountUpdateList.add(acc);
                                   accountIdSet.add(con.AccountId);
                               }
                           }

        if(accountUpdateList.size() > 0){
            // NOTE : CRUD operations are only performed on LIST 
            update accountUpdateList;
        }
    }
    
     // above doing same using list and set // now the same can be solve using Map only
     public void solutionUsingMap(){
        // 
        Map<Id,Account> recordIdToRecordMap = new Map<Id,Account>();
        for(Contact con :  [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE Name like 'Contact Demo%'
                           AND AccountId != NULL]){
                                if(!recordIdToRecordMap.containsKey(con.AccountId)){
                                    Account acc = new Account();
                                    acc.Id = con.AccountId;
                                    acc.Active__c = 'Yes';
                                    recordIdToRecordMap.put(acc.Id,acc);
                               }
                            }
         
        if(recordIdToRecordMap.size() > 0){
            
            // we can update with below two ways 
           //  update recordIdToRecordMap.values();
            List<Account> updateRecordList = recordIdToRecordMap.values();
            update updateRecordList;
            for(Account acc : updateRecordList){
                System.debug('the update record id is : ' + acc.Id);
            }
        }
    }
}