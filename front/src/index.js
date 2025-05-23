import Router from './router.js';

import ControllerErrorNotFound from './Controllers/ErrorNotFound.js';

import ControllerHome from './Controllers/Home.js';
import ControllerLogin from './Controllers/Login.js';
import ControllerAccount from './Controllers/Account.js';

import './Profit-Design-System.scss'

const router = new Router();
router.setDefault(ControllerErrorNotFound)

router.add('/', ControllerHome)                                                // I just love chained method don't mind
.add('/login', ControllerLogin)
.add('/account', ControllerAccount);

router.resolve();