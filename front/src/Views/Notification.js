import ComponentNotification from '../Components/Notification.js';

export default class ViewAccount {
    constructor(query, title, message, backgroundColor, textColor) {
        this.query = document.querySelector(query);

        this.title = title;
        this.message = message;
        this.backgroundColor = backgroundColor;
        this.textColor = textColor;

        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.query.innerHTML = `${ComponentNotification}`
        .replace('{{Title}}', this.title)
        .replace('{{Message}}', this.message)
        .replace('{{BackgroundColor}}', 'pds-background-' + this.backgroundColor)
        .replaceAll('{{TextColor}}', 'pds-text-' + this.textColor);
    }
}