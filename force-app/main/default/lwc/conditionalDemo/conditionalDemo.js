import { LightningElement } from 'lwc';

export default class ConditionalDemo extends LightningElement {
    show = true;
    handleChange(event){
        this.show = !this.show;
    }

}
