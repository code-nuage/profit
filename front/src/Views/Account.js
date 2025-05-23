import ComponentAccount from '../Components/Account.js';

import ModelMe from '../Models/Me.js';
import ModelLogout from '../Models/Logout.js';

export default class ViewAccount {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    async run() {
        this.user = await ModelMe();

        this.render();

        document.querySelector('.redirect-logout').addEventListener('click', (e) => {
            ModelLogout();
        });
    }

    render() {
        this.query.innerHTML = `${ComponentAccount}`.replace("{{Username}}", this.user.name);
    }
}