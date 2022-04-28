import { LightningElement,api} from 'lwc';

export default class Demo18ContactTiles extends LightningElement {
    @api contacts;

    handleTileEvent(tileEventRef){
        alert('Contact Tiles says : tileEvent received from ContactTile');
        alert('ContactTiles says : Selected Contact Id is ... ' + tileEventRef.detail.contactId);
    }
}
