import ComponentRegister from '../Components/Register.js';

export default class ViewRegister {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentRegister}`;
    }
}