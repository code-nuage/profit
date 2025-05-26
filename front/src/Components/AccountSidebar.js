import TemplateSidebar from '../Templates/AccountSidebar.html';

import IconAccount from '../Assets/account.svg';
import IconBag from '../Assets/bag.svg'
import IconSettings from '../Assets/settings.svg';

import '../Styles/AccountSidebar.scss';

export default `${TemplateSidebar}`
.replace('{{IconAccount}}', IconAccount)
.replace('{{IconBag}}', IconBag)
.replace('{{IconSettings}}', IconSettings);
