import TemplateNavbar from '../Templates/Navbar.html';

import IconAccount from '../Assets/account.svg';

import '../Styles/Navbar.scss';

export default `${TemplateNavbar}`.replace('{{IconAccount}}', IconAccount);
