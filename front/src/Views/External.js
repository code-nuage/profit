import ComponentExternal from '../Components/External.js';

import ModelAddToCart from '../Models/AddToCart.js';
import ModelCustom from '../Models/Cutoms.js';

export default class ViewExternal {
    constructor(query) {
        this.query = document.querySelector(query);
        this.form = ``;
        this.ready = this.run();
    }

    async run() {
        this.data = await ModelCustom();

        const types = {
            "diameter": "Diamètre",
            "taste": "Goût",
            "texture": "Texture",
            "matter": "Matière",
            "color": "Couleur",
            "lubricant": "Lubrifiant"
        };

        this.data.forEach(e => {
            const options = e.customs
                .map(c => `<option class="pds-text-light pds-text-size-16">${c.name}</option>`)
                .join('');

            this.form += `
            <div class="${e.type}">
                <h2 class="pds-text-light pds-text-size-24 pds-text-weight-bold">${types[e.type]}</h2>
                <select class="pds-text-light pds-text-size-16 pds-border-1 pds-border-light pds-border-radius-4 pds-background-primary" id="${e.type}" name="${e.type}">
                    ${options}
                </select>
            </div>`;
        });

        this.form += `<button class="redirect-add pds-button pds-text-light pds-text-size-16 pds-background-accent pds-border-radius-4" type="submit">Ajouter au panier</button>`;

        this.render();
        

        document.querySelector('.redirect-add').addEventListener('click', (e) => {
            e.preventDefault();
            ModelAddToCart();
        });

    }


    render() {
        this.query.innerHTML = `${ComponentExternal}`;
        const formElement = document.querySelector('form');
        formElement.innerHTML = this.form;
    }
}
