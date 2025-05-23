import Config from "../config.js";

// import NotificationController from "../Controllers/Notification";

export default async function() {
    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/logout`, {
            method: 'POST',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
        });

        const result = await response.text();

        if (response.ok) {
            // new NotificationController("Connection", result.message, "accent");
            console.log(result);

            window.location.replace(window.location.origin);                   // Redirection to home page
        } else {
            // new NotificationController("Error", result.error, "negative");
            console.log(result);
        }
    } catch(error) {
        // new NotificationController("Server Error", "Can't connect to the backend server", "negative");
        console.log(error);
    }
}