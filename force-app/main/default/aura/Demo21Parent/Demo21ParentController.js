({
    handleBubble : function(component, event, helper) {
        console.log('Bubble Phase for Parent Handler for ' + event.getName());
    },
    handleCapture :  function(component, event, helper) {
        console.log('Capture Phase for Parent handler for ' + event.getName());
    },
    handleCapture1 :  function(component, event, helper) {
        console.log('Capture Phase for Parent handler for ' + event.getName());
    },
    
})
