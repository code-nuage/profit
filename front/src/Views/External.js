import ComponentExternal from '../Components/External.js';

export default class ViewExternal {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentExternal}`;
    }
}