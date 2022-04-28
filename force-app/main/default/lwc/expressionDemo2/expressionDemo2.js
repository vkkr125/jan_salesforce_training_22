import { LightningElement } from 'lwc';

export default class ExpressionDemo2 extends LightningElement {
    firstName = 'vicky'; // property name should be in camle case
    lastName = 'kumar';

    // getter method //  this also works as property
    get fullName(){
        return this.firstName + ' ' + this.lastName;
    }
    handleChange(event){
        // alert('change event is genereted by ' + event.target.name);
        // alert('value received is ... ' + event.target.value);
        
        if(event.target.name === 'fname'){
            this.firstName = event.target.value;
        }else{
            this.lastName = event.target.value;
        }
    }
}