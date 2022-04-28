import { LightningElement, wire,track} from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class Demo16ApexFunction extends LightningElement {

    @track contacts = [];
    @wire(getContacts)
    wiredGetContacts({data, error}){
        if(data){
            // this.contacts = data;
            data.forEach(contact=>{
                this.contacts.push({
                    cid : contact.Id,
                    cname : contact.Name,
                    ctitle : contact.Title,
                    cemail : contact.Email,
                    cphone : contact.Phone
                });
            });
        }
    }

}