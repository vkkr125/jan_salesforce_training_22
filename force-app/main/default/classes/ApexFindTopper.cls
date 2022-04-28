public class ApexFindTopper{
    
    public ApexFindTopper(){
        
    }
    public ApexFindTopper(Set<Id> collegeIdSet){
        Map<Id,Set<Id>> collegeIdToStudentIdMap = new Map<Id,Set<Id>>();
        Map<Id,Decimal> studentIdToTotalMap = new Map<Id,Decimal>();
        Map<Id,String> collegeIdToName = new Map<Id,String>();
        Map<Id,String> studentIdToName = new Map<Id,String>();
        
        for(Marks__c marks : [SELECT Id,Score__c,Student__c,Student__r.Name,
                              Student__r.College__c,Student__r.College__r.Name
                              FROM Marks__c
                              WHERE Student__r.College__c IN :collegeIdSet
                              AND Score__c != NULL]){
                                  collegeIdToName.put(marks.Student__r.College__c,marks.Student__r.College__r.Name);
                                  studentIdToName.put(marks.Student__c,marks.Student__r.Name);
                                  if(!collegeIdToStudentIdMap.containsKey(marks.Student__r.College__c)){
                                      collegeIdToStudentIdMap.put(marks.Student__r.College__c,new Set<Id>());
                                  }
                                  collegeIdToStudentIdMap.get(marks.Student__r.College__c).add(marks.Student__c);
                                  // calculating studentIdToTotalMap data
                                  if(!studentIdToTotalMap.containsKey(marks.Student__c)){
                                      studentIdToTotalMap.put(marks.Student__c,0);
                                  }
                                  Decimal score = studentIdToTotalMap.get(marks.Student__c);
                                  score = score + marks.Score__c;
                                  studentIdToTotalMap.put(marks.Student__c,score);
                              }
        
         
        for(Id collegeID : collegeIdToStudentIdMap.keySet()){
            Set<Id> studentsIdSet = collegeIdToStudentIdMap.get(collegeID);
            Decimal maxMarks = 0;
            Id topperId = null;
            for(Id studentId :  studentsIdSet){
                if(studentIdToTotalMap.get(studentId) > maxMarks){
                    maxMarks = studentIdToTotalMap.get(studentId);
                    topperId = studentId;
                }
            }
            System.debug('College : '+collegeIdToName.get(collegeID)+' Topper is : '+studentIdToName.get(topperId)+' Max MArks : '+maxMarks);
        }
    }
   
    
    
    // try to implement in O(n) time complexity
    public void getToppers(Set<Id> collegeIdSet){
        
        // key = collegeId + studentId : sum(marks)
        Map<String,Decimal> collegeAndStudentIdToMarksMap = new Map<String, Decimal>();
        Map<Id,String> studentIdToStudentNameMap = new Map<Id,String>();
        Map<Id,String> collegeIdToCollegeName = new Map<Id,String>();
        
        for(Marks__c marks : [SELECT Id,Score__c,Student__c,Student__r.Name,
                              Student__r.College__c,Student__r.College__r.Name
                              FROM Marks__c
                              WHERE Student__r.College__c IN : collegeIdSet]){
                                  if(!collegeAndStudentIdToMarksMap.containsKey(marks.Student__r.College__c + '*' + marks.Student__c)){
                                      collegeAndStudentIdToMarksMap.put(marks.Student__r.College__c + '*' + marks.Student__c, 0);
                                  }
                                  Decimal score = collegeAndStudentIdToMarksMap.get(marks.Student__r.College__c + '*' + marks.Student__c);
                                  score += marks.Score__c;
                                  collegeAndStudentIdToMarksMap.put(marks.Student__r.College__c + '*' + marks.Student__c,score);
                                  // getting student studentId -> studentName
                                  if(!studentIdToStudentNameMap.containsKey(marks.Student__c)){
                                      studentIdToStudentNameMap.put(marks.Student__c, marks.Student__r.Name);
                                  }
                             
                                  // getting collegeId -> collegeName
                                  if(!collegeIdToCollegeName.containsKey(marks.Student__r.College__c)){
                                     collegeIdToCollegeName.put(marks.Student__r.College__c, marks.Student__r.College__r.Name);
                                  }
                                 
                         
                              }
        
        
        
        Map<Id,String> collegeIdToTopperStudentMap = new Map<Id,String>();
        for(String key : collegeAndStudentIdToMarksMap.keySet()){
            Id collegeId = key.split('\\*').get(0);
            Id StudentId = key.split('\\*').get(1);
            Decimal currentMarks = collegeAndStudentIdToMarksMap.get(key);
      
            // System.debug(collegeId + ' ' + studentId + '-> ' + currentMarks);
            if(!collegeIdToTopperStudentMap.containsKey(collegeId)){
                collegeIdToTopperStudentMap.put(collegeId, StudentId + '*' + 0);
            }
            Decimal tempMarks = Decimal.valueOf(collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(1));
            if(currentMarks > tempMarks){
                collegeIdToTopperStudentMap.put(collegeId, StudentId + '*' + currentMarks);
            }
        }
        
        for(Id collegeId : collegeIdToTopperStudentMap.keySet()){
            Id studentId = collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(0);
    
            String topperStudentName = studentIdToStudentNameMap.get(studentId);
            String collegeName = collegeIdToCollegeName.get(collegeId);
            
            System.debug('College : ' + collegeName +
                         ' Topper Student is :' + topperStudentName +
                         ' With Total Marks :' + collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(1));
         
        }
        
    }
    
    public void timeComparision(){
        
        // take collegeId and corrosponding name of the college 
        Map<Id,String> accountIdToAccountNameMap = new Map<Id,String>();
        for(Account acc : [SELECT Id,Name FROM Account]){
            accountIdToAccountNameMap.put(acc.Id,acc.Name);
        }
        for(Id accountId : accountIdToAccountNameMap.keySet()){
            for(Integer i = 0; i<1000; i++){
                if(accountIdToAccountNameMap.containsKey(accountId)){
                    // do nothing
                }
            }
        } 
        
        
       /* Map<String,String> accountIdAndNameToNameMap = new Map<String,String>();
        for(Account acc : [SELECT Id,Name FROM Account]){
            accountIdAndNameToNameMap.put(acc.Id + '*' + acc.Name, acc.Name);
        }
        for(String key : accountIdAndNameToNameMap.keySet()){
            for(Integer i = 0; i<1000; i++){
                if(accountIdAndNameToNameMap.containsKey(key)){
                    // do nothing
                }
            }
        } */
    }
}