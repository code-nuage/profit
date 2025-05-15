import NotificationView from '../Views/Notification';

const colors = {
    "primary": "pds-bg-color-primary",
    "secondary": "pds-bg-color-secondary",
    "tertiary": "pds-bg-color-tertiary",
    "positive": "pds-bg-color-positive",
    "negative": "pds-bg-color-negative",
    "accent": "pds-bg-color-accent",
    "light": "pds-bg-color-light",
    "dark": "pds-bg-color-dark",
}

export default class NotificationController {
    constructor(title, message, color) {
        this.app = document.querySelector('#app');
        this.title = title;
        this.message = message;
        this.color = colors[color];
        this.run();
    }

    run() {
        this.render();

        this.container = document.querySelector('#notification');

        this.close = this.container.querySelector("#close");

        this.close.addEventListener("click", (e) => {
            this.container.remove()
        })

        setTimeout(() => {
            if (this.container) {
                this.container.remove();
            }
        }, 5000);
    }

    render() {
        this.app.innerHTML += `
        ${NotificationView}
        `.replace("{{Title}}", this.title)
        .replace("{{Message}}", this.message)
        .replace("{{BackgroundColor}}", this.color);
    }
}