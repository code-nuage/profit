import ComponentHome from '../Components/Home.js';

export default class ViewHome {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentHome}`;
    }
}