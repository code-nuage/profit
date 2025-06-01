import ViewNavbar from '../Views/Navbar.js';
import ViewSidebar from '../Views/AccountSidebar.js';
import ViewSettings from '../Views/Settings.js';

import ModelRename from '../Models/Rename.js';
import ModelResetPassword from '../Models/ResetPassword.js';
import ModelLogout from '../Models/Logout.js';
import ModelDelete from '../Models/Delete.js';

export default class ControllerSettings {
    constructor() {
        this.body = document.body;
        this.body.innerHTML = `<header id="navbar"></header>
<header id="sidebar"></header>
<section id="settings"></section>
<div id="notifications"></div>`;
        this.section = document.querySelector('#settings');
        this.run();
    }

    async run() {
        await this.render();

        this.attachForms();
    }

    async render() {
        new ViewNavbar('#navbar');
        new ViewSidebar('#sidebar');
        const settings = new ViewSettings('#settings');
        await settings.ready;
    }

    attachForms() {
        const rename = document.querySelector('.rename');
        if (rename) {
            rename.addEventListener('submit', async (event) => {
                event.preventDefault();

                ModelRename(this);
            });
        }
        const resetPassword = document.querySelector('.reset-password');
        if (resetPassword) {
            resetPassword.addEventListener('submit', async (event) => {
                event.preventDefault();

                ModelResetPassword();
            });
        }
        const deleteUser = document.querySelector('.delete-user');
        if (deleteUser) {
            deleteUser.addEventListener('click', async (event) => {
                ModelDelete();
                ModelLogout();
            });
        }
    }
}
