public class UserUtilityDemo {
    
    public void callFutureMethod(){
        Account acc = new Account();
        acc.Name = 'Future Pvt Ltd';
        acc.Type = 'Prospect';
        
        try{
            insert acc;
        }catch(DmlException ex){
            Error_Log_Number__c log = new Error_Log_Number__c();
            log.Trace__c = ex.getMessage();
            insert log;
        }
        
        //call future method ->gets executed in seprated threads(in seperate transactions)
        UserUtility.createChatterUser('kumar','kumar43','rakeshkr26941@gmail.com', 'rakeshkr26941@gmail.com.future_method_test');
        
    }
}