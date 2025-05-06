import ViewNavbar from '../Views/Navbar.js';
import ViewHome from '../Views/Home.js';

export default class ControllerHome {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="home"></section>`;
        this.section = document.querySelector('#home');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewHome('#home');
    }
}
