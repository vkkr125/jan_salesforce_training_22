import { LightningElement } from 'lwc';
export default class ParentComponent extends LightningElement {

    parentProperty = 123;
    handleClick(){
        let childObjRef = this.template.querySelector('c-child-component');
        childObjRef.printChildProperty();
    }
    handleChildEvent(event){
        alert('Parentcomponent says : childevent received from childcomponent');
        alert('Parentcomponent says : data received from the childevent is ....' + event.detail.products);
    }
}

// when a component included into the other component then it called composition
// here child component is included component 
// and the parent component is including component // or parent component is including child component 


// communication 
// communication between comoponet are two types
// parent will talk to child
//    a) paren will set or assign the value of a child properties
//    b) parent will call the method of child component 

// child will talk to parent
//    a) 
