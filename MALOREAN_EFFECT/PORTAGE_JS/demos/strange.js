// STRANGE : les programmes CARLE*.PAS (juillet 1993) et les formules de STRANGE.DOC.
// Pour chaque image c (0..1000) et chaque point (f,g) du huitième d'écran (g >= f, 0..99) :
//     cou := formule(x=f, y=g, z=c)    -> octet (modulo 256) = indice de couleur, recopié par symétrie à 8.
// Les opérandes de Mod/Div sont pris en Word 16 bits comme en Turbo Pascal ; Mod ou Div par zéro donnent 0.
// Priorités du Pascal : and, *, div, mod, shl sont au même niveau (de gauche à droite), plus fort que + - or xor.
// Ainsi « (x-y)(y-z)(z-x) And x*y+z » se lit ((((x-y)(y-z)(z-x)) And x) * y) + z.
(function () {
  const m = (a, b) => { a &= 0xFFFF; b &= 0xFFFF; return b ? a % b : 0; };
  const d = (a, b) => { a &= 0xFFFF; b &= 0xFFFF; return b ? Math.trunc(a / b) : 0; };
  const F = [
    ['(x+y-z) Or z*x*y', 'Volcano', (x, y, z) => (x + y - z) | (z * x * y)],
    ['(x-y)(y-z)(z-x) And x+y*z', 'Blue', (x, y, z) => ((((x - y) * (y - z) * (z - x)) & x) + y * z)],
    ['(x-y)(y-z)(z-x) Xor x-y', 'Volcano', (x, y, z) => ((((x - y) * (y - z) * (z - x)) ^ x) - y)],
    ['(x+y+y)*(x+x+y+z+z+z)', 'Volcano', (x, y, z) => (x + y + y) * (x + x + y + z + z + z)],
    ['(x*y*z) And z', 'Volcano', (x, y, z) => (x * y * z) & z],
    ['(x-y)*(y-z)*(z-x) And x*y+z', 'Blue', (x, y, z) => ((((x - y) * (y - z) * (z - x)) & x) * y + z)],
    ['(x-y)*(y-z)*(z-x) And x*z+y*z', 'Blue', (x, y, z) => ((((x - y) * (y - z) * (z - x)) & x) * z + y * z)],
    ['(x-y)*(y-z)*(z-x) And y*z+x', 'Blue', (x, y, z) => ((((x - y) * (y - z) * (z - x)) & y) * z + x)],
    ['z+(z-x)*y', 'Volcano', (x, y, z) => z + (z - x) * y],
    ['y*(z-x)+x*z', 'Volcano', (x, y, z) => y * (z - x) + x * z],
    ['z*z+y*(z-x)', 'Blue', (x, y, z) => z * z + y * (z - x)],
    ['z*z*z+y*(z-x)', 'Blue', (x, y, z) => z * z * z + y * (z - x)],
    ['x(z-y)', 'Blue', (x, y, z) => x * (z - y)],
    ['x*y*z', 'Blue', (x, y, z) => x * y * z],
    ['[x*(z-y)] And x*y', 'Blue', (x, y, z) => (((x * (z - y)) & x) * y)],
    ['[x*(z-y)] Or x*y', 'Blue', (x, y, z) => (x * (z - y)) | (x * y)],
    ['[x*(z-y)] Div (x+y+1)', 'Blue', (x, y, z) => d(x * (z - y), x + y + 1)],
    ['[x*(z-y)] Mod (x+y+1)', 'Blue', (x, y, z) => m(x * (z - y), x + y + 1)],
    ['[x And (z-y)] Mod (x*y+1)', 'Blue', (x, y, z) => m(x & (z - y), x * y + 1)],
    ['[x And (z Mod y)]', 'Blue', (x, y, z) => x & m(z, y)],
    ['(x+y+y) Mod (1+x+x+y+z+z+z)*z', 'Blue', (x, y, z) => m(x + y + y, 1 + x + x + y + z + z + z) * z],
    ['(x+y+y) And (1+x+x+y+z+z+z)', 'Volcano', (x, y, z) => (x + y + y) & (1 + x + x + y + z + z + z)],
    ['(x+y+y+y) And (1+x+x+y+z)', 'Volcano', (x, y, z) => (x + y + y + y) & (1 + x + x + y + z)],
    ['(x+y+y+y) And (x+x+y+z Shl 2)', 'Volcano', (x, y, z) => (x + y + y + y) & (x + x + y + (z << 2))],
    ['(x+y+y+y)*(x+x+y+z)', 'Volcano', (x, y, z) => (x + y + y + y) * (x + x + y + z)],
    ['(x*y mod z) Mod [(x+y Mod y)+1]', 'Volcano', (x, y, z) => m(m(x * y, z), x + m(y, y) + 1)],
    ['(z Mod x)*(z Mod y)', 'Volcano', (x, y, z) => m(z, x) * m(z, y)],
    ['x And y Mod z', 'Volcano', (x, y, z) => m(x & y, z)],
    ['z-x*y', 'Volcano', (x, y, z) => z - x * y],
    ['(z-x*y)+(y-z*x)+(x-y*z)', 'Volcano', (x, y, z) => (z - x * y) + (y - z * x) + (x - y * z)],
    ['(z-x*y) And (y-z*x) And (x-y*z)', 'Volcano', (x, y, z) => (z - x * y) & (y - z * x) & (x - y * z)],
    ['(x-y) And z Mod y', 'Blue', (x, y, z) => m((x - y) & z, y)],
    ['(x-y)*z', 'Blue', (x, y, z) => (x - y) * z],
    ['(x-y*z)*y*y', 'Blue', (x, y, z) => (x - y * z) * y * y],
    ['(x-y*z)*z', 'Blue', (x, y, z) => (x - y * z) * z],
    ['(x-z)*y*y', 'Blue', (x, y, z) => (x - z) * y * y],
    ['(x+y+y) Or (1+x+x+y+z+z+z)', 'Blue', (x, y, z) => (x + y + y) | (1 + x + x + y + z + z + z)],
    ['(x-y) And (y-x) And (x-z) Or (y-z)', 'Blue', (x, y, z) => ((x - y) & (y - x) & (x - z)) | (y - z)],
  ];
  DEMOS.push({
    id: 'strange', title: 'Strange', year: '1993', group: 'demo',
    desc: 'Formules entières f(x,y,z) calculées pour chaque pixel, avec z comme numéro d\'image. Écran VGA 320×200 en symétrie à 8.',
    source: 'CODE hors demo/STRANGE/CARLE*.PAS · docs/STRANGE_formules.pdf',
    mount(el) {
      el.innerHTML = `
        <div class="screen"><canvas id="stc" width="320" height="200" class="px"></canvas></div>
        <div class="bar">
          <button id="stp">⏸ Pause</button>
          <select id="stf" aria-label="Formule"></select>
        </div>
        <div class="bar">
          <label>Palette <select id="stpal"><option value="auto">celle du fichier</option><option>Volcano</option><option>Blue</option></select></label>
          <label>Vitesse <input type="range" id="sts" min="2" max="60" value="20"><span id="stsv" class="rv">20 /s</span></label>
          <label>Image z <input type="range" id="stz" min="0" max="1000" value="0"><span id="stzv" class="rv">0</span></label>
        </div>
        <div class="info"><b id="stn"></b><p>cou := formule(f, g, c) and 255, pour g ≥ f entre 0 et 99, recopié 8 fois par symétrie. Le « z-f » de STRANGE.DOC est lu « z-x ».</p></div>`;
      const $ = id => el.querySelector('#' + id), sel = $('stf'), vga = new VGA($('stc')), mem = vga.mem, sym = MALO.sym;
      F.forEach((f, i) => sel.add(new Option(String(i + 1).padStart(2, '0') + ' · ' + f[0] + ' (' + f[1] + ')', i)));
      sel.value = 22;   // CARLE22 : (f+g+g+g) and (1+f+f+g+c)
      let z = 0, paused = false, acc = 0, last = performance.now(), raf = 0;
      const pal = () => { const p = $('stpal').value; vga.putDac(PALETTES[(p === 'auto' ? F[+sel.value][1] : p).toUpperCase()]); $('stn').textContent = 'f(x,y,z) = ' + F[+sel.value][0]; };
      const draw = () => {
        const f = F[+sel.value][2];
        mem.fill(0);
        for (let a = 0; a <= 99; a++) for (let b = a; b <= 99; b++) sym(mem, a, b, f(a, b, z) & 255);
        $('stzv').textContent = z; $('stz').value = z;
      };
      const frame = t => {
        const dt = Math.min(100, t - last); last = t;
        if (!paused) { acc += dt * $('sts').value / 1000; if (acc >= 1) { z = (z + Math.floor(acc)) % 1001; acc %= 1; draw(); } }
        vga.present(); raf = requestAnimationFrame(frame);
      };
      sel.onchange = () => { pal(); draw(); }; $('stpal').onchange = pal;
      $('stz').oninput = e => { z = +e.target.value; draw(); };
      $('sts').oninput = e => $('stsv').textContent = e.target.value + ' /s';
      $('stp').onclick = () => { paused = !paused; $('stp').textContent = paused ? '▶ Lecture' : '⏸ Pause'; };
      pal(); draw(); raf = requestAnimationFrame(frame);
      return () => cancelAnimationFrame(raf);
    }
  });
})();
