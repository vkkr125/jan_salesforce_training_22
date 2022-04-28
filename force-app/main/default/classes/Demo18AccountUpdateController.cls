public with sharing class Demo18AccountUpdateController {
    @AuraEnabled
    public static Account getAccountInfo(String accountId){
        return [SELECT Id, Name, Rating 
                FROM Account
                 WHERE Id =: accountId];

    }
    @AuraEnabled
    public static string updateAccontDetails(Account acc){
        try {
            update acc;
            return 'OK';
        } catch (Exception e) {
            return 'NOTOK';
        }
    }
}
