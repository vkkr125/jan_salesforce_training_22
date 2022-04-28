import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    firstNo;
    secondNo;
    result;

    handleChange(event){
        if(event.target.name === 'fno'){
            this.firstNo = parseFloat(event.target.value);
        }else{
            this.secondNo = parseFloat(event.target.value);
        }
    }
    add(event){
        this.result ="Addition is ..." + (this.firstNo + this.secondNo);
    }
    sub(){
        this.result = "Substraction is ..." + (this.firstNo - this.secondNo);
    }
}