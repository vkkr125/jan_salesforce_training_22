import { track,LightningElement } from 'lwc';
export default class TrackDemo extends LightningElement {

    // all the product properties in lwc is reactive 
    // and any time the properties value get changed it rerenders the UI component
    // when the content of object, list, array get's changed that make only changes in the values of the data structure that not change but reference remain same that do not get changes in the UI as well

    // to track the changes in the values of the array, list or object we have to use @track annotation 
    
    @track products = ['Jaggery','Lux', 'Colgate', 'Cumin'];
    handleClick(){
        // this.products[2] = 'vicky';
        // this.products = ['Dov', 'Santooer'];
        this.products.push('Lifebuoy');

    }
}