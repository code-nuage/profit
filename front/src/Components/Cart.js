import TemplateCart from '../Templates/Cart.html';

import IconCheckout from '../Assets/checkout.svg';

import '../Styles/Cart.scss';

export default `${TemplateCart}`.replace("{{IconCheckout}}", IconCheckout);