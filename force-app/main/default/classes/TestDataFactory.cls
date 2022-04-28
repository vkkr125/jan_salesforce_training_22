// this is crated 1 per Project , and this is used by all developers.
public class TestDataFactory {
    public static List<Account> createAccountList(Integer count,String name,Boolean isInsert){
        List<Account> accountList = new List<Account>();
        for(Integer  i =1 ; i < = count; i++){
            Account acc = new Account();
            acc.Name = name+i;
            accountList.add(acc);
        }
        if(isInsert){
            insert accountList;
        }
        return accountList;
    }
    public static List<College__c> createCollegeList(Integer count,String name,Boolean isInsert){
        List<College__c> collegeList = new List<College__c>();
        for(Integer  i =1 ; i < = count; i++){
            College__c clg = new College__c();
            clg.Name = name+i;
            clg.College_Email__c = name+i+'@mtxb2b.com';
            clg.State__c = 'Rajasthan';
            collegeList.add(clg);
        }
        if(isInsert){
            insert collegeList;
        }
        return collegeList;
    }
    
    public static List<Student__c> createStudentList(Integer count,String name,College__c college,Boolean isInsert){
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i=1 ; i<=count ; i++){
            Student__c stud = new Student__c();
            stud.Name = 'testStudent'+i;
            stud.Adhar_Number__c =  Math.round((Math.random() * (9000) + 1000))
                +'-'+Math.round((Math.random() * (9000) + 1000))
                +'-'+Math.round((Math.random() * (9000) + 1000));
            
            stud.Age__c = 22;
            stud.Student_Email__c = 'vkkr125@gmail.com';
            if(college != NULL){
                stud.State__c = college.State__c;
                stud.College__c = college.Id;
            }
            studentList.add(stud);
        }
        if(isInsert){
            insert studentList;
        } 
        return studentList;                                                                                                                                   
        
    }
}