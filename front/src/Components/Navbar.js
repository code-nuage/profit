import TemplateNavbar from '../Templates/Navbar.html';

import IconCart from '../Assets/cart.svg';
import IconAccount from '../Assets/account.svg';

import '../Styles/Navbar.scss';

export default `${TemplateNavbar}`
.replace('{{IconCart}}', IconCart)
.replace('{{IconAccount}}', IconAccount);
