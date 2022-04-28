import { LightningElement,api } from 'lwc';
export default class Demo9RecordForm extends LightningElement { 
    @api recordId;
    @api objectApiName;
}

// public property value will be assigned by parent component
// even we give any default value it will be overrided by the value providec by the parent component