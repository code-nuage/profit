import ComponentLogin from '../Components/Login.js';

export default class ViewLogin {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentLogin}`;
    }
}