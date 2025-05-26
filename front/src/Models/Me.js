import Config from '../config.js';

export default async function() {
    try {
        const response = await fetch(`http://${Config.backend.ip}:${Config.backend.port}/me`, {
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
            console.log(result);
            return false;
        }
    } catch(error) {
        console.log(error);
        return false;
    }
}