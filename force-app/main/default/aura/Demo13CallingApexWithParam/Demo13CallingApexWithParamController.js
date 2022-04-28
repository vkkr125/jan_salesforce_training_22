({
    doInit : function(component, event, helper) {
        component.set('v.isError', false);
        component.set('v.errorMessage', '');


        component.set('v.showSpinner', true);
        var action = component.get('c.getAccounts');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.accountList', response.getReturnValue());
            }
            if(state === 'ERROR'){
                alert('Error');
            }
            component.set('v.showSpinner', false);
        });
        $A.enqueueAction(action);
    },
    getContactRecords : function(component, event, helper) {
        // alert('Select Account Id is : : : ' + component.get('v.selectedAccountId'));
        component.set('v.isError', false);
        component.set('v.errorMessage', '');

        component.set('v.showSpinner', true);
        var action = component.get('c.getContacts');
        action.setParams({ accId : component.get('v.selectedAccountId')});
        console.log(component.get('v.selectedAccountId'));
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.contactList', response.getReturnValue());
            }
            if(state === 'ERROR'){
                var error = response.getError();
                console.log(JSON.stringify(error));
                console.log(JSON.stringify(error[0]));
                component.set('v.errorMessage', 'Somthing Went Wrong ,Contact to your system admin');
                // if(error[0].message === 'Assertion Failed'){
                   
                // }
                component.set('v.isError', true);
            }
            component.set('v.showSpinner', false);
        });
        $A.enqueueAction(action);
    },
})
