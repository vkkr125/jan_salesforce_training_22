({
    handleEvent : function(component, event, helper) {
        var msg = event.getParam('message');
        var show_warnig_message = event.getParam('showWarningMessage');

        component.set('v.show_warning_message', show_warnig_message);
        component.set('v.messageFromEvent', msg);

    }
})
