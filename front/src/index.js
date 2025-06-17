import Router from './router.js';

import ControllerErrorNotFound from './Controllers/ErrorNotFound.js';

import ControllerHome from './Controllers/Home.js';
import ControllerRegister from './Controllers/Register.js';
import ControllerLogin from './Controllers/Login.js';
import ControllerAccount from './Controllers/Account.js';
import ControllerSettings from './Controllers/Settings.js';
// import ControllerCommands from './Controllers/Commands.js';
import ControllerExternal from './Controllers/External.js';
import ControllerCart from './Controllers/Cart.js';

import Favicon from './favicon.ico';

import './Profit-Design-System.scss';

const router = new Router();
router.setIcon(Favicon).setDefault(ControllerErrorNotFound)                    // I just love chained method don't mind
.add('/', ControllerHome)
.add('/register', ControllerRegister)
.add('/login', ControllerLogin)
.add('/account', ControllerAccount)
.add('/account-settings', ControllerSettings)
// .add('/account-commands', ControllerCommands);
.add('/external', ControllerExternal)
.add('/cart', ControllerCart)
.resolve();
