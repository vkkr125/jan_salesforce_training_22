public class ContactTriggerHandler {
    public static void preventDuplicate(List<Contact> newList,Map<Id,Contact> oldMap){
        
        // get all contact getting inserted
        // check if same contact exist in database
        // if yes, throw an error
        // if no, Allow insert of the reocrd
        // duplicate contact based on 4 fields, first name, last name, email, birthday
        
        Set<String> firstNameSet = new Set<String>();
        Set<String> lastNameSet = new Set<String>();
        Set<String> emailSet = new Set<String>();
        Set<Date> birthDateSet = new Set<Date>();
        
        for(Contact con : newList){
            if(oldMap == NULL 
               || con.FirstName != oldMap.get(con.Id).FirstName
               || con.LastName != oldMap.get(con.Id).LastName
               || con.Email != oldMap.get(con.Id).Email
               || con.Birthdate != oldMap.get(con.Id).Birthdate){
                   
                   firstNameSet.add(con.FirstName);
                   lastNameSet.add(con.lastName);
                   emailSet.add(con.email);
                   birthDateSet.add(con.Birthdate);
               }
        }
        
        Set<String> uniqueContactSet = new Set<String>();
        if(lastNameSet.size() == 0) return;
        for(Contact con : [SELECT Id,FirstName,LastName,Email,Birthdate
                           FROM Contact
                           WHERE FirstName IN:firstNameSet
                           AND LastName IN : lastNameSet
                           AND Email IN :emailSet
                           AND Birthdate IN : birthDateSet]){
                               uniqueContactSet.add((con.FirstName + '*' + con.LastName + '*' + con.Email + '*' + String.valueOf(con.Birthdate)).toUpperCase());
                           }
        
        for(Contact con : newList){
            String key = con.FirstName + '*' + con.LastName + '*' + con.Email + '*' + String.valueOf(con.Birthdate);
            if(uniqueContactSet.contains(key.toUpperCase())){
                con.addError(System.Label.DuplicateContactError);
            }else{
                uniqueContactSet.add(key.toUpperCase());
            }
        }
        
    }
}