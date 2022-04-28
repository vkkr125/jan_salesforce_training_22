public with sharing class Demo12CallingApexController {
    
    @AuraEnabled
    public static List<Account> getAccounts(){
        try {
            return [SELECT Id, Name, Active__c 
                   FROM Account];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Contact> getContacts(Id accId){
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id, FirstName, LastName, Email
                   FROM Contact 
                   WHERE AccountId =:accId];

        // List<Contact> temp;
        // temp.size();  // dereference to null pointer error
        // System.assert(false);
        return conList;
    }
}
