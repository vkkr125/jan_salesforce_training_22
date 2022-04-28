public class DatabaseOperations {
    // to delete the record id is always required
    public void deleteRecords(){
        List<Account> accountDeleteList = new List<Account>();
        accountDeleteList = [SELECT Id 
                              FROM Account
                              WHERE Name Like 'Test%'];
        if(accountDeleteList.size() > 0){
            delete accountDeleteList;
        }
    }
    // update the records, to update record id is always required field
    public void updateRecords(){
        List<Account> accountUpdateList = new List<Account>();
        for(Account acc : [SELECT Id,Name,AccountNumber,OwnerId,Active__c,
                           AnnualRevenue, Description,Industry,Phone,Rating
                           FROM Account
                           WHERE Active__c = 'Yes'
                           AND Industry != NULL
                           LIMIT 20
                           OFFSET 10]){
                              acc.Active__c = 'No';
                              accountUpdateList.add(acc);
                          }
        
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
            for(Account acc : accountUpdateList){
                acc = NULL;
                System.debug('::::' + acc.Id);
            }
        }
    }
    
    
    // read the record from the database
    // best practice will writing queries
    // all keywords should be in capital, should not keep in single line if query is longer
    public void readRecords(){
        List<Account> accountList = [SELECT Id,Name, AccountNumber,OwnerId,Active__c,
                                     AnnualRevenue,Description,Industry,Phone,Rating
                                     FROM Account
                                     WHERE Active__c = 'No'
                                     AND Industry != NULL
                                     ORDER BY NAME
                                     LIMIT 20];
        
        
        Integer count = 0;
        for(Account acc : accountLIst){
            count ++;
            System.debug('%%%%%%%%%%%%%%%% count' + count);
            System.debug('This Id is ' + acc.id + '>>>> Account Name is ' + acc.Name);
        }
       // for(Integer i = 0; i<accountList.size(); i++){
       //    System.debug('This is is ' + accountList.get(i).id + '>>>>Account Name is ' + accountList.get(i).Name);
       //}
       
        
       //Alernate way of writing the above code
       for(account acc : [SELECT Id,Name, AccountNumber,OwnerId,Active__c,
                                     AnnualRevenue,Description,Industry,Phone,Rating
                                     FROM Account
                                     WHERE Active__c = 'Yes'
                                     AND Industry != NULL
                                     ORDER BY NAME
                          			 LIMIT 20
                         			 OFFSET 10]){
                               System.debug('This Id is ' + acc.id + '>>>> Account Name is ' + acc.Name);
                          }
    }
    public void creatSingleRecord(){
        Account acc = new Account();
        acc.Name = 'Test Account 2';
        acc.Active__c = 'Yes';
        acc.Industry = 'Biotechnology';
        acc.Description = 'test description';
        Date myDate = Date.newInstance(2022, 2, 28);
        acc.SLAExpirationDate__c = myDate;
        acc.SLAExpirationDate__c.addDays(5);
        insert acc;
        System.debug('The inserted account id is' + acc.id);
    }
    
    public void createSingleObject1(Integer i){
        Account acc = new Account();
        acc.Name = 'Test Account ' + i;
        acc.Active__c = 'Yes';
        acc.Industry = 'Biotechnology';
        acc.Description = 'test description';
        Date myDate = Date.newInstance(2022,2,28);
        acc.SLAExpirationDate__c = myDate;
        insert acc;
        System.debug('The inserted account id is ' + acc.id);
    }
    
    public void run(){
        for(Integer i = 50; i<250; i++){
            this.createSingleObject1(i);
        }
    }
    // maximum number of DML operation can be up to 150
    // DML opertions are //insert, delete, upsert 
    // so below code will throw exception too many DML operations 151
    // 
    // best practice : NEVER write DML in loop even if the loop is running for 2 times
    // we can use collections(list,set,map) to solve this problem
    // to create multiple records or any DML operations we make use of DML collections
    // List : it contains the element of signle data type(premitive,sObject,collection)
    // , it allow duplicates elements, it is used mostely for CRUD operations
    
    public void createMultipleRecords(){
       /* for(Integer i = 1; i<=200; i++){
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Active__c = 'Yes';
            acc.Industry = 'Biotechnology';
            acc.Description = 'test description';
            Date myDate = Date.newInstance(2022, 2, 28);
            acc.SLAExpirationDate__c = myDate;
            acc.SLAExpirationDate__c.addDays(5);
            insert acc;
            System.debug('The inserted account id' + i + 'is ' + acc.id);
        }

		*/
        List<Account> accountList = new List<Account>();
        for(Integer i = 51; i < 56; i++){
            // total number of records on which DML can be performed in transaction can b
            // e 10000
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Active__c = 'Yes';
            acc.Industry = 'Biotechnology';
            acc.Description = 'test description';
            Date myDate = Date.newInstance(2022, 2, 28);
            acc.SLAExpirationDate__c = myDate;
           // acc.SLAExpirationDate__c.addDays(5);
            accountList.add(acc);
	        }
        if(accountList.size() > 0){
            insert accountList;
            
            
            // (partial success) -> if out of 800 if 10 records fail then 790 will be success and will not throw error
            // Database.insert(accountList,false);
            // when Database.Insert(list, false) used ?  in case of sharing rule
            // if a person has already acces and we are reducing or giving the access to some people that in that case 
            // all the people who do not have access will get access and those who have access will do nothing and remain same 
            // and it will not throw any error 
            // (explore : saveResultClass)
            
          /*Database.SaveResult [] srList = Database.insert(accountList,false);
            for(Database.SaveResult sr : srList){
                if(sr.isSuccess()){
                    System.debug('inserted record id is ' + sr.getId());
                }else{
                    System.debug('faield record id is is ' + sr.getId());
                }
            }*/
            
        }
        for(Account acc : accountList){
            System.debug('The Inserted Account Id is ' + acc.Id + '>>> Account Name is ' + acc.Name);
        }
    }
    
    
}