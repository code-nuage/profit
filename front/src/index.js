import Router from './router.js';

import ControllerErrorNotFound from './Controllers/ErrorNotFound.js';

import ControllerHome from './Controllers/Home.js';
// import ControllerLogin from './Controllers/Login.js';

import './Profit-Design-System.scss'

const router = new Router();
router.setDefault(ControllerErrorNotFound)

router.add('/', ControllerHome);

router.resolve();