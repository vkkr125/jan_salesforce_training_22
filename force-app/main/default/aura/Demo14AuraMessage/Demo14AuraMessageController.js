({
    auraShowMessage : function(component, event, helper) {
        // var msg = event.getParam('arguments').message;
        // alert('Message is'+msg);
        helper.messageutility('Success', component, event, 'green');
    },
  
    auraShowErrorMessage : function(component, event, helper) {
        // var msg = event.getParam('arguments').message;
        // alert('Error Message is'+msg);
        helper.messageutility('Error' , component, event, 'red');
    },
    auraRemoveMessage : function(component, event, helper) {
        // alert('Remove Message');
        helper.removemessage(component);
    }
   
 })
 