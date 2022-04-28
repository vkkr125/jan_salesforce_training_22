import { api, LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import FIELD_NAME from '@salesforce/schema/Contact.Name';
import FIELD_TITLE from '@salesforce/schema/Contact.Title';
import FIELD_EMAIL from '@salesforce/schema/Contact.Email';
import FIELD_PHONE from '@salesforce/schema/Contact.Phone';


const FIELDS = [FIELD_NAME, FIELD_TITLE, FIELD_EMAIL, FIELD_PHONE];
export default class Demo13GetRecordFunction extends LightningElement {
    @api recordId;
    contact;

    @wire(getRecord, {recordId : '$recordId', fields : FIELDS})
    wiredGetRecord({data,error}){
        if(data){
            // this.contact = data;
            this.contact = {
                cname : data.fields.Name.value,
                ctitle : data.fields.Title.value,
                cemail : data.fields.Email.value,
                cphone : data.fields.Phone.value,
            }
        }
    }
    // get name(){
    //     return this.contact.fields.Name.value;
    // }
    // get title(){
    //     return this.contact.fields.Title.value;
    // }
    // get email(){
    //     return this.contact.fields.Email.value;
    // }
    // get phone(){
    //     return this.contact.fields.Phone.value;
    // }
}