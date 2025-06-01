import ComponentSettings from '../Components/Settings.js';

import ModelMe from '../Models/Me.js';

export default class ViewSettings {
    constructor(query) {
        this.query = document.querySelector(query);
        this.ready = this.run();
    }

    async run() {
        this.user = await ModelMe();

        this.render();
    }

    async render() {
        this.query.innerHTML = `${ComponentSettings}`.replace('{{Name}}', this.user.name);
    }
}