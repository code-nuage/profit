import TemplateNotification from '../Templates/Notification.html';

import IconNotification from '../Assets/notification.svg';
import IconClose from '../Assets/close.svg';

import '../Styles/Notification.scss';

export default `${TemplateNotification}`
.replace('{{IconNotification}}', IconNotification)
.replace('{{IconClose}}', IconClose);
