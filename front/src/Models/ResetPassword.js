import Config from '../config.js';

import ControllerNotification from '../Controllers/Notification';

export default async function() {
    const password = document.querySelector('#password').value;
    const passwordConfirm = document.querySelector('#password-confirm').value;

    const data = { password, passwordConfirm };

    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/resetpassword`, {
            method: 'PATCH',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const result = await response.json();

        if (response.ok) {
            new ControllerNotification('Password', 'Password reset', 'accent', 'light');

            setTimeout(() => {
                window.location.replace(window.location.origin + '/account-settings');  // Redirection to settings page
            }, 1000);
        } else {
            new ControllerNotification('Error', result, 'negative', 'light');
        }
    } catch(error) {
        new ControllerNotification('Server Error', 'Can\'t connect to the backend server', 'negative', 'light');
    }
}