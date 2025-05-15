import ViewNavbar from '../Views/Navbar.js';
import ViewLogin from '../Views/Login.js';

import ModelLogin from '../Models/Login.js';

export default class ControllerLogin {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="login"></section>`;
        this.section = document.querySelector('#login');
        this.run();
    }

    run() {
        this.render();

        this.attachForm();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewLogin('#login');
    }

    attachForm() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', async (event) => {
                event.preventDefault();

                ModelLogin(this);
            });
        }
    }
}
