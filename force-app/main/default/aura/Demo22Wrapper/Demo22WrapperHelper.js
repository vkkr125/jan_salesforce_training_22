({
    getMyData : function(component) {

        var action = component.get('c.getAccounts');
        action.setCallback(this,function(responce){
            var state = responce.getState();
            if(state === 'SUCCESS'){
                component.set('v.accountList', responce.getReturnValue());
                // console.log(responce.getReturnValue());
            }else{
                // console.log(responce.getError());
                console.log('smothing went wrong');
            }
        });
        $A.enqueueAction(action);

        var action2 = component.get('c.getPickListValuesIntoList');
        action2.setCallback(this,function(responce){
            var state = responce.getState();
            if(state === 'SUCCESS'){
                component.set('v.stageList', responce.getReturnValue());
                // console.log(responce.getReturnValue());
            }else{
                console.log(responce.getError());
                console.log('smothing went wrong');
            }
        });
        $A.enqueueAction(action2);
    },
    get_changed_data : function(component){
        var action = component.get('c.getAccountDetailWithRelatedData');
        action.setParams({
            accountId : component.get('v.selectedAccountId')
        });
        action.setCallback(this,function(responce){
            var state = responce.getState();
            if(state === 'SUCCESS'){
                // console.log('#####' + responce.getReturnValue());
                var responceObj = JSON.parse(responce.getReturnValue());
                component.set('v.view', responceObj);
                // console.log(responceObj);
               // console.log(JSON.stringify(responceObj));

            }
        })
        $A.enqueueAction(action);
    }
})

