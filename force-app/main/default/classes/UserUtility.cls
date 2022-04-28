public class UserUtility {
    
    @future
    public static void createChatterUser(String lastName, String alias,String email,String username){
        Profile profRecord = [SELECT Id FROM Profile
                              WHERE Name = 'Chatter Free User'];
        User userRecord = new User();
        userRecord.Alias = alias;
        userRecord.LastName = lastName;
        userRecord.Email = email;
        userRecord.Username = username;
        userRecord.EmailEncodingKey = 'UTF-8';
        userRecord.LanguageLocaleKey = 'en_US';
        userRecord.LocaleSidKey = 'en_US';
        userRecord.TimeZoneSidKey = 'America/Los_Angeles';
        userRecord.ProfileId = profRecord.Id;
        
        
        try{
            insert userRecord;
        }catch(DmlException ex){
            Error_Log_Number__c log = new Error_Log_Number__c();
            log.Trace__c = ex.getMessage();
            insert log;
        }
    }
}