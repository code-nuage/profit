import ViewNavbar from '../Views/Navbar.js';
import ViewAbout from '../Views/About.js';

export default class ControllerAbout {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="about"></section>`;
        this.section = document.querySelector('#about');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewAbout('#account');
    }
}
