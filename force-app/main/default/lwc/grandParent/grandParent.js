import { LightningElement } from 'lwc';
export default class GrandParent extends LightningElement {
    handleChildEvent(event){
        alert('GrandParent says : childevent received from childcomponent');
        alert('GrandParent says : data received from the childevent is ....' + event.detail.products);
    }
}