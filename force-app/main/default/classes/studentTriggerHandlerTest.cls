@isTest
public class studentTriggerHandlerTest {
    
    // testSetup store temprearlly store the data we can query the records and we do not have to call the
  /*  @testSetup
    static static void setup(){
        List<College__c> collegeList = new List<College__c>();
        List<Student__c> studentList = new List<Student__c>();
        collegeList = TestDataFactory.createCollegeList(5,'testcollege',false);
        for(College__c clg : collegeList){
            clg.Is_Active__c = true;
        }
        insert collegeList;
        for(College__c clg : collegeList){
            studentList.addAll(TestDataFactory.createStudentList(10,'teststudent',clg, false));
        }
        insert studentList;
    }
    
    @isTest
    static void testCountOnCreate(){
        List<College__c> collegeList = new List<College__c>();
        collegeList = [SELECT Id FROM College__c WHERE Name LIKE 'testcollege%'];
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id IN :collegeList]){
                                  System.assertEquals(10, clg.Student_Count__c);
                              }
    }
    
    @isTest
    static void testCountOnUpdate(){
        List<Student__c> studentList = new List<Student__c>();
        List<College__c> collegeList = new List<College__c>();
        studentList = [SELECT Id,College__c FROM Student__c WHERE Name LIKE 'teststudent%'];
        collegeList = [SELECT Id FROM College__c WHERE Name LIKE 'testcollege%'];
        for(Student__c stud : studentList){
            if(stud.College__c != collegeList.get(0).Id){
                stud.College__c = collegeList.get(0).Id;
            }
        }
        update studentList;
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id = :collegeList.get(0).Id]){
                                  System.assertEquals(50, clg.Student_Count__c);
                              }
        
    }*/

    
    
    
    // in below code we have to call createData method each time (solutin above using @testsetup-> it will store the data we can query the data)
    public static List<College__c> collegeList;
    public static List<Student__c> studentList;
    
    
    public static User usr;
    public static void createData(){
        collegeList = new List<College__c>();
        studentList = new List<Student__c>();
        collegeList = TestDataFactory.createCollegeList(5, 'testcollege', false);
        for(College__c clg : collegeList){
            clg.is_Active__c = true;
        }
        insert collegeList;
        studentList = new List<Student__c>();
        for(College__c clg : collegeList){
            studentList.addAll(TestDataFactory.createStudentList(10, 'testcollege', clg, false));
        }
        insert studentList;
    }
    @isTest
    static void testCountOnCreate(){
        
        try{
            
            UserRole r = [SELECT Id, Name FROM UserRole LIMIT 1];
            Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'Demo Profile'];
            usr = new User(Alias = 'standt', Email = 'vkkr125@gmail.com',
                           EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
                           LocaleSidKey = 'en_US', ProfileId = p.Id,
                           TimeZoneSidKey = 'America/Los_Angeles',
                           UserRoleId = r.Id,
                           userName = 'vicky26941@gmail.com.test');
            
            
            insert usr;
            createData(); 
        }
        catch(Exception ex){
            System.debug(ex.getMessage());
        }
       /* System.runAs(usr){
           
            for(College__c clg: [SELECT Id, Student_Count__c
                                 FROM College__c
                                 WHERE Id IN : collegeList]){
                                     System.assertEquals(10,clg.Student_Count__c);
                                 } 
        }*/
        
        
    }

   /* @isTest
    static void testCountOnUpdate(){
        createData();
        for(Student__c stud : studentList){
            if(stud.College__c != collegeList.get(0).Id){
                stud.College__c = collegeList.get(0).Id;
            }
        }
        
        
        // each method have only one Test.start and Test.stopTest() 
        // it reset the gorvener limit to 0
        Test.startTest();
        update studentList;
        
        Test.stopTest();
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id =: collegeList.get(0).Id]){
                                  System.assertEquals(50, clg.Student_Count__c);
                              }
   
    }
    @isTest
    static void testCountOnDelete(){
        createData();
        delete studentList;
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id = :collegeList.get(0).Id]){
                                  System.assertEquals(0, clg.Student_Count__c);
                              }
        
    }
    
    @isTest
    static void testCountOnUnDelete(){
        
        Test.startTest();
        createData();
        List<Student__c> deleteList = new List<Student__c>();
        for(Student__c std : studentList){
            if(std.College__c == collegeList.get(0).Id){
                deleteList.add(std);
            }
        }
        
        delete deleteList;
        
        test.stopTest();
     
        
        List<Student__c> undeleteList = new List<Student__c>();
        undeleteList = [SELECT Id,Name
                        FROM Student__c
						WHERE isDeleted = true
                        ALL ROWS]; // VVI : // all rows will return all the data which present in the recycle bin
        
        //System.assert(false, '>>>>>> ' + undeleteList.size());
        undelete undeleteList;
        for(College__c clg : [SELECT Id,Student_Count__c
                              FROM College__c
                              WHERE Id IN : collegeList]){
                                  System.assertEquals(10,clg.Student_Count__c);
                              }
    } 
    */
    
    
    
    
    
    
 /*   static testmethod void testCountOnCreate(){
        List<College__c> collegeList = new List<College__c>();
        for(Integer i = 1; i <= 5; i++){
            College__c clg = new College__c();
            clg.Name = 'Test College ' + i;
            clg.College_Email__c = 'testcollege' + i + '@mtxb2b.com';
            clg.is_Active__c = true;
            clg.State__c = 'Bihar';
            collegeList.add(clg);
        }
        
        if(collegeList.size() > 0){
            insert collegeList;
        }
        
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 1; i<=50; i++){
            Student__c stud = new Student__c();
            stud.Name = 'test student ' + i;
            stud.Age__c = 20;
            stud.Adhar_Number__c = i < 10 ? '1211-2222-440' + i : '1111-2222-44' + i;
            stud.State__c = 'Bihar';
            stud.Student_Email__c = 'vkkr125@gmail.com';
            stud.College__c = collegeList.get(math.mod(i,5)).Id;
            studentList.add(stud);
        }
        
        if(studentList.size() > 0){
            insert studentList;
        }
        for(College__c clg : [SELECT Id, Student_Count__c
                              FROM College__c
                              WHERE Id IN : collegeList]){
                                  System.debug(clg.Student_Count__c);
                                  System.assertEquals(10,(Integer)clg.Student_Count__c);
                              }
  
    }
    
    static void testCountOnUpdate(){
         List<College__c> collegeList = new List<College__c>();
        for(Integer i = 1; i <= 5; i++){
            College__c clg = new College__c();
            clg.Name = 'Test College ' + i;
            clg.College_Email__c = 'testcollege' + i + '@mtxb2b.com';
            clg.is_Active__c = true;
            clg.State__c = 'Bihar';
            collegeList.add(clg);
        }
        
        if(collegeList.size() > 0){
            insert collegeList;
        }
        
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 1; i<=50; i++){
            Student__c stud = new Student__c();
            stud.Name = 'test student ' + i;
            stud.Age__c = 20;
            stud.Adhar_Number__c = i < 10 ? '1211-2222-440' + i : '1111-2222-44' + i;
            stud.State__c = 'Bihar';
            stud.Student_Email__c = 'vkkr125@gmail.com';
            stud.College__c = collegeList.get(math.mod(i,5)).Id;
            studentList.add(stud);
        }
        
        if(studentList.size() > 0){
            insert studentList;
        }
         for(Student__c stud : studentList){
            if(stud.College__c != collegeList.get(0).Id){
                stud.College__c = collegeList.get(0).Id;
            }
        }
        update studentList;
        delete studentList;
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id = :collegeList.get(0).Id]){
                                  System.assertEquals(0, clg.Student_Count__c);
                              }

        
        
    }*/
    
    
}