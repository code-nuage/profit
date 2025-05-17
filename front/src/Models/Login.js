import Config from "../config.js";

// import NotificationController from "../Controllers/Notification";

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

        const result = await response.json();

        if (response.ok) {
            // new NotificationController("Connection", result.message, "accent");
            console.log(result);

            window.location.redirect(window.location.origin + "/account");      // Redirection to account page
        } else {
            // new NotificationController("Error", result.error, "negative");
            console.log(result);
        }
    } catch(error) {
        // new NotificationController("Server Error", "Can't connect to the backend server", "negative");
        console.log(error);
    }
}