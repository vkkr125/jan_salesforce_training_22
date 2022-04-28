public class ApexCreateOpportunityReport {
    
    public  Map<String,Decimal> monthTypeToAmountMap;
    public Map<String,Integer> monthTypeToCountMap;
    public ApexCreateOpportunityReport(String stage){
        List<String> monthList = new List<String> {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
        monthTypeToAmountMap = new Map<String,Decimal>();
        monthTypeToCountMap = new Map<String,Integer>();
        
        for(Opportunity opp : [SELECT Id,Amount,StageName,Type,CloseDate, OwnerId
                               FROM Opportunity
                               WHERE Type != NULL
                               AND StageName =:stage
                               AND Amount > 0]){
                                   Integer month = opp.CloseDate.month();
                                   Integer year = opp.CloseDate.year();
                                   //String key = monthList.get(month - 1) + '-' + year + '-' + opp.Type;
                                   String key = monthList.get(month - 1) + '-' + year + '-' + opp.Type + '-' + opp.ownerId;
                                   if(!monthTypeToAmountMap.containsKey(key)){
                                       monthTypeToAmountMap.put(key,0);
                                       monthTypeToCountMap.put(key,0);
                                   }
                                   // monthTypeToAmountMap.get(key) += opp.Amount; // with premitive data type references does not work
                                   Decimal tempAmount = monthTypeToAmountMap.get(key);
                                   tempAmount += opp.Amount;
                                   monthTypeToAmountMap.put(key,tempAmount);
                                   
                                   // monthTypeToCountMap.get(key) += 1; // with premitive data type references does not work
                                   Integer tempCount = monthTypeToCountMap.get(key);
                                   tempCount += 1;
                                   monthTypeToCountMap.put(key,tempCount);
                                   
                                   
                               }   
        for(String key : monthtypeToAmountMap.keySet()){
            System.debug(key+'%%%%%'+monthtypeToAmountMap.get(key)+'### Total Count : '+monthtypeToCountMap.get(key));
            
        }
        
    }
    public void utility(){
        
        // code to find the picklist values
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = College__c.State__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            //pickListValuesList.add(pickListVal.getLabel());
            System.debug('>>>'+pickListVal.getLabel());
        }  
        
        // get record type
        Id recordTypeId = Schema.SObjectType.Student__c.getRecordTypeInfosByName().get('Graduation').getRecordTypeId();
        System.debug('REcord Type id is '+recordTypeId);

        
    }
}

// governorr limits:
// maximum DML : 150
// maximum SOQL : 100
// total record via all soql can be maximum 50,000[NEVER write a SOQL without WHERE clause(using where clause we can reduce records)]
// maximum Limit for inner query record returns : 200
// with DML : maximum no of records which can be processed are : 10,000
// CPU time limit : 10,000 miliseconds (so, don't write infinite loops etc)
// 
// 
// any logs getting genereted in backend for any type of error
// we can check logs in developer console , sometimes logs get stripped out because of the size of the log getting generated 

// maximum time in debug log 24 hours