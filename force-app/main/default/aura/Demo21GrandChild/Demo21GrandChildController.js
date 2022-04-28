({
    handleBubble : function(component, event, helper) {
        console.log('Bullble Phase for grand child handler for ' + event.getName());
    },
    handleCapture :  function(component, event, helper) {
        console.log('Capture Phase for grand child handler for ' + event.getName());
    },
    
})
