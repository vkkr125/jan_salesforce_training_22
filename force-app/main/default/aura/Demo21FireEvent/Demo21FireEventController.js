({
    fireEvent : function(component, event, helper) {
        var cmpeve = component.getEvent('bubbleevent');
        cmpeve.setParams({
            message : 'event bubbling'
        });
        cmpeve.fire();

        var captureEvent = component.getEvent('captureevent');
        captureEvent.setParams({
            message : 'event capturing'
        });
        captureEvent.fire();
    }
})
