import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class Demo17ApeximperativeCall extends LightningElement {
    get features() {
        return [
          {
            scope: 'col',
            class: 'slds-truncate',
            value: 'Contact Name',
          },
          {
            scope: 'col',
            class: 'slds-truncate',
            value: 'Contact Title'
          },
          {
            scope: 'col',
            class: 'slds-truncate',
            value: 'Contact Phone'
          },
          {
            scope: 'col',
            class: 'slds-truncate',
            value: 'Contact Email'
          },
        ];
      }

    contacts;
    error;
    handleGetContacts(event){
        // result parameter contains reference to the list of contact objects returened by getContasts()
        getContacts()
        .then((result)=>{
            this.contacts = result;
        })
        .catch((error)=>{
            this.error = error;
        })
    }
}

// Note : wire service methods get called multiple times before or after calling the constructor, we can controll the calling of wire services with imprativeCalling, means call the method when any event get called



/*
NOTE : javascript is asynchronous in processing
we don't we know when getContacts() will call after clicking the button , it return's promise object
promise object(eventutal completion or filure)
promis object contain's the whethare the operation is successfull or faild

then() will call if getContacts() is successfull else catch will be called


*/
