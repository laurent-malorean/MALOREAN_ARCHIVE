// MAT6.PAS (mai 1994) : images, effets « Marc » et rotation de palette (IncDac256), avec REDHOUSE.MOD au tracker.
// La musique n'est pas reproduite. Arithmétique Word 16 bits comme en Turbo Pascal ; PULSE = tick BIOS à 18,2 Hz (TICK).
(function () {
  const w = x => x & 0xFFFF;
  const PAL4 = () => PAL.DAC_FRAC.PAL4;

  // MARC_3 : cou := X*X and y*y   (and et * ont la même priorité en Pascal : ((X*X) and y) * y)
  function* marc3(v) {
    v.putDac(PAL4());
    for (let x = 1; x <= 319; x++) {
      for (let y = 1; y <= 199; y++) v.mem[y * 320 + x] = w(w(w(x * x) & y) * y) & 255;
      if (x % 8 === 0) yield;
    }
    yield 2500;
  }
  // MARC_9 : cou := ((x+z) and (y+z)) xor (x or y), z de 1 à 60
  function* marc9(v) {
    v.putDac(PAL4());
    for (let z = 1; z <= 60; z++) {
      for (let x = 1; x <= 319; x++) for (let y = 1; y <= 199; y++) v.mem[y * 320 + x] = (((x + z) & (y + z)) ^ (x | y)) & 255;
      yield;
    }
  }
  // MARC_10 : dans la boucle « for Z:=1 to 600 » le source fait z:=z+3, d'où z = 4, 8, … 600 (150 images), à chaque image
  // attente du retour vertical. Carre n'est rempli que jusqu'à 350 alors que z monte à 600 : ici Carre[n] = n*n partout.
  function* marc10(v) {
    v.putDac(PAL4());
    const carre = []; for (let n = 0; n <= 600; n++) carre[n] = w(n * n);
    for (let z = 4; z <= 600; z += 4) {
      for (let y = 1; y <= 150; y++) {
        const cst1 = w(carre[z] + carre[y] - y), o = y * 320;
        for (let x = 1; x <= 150; x++) v.mem[o + x] = Math.trunc(w(cst1 + carre[x] + x) / (x + y + 1)) & 255;
      }
      yield;
    }
    yield 2000;
  }
  // IncDac256 : l'entrée 0 reste, les entrées 1..255 tournent d'un cran ; n = nombre de ticks d'attente (0 = aucune).
  function rotate(p) {
    const o = p.slice();
    for (let f = 2; f <= 255; f++) for (let k = 0; k < 3; k++) p[f * 3 + k] = o[(f - 1) * 3 + k];
    for (let k = 0; k < 3; k++) p[3 + k] = o[255 * 3 + k];
  }
  function* cycle(v) {
    const p = PAL4().slice();                         // move(dac_frac.pal4, pal1, 3*256)
    const inc = n => { rotate(p); v.putDac(p); return n; };
    for (let g = 0; g <= 100; g++) yield inc(1) * TICK;
    for (let g = 0; g <= 40; g++) { inc(0); yield inc(1) * TICK; }
    for (let g = 0; g <= 80; g++) { inc(0); yield inc(1) * TICK; inc(0); }
    for (let g = 0; g <= 80; g++) { inc(0); inc(0); yield inc(1) * TICK; inc(0); inc(0); }
  }
  sceneDemo({
    music: 'redhouse',
    id: 'mat6', title: 'Mathematica 6', year: '1994',
    desc: 'Release mai 1994 · code Volpone (code et musique), Askchaga (code), Toto (gfx). Images, effets « Marc » en arithmétique entière et rotation de palette. Musique : REDHOUSE.MOD (bouton ♪).',
    source: 'CODE/demosour/mat6/MAT6.PAS',
    scenes: [
      { name: 'Data.005', note: 'Image, attente de 100 ticks (≈ 5,5 s).', run: function* (v) { v.loadImage('mat6', 'data.005'); yield 100 * TICK; } },
      { name: 'Data.000', note: 'Image, Delay(4000).', run: image('mat6', 'data.000', 4000) },
      { name: 'Marc_3', note: 'Palette Pal4 · cou := X*X and y*y', run: marc3 },
      { name: 'Data.001', note: 'Image, Delay(4000).', run: image('mat6', 'data.001', 4000) },
      { name: 'Data.002 · palette qui tourne', note: 'L\'image garde ses pixels, mais la palette Pal4 est décalée à chaque IncDac256, de plus en plus vite.',
        run: function* (v) { v.loadImage('mat6', 'data.002'); yield 2800; yield* cycle(v); } },
      { name: 'Data.003 · Marc_10', note: 'Image, Delay(3000), puis (cst1 + x² + x) div (x+y+1) pour z = 4, 8… 600.',
        run: function* (v) { v.loadImage('mat6', 'data.003'); yield 3000; yield* marc10(v); } },
      { name: 'Data.004 · palette · Marc_9', note: 'Image à palette tournante, puis ((x+z) and (y+z)) xor (x or y).',
        run: function* (v) { v.loadImage('mat6', 'data.004'); yield 2800; yield* cycle(v); yield* marc9(v); } },
      { name: 'Data.006', note: 'Image finale, attente de 250 ticks (≈ 14 s).', run: function* (v) { v.loadImage('mat6', 'data.006'); yield 250 * TICK; } },
    ],
  });
})();
