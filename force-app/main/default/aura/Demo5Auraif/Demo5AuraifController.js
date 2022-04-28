({
    handleClick : function(component, event, helper) {
        var boolval = component.get("v.truthy");
        component.set("v.truthy", !boolval);
        if(boolval == true){
            component.set("v.buttonlabel", 'Show True');
        }else{
            component.set("v.buttonlabel",'Show False');
        }
    }
})