import ViewNavbar from '../Views/Navbar.js';
import ViewAccount from '../Views/Account.js';

export default class ControllerAccount {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<section id="account"></section>`;
        this.section = document.querySelector('#account');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewAccount('#account');
    }
}
