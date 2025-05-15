import ComponentNavbar from '../Components/Navbar.js';

export default class ViewNavbar {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
        document.querySelector('.redirect-home').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/");
        });
        document.querySelector('.redirect-internal').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/internal");
        });
        document.querySelector('.redirect-external').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/external");
        });
        document.querySelector('.redirect-about').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/about");
        });
        document.querySelector('.redirect-login').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/login");
        });
    }

    render() {
        this.query.innerHTML = `${ComponentNavbar}`;
    }
}