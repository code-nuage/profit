export default class Router {
    constructor(defaultController) {
        this.routes = {};
        this.setDefault(defaultController);
    }

    add(route, controller) {
        this.routes[route] = controller;
        return this;
    }

    setDefault(controller) {
        this.defaultController = controller;
    }

    resolve() {
        const path = window.location.pathname;
        const Controller = this.routes[path];
        if (Controller) {
            new Controller();
        } else {
            this.notFound();
        }
    }

    notFound() {
        new this.defaultController();
    }
}
