({
    handleClick : function(component, event, helper) {
        component.set('v.showSpinner',true);
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.accountList',response.getReturnValue());
            }
            if(state === 'ERROR'){
                alert('Error');
            }
            component.set('v.showSpinner',false);
        });
        $A.enqueueAction(action);
    }
 })