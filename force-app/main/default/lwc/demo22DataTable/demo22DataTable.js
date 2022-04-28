import getContacts from '@salesforce/apex/ContactController.getContacts';
import { LightningElement, wire } from 'lwc';

export default class Demo22DataTable extends LightningElement {
    @wire(getContacts)
    contacts;
    
    columns = [
        {label:'Contact Name', fieldName:'Name'},
        {label:'Title', fieldName:'Title'},
        {label:'Email', fieldName:'Email', editable:true},
        {label:'Phone', fieldName:'Phone', editable:true},
    ];
}