global class BatchApexDemo implements Database.Batchable<sObject>, Database.Stateful {
    Integer recordCount = 0;
    // BatchableContext will contains the information of all batch jobs
    // like Id of batch Job
    // 
    // in start here return type could be Database.QueryLocator or Iterator
    // Database.QueryLocator allow use to get 50million records in single transactions // this has higher gorvner limits
    // In Iteraor it's normal gorvener limits get 50k records
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        // this will fetch up to 50M in single transactions
        String query = 'SELECT Type FROM Account WHERE Name like \'Demo%\'';
        return Database.getQueryLocator(query);
    }
    
    // execute methods will be called based on the number of records returned by start method / batch size
    // if above query returns 1000 records and batch size in 250 then execute mtehod will be called 4 times
    // every execute method will be consuming one seperate transaction
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        
        for(Account acc : accList){
            acc.Type = 'Other';
            recordCount ++;
        }
       
        // using standalone dml
        /*try{
            update accList;
        }catch(DmlException ex){
            Error_Log_Number__c log = new Error_Log_Number__c();
            log.Trace__c = ex.getMessage();
            insert log;
        }*/
        
        // using database method
        List<Database.SaveResult> srList = Database.update(accList,false);
        for(Database.SaveResult sr : srList){
            if(!sr.isSuccess()){
                String str = '';
                for(Database.Error err : sr.getErrors()){
                    str += err.getMessage() + '\n';
                }
                Error_Log_Number__c log = new Error_Log_Number__c();
                log.Trace__c = str;
                insert log;
            }
        }
    }
    // finish method will call after completion all the execute callings
    // main purpose of finsih methods to notify the use that the all the batches are finished by sending the email or any thing else
    global void finish(Database.BatchableContext bc){
        // email which will be covered in integration session
        Error_Log_Number__c log = new Error_Log_Number__c();
        log.Trace__c = '' + recordCount;
        insert log;
    }
}