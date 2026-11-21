// Page de documentation : l'article docs/math/mathematiques-des-demos.md (formules et images comprises).
DEMOS.push({
  id: 'maths', title: 'Mathématiques dans Malorean', year: 'article', group: 'doc',
  desc: 'Les principes mathématiques des démos : symétrie à huit, arithmétique entière, fractales en virgule fixe, quartiques, congruences, rotation de palette, 3D.',
  source: 'docs/math/mathematiques-des-demos.md',
  mount(el) {
    el.innerHTML = '<article class="doc">' + ARTICLE_HTML + '</article>';
    el.querySelectorAll('a[href^="#"]').forEach(a => a.addEventListener('click', e => {
      e.preventDefault(); const t = el.querySelector('#' + CSS.escape(decodeURIComponent(a.getAttribute('href').slice(1)))); if (t) t.scrollIntoView({ behavior: 'smooth' });
    }));
  }
});
