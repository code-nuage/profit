import TemplateHome from '../Templates/Home.html';

import IconProfit from '../Assets/profit.png';

import '../Styles/Home.scss';

export default `${TemplateHome}`.replace('{{IconProfit}}', IconProfit);