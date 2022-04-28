({
    doInit : function(component, event, helper) {

        var data = {
            'name' : 'MTX Training',
            'email': 'vkkr125@gmail.com',
        };
        // component.get('v.mystring');  // to get the data from component
        component.set('v.jsObject', data);
        component.set('v.myCustomeType',{'myname' : 'vicky', 'email' : 'vkkr125@gmail.com'});

    }
})