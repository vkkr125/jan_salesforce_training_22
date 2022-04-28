import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class Demo14ApexProperty extends LightningElement {
   
    @wire(getContacts)
    contacts;
    
}