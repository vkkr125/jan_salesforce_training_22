@isTest
public class ApexCreateOpportunityReportTest {
    static testmethod void testOportunityReport(){
     /*   Id prepaidRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
         Opportunity opp =new Opportunity();
         opp.StageName = 'Prospecting';
         opp.CloseDate = Date.today().addDays(100);
         opp.Name = 'Test Default Opportunity';
         opp.Type = 'New Customer';
         opp.RecordTypeId = prepaidRecordTypeId;
         insert opp; - Execution cycle will run and run all triggers , WF , PB , FLOWS , etc - 35SOQL 
        Opportunity opp1 =new Opportunity();
         opp1.StageName = 'Prospecting';
         opp1.CloseDate = Date.today().addDays(100);
         opp1.Name = 'Test Default Opportunity';
         opp1.Type = 'New Customer';
         opp1.RecordTypeId = prepaidRecordTypeId;
         insert opp1;- Execution cycle will run and run all triggers , WF , PB , FLOWS , etc - 70 ( 35 * 2)SOQL 
        Opportunity opp2 =new Opportunity();
         opp2.StageName = 'Prospecting';
         opp2.CloseDate = Date.today().addDays(100);
         opp2.Name = 'Test Default Opportunity';
         opp2.Type = 'New Customer';
         opp2.RecordTypeId = prepaidRecordTypeId;
         insert opp2;Execution cycle will run and run all triggers , WF , PB , FLOWS , etc - 105 ( 35 * 3)SOQL - CODE breaks here
 		NEVER WRITE MULTIPLE INSERT STATEMENTS IN TEST CLASSES AS WELL WITHING A SINGLE METHOD
		*/
        
        Id prepaidRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i = 1; i<=30; i++){
            Opportunity opp = new Opportunity();
            opp.StageName = 'Closed Won';
            opp.Name = 'Test Default Opportunity ' + i;
            if(i <= 15){
                opp.Type = 'New Customer';
                opp.CloseDate = Date.today().addDays(0);
            }else{
                opp.Type = 'Existing Customer - Upgrade';
                opp.CloseDate = Date.today().addDays(30);
            }
            opp.RecordTypeId = prepaidRecordTypeId;
            opp.Amount = 1000;
            oppList.add(opp); 
        }
        
        if(oppList.size() > 0){
            insert oppList;
            List<Opportunity> oppRes = [SELECT Id,Amount,StageName,Type,CloseDate, OwnerId
                               			FROM Opportunity
                               			WHERE Type != NULL
                               			AND StageName = 'Closed Won'
                               			AND Amount > 0];
            System.debug(oppRes.size());
        }
        
        ApexCreateOpportunityReport obj = new ApexCreateOpportunityReport('Closed Won');
        System.debug('>>>> $$$$$' + obj.monthTypeToAmountMap);
        system.debug('>>>> $$$$$' + obj.monthTypeToCountMap);
        
        String key = 'Mar-2022-New Customer-' + UserInfo.getUserId();
        System.assert(obj.monthTypeToCountMap.containsKey(key));
        System.assertEquals(15000, obj.monthTypeToAmountMap.get(key));
        
        System.assertEquals(15, obj.monthTypeToCountMap.get(key));
        key = 'Apr-2022-Existing Customer - Upgrade-' + UserInfo.getUserId();
        System.assert(obj.monthTypeToAmountMap.containsKey(key));
        System.assertEquals(15000, obj.monthTypeToAmountMap.get(key));
        System.assertEquals(15, obj.monthTypeToCountMap.get(key));
        
    }
}