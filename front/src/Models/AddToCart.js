import Config from '../config.js';

import ModelMe from './Me.js';

import ControllerNotification from '../Controllers/Notification.js';

export default async function() {
    const user = await ModelMe();

    const user_email = user.email;

    const diameter = document.querySelector("select#diameter").value;
    const taste = document.querySelector("select#taste").value;
    const texture = document.querySelector("select#texture").value;
    const matter = document.querySelector("select#matter").value;
    const color = document.querySelector("select#color").value;
    const lubricant = document.querySelector("select#lubricant").value;

    const customs = { diameter, taste, texture, matter, color, lubricant};

    const data = {product: {customs}, user_email}

    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/cart/product`, {
            method: 'POST',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const result = await response.json();

        if (response.ok) {
            new ControllerNotification('Cart', 'Product added to cart', 'accent', 'light');

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