import Config from '../config.js';

import ControllerNotification from '../Controllers/Notification';

export default async function() {
    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/delete`, {
            method: 'DELETE',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        const result = await response.text();

        if (response.ok) {
            new ControllerNotification('Delete', 'Account deleted', 'accent', 'light');

            setTimeout(() => {
                window.location.replace(window.location.origin + '/login');    // Redirection to login page
            }, 1000);
        } else {
            new ControllerNotification('Error', error, 'negative', 'light');
        }
    } catch(error) {
        new ControllerNotification('Server Error', 'Can\'t connect to the backend server', 'negative', 'light');
        console.log(error)
    }
}