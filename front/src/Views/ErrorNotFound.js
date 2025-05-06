import ComponentErrorNotFound from '../Components/ErrorNotFound.js';

export default class ViewErrorNotFound {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentErrorNotFound}`;
    }
}