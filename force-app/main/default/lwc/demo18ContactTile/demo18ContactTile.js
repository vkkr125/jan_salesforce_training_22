import { LightningElement ,api} from 'lwc';

export default class Demo18ContactTile extends LightningElement {
    @api contact;

    handleClick(){
        let tileEvent = new CustomEvent('tileevent', {
            detail : {contactId : this.contact.Id},
            bubbles : true,
            composed : true,
        });
        this.dispatchEvent(tileEvent);
    }
}
// communication between siblings component could be done through message channels