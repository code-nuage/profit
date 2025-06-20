import ComponentCart from '../Components/Cart.js';
import ComponentCartItem from '../Components/CartItem.js';

import ModelCart from '../Models/Cart.js';
import ModelCustomById from '../Models/CustomById.js';
import ModelRemoveFromCart from '../Models/RemoveFromCart.js';

export default class ViewCart {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    async run() {
        this.data = await ModelCart();
        
        this.render();

        this.items = this.query.querySelector('.items');

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
            let customsPrice = 0;
            let basePrice = e.base_price;

            for (const [key, id] of Object.entries(e.customs)) {
                const label = types[key];
                const customData = await ModelCustomById(id);
                const name = customData?.name || `Inconnu (${id})`;
                const price = customData?.price || `0`;

                customsHTML += `<li class="pds-text-light"><span class="name pds-text-size-16">${label}: ${name}</span><span class="price">+${price}€</span></li>`;

                customsPrice += Number(price);
            }

            const totalPrice = customsPrice + basePrice;

            this.items.innerHTML += `${ComponentCartItem}`
            .replace('{{ItemId}}', e.id)
            .replace('{{Customs}}', customsHTML)
            .replace('{{BasePrice}}', basePrice)
            .replace('{{CustomsPrice}}', customsPrice)
            .replace('{{TotalPrice}}', totalPrice);
        }

        const itemElements = this.items.querySelectorAll('[data-id]');

        itemElements.forEach(item => {
            const id = item.dataset.id;

            const itemDelete = item.querySelector(".redirect-delete");

            itemDelete.addEventListener('click', e => {
                ModelRemoveFromCart(id);
            });
        });
    }

    render() {
        this.query.innerHTML = `${ComponentCart}`;
    }
}