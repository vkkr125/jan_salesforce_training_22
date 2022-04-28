import { LightningElement } from 'lwc';

export default class ForEachDemo extends LightningElement {
    // products = ['Lux', 'Dove', 'Santoor', 'Lifebuoy'];

    products = [
        {pno : 101, pname:'Colgate', price:97},
        {pno : 102, pname:'Pepsodent', price:80},
        {pno : 103, pname:'Dant-Kanti', price:78},
    ];
    
    
}