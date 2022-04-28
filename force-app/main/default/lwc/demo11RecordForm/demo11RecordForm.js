import { api, LightningElement } from 'lwc';
export default class Demo11RecordForm extends LightningElement {
    // recordForm allow to view as well as edit the record

    @api recordId;
    @api objectApiName;
    fields = ['Name', 'Title','Email','Phone'];
}