import TemplateButton from '../Templates/Button.html';

export default (text, id, backgroundColor, textColor) => {
    return `${TemplateButton}`
    .replace("{{Text}}", text)
    .replace("{{Id}}", id)
    .replace("{{ColorBackground}}", backgroundColor)
    .replace("{{ColorText}}", textColor)
}