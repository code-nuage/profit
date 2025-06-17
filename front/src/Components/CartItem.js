import TemplateCartItem from '../Templates/CartItem.html';

import IconDelete from '../Assets/delete.svg';

import '../Styles/CartItem.scss';

export default `${TemplateCartItem}`
.replace("{{IconDelete}}", IconDelete)
.replace("{{Name}}", "Préservatif externe");