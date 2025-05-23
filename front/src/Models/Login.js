import Config from "../config.js";

import ControllerNotification from "../Controllers/Notification";

export default async function() {
    const email = document.querySelector('#email').value;
    const password = document.querySelector('#password').value;

    const data = { email, password };

    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/login`, {
            method: 'POST',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const result = await response.text();

        if (response.ok) {
            new ControllerNotification("Connection", result, "accent", "light");

            setTimeout(() => {
                window.location.replace(window.location.origin + "/account");  // Redirection to account page
            }, 1000);
        } else {
            new ControllerNotification("Error", result, "negative", "light");
            console.log(result);
        }
    } catch(error) {
        new ControllerNotification("Server Error", "Can't connect to the backend server", "negative", "light");
    }
}