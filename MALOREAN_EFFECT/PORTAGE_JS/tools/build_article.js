// Génère data/article.js (HTML de l'article docs/math/mathematiques-des-demos.md, formules KaTeX en MathML, images en base64).
// Usage : NODE_PATH=<dossier de node_modules avec marked et katex> node tools/build_article.js
const fs = require('fs'), path = require('path'), katex = require('katex'), { marked } = require('marked');
const root = path.join(__dirname, '..', '..', 'docs', 'math');
let md = fs.readFileSync(path.join(root, 'mathematiques-des-demos.md'), 'utf8');
const store = [], keep = h => '\u0001' + (store.push(h) - 1) + '\u0002';
const tex = (s, display) => keep(katex.renderToString(s, { displayMode: display, output: 'mathml', throwOnError: false }));
// code protégé, puis formules, dans le texte hors code
md = md.split(/(```[\s\S]*?```|`[^`\n]*`)/).map((seg, i) => i % 2 ? seg : seg
  .replace(/\$\$([\s\S]+?)\$\$/g, (_, f) => tex(f, true)).replace(/\$([^$\n]+?)\$/g, (_, f) => tex(f, false))).join('');
const slug = t => t.toLowerCase().replace(/<[^>]+>/g, '').replace(/[^\p{L}\p{N}\s-]/gu, '').trim().replace(/\s/g, '-');
const r = new marked.Renderer();
r.heading = (text, level) => `<h${level} id="${slug(text)}">${text}</h${level}>`;
let html = marked.parse(md, { renderer: r, gfm: true });
html = html.replace(/\u0001(\d+)\u0002/g, (_, i) => store[+i]).replace(/<img src="img\/([^"]+)"/g, (_, f) =>
  `<img src="data:image/png;base64,${fs.readFileSync(path.join(root, 'img', f)).toString('base64')}" loading="lazy"`);
fs.writeFileSync(path.join(__dirname, '..', 'data', 'article.js'), '// Article « Les mathématiques derrière les démos » (HTML généré par tools/build_article.js)\nwindow.ARTICLE_HTML = ' + JSON.stringify(html) + ';\n');
console.log(html.length, 'octets', (html.match(/<math/g) || []).length, 'formules');
