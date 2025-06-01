import TemplateErrorNotFound from '../Templates/ErrorNotFound.html';

import IconProfit from '../Assets/profit.png';

import '../Styles/ErrorNotFound.scss';

export default `${TemplateErrorNotFound}`.replace('{{IconProfit}}', IconProfit);