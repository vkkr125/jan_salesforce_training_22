({
    handleclick : function(component, event, helper) {
        var cmp = component.find('demo1input');
        console.log('Local Id is :' + cmp.getLocalId());
        console.log('Global Id is :' + cmp.getGlobalId());
        console.log('Value of input Value is :' + cmp.get('v.value'));
        console.log('Value of input Label is :' + cmp.get('v.label'));
        cmp.set('v.value', 'Training Demo');
        cmp.set('v.label', 'Changed Input Label');
        console.log('value after inputed : ' + cmp.get('v.value'));
    },
    showMultipleIds : function(component) {
        var cmp = component.find('demo2input');
        cmp.forEach(function(item,index){
            console.log('Item Index is -----'+index + ' Local Id is '+item.getLocalId()+'   ----->> value is : '+item.get('v.value'));
            console.log('Item Index is -----'+index + ' Global Id is '+item.getGlobalId()+'   ----->> value is : '+ item.get('v.value'));
            var myvalue = item.get('v.value');
            if(myvalue !== ''){
                item.set('v.readonly',true);
            }
        });
    },
 
    resetValues :  function(component) {
        var cmp = component.find('demo2input');
        cmp.forEach(function(item,index){
            item.set('v.value','');
            item.set('v.readonly',false);
        });
    }
 
   
})


/*
 global id's 
 try not to use global id's
 -> generated at runtime 
 -> it is not gauranteed to be same beyond the lifetime
*/