export default class Router {
    constructor(defaultController, icon) {
        this.routes = {};
        this.setDefault(defaultController);
        this.setIcon(icon);
    }

    add(route, controller) {
        this.routes[route] = controller;
        return this;
    }

    setDefault(controller) {
        this.defaultController = controller;
        return this;
    }

    setIcon(path) {
        this.icon = path;
        return this;
    }

    resolve() {
        const path = window.location.pathname;
        const Controller = this.routes[path];
        if (Controller) {
            new Controller();
            if (this.icon) {                                                   // Set an icon
                document.querySelector('head').innerHTML += `<link rel="icon" type="image/x-icon" href="${this.icon}">`; // Can't get Webpack applying icon so doing it with pure JS
            }
        } else {
            this.notFound();
        }
    }

    notFound() {
        new this.defaultController();
    }
}
