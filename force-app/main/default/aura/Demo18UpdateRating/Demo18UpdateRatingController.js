({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountInfo");
        
        action.setParams({ accountId : component.get('v.recordId')});
        action.setCallback(this,function(responce){
            component.set('v.accountRec', responce.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    handleClick : function(component, event, helper) {
        var action = component.get("c.updateAccontDetails");
        action.setParams({ acc : component.get('v.accountRec')});
        action.setCallback(this,function(responce){
            var state = responce.getState();
            if(state === 'SUCCESS'){
                var result = responce.getReturnValue();
                if(result === 'OK'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "The record has been updated successfully."
                    });
                    toastEvent.fire();
                }
                $A.get('e.force:refreshView').fire();
            }
        });

        $A.enqueueAction(action);
    }

    
})
