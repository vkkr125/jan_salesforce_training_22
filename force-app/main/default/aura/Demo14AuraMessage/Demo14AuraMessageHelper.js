({
    messageutility : function(title,cmp,eve,cssclass) {
        var msg = eve.getParam('arguments').message;
        var msgdiv = cmp.find('messagediv');
        $A.createComponents([
            ["lightning:card",{
                'title' : title,
                'class' : cssclass
            }],
            ["lightning:formattedText",{
                'value' : msg
            }]
        ],
        function(cmp,status,errorMessage){
            if(status === 'SUCCESS'){
                var lccard = cmp[0];
                var formattedtext = cmp[1];
                lccard.set('v.body', formattedtext);
                msgdiv.set('v.body',lccard);
            }else if(status === 'INCOMPLETE'){
                console.log('No responce');
            }
            else if(status === 'ERROR'){
                console.log('Error' +errorMessage);
            }
        });
    },
    removemessage : function(cmp){
        var msgdiv = cmp.find('messagediv');
        msgdiv.set('v.body', []);
    }
})

// $A.createComponents([],function(components,status){});