import Config from '../config.js';

import ControllerNotification from '../Controllers/Notification';

export default async function() {
    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/customs`, {
            method: 'GET',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        const result = await response.json();

        if (response.ok) {
            return result;
        } else {
            new ControllerNotification('Error', error, 'negative', 'light');
        }
    } catch(error) {
        new ControllerNotification('Server Error', 'Can\'t connect to the backend server', 'negative', 'light');
    }
}