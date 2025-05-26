import ComponentNavbar from '../Components/Navbar.js';

import ModelMe from '../Models/Me.js';

export default class ViewNavbar {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
        document.querySelector('.redirect-home').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/');
        });
        document.querySelector('.redirect-internal').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/internal');
        });
        document.querySelector('.redirect-external').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/external');
        });
        document.querySelector('.redirect-about').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/about');
        });
        document.querySelector('.redirect-cart').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/cart');
        });
        document.querySelector('.redirect-login').addEventListener('click', async (e) => {
            const me = await ModelMe();
            if (!me) {
                window.location.replace(window.location.origin + '/login')
            } else {
                window.location.replace(window.location.origin + '/account');
            }
        });
    }

    render() {
        this.query.innerHTML = `${ComponentNavbar}`;
    }
}