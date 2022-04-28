@isTest
public class ApexScenario1Test {
    
    // the data created in the test classes automatically got deleted when test function overed
    public static testmethod void testSolutionUsingMaps(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Contact';
        con.LastName = 'Demo10';
        con.AccountId = acc.Id;
        insert con;
        
        ApexScenario1 obj = new ApexScenario1();
        obj.solutionUsingMap();
        List<Account> accList = [SELECT Id,Active__c
                                 FROM Account
                                 WHERE Id =: acc.Id];
        
      /*  System.debug('First Line Id' + acc.Id);
        System.debug('Second Line Id ' + accList.get(0).Id);
        System.debug('First Line' + acc.Active__c); // null
        System.debug('Second Line' + accList.get(0).Active__c); // Yes */
        
        System.assertEquals('Yes', accList.get(0).Active__c);
    }
    
    public static testmethod void testSolutionUsingSet(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Contact';
        con.LastName = 'Demo10';
        con.AccountId = acc.Id;
        insert con;
        
        ApexScenario1 obj = new ApexScenario1();
        obj.solutionUsingSet();
        List<Account> accList = [SELECT Id,Active__c
                                 FROM Account
                                 WHERE Id =: acc.Id];
        System.assertEquals('No', accList.get(0).Active__c);
        
    }
}