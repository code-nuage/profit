import ViewNavbar from '../Views/Navbar.js';
import ViewErrorNotFound from '../Views/ErrorNotFound.js';

export default class ControllerErrorNotFound {
    constructor() {
        document.body.innerHTML = `<header id="navbar"></header>
<section id="error-not-found"></section>`;
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        new ViewNavbar('#navbar');
        new ViewErrorNotFound('#error-not-found');
    }
}
