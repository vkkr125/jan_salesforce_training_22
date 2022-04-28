
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
// export default class Utility{

//    static showToast(component,toastTitle,toastMessage, toastVariant, toastMode){
//         let toastEventObj = new ShowToastEvent({
//             title : toastTitle, 
//             message : toastMessage,
//             variant : toastVariant,
//             mode : toastMode
//         });
//         component.dispatchEvent(toastEventObj);
//     }
// }

const showToast = (component,toastTitle,toastMessage, toastVariant, toastMode)=>{
    let toastEventObj = new ShowToastEvent({
        title : toastTitle, 
        message : toastMessage,
        variant : toastVariant,
        mode : toastMode
    });
    component.dispatchEvent(toastEventObj);
}
export {showToast}
