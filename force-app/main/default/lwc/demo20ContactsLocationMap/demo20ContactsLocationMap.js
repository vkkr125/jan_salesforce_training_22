import { LightningElement, wire ,track, api} from 'lwc';
import getLocations from '@salesforce/apex/ContactController.getLocations';

export default class Demo20ContactsLocationMap extends LightningElement {
    
    @api listView;
    @track  mapMarkers = [];
    @wire(getLocations)
    wiredGetLocations({data,error}){
        if(data){
            this.mapMarkers = [];
            data.forEach((contact)=>{
                this.mapMarkers.push({
                    location : {City:contact.MailingCity, Country:contact.MailingCountry}, 
                    title : contact.MailingCity + '::' + contact.MailingCountry 
                });
            });
        }
    }
}