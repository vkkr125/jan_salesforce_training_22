import { LightningElement,api} from 'lwc';

export default class ChildComponent extends LightningElement {

    // by default all properties in a component are PROVATE //we have to use @api to make public and public peoperties could be accessed in the parent component

    // now childProperty is a PUBLIC properties and will be accessible in the parent component 
    // never assign a value to the PUBLIC property inside the compnent as it will be overwritten by a value coming from the parent
    // even if will assign it will be overided
    products = ['Lux', 'Mansoor', 'Sugar'];
    @api childProperty;
    // now print child properties is a public method and accessible to the parent
    @api
    printChildProperty(){
        alert('value of child property : ' + this.childProperty);
    }
    handleClick(){
        // custom event name of the evet must be always in lowercase
        // let custEvent = new CustomEvent("childevent", {detail : 12345});
        // let custEvent = new CustomEvent("childevent", {detail : {abc : 123}});
        let custEvent = new CustomEvent("childevent", {
            detail : {products : this.products},
            bubbles: true,
            composed: true,
        });
        this.dispatchEvent(custEvent);
    }
}