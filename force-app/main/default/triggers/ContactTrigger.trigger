trigger ContactTrigger on Contact (before insert,before update) {
    ContactTriggerHandler.preventDuplicate(Trigger.New, Trigger.oldMap);
    
}