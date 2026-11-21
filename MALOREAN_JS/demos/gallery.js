// Galerie des images SHOOT (320x200, 256 couleurs) retrouvées dans les archives : data/gallery.js (vignettes 160x100).
// Les PNG pleine taille sont dans le dossier images/ (liens valables en local).
DEMOS.push({
  id: 'galerie', title: 'Galerie d\'images', year: '1992–95', group: 'outil',
  desc: GALLERY.length + ' images uniques décodées depuis les fichiers DATA.xxx, MALODATA et .BIT : logos, fractales et séries de rosaces.',
  source: 'DATA.000… · ALL_OVER/*.BIT · CODE/SOURCE/BIT',
  mount(el) {
    const short = n => n.replace(/\.png$/, '').replace(/^(CODE__SOURCE__|CODE__demosour__|DEMO__)/, '').replace(/__/g, ' / ').replace(/_/g, ' ');
    el.innerHTML = `
      <div class="bar"><input id="gq" type="search" placeholder="Filtrer par nom (ex. mat6, kashmir, MALOREAN)" aria-label="Filtrer"><span class="rv" id="gn" style="width:auto"></span></div>
      <div class="grid" id="gg"></div>
      <div class="modal" id="gm" hidden><div class="mbox"><canvas id="gmc" width="320" height="200" class="px"></canvas><p id="gmt"></p><p class="hint"><a id="gml" target="_blank" rel="noopener">PNG pleine taille</a> (fichier local) · clic pour fermer</p></div></div>`;
    const $ = id => el.querySelector('#' + id), g = $('gg'), modal = $('gm');
    const render = q => {
      const list = GALLERY.filter(([n]) => n.toLowerCase().includes(q.toLowerCase()));
      $('gn').textContent = list.length + ' / ' + GALLERY.length;
      g.innerHTML = list.map(([n, b]) => `<button class="th" data-n="${n}" title="${short(n)}"><img loading="lazy" src="data:image/png;base64,${b}" alt="${short(n)}" width="160" height="100"><span>${short(n)}</span></button>`).join('');
    };
    g.onclick = e => {
      const t = e.target.closest('.th'); if (!t) return;
      const img = t.querySelector('img'), cx = $('gmc').getContext('2d'); cx.imageSmoothingEnabled = false; cx.drawImage(img, 0, 0, 320, 200);
      $('gmt').textContent = short(t.dataset.n); $('gml').href = 'images/' + t.dataset.n; modal.hidden = false;
    };
    modal.onclick = e => { if (e.target.id !== 'gml') modal.hidden = true; };
    $('gq').oninput = e => render(e.target.value);
    render('');
  }
});
