({
    handleBubble : function(component, event, helper) {
        console.log('Bubble Phase for application Handler for ' + event.getName());
        console.log('Bubble Phase event message ' + event.getParam('message'));
        
    }
})