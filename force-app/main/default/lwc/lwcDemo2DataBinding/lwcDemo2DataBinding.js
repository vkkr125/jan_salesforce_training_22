import { track,LightningElement } from 'lwc';


export default class LwcDemo2DataBinding extends LightningElement {
    greeting = 'hellow';
    firstName = '';
    lastName = '';
    @track fullName = {fname : '', lname : ''};
    handleGreetingChange(event){
        this.greeting = event.target.value;
    }
    handleNameChange(event){
        var field = event.target.name;
        if(field === 'firstname'){
            this.firstName = event.target.value;
        }else{
            this.lastName = event.target.value;
        }
        // this.fullName = {fname: this.firstName, lname:this.lastName};
        this.fullName.fname = this.firstName;
        this.fullName.lname = this.lastName;
    }
    handleClick(even){
        alert(this.firstName + '$$$$$' + this.lastName);
        alert(this.fullName.fname + '####' + this.fullName.lname);
        alert(JSON.stringify(this.fullName));
    }
}


// any time updating the js object or array 
// specifically updating js single properties then we have to use @track to update on UI as weell
// otherwise the data will be updated in the javascript but it will not reflected to the ui