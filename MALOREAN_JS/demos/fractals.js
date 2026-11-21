// Galerie des 116 fractales GIF de malorean effect/MALOREAN/Image/FRACTAL (vignettes intégrées ; pleine taille dans images/fractal/ en local).
DEMOS.push({
  id: 'fractales', title: 'Galerie de fractales', year: '1992–94', group: 'outil',
  desc: FRACTALS.length + ' images GIF de fractales (Mandelbrot, Julia, rosaces) générées par les programmes de l\'archive.',
  source: 'malorean effect/MALOREAN/Image/FRACTAL/*.GIF',
  mount(el) {
    el.innerHTML = `<div class="bar"><input id="fq" type="search" placeholder="Filtrer (ex. FRAC1, EMSIN)" aria-label="Filtrer"><span class="rv" id="fn" style="width:auto"></span></div>
      <div class="grid" id="fg"></div>
      <div class="modal" id="fm" hidden><div class="mbox"><img id="fi" alt="" style="max-width:100%;max-height:80vh;display:block;border:1px solid var(--line)"><p id="ft"></p></div></div>`;
    const $ = id => el.querySelector('#' + id), g = $('fg'), modal = $('fm');
    const render = q => {
      const list = FRACTALS.filter(([n]) => n.toLowerCase().includes(q.toLowerCase()));
      $('fn').textContent = list.length + ' / ' + FRACTALS.length;
      g.innerHTML = list.map(([n, w, h, b]) => `<button class="th" data-n="${n}" title="${n} (${w}×${h})"><img loading="lazy" src="data:image/png;base64,${b}" alt="${n}"><span>${n.replace('.png', '')} · ${w}×${h}</span></button>`).join('');
    };
    g.onclick = e => {
      const t = e.target.closest('.th'); if (!t) return;
      const img = t.querySelector('img'), fi = $('fi'), n = t.dataset.n;
      fi.onerror = () => { fi.onerror = null; fi.src = img.src; fi.style.imageRendering = 'pixelated'; fi.style.width = '640px'; };
      fi.style.imageRendering = ''; fi.style.width = ''; fi.src = 'images/fractal/' + n; $('ft').textContent = n.replace('.png', '.GIF'); modal.hidden = false;
    };
    modal.onclick = () => { modal.hidden = true; };
    $('fq').oninput = e => render(e.target.value);
    render('');
  }
});
