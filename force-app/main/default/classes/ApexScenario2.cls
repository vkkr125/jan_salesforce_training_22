public class ApexScenario2 {
    
    public void createMapUsingParentwithMorethan200Child(){
        
     /*   for(Account acc : [SELECT Id,Name
                           FROM Account
                           WHERE CreatedDate = Yesterday]){
                               for(Contact con : [SELECT Id,Name
                                                  FROM Contact
                                                  WHERE AccountId =:acc.Id]){
                                                      
                                                  }
                           } WRONG CODE: NEVER WRITE SOQL IN LOOP */
        Map<Id,List<Contact>> accountIdToContactMap = new Map<Id,List<Contact>>();
        Set<id> accountIdSet = new Set<Id>();
        for(Account acc : [SELECT Id,Name
                           FROM Account]){
                               accountIdSet.add(acc.Id);
                               accountIdToContactMap.put(acc.Id, new List<Contact>());
                               // using this we will have all the contacts with 0 contacts as well 
                           }
        for(Contact con : [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE AccountId IN :accountIdSet]){
                              /* if(!accountIdToContactMap.containsKey(con.AccountId)){
                                   accountIdToContactMap.put(con.AccountId, new List<Contact>());
                               } */
                               accountIdToContactMap.get(con.AccountId).add(con);
                           }
        for(Id accountId : accountIdToContactMap.keySet()){
            List<Contact> tempContactList = accountIdToContactMap.get(accountId);
            String allContacts = '';
            if(tempContactList.size() > 0){
                for(Contact con : tempContactList){
                    allContacts += con.Name + ' ; ';
                }
                System.debug('For Account ' + accountId + ' Total Contacts are : ' + 
                            tempContactList.size() + ' Contact values are :' + allContacts);
            }else{
                System.debug('For the Account ' + accountId + 'Total Contacts are : 0');
            }
        }
    }
    
    public void createMapUsingChild(){
        
        // this approach will only give the accounts which have contact associated with it
        Map<Id,List<Contact>> accountIdToContactMap = new Map<Id,List<Contact>>();
        for(Contact con : [SELECT Id,Name,AccountId
                           FROM Contact]){
                               if(!accountIdToContactMap.containsKey(con.AccountId)){
                                   accountIdToContactMap.put(con.AccountId, new List<Contact>());
                               }
                              // List<Contact> tempContactList = accountIdToContactMap.get(con.AccountId);
                              // tempContactList.add(con);
                              
                               // no need to this below line because tempContacList is a reference of map list value and adding contact to this also updated into the map
                              // accountIdToContactMap.put(con.AccountId, tempContactList); xxx
                              
                               // using single line
                              accountIdToContactMap.get(con.AccountId).add(con);
                           }
        
         for(Id accountId : accountIdToContactMap.keySet()){
            List<Contact> tempContactList = accountIdToContactMap.get(accountId);
            String allContact = '';
            if(tempContactList.size() > 0){
                for(Contact con : tempContactList){
                    allContact += con.Name + ' ; ';
                }
                System.debug('For Account ' + accountId + ' Total Contacts are : ' + 
                            tempContactList.size() + ' Contact values are :' + allContact);
            }else{
                System.debug('For the Account ' + accountId + 'Total Contacts are : 0');
            }
        }
    }
    public void createMapUsingParent(){
        // if inner query returns more then 200 records it will throw error
        Map<Id,List<Contact>> accountIdToContactMap = new Map<Id,List<Contact>>();
        for(Account acc : [SELECT Id,Name,
                          (SELECT Id,Name ,Title FROM Contacts)
                           FROM Account]){
                              /* List<Contact> tempContactList = acc.Contacts;
                               accountIdToContactMap.put(acc.Id,tempContactList); */
                               
                               if(acc.Contacts.size() > 0){
                                   accountIdToContactMap.put(acc.Id,acc.Contacts);
                               }
                           }
        
        for(Id accountId : accountIdToContactMap.keySet()){
            List<Contact> tempContactList = accountIdToContactMap.get(accountId);
            String allContact = '';
            if(tempContactList.size() > 0){
                for(Contact con : tempContactList){
                    allContact += con.Name + ' ; ';
                }
                System.debug('For Account ' + accountId + ' Total Contacts are : ' + 
                            tempContactList.size() + ' Contact values are :' + allContact);
            }else{
                System.debug('For the Account ' + accountId + 'Total Contacts are : 0');
            }
        }
    }
}