import ComponentLogin from '../Components/Login.js';

export default class ViewLogin {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();

        document.querySelector('.redirect-register').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + "/register");
        });
    }

    render() {
        this.query.innerHTML = `${ComponentLogin}`;
    }
}