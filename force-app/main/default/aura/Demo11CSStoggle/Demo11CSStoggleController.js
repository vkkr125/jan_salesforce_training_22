({
    handleClick : function(component, event, helper) {
        var toggleText = component.find("mytext");
        $A.util.toggleClass(toggleText, "toggle");
        if($A.util.hasClass(toggleText, "toggle")){
            component.find("mybutton").set('v.label','Show');
        }else{
            component.find("mybutton").set('v.label','Hide');
        }
    }
 })
 