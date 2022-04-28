({
    doInit : function(component, event, helper) {
        helper.getMyData(component);
    },
    
    handleChange : function(component, eve,helper){
        helper.get_changed_data(component);
    },
    handleEdit : function(component, eve,helper){
        
        var _contactList = component.get('v.view.wrapperContactList');
        var _tempContactList = [];
        _contactList.forEach((element,index) =>{
            element.isEditable = true;
            _tempContactList.push(element);
        });
        component.set('v.view.wrapperContactList', _tempContactList);
        component.set('v.editable', true);
    },
    handleSaveAll : function(component, eve,helper){
        var action = component.get('c.saveDataToDatabase');
        action.setParams({
            jsonString : JSON.stringify(component.get('v.view'))
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
               alert("Contact Records updated");
               helper.get_changed_data(component);
               component.set("v.editable",false);

            }
        });
        $A.enqueueAction(action);
    },
    handleOppotunityEdit : function(component, eve,helper){
        var _opportunityList = component.get('v.view.wrapperOpportunityList');
        var _tempOpportunityList = [];
        _opportunityList.forEach((element, index)=>{
            element.isEditable = true;
            _tempOpportunityList.push(element);
        });
        component.set('v.view.wrapperOpportunityList', _tempOpportunityList);
        component.set('v.oppeditable', true);

    },
    handleOpportunitySave : function(component, eve,helper){
        var action = component.get('c.saveDataToDatabase');
        action.setParams({
            jsonString : JSON.stringify(component.get('v.view'))
        });

        action.setCallback(this, function(responce){
            var state = responce.getState();
            if(state === 'SUCCESS'){
                alert('Opportunity Records Updated');
                helper.get_changed_data(component);
                component.set('v.oppeditable', false);
            }
        });
        $A.enqueueAction(action);

    },
    addNewOpportunity :  function(component, eve,helper){
        console.log(JSON.stringify(component.get('v.view')));

        var _newOpportunity = {
            "opportunityObj":{
                "attributes":{
                    "type":"Opportunity",
                },
                "Name":"",
                "CloseDate":"",
                "AccountId":component.get('v.selectedAccountId'),
                "StageName":"",
                "Amount": "",                
            },
            "isEditable":true
        };
        component.set('v.oppeditable', true);
        var _view_opportunityList = component.get('v.view.wrapperOpportunityList');
        _view_opportunityList.push(_newOpportunity);
        component.set('v.view.wrapperOpportunityList', _view_opportunityList);


    },
    addNewContact :  function(component, eve,helper){
        console.log(JSON.stringify(component.get('v.view')));
        // alert('ok');

        var _newContact = {
            "isEditable":true,
            "contactObj":{
                "attributes":{
                    "type":"Contact",
                },
                "FirstName": "",
                "LastName": "",
                "Phone":"",
                "Email":"",
                "AccountId": component.get('v.selectedAccountId'),
                
            }
        };
        component.set('v.editable', true);
        var _view_contactList = component.get('v.view.wrapperContactList');
        _view_contactList.push(_newContact);

        component.set('v.view.wrapperContactList', _view_contactList);

    },

    editInlineRecord :  function(component, eve,helper){
        component.set('v.editable', true);
        var selectedId = eve.getSource().get('v.name'); //  giving id of record which is being clicked
        var _contactList = component.get('v.view.wrapperContactList');
        var _tempContactList = [];
        _contactList.forEach((element,index) =>{
            if(element.contactObj.Id === selectedId){
                element.isEditable = true;
            }
            _tempContactList.push(element);
        });
        component.set('v.view.wrapperContactList', _tempContactList);
    },
    saveInlineRecord : function(component,event,helper){

        var jsondata = null;
        var selectedId = event.getSource().get('v.name');
        var _contactList = component.get('v.view.wrapperContactList');
        var _tempContactList = [];
        _contactList.forEach((element,index)=>{
            if(element.contactObj.Id === selectedId){
                // element.isEditable = false;
                jsondata = JSON.stringify(element);
            }
        });

       
        var action = component.get('c.saveSingleRecord');
        action.setParams({
            jsonString : jsondata
        });
        action.setCallback(this,function(responce){
            var state = responce.getState();
            var count = 0;
            if(state === 'SUCCESS'){
                alert('Record Updated');
                var new_recordId = responce.getReturnValue();
                _contactList.forEach((element,index)=>{
                    if(element.contactObj.Id === selectedId){
                     
                      element.isEditable = false;   
                      element.contactObj.Id = new_recordId;
                    }
                    if(element.isEditable) count ++;
                    _tempContactList.push(element);
                });
                if(count === 0) 
                    component.set('v.editable', false);
                component.set('v.view.wrapperContactList', _tempContactList);
            }

        });
       
        $A.enqueueAction(action);
    },

    handleInlineOppEdit : function(component,event,helper){
        component.set('v.oppeditable', true);

        var selectedId = event.getSource().get('v.name'); // will return the buttons which are getting selected
        var _opportunityList = component.get('v.view.wrapperOpportunityList');
        var _temp_opportunityList = [];
        _opportunityList.forEach((element,index)=>{
            if(element.opportunityObj.Id === selectedId){
                element.isEditable = true;
            }
            _temp_opportunityList.push(element);
        });
        component.set('v.view.wrapperOpportunityList', _temp_opportunityList);
        
    },
    handleInlineOppSave : function(component,event,helper){
        var json_opportunity_data = null;
        var selectedId = event.getSource().get('v.name'); // will return the buttons which are getting clicked
        var _opportunityList = component.get('v.view.wrapperOpportunityList');

        
        
        _opportunityList.forEach((element,index)=>{
            if(element.opportunityObj.Id === selectedId){
                json_opportunity_data = JSON.stringify(element);
                // element.isEditable = false;
            }
        });
        var action = component.get('c.saveSingleOpportunity');
        action.setParams({
            jsonString : json_opportunity_data
        });

        action.setCallback(this,function(responce){
            var state = responce.getState();

            var count = 0;
            if(state === 'SUCCESS'){
                alert('Record Updated');
                var result = responce.getReturnValue().split('*');
                var new_opportuntyId = result[0];
                var opportunity_account_name = result[1];
                var opportunity_owner_email = result[2];
                var opportunity_porbability = result[3];
                // console.log(opportunity_porbability);
                // console.log(opportunity_account_name);
                // console.log(opportunity_owner_email);


                var _temp_opportunityList = [];
                _opportunityList.forEach((element,index)=>{
                    if(element.opportunityObj.Id === selectedId){
                        element.isEditable = false;
                        element.opportunityObj.Id = new_opportuntyId;
                        element.opportunityObj.Probability = opportunity_porbability;
                        // element.opportunityObj.Owner.Email = opportunity_owner_email;
                        // element.opportunityObj.Account.Name = opportunity_account_name;
                    }
                    _temp_opportunityList.push(element);
                    if(element.isEditable) count ++;
                });
                if(count === 0)
                    component.set('v.oppeditable', false);
                component.set('v.view.wrapperOpportunityList', _temp_opportunityList);
            }
        });

        $A.enqueueAction(action);
    }
})

