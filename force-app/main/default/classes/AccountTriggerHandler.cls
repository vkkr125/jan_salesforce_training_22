public class AccountTriggerHandler {
    public static void copyBillingToShipping(List<Account> newList,Map<Id,Account> oldMap){
        Boolean isBillingChanged, isShippingChanged;
        for(Account acc : newList){
            isBillingChanged = false;
            isShippingChanged = false;
            if(oldMap != NULL){
               isBillingChanged = (acc.BillingCity != oldMap.get(acc.Id).BillingCity
              					|| acc.BillingState != oldMap.get(acc.Id).BillingState
             				    || acc.BillingCountry != oldMap.get(acc.Id).BillingCountry
              					|| acc.BillingPostalCode != oldMap.get(acc.Id).BillingPostalCode
              					|| acc.BillingStreet != oldMap.get(acc.Id).BillingStreet);
                
               isShippingChanged = (acc.ShippingCity != oldMap.get(acc.Id).ShippingCity
              						 || acc.ShippingState != oldMap.get(acc.Id).ShippingState
              						 || acc.ShippingCountry != oldMap.get(acc.Id).ShippingCountry
             						 || acc.ShippingPostalCode != oldMap.get(acc.Id).ShippingPostalCode
              						 || acc.ShippingStreet != oldMap.get(acc.Id).ShippingStreet);
            }
            
            if(oldMap == NULL || acc.Copy_Billing_To_Shipping__c != oldMap.get(acc.Id).Copy_Billing_To_Shipping__c
                              || isBillingChanged
                              || isShippingChanged){
                if(acc.Copy_Billing_To_Shipping__c){
                    if(isShippingChanged){
                        acc.addError('You are not allowed to change shipping address');
                    }else{
                       	acc.ShippingCity = acc.BillingCity;
                    	acc.ShippingState = acc.BillingState;
                    	acc.ShippingCountry = acc.BillingCountry;
                    	acc.ShippingPostalCode = acc.BillingPostalCode;
                    	acc.ShippingStreet  = acc.BillingStreet; 
                    }
                    
                }
            }
        }
    }

    // both update, insert handling at the same time
    public static void populateFavouriteColorUpdateInsert(List<Account> newList,Map<Id,Account> oldMap){
        Set<Id> ownerIdSet = new Set<Id>();
                // try to avoid for loop inside for loop
                /* for(Account acc : newList){
        for(Account oldAcc : oldList){
        if(acc.Id == oldAcc.Id && acc.OwnerId != oldAcc.ownerId){
        ownerIdSet.add(acc.OwnerId);
        }
        }
        }*/
        
        for(Account acc : newList){
            if(oldMap == NULL || acc.OwnerId != oldMap.get(acc.Id).ownerId){
                ownerIdSet.add(acc.OwnerId);
            }
        }
        if(ownerIdSet.size() > 0){
            Map<Id,String> userIdToFavColor = new Map<Id,String>();
            for(User usr : [SELECT Id,Favorite_Color__c
                            FROM User
                            WHERE Id IN : ownerIdSet]){
                                userIdToFavColor.put(usr.Id, usr.Favorite_Color__c);
                            }
            for(Account acc : newList){
                if(oldMap == NULL || acc.OwnerId != oldMap.get(acc.Id).ownerId){
                    acc.Favorite_Color__c = userIdToFavColor.get(acc.OwnerId);
                }
            }
            System.debug('@@@@@@@@@@@');
        }
        
    }
        /*    public static void populateFavouriteColor(List<Account> newList){
    Set<Id> ownerIdSet = new Set<Id>();
    for(Account acc : newList)
    ownerIdSet.add(acc.OwnerId);
    Map<Id,String> userIdToFavColor = new Map<Id,String>();
    for(User usr : [SELECT Id,Favorite_Color__c
    FROM User
    WHERE Id IN : ownerIdSet]){
    userIdToFavColor.put(usr.Id, usr.Favorite_Color__c);
    }
    
    for(Account acc : newList){
    acc.Favorite_Color__c = userIdToFavColor.get(acc.OwnerId);
    }
    }
    */
    
    public static void populateSLAExpirationDate(List<Account> newList){
        for(Account acc : newList){
            acc.SLAExpirationDate__c = Date.today().addDays(180);
            acc.Active__c = 'Yes';
        }
    }
    public static void createDefaultOpportunity(List<Account> newList){
        List<Opportunity> opportunityList = new List<Opportunity>();
        Id prepaidRedordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
        for(Account acc : newList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + '- Default Opportunity';
            opp.CloseDate = Date.today().addDays(180);
            opp.StageName = 'Prospecting';
            opp.AccountId = acc.Id;
            opp.RecordTypeId = prepaidRedordTypeId;
            
            opportunityList.add(opp);
        }
        if(opportunityList.size() > 0){
            insert opportunityList;
        }
    }
    
    public static void populateSLAExpirationDateAfterInsert(List<Account> newList){
        List<Account> updateAccountList = new List<Account>();
        for(Account acc : newList){
            
            Account newAcc = new Account();
            newAcc.Id = acc.Id;
            newAcc.Name = acc.Name;
            newAcc.Active__c = 'Yes';
            newAcc.SLAExpirationDate__c = Date.today().addDays(180);
            updateAccountList.add(newAcc);
        }
        if(updateAccountList.size() > 0){
            StaticConstants.runAccountTrigger = false;
            update updateAccountList;
        }
    }
    
}