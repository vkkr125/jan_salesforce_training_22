public with sharing class Demo22WrapperDemoController {

    @AuraEnabled
    public static String saveSingleRecord(String jsonString){
        ContactWrapper wrapper = new ContactWrapper();
        wrapper = (ContactWrapper) JSON.deserialize(jsonString, ContactWrapper.class);
        upsert wrapper.contactObj;
        
        return wrapper.contactObj.Id;
    }
    @AuraEnabled
    public static string saveSingleOpportunity(String jsonString){
        OpportunityWrapper wrapper = new OpportunityWrapper();
        wrapper = (OpportunityWrapper) JSON.deserialize(jsonString, OpportunityWrapper.class);
        upsert wrapper.opportunityObj;
        // AccountName + OwnerEmail + Probability
        String res = '';
        List<Opportunity> oppData = [SELECT Id, Name, Account.Name, Owner.Email, Probability
                                    FROM Opportunity 
                                    WHERE Id =: wrapper.opportunityObj.Id];
                                    
        res = oppData.get(0).Id + '*' + oppData.get(0).Account.Name + '*' + oppData.get(0).Owner.Email + '*' + oppData.get(0).Probability;
        return res;
    }

    @AuraEnabled
    public static List<String> getPickListValuesIntoList(){
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
     return pickListValuesList;
    }

    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> accList = new List<Account>();
        accList = [SELECT Id,Name 
                   FROM Account];

        return accList;
    }
    @AuraEnabled
    public static string getAccountDetailWithRelatedData(String accountId){
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> opportunityList = new List<Opportunity>();

        accountList = [SELECT Id, Name, Industry
                       FROM Account
                       WHERE Id =: accountId];
        contactList = [SELECT FirstName, LastName, Phone, Email, AccountId
                       FROM Contact
                       WHERE AccountId =: accountId];
        opportunityList = [SELECT Id, Name, CloseDate, Account.Name, StageName, Amount, AccountId, Owner.Email, Probability
                           FROM Opportunity
                           WHERE AccountId =: accountId];
                          
        ResponceJSONWrapper wrapper = new ResponceJSONWrapper();
        List<ContactWrapper> tempContactWrapperList = new List<ContactWrapper>();
        List<OpportunityWrapper> tempOpportunityWrapperList = new List<OpportunityWrapper> ();
        for(Contact record : contactList){
            tempContactWrapperList.add(new ContactWrapper(record));
        }
        for(Opportunity opprecord : opportunityList){
            tempOpportunityWrapperList.add(new OpportunityWrapper(opprecord));
        }

        if(accountList.size() > 0){
            wrapper.Id = accountList.get(0).Id;
            wrapper.name = accountList.get(0).Name;
            wrapper.industry = accountList.get(0).Industry;
            // wrapper.wrapperContactList = contactList;
            wrapper.wrapperContactList = tempContactWrapperList;
            wrapper.wrapperOpportunityList = tempOpportunityWrapperList;
        }
        String responce = '';
        responce = JSON.serialize(wrapper);
        return responce;
        
    }

    @AuraEnabled
    public static void saveDataToDatabase(String jsonString){

        // System.debug(jsonString);
        ResponceJSONWrapper wrapper = new ResponceJSONWrapper();
        wrapper = (ResponceJSONWrapper)JSON.deserialize(jsonString, ResponceJSONWrapper.class);
        List<ContactWrapper> wrapperContactList = new List<ContactWrapper>();
        wrapperContactList = wrapper.wrapperContactList;
        List<Contact> conList = new List<Contact>();
        for(ContactWrapper record : wrapperContactList)
            conList.add(record.contactObj);

        if(conList.size() > 0)
            upsert conList;

        List<OpportunityWrapper> wrapperOpportunityList = new List<OpportunityWrapper>();
        wrapperOpportunityList = wrapper.wrapperOpportunityList;
        List<Opportunity> oppList = new List<Opportunity>();
        for(OpportunityWrapper record : wrapperOpportunityList)
            oppList.add(record.opportunityObj);
        
        if(oppList.size() > 0){
            upsert oppList;
        }
    }

    public class ResponceJSONWrapper{
        public Id id;
        public String name;
        public String industry;
        public List<ContactWrapper> wrapperContactList;
        public List<OpportunityWrapper> wrapperOpportunityList;
        
        public ResponceJSONWrapper(){
            wrapperContactList = new List<ContactWrapper>();
            wrapperOpportunityList = new List<OpportunityWrapper>();
        }
    }
    
    public class ContactWrapper{
        public Boolean isEditable;
        public Contact contactObj;
        public ContactWrapper(Contact con){
            isEditable = false;
            contactObj = con;
        }
        public ContactWrapper(){
            isEditable = false;
            contactObj = new Contact();
        }
    }

    public class OpportunityWrapper{
        public Boolean isEditable;
        public Opportunity opportunityObj;
        public OpportunityWrapper(){
            isEditable = false;
            opportunityObj = new Opportunity();
        }
        public OpportunityWrapper(Opportunity opp){
            isEditable = false;
            opportunityObj = opp;
        }
    }
}


