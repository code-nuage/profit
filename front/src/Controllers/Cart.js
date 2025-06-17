import ViewNavbar from '../Views/Navbar.js';
import ViewCart from '../Views/Cart.js';

export default class ControllerCart {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="cart"></section>
<section id="notifications"></section>`;
        this.section = document.querySelector('#cart');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewCart('#cart');
    }
}
