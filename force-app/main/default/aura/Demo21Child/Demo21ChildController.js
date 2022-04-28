({
    handleBubble : function(component, event, helper) {
        console.log('Bublle Phase for Child Handler for ' + event.getName());
        
      // this will stop the propogation of message from buttom to top (bubble phase)
      //  event.stopPropagation();
    }
})
