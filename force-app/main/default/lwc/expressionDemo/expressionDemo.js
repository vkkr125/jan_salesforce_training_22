import { LightningElement } from 'lwc';

// LightningElement is a java class import from lwc and must be inherited by this lightning class
export default class ExpressionDemo extends LightningElement {
    greet = "welcome to LWC !!!"; // this is called as property of class ExpressionDemo
    
    // whenever the apppage is loaded then the instance(object) of this class created
    // here object ExpressionDemo created and having property with greet value is undefined
    
    
}