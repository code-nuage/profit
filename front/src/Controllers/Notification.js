import ViewNotification from '../Views/Notification';

export default class NotificationController {
    constructor(title, message, backgroundColor, textColor) {
        this.container = document.querySelector('#notifications');
        this.title = title;
        this.message = message;
        this.backgroundColor = backgroundColor;
        this.textColor = textColor;
        this.run();
    }

    run() {
        this.render();

        this.notification = document.querySelector('#notification');

        this.close = this.notification.querySelector("#close");

        this.container.classList.add('displayed');

        this.close.addEventListener("click", (e) => {
            this.notification.remove();
            this.notification = null;
            this.container.classList.remove("displayed");
        })

        setTimeout(() => {
            if (this.notification) {
                this.notification.remove();
                this.container.classList.remove('displayed');
            }
        }, 5000);
    }

    render() {
        new ViewNotification('#notifications', this.title, this.message, this.backgroundColor, this.textColor);
    }
}