import { LightningElement, api} from 'lwc';
export default class Demo8Child extends LightningElement {
    @api childProp;
    constructor(){
        super();
        //alert('Inside child CONSTRUCTOR ...');
        this.childProp = 1234;
        //alert('Inside child CONSTRUCTOR : value of childProp : ' + this.childProp);
    }
    // connected calback will be called after the component dom is created and attached to the parent dom , here public property will be accessible because they already got initialized
    connectedCallback(){
       // alert('Inside child connectedCallBack : value of childProp : ' + this.childProp);
    }
}