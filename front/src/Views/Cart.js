import ComponentCart from '../Components/Cart.js';
import ComponentCartItem from '../Components/CartItem.js';

import ModelCart from '../Models/Cart.js';
import ModelCustomById from '../Models/CustomById.js';

export default class ViewCart {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    async run() {
        this.data = await ModelCart();
        
        this.render();

        this.items = this.query.querySelector('.items');

        console.log(this.items);

        const types = {
            "diameter": "Diamètre",
            "taste": "Goût",
            "texture": "Texture",
            "matter": "Matière",
            "color": "Couleur",
            "lubricant": "Lubrifiant"
        };

        for (const e of this.data.products) {
            let customsHTML = '';

            for (const [key, id] of Object.entries(e.customs)) {
                const label = types[key];
                const customData = await ModelCustomById(id);
                console.log(customData);
                const readable = customData?.name || `Inconnu (${id})`;

                customsHTML += `<li class="pds-text-light pds-text-size-16">${label}: ${readable}</li>`;
            }

            this.items.innerHTML += `${ComponentCartItem}`.replace('{{Customs}}', customsHTML);
        }

    }

    render() {
        this.query.innerHTML = `${ComponentCart}`;
    }
}