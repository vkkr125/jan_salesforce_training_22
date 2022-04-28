@isTest
public class AccountTriggerHandlerTest {
		
    static testmethod void testCoppyBillingToShippingOnCreate(){
        Account acc = new Account();
        acc.Name = 'test';
        acc.Copy_Billing_to_Shipping__c = true;
        acc.BillingCity = 'Jaipur';
        acc.BillingCountry = 'India';
        acc.BillingPostalCode = '302004';
        acc.BillingStreet = 'JLN Marg';
        acc.BillingState = 'Rajasthan';
        insert acc;
        
        List<Account> accountList = [SELECT Id,ShippingCity,ShippingCountry,ShippingState,
                                     ShippingPostalCode,ShippingStreet
                                     FROM Account 
                                     WHERE Id =:acc.Id];
        
         System.assertEquals(acc.BillingCity, accountList.get(0).ShippingCity);
         System.assertEquals(acc.BillingCountry, accountList.get(0).ShippingCountry);
         System.assertEquals(acc.BillingState, accountList.get(0).ShippingState);
         System.assertEquals(acc.BillingPostalCode, accountList.get(0).ShippingPostalCode);
         System.assertEquals(acc.BillingStreet, accountList.get(0).ShippingStreet);
    } 
    
    static testmethod void testCoppyBillingToShippingOnUpdate(){
        Account acc = new Account();
        acc.Name = 'test';
        acc.Copy_Billing_to_Shipping__c = true;
        acc.BillingCity = 'Jaipur';
        acc.BillingCountry = 'India';
        acc.BillingPostalCode = '302004';
        acc.BillingStreet = 'JLN Marg';
        acc.BillingState = 'Rajasthan';
        insert acc;
        acc.BillingCity = 'Udaipur';
        update acc;
        List<Account> accountList = [SELECT Id,ShippingCity,ShippingCountry,ShippingState,
                                     ShippingPostalCode,ShippingStreet
                                     FROM Account 
                                     WHERE Id =:acc.Id];
         System.assertEquals('Udaipur', accountList.get(0).ShippingCity);
    } 
}