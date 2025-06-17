import Config from '../config.js';

import ModelMe from './Me.js';

import ControllerNotification from '../Controllers/Notification.js';

export default async function() {
    try {
        const user = await ModelMe();

        const user_email = encodeURIComponent(user.email);
    
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/cart/${user_email}`, {
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