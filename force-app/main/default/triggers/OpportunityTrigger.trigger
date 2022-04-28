trigger OpportunityTrigger on Opportunity (after insert) {
    
    for(Opportunity opp : Trigger.New){
        System.debug('>>>> 1' + opp.Name);
        System.debug('>>>> 2' + opp.AccountId);
        System.debug('>>>> test' + opp.StageName);
        System.debug('>>>> 3' + opp.Account.Id);
        System.debug('>>>> 4' + opp.Account.Name);
        System.debug('>>>> 5' + opp.recordTypeId);
        System.debug('>>>> 6' + opp.recordType.Name);
    }
}