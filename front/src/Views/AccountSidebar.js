import ComponentSidebar from '../Components/AccountSidebar.js';

export default class ViewAccount {
    constructor(query) {
        this.query = document.querySelector(query);
        this.run();
    }

    run() {
        this.render();
        document.querySelector('.redirect-account-home').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/account');
        });
        document.querySelector('.redirect-account-commands').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/account-commands');
        });
        document.querySelector('.redirect-account-settings').addEventListener('click', (e) => {
            window.location.replace(window.location.origin + '/account-settings');
        });
    }

    render() {
        this.query.innerHTML = `${ComponentSidebar}`;
    }
}