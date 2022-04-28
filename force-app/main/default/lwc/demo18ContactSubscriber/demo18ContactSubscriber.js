import { LightningElement, wire,track } from 'lwc';
import CONTACT_SELECTED_CHANNEL from '@salesforce/messageChannel/ContactSelected__c';
import { subscribe,unsubscribe, MessageContext} from 'lightning/messageService';

import {deleteRecord, getRecord} from 'lightning/uiRecordApi';
import FIELD_NAME from '@salesforce/schema/Contact.Name';
import FIELD_TITLE from '@salesforce/schema/Contact.Title';
import FIELD_EMAIL from '@salesforce/schema/Contact.Email';
import FIELD_PHONE from '@salesforce/schema/Contact.Phone';

// NavigationMixin class contains static Navigate method
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
// import UtilityClass from 'c/utility';
import { showToast } from 'c/utility';

const FIELDS = [FIELD_NAME, FIELD_TITLE, FIELD_EMAIL, FIELD_PHONE];
export default class Demo18ContactSubscriber extends NavigationMixin(LightningElement) {
    // after the dom is created and connected to the main dom subscribe the CONNECTED_SELECTED_CHANNEL
    // wo will write it in connecteCallBack()
    subscription;
    selectedContactId;
    @wire(MessageContext)
    context;

    @wire(getRecord,{recordId:'$selectedContactId',fields:FIELDS})
    contact;

    // it is call when the DOM of componenent is created and attached to the main DOM
    connectedCallback(){
        this.subscribeToMessageChannel();
        
    }
    subscribeToMessageChannel(){
        this.subscription = subscribe(this.context, CONTACT_SELECTED_CHANNEL,
             (receivedMessage)=>{
                 this.handleMessage(receivedMessage);
              });
    }
    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription = null;
        // console.log(JSON.stringify(this.contact.data.fields));
    }
    handleMessage(message){
        alert('Contact Subscriber says : published message received');
        alert('Contact Subscriber says : selected contact id is....' + message.contactRecordId);

        this.selectedContactId = message.contactRecordId;
        console.log('selected contact Id :' + this.selectedContactId);
    }
    get name(){
        return this.contact.data.fields.Name.value;
    }
    get phone(){
        return this.contact.data.fields.Phone.value;
    }
    get email(){
        return this.contact.data.fields.Email.value;
    }
    get title(){
        return this.contact.data.fields.Title.value;
    }

    handleEditClick(){
        let pageReference = {
            type: 'standard__recordPage',
            attributes : {
                recordId : this.selectedContactId,
                objectApiName : 'Contact',
                actionName : 'edit'
            }
        };
        this[NavigationMixin.Navigate](pageReference);
    }

    handleDeleteClick(){
        deleteRecord(this.selectedContactId)
        .then( ()=>{
            // alert('Record deletion sucessfully !!!');
            //  let dispalyToast = new ShowToastEvent({
            //     title : 'DELETE RECORD',
            //     message : 'Record deleted successfully !!!',
            //     variant : 'success',
            //     mode : 'pester'
            // });
            // this.dispatchEvent(dispalyToast); 

            // UtilityClass.showToast(this,'DELETE RECORD','Record deleted successfully !!!','success','pester');
            showToast(this,'DELETE RECORD','Record deleted successfully !!!','success','pester');

        })
        .catch(()=>{
            // let dispalyToast = new ShowToastEvent({
            //     title : 'DELETE RECORD',
            //     message : 'Record deletion unsuccessful !!!!!!',
            //     variant : 'error',
            //     mode : 'sticky'
            // });
            // this.dispatchEvent(dispalyToast);
            //alert('Record deletion unsuccessful !!!');
            // UtilityClass.showToast(this,'DELETE RECORD','Record deletion unsuccessful !!!','error','sticky');
            showToast(this,'DELETE RECORD','Record deletion unsuccessful !!!','error','sticky');

        })
    }
}
