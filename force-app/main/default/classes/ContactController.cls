public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        List<Contact> contactList = new List<Contact>();
        contactList = [SELECT Id, Name, Title, Email, Phone
                       FROM Contact
                       ORDER BY Name
                       LIMIT 10];
        return contactList;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByMailingCountry(String mailingCountry){

        // :mailingCountry is called as BIND variable
        return [SELECT Id, Name , Title, Phone, Email
                FROM Contact 
                WHERE MailingCountry =: mailingCountry];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getLocations(){
        return [
            SELECT Id, MailingCity,MailingCountry
            FROM Contact
            WHERE MailingCity != NULL AND MailingCountry != NULL
        ];
    }
}
