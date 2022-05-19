public class ApexAssignment {
   
    public void maximumMarksForEachCollege(Set<Id> collegeIdSet){
        Map<Id,Integer> collegeIdToMaxMarks = new Map<Id,Integer>();
        for(Id collegeId : collegeIdSet)
            collegeIdToMaxMarks.put(collegeId,0);
        
        
        // query from child
        for(Student__c student : [SELECT Id,Name,Total_Marks__c,College__c
                                  FROM Student__c
                                  WHERE College__c IN :collegeIdSet]){
                                      if(!collegeIdToMaxMarks.containsKey(student.College__c)){
                                          collegeIdToMaxMarks.put(student.College__c,0);
                                      }
                                      Integer currentMaxMarks = collegeIdToMaxMarks.get(student.College__c);
                                      currentMaxMarks = Math.max(currentMaxMarks,(Integer)student.Total_Marks__c);
                                      collegeIdToMaxMarks.put(student.College__c,currentMaxMarks);
                                  }
        
        
        Map<Id,String> collegeIdToCollegeNameMap = new Map<Id,String>();
        for(College__c clg : [SELECT Id,Name 
                              FROM College__c]){
                                  collegeIdToCollegeNameMap.put(clg.Id,clg.Name);
                              }
        
        for(Id collegeId: collegeIdToMaxMarks.keySet()){
            System.debug('Maximum marks of ' + collegeIdToCollegeNameMap.get(collegeId) + ' college is ' + collegeIdToMaxMarks.get(collegeId));
        }
    }

     // print the Name of topper student as well 
    public void solutionFromParentToChild(Set<Id> collegeIdSet){
        Map<Id,Integer> collegeIdToMaxMarks = new Map<Id,Integer>();
        Map<Id,String> collegeToTopperStudentNameMap = new Map<Id,String>();
        
        
        
        for(Id collegeId : collegeIdSet) collegeIdToMaxMarks.put(collegeId,0);
            
        for(Student__c student : [SELECT Id,Name,Total_Marks__c,College__c
                                  FROM Student__c
                                  WHERE College__c IN:collegeIdSet]){
                                      if(!collegeIdToMaxMarks.containsKey(student.College__c)){
                                          collegeIdToMaxMarks.put(student.College__c,0);
                                          collegeToTopperStudentNameMap.put(student.College__c, '');
                                      }
                                      Integer currentMaxMarks = collegeIdToMaxMarks.get(student.College__c);
                                      String topper_name = collegeToTopperStudentNameMap.get(student.College__c);
                                      
                                      if(student.Total_Marks__c > currentMaxMarks){
                                          currentMaxMarks = (Integer)student.Total_Marks__c;
                                          topper_name = student.Name;
                                          collegeIdToMaxMarks.put(student.College__c,currentMaxMarks);
                                          collegeToTopperStudentNameMap.put(student.College__c, topper_name);
                                      }
                                  }
        Map<Id,String> collegeIdToCollegeNameMap = new Map<Id,String>();
        for(College__c clg : [SELECT Id,Name 
                              FROM College__c]){
                                  collegeIdToCollegeNameMap.put(clg.Id,clg.Name);
                              }
        
        for(Id collegeId : collegeIdToMaxMarks.keySet()){
            if(collegeIdToMaxMarks.get(collegeId) > 0){
                 System.debug('Maximum marks of ' + collegeIdToCollegeNameMap.get(collegeId) + 
                         ' college is ' + collegeIdToMaxMarks.get(collegeId) + ' and topper student name is ' + collegeToTopperStudentNameMap.get(collegeId));
            }else{
                System.debug('Maximum marks of the collge is  0');
            }
        }
    }
    
    public void topperOfTheCollege(Set<Id> collegeIdSet){
        
        // collegeId + studentId-> sum(marks)
        Map<String,Integer> collegeIdAndStudentIdToMarks = new Map<String,Integer>();
        Map<Id,String> collegeIdToCollegeNameMap = new Map<Id,String>();
        Map<Id,String> studentIdToStudentNameMap = new Map<Id,String>();
        
        
        for(Marks__c marks : [SELECT Id,Score__c,Student__c,
                              Student__r.College__c, Student__r.College__r.Name, Student__r.Name
                              FROM Marks__c
                              WHERE Student__r.College__c IN : collegeIdSet
                              And Score__c != NULL]){
                                  String key = marks.Student__c + '*' + marks.Student__r.College__c;
                                  if(!collegeIdAndStudentIdToMarks.containsKey(key)){
                                      collegeIdAndStudentIdToMarks.put(key, 0);
                                  }
                                  Integer val = collegeIdAndStudentIdToMarks.get(key);
                                  val += (Integer)marks.Score__c;
                                  collegeIdAndStudentIdToMarks.put(key,val);
                                  
                                 // collegeIdToCollegeNameMap
                                 collegeIdToCollegeNameMap.put(marks.Student__r.College__c,marks.Student__r.College__r.Name);
                                 studentIdToStudentNameMap.put(marks.Student__c,marks.Student__r.Name);
                              }

       Map<Id,String> collegeIdToTopperStudentMap = new Map<Id,String>();
        for(String key : collegeIdAndStudentIdToMarks.keySet()){
            Id collegeId = key.split('\\*').get(1);
            Id studentId = key.split('\\*').get(0);
            Integer totalMarks = collegeIdAndStudentIdToMarks.get(key);
            
            if(!collegeIdToTopperStudentMap.containsKey(collegeId)){
                collegeIdToTopperStudentMap.put(collegeId,0 + '*' + studentId);
            }
            Integer tempMarks = Integer.ValueOf(collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(0));
            if(tempMarks < totalMarks){
                collegeIdToTopperStudentMap.put(collegeId, totalMarks + '*' + studentId);
            }
        }
        
        for(Id collegeId : collegeIdToTopperStudentMap.keySet()){
            Id studentId = collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(1);
            Integer topperStudentMarks = Integer.ValueOf(collegeIdToTopperStudentMap.get(collegeId).split('\\*').get(0));
            
            String res = 'Topper of College :' + collegeIdToCollegeNameMap.get(collegeId) + ' is '
                + studentIdToStudentNameMap.get(studentId) + ' With total marks : ' + topperStudentMarks;
            System.debug(res);
        }
        
        
        
    }
}