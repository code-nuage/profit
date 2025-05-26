import ViewNavbar from '../Views/Navbar.js';
import ViewRegister from '../Views/Register.js';

import ModelRegister from '../Models/Register.js';

export default class ControllerRegister {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="register"></section>
<div id="notifications"></div>`;
        this.section = document.querySelector('#register');
        this.run();
    }

    run() {
        this.render();

        this.attachForm();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewRegister('#register');
    }

    attachForm() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', async (event) => {
                event.preventDefault();

                ModelRegister(this);
            });
        }
    }
}
