public class SetExample {
    public SetExample(){
        
    }
    public void test_example1(){
        // why we should not create Set of sObject
        
        Set<Account> accountSet = new set<Account>();
        Set<Id> accountIdSet = new Set<Id>();
        Account acc = new Account();
        acc.Name = 'test';
        insert acc;
        accountIdSet.add(acc.Id);
        
        accountSet.add(acc);
        System.debug('Set values are ' + accountSet);
        System.debug('Set size is ' + accountSet.size()); // 1
        
        Account tempAccount = new Account();
        tempAccount.Id = acc.Id;
        tempAccount.Name = 'Test';
        update tempAccount;
        
        System.debug('---####---' + accountSet.contains(tempAccount)); // false
        System.debug('---$$$$---' + accountIdSet.contains(tempAccount.Id)); // true
        accountSet.add(tempAccount);
        System.debug('---####----' + accountSet.contains(tempAccount)); // true
        
        System.debug('=====================================');
        System.debug('Set values are ' + accountSet);
        System.debug('Set size is ' + accountSet.size()); // 2
     
        // this will give error because it contain's duplicate id's
        /* List<Account> testList = new List<Account>();
        testList.addAll(accountSet);
        update testList;
		*/
        // that's why we should avoid to create Set of sObjects because single records is processed twice
        // and but in backend only one record is updated and set treat it as two different records
        
        // update accountSet; // error salesforce allow only List for CRUD operations
        // always remember , as best practive do not create set of sObjects
    }
    
    public void test_example2(){
        Account acc = new Account();
        List<Account> testList = new List<Account>();
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        testList.add(acc);
        
        System.debug('size of list is ' + testList.size());
        Set<Account> mySet = new Set<Account>();
        mySet.addAll(testList);
        System.debug('values is set ' + mySet);
    }
    
    public void test_example3(){
     /*   List<Account> testList = new List<Account>();
        Account acc1 = new Account();
        acc1.Name = 'test';
        insert acc1;
        
        testList.add(acc1);
        acc1.Active__c = 'Yes';
        update acc1;
        System.debug('$$$$ ' + testList.contains(acc1)); // true
        // everything is passed by referenc
        
        */
        
        List<Account> testList = new List<Account>();
        Account acc1 = new Account();
        acc1.Name = 'test';
        insert acc1;
        
        Id recordId = acc1.Id;
        testList.add(acc1);
        acc1 = new Account();
        acc1.Id = recordId;
        acc1.Active__c = 'Yes';
        
     //   update acc1;
        System.debug('$$$$$ ' + testList.contains(acc1)); // false
        if(testList.get(0).Id == acc1.Id){
            System.debug('both id are same');
        }
        //because values are passed here as reference, so after creating new instance and updating id is same but reference is 
        // different that why we here getting false
    }
    
}