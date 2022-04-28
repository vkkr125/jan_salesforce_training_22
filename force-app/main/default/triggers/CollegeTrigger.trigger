trigger CollegeTrigger on College__c (after delete) {
    
    Set<Id> collegeIdSet = new Set<Id>();
    for(College__c clg : Trigger.New){
        collegeIdSet.add(clg.Id);
    }
    List<Student__c> studList = new List<Student__c>();
    studList = [SELECT Id,Name
                FROM Student__c
                WHERE College__c IN : collegeIdSet];
    
    System.debug(' >>>>>> Student list size is ' + studList.size());
}