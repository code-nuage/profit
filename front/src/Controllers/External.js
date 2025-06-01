import ViewNavbar from '../Views/Navbar.js';
import ViewExternal from '../Views/External.js';

export default class ControllerExternal {
    constructor() {
        document.body.innerHTML = `<header id="navbar"></header>
<section id="external"></section>`;
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewExternal('#external');
    }
}
