import { LightningElement, wire,api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import FIELD_MAILING_CITY from '@salesforce/schema/Contact.MailingCity';
import FIELD_MAILING_COUNTRY from '@salesforce/schema/Contact.MailingCountry';

const FILEDS = [FIELD_MAILING_CITY, FIELD_MAILING_COUNTRY];
export default class Demo19ContactLocationMap extends LightningElement {
    mapMarkers;
    @api recordId;
    @wire(getRecord, {recordId:'$recordId', fields:FILEDS})
    wiredGetRecord({data}){
        if(data){
            let mailingCity = data.fields.MailingCity.value;
            let mailingCountry = data.fields.MailingCountry.value;

            this.mapMarkers = [
                {
                    location:{City:mailingCity, Country : mailingCountry},
                    title : mailingCity + ' :: ' + mailingCountry
                }
            ];
        }
    }
}