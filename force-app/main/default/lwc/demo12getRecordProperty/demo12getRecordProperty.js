import { LightningElement ,wire,api} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import FIELD_NAME from '@salesforce/schema/Contact.Name';
import FIELD_TITLE from '@salesforce/schema/Contact.Title';
import FIELD_EMAIL from '@salesforce/schema/Contact.Email';
import FIELD_PHONE from '@salesforce/schema/Contact.Phone';

// always import reference of fields insted of writing apiname and field name because if someone trying to delete the field it will not allow them to delete that field which we are refering in the lwc
// const FIELDS = ['Contact.Name','Contact.Title','Contact.Email','Contact.Phone'];

const FIELDS = [FIELD_NAME, FIELD_TITLE, FIELD_EMAIL, FIELD_PHONE];
export default class Demo12getRecordProperty extends LightningElement {
    
    @api recordId;
    // @wire (getRecord,{recordId: '0035j00000KXdmYAAT' ,fields: FIELDS}) 
    // $recordId is treated as reactive variable
    @wire (getRecord,{recordId: '$recordId' ,fields: FIELDS})  
    contact;  // contact property is wired with getrecord method // means returned value will be stored here in contact property
    get name(){
        return this.contact.data.fields.Name.value;
    }
    get email(){
        return this.contact.data.fields.Email.value;
    }
    get phone(){
        return this.contact.data.fields.Phone.value;
    }
    get title(){
        return this.contact.data.fields.Title.value;
    }
}