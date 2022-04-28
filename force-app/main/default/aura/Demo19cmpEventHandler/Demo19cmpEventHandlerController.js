({
    handleEvent : function(component, event, helper) {
        var msg = event.getParam('message');
        var warnmsg = event.getParam('showWarningMessage');

        var count = component.get('v.count');
        count = count + 1;
        component.set('v.count', count);


        component.set('v.messageFromEvent',msg);
        component.set('v.show_warning_message', warnmsg);
        console.log(msg);
        console.log(warnmsg);
        
    }
})
