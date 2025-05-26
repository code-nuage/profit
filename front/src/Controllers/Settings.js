import ViewNavbar from '../Views/Navbar.js';
import ViewSidebar from '../Views/AccountSidebar.js';
import ViewSettings from '../Views/Settings.js';

export default class ControllerSettings {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<header id="sidebar"></header>
<section id="settings"></section>`;
        this.section = document.querySelector('#settings');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewSidebar('#sidebar');
        new ViewSettings('#settings');
    }
}
