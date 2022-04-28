import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

import CONTACT_SELECTED_CHANNEL from '@salesforce/messageChannel/ContactSelected__c';
import { publish ,MessageContext} from 'lightning/messageService';

export default class Demo18ContactPublisher extends LightningElement {
    // contactPublisher -> contactTiles -> contactTile
    @wire(getContacts)
    contacts;  // contact.data refers to list of contact objects

    @wire(MessageContext)
    context;            // this property holds data about ContactPublisher which would like to publish the message

    handleTileEvent(tileEventRef){
        alert('ContactPublisher says : tileEvent received from ContactTile');
        alert('ContactPublisher says : Selected Contact Id is ... ' + tileEventRef.detail.contactId);
        
        let message = {contactRecordId : tileEventRef.detail.contactId}
        publish(this.context, CONTACT_SELECTED_CHANNEL, message);
    }
}