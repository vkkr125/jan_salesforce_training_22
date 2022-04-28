trigger UserTrigger on User (after update) {
    UserTriggerHandler.updateAccountFavColor(Trigger.new, Trigger.oldMap);
}