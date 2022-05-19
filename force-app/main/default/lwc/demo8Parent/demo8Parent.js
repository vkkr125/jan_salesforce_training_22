import { LightningElement } from 'lwc';

export default class Demo8Parent extends LightningElement {
    parentProp;

    // use constructor to initialize the private property
    // NOTE : public property will not initialize in the constructor even we initialiize those because component is in creation phase  
    // NOTE : public propeties will be initialized after constructor call
    constructor(){
        super(); // calls the super calss constructor i.e LightningElement
      //  alert('INSIDE Parent CONSTRUCTOR');
        this.parentProp = 234;
       // alert('INSIDE Parent CONSTRUCTOR : Value of parentProp : ' + this.parentProp);
       
    }
    connectedCallback(){
       // alert('INSIDE Parent CONSTRUCTOR');

    }
}