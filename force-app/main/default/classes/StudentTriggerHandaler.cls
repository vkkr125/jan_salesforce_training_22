public class StudentTriggerHandaler {
    
  /*  public static void updateCountUsingAggrigateQuery(List<Student__c> newList, Map<Id,Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        if(newList != NULL){
            for(Student__c student : newList){
                if(oldMap == NULL || student.College__c != oldMap.get(Student.Id).College__c){
                    if(Student.College__c != NULL){
                        collegeIdSet.add(student.College__c);
                    }
                    if(oldMap != NULL && oldMap.get(Student.Id).College__c != NULL){
                        collegeIdSet.add(oldMap.get(student.Id).College__c);
                    }
                }
            }
        }else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != NULL){
                    System.debug(' >>>>>>>>' + oldMap.get(studentId).College__c);
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                }
            }
        }
        Map<Id,Integer> collegeIdToCountMap = new Map<Id,Integer>();
        for(Id collegeId : collegeIdSet){
            collegeIdToCountMap.put(collegeId,0);
        }
        
        if(collegeIdSet.size() == 0) return;        
        for(AggregateResult ar : [SELECT College__c, COUNT(Id), AVG(Age__c) college_age_average
                                  FROM Student__c
                                  WHERE College__c IN : collegeIdSet
                                  GROUP BY College__c]){
                                      // to get college Id - ar.get('College__c');
                                      // to get count - ar.get('expr0');
                                      // to get avg - ar.get('expr1') or ar.get('college_age_average')
                                      collegeIdToCountMap.put((Id)ar.get('College__c'), (Integer)ar.get('expr0'));
                                  }
        List<College__c> collegeUpdateList = new List<College__c>();
        for(Id collegeId : collegeIdToCountMap.keySet()){
            College__c clg = new College__c();
            clg.Id = collegeId;
            clg.Student_Count__c = collegeIdToCountMap.get(collegeId);
            collegeUpdateList.add(clg);
        }
        if(collegeUpdateList.size() > 0){
            update collegeUpdateList;
        }
    } */

    public static void updateCountQueryFromStudent(List<Student__c> newList, Map<Id,Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        if(newList != NULL){
            for(Student__c student : newList){
                if(oldMap == NULL || student.College__c != oldMap.get(Student.Id).College__c){
                    if(Student.College__c != NULL){
                        collegeIdSet.add(student.College__c);
                    }
                    if(oldMap != NULL && oldMap.get(Student.Id).College__c != NULL){
                        collegeIdSet.add(oldMap.get(student.Id).College__c);
                    }
                }
            }
        }else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != NULL){
                    System.debug(' >>>>>>>>' + oldMap.get(studentId).College__c);
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                }
            }
        }
        
        Map<Id,Integer> collegeIdToCountMap = new Map<Id,Integer>();
        for(Id collegeId : collegeIdSet){
            collegeIdToCountMap.put(collegeId,0);
        }
        for(Student__c student : [SELECT Id,College__c
                                  FROM Student__c
                                  WHERE College__c IN :collegeIdSet]){
                                      
                                      // in this case when deleting the student from college if college has only one student in that case it will fail on boundary condition
                                    /*  if(!collegeIdToCountMap.containsKey(student.College__c)){
                                          collegeIdToCountMap.put(student.College__c, 0);
                                      }
                                      */
                                      Integer tempCount = collegeIdToCountMap.get(student.College__c);
                                      tempCount += 1;
                                      collegeIdToCountMap.put(student.College__c, tempCount);
                                  }
        
        
        List<College__c> updateCollegeList = new List<College__c>();
        for(Id collegeId : collegeIdToCountMap.keySet()){
            College__c college = new College__c();
            college.Id = collegeId;
            college.Student_Count__c = collegeIdToCountMap.get(collegeId);
            
            updateCollegeList.add(college);
        }
        if(updateCollegeList.size() > 0){
            update updateCollegeList;
        }

    }
    
    
   /* public static void updateCount(List<Student__c> newList,Map<Id,Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        if(newList != NULL){
            for(Student__c student : newList){
                if(oldMap == NULL || student.College__c != oldMap.get(Student.Id).College__c){
                    if(Student.College__c != NULL){
                        collegeIdSet.add(student.College__c);
                    }
                    if(oldMap != NULL && oldMap.get(Student.Id).College__c != NULL){
                        collegeIdSet.add(oldMap.get(student.Id).College__c);
                    }
                }
            }
        }else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != NULL){
                    System.debug(' >>>>>>>>' + oldMap.get(studentId).College__c);
                    collegeIdSet.add(oldMap.get(studentId).College__c);
                }
            }
        }
        
        Map<Id,Integer> collegeIdToCountMap = new Map<Id,Integer>();
        for(College__c college : [SELECT Id,
                                  (SELECT Id FROM Students__r)
                                  FROM College__c
                                  WHERE Id IN : collegeIdSet]){
                                      collegeIdToCountMap.put(college.Id, college.Students__r.size());
                                  }
        
        List<College__c> updateCollegeList = new List<College__c>();
        for(Id collegeId : collegeIdToCountMap.keySet()){
            College__c college = new College__c();
            college.Id = collegeId;
            college.Student_Count__c = collegeIdToCountMap.get(collegeId);
            
            updateCollegeList.add(college);
        }
        if(updateCollegeList.size() > 0){
            update updateCollegeList;
        }
        
    }*/
}