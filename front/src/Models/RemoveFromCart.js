import Config from '../config.js';

import ModelMe from './Me.js';

import ControllerNotification from '../Controllers/Notification.js';

export default async function(id) {
    const user = await ModelMe();

    const user_email = user.email;

    const data = {user_email}

    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/cart/product/${id}`, {
            method: 'DELETE',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const result = await response.text();

        if (response.ok) {
            new ControllerNotification('Cart', 'Product removed from cart', 'accent', 'light');

            setTimeout(() => {
                window.location.replace(window.location.origin + '/cart');     // Redirection to cart page
            }, 1000);
        } else {
            new ControllerNotification('Error', result, 'negative', 'light');
        }
    } catch(error) {
        console.log(error);
        new ControllerNotification('Server Error', 'Can\'t connect to the backend server', 'negative', 'light');
    }
}