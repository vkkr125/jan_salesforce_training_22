public class ApexCopyBillingToShipping {
    public void copyBillingToShipping(Set<Id> accountIdSet){
        
        List<Account> accountUpdateList = new List<Account>();
        for(Account acc : [SELECT Id,Name,BillingStreet,BillingCity,
                           BillingState,BillingPostalCode,BillingCountry
                           FROM Account
                           WHERE Id IN :accountIdSet]){
                               acc.ShippingCity = acc.BillingCity;
                               acc.ShippingCountry = acc.BillingCountry;
                               acc.ShippingState = acc.BillingState;
                               acc.ShippingPostalCode = acc.BillingPostalCode;
                               acc.ShippingStreet = acc.BillingStreet;
                               
                               accountUpdateList.add(acc);
                           }
        
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
            for(Account acc : accountUpdateList){
                System.debug('Updated account Id is ' + acc.Id);
            }
        }
        
    }
    
}