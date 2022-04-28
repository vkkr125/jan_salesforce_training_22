import { LightningElement, wire } from 'lwc';
import getContactsByMailingCountry from '@salesforce/apex/ContactController.getContactsByMailingCountry';

export default class Demo15ApexParameter extends LightningElement {

    mailingCountry;
    @wire(getContactsByMailingCountry, {mailingCountry : '$mailingCountry'})
    contacts;

    handleChange(event){
        this.mailingCountry = event.target.value;

    }
}