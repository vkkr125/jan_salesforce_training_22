({
    doInit : function(component, event, helper) {
        var myDate = new Date();
        var pstDate = myDate.toLocaleString("en-US", {
            timeZone: "America/Los_Angeles"
        });
        console.log(pstDate)
        component.set('v.currentDateTime', new Date()); 
    }
})
