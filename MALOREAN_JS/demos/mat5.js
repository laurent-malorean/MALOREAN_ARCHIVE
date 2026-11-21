// MATHEMATICA 5 (MAT5.PAS, décembre 1993) : quartiques. Code Volpone, idées de Toto sur la manipulation des quartiques.
// Image(Q) = D2x·x² + D2y·y² + D1x·x + D1y·y + D0 calculé en Integer 16 bits (comme Turbo Pascal), résultat LongInt.
// Les produits de deux Image sont en 32 bits (Math.imul), puis « div » constante, puis Byte (& 255).
(function () {
  const i16 = x => (x << 16) >> 16;
  const img = (q, x, y) => i16(q[0] * x * x + q[1] * y * y + q[2] * x + q[3] * y + q[4]);   // q = [D2x, D2y, D1x, D1y, D0]
  const div = (a, b) => Math.trunc(a / b);
  const pal = (v, p) => v.putDac(p);
  // États des variables globales Q1, Q2, Q3 au moment où chaque procédure s'exécute (Q2.D1 et les D0 de Q2/Q3 ne sont
  // jamais affectés dans le source : ils restent à 0, car le source écrit Q3.D1 à la place de Q2.D1).
  function* quart1(v) {
    pal(v, PAL.DAC_TOTO.TOTO17); v.cls(0);
    const q1 = [1, 1, 1, 1, 5], q2 = [1, 1, 0, 0, 0];
    for (let x = 0; x <= 319; x++) {
      for (let y = 0; y <= 199; y++) v.mem[y * 320 + x] = div(Math.imul(img(q1, x, y), img(q2, x, y)), 10000) & 255;
      if (x % 4 === 3) yield;
    }
    yield 5000;
  }
  function* quart2(v) {
    pal(v, PAL.DAC_FRAC.BLUE); v.cls(0);
    const q1 = [1, 3, 0, 2, 5], q2 = [4, 3, 0, 0, 0], q3 = [8, -9, -7, -2, 0];
    for (let x = 0; x <= 159; x++) {
      for (let y = 0; y <= 99; y++) {
        const c = div(Math.imul(img(q1, x, y) + img(q2, x, y), img(q3, x, y)), 3000000) & 255;
        v.mem[(y + 100) * 320 + x + 160] = c; v.mem[(-y + 100) * 320 + x + 160] = c;
        v.mem[(y + 100) * 320 - x + 160] = c; v.mem[(-y + 100) * 320 - x + 160] = c;
      }
      if (x % 2 === 1) yield;
    }
    yield 5000;
  }
  function* quart3(v) {
    pal(v, PAL.DAC_FRAC.BLUE); v.cls(0);
    const q1 = [1, 3, 0, 0, -5], q2 = [-2, 5, 0, 0, 0];
    for (let x = 0; x <= 319; x++) {
      for (let y = 0; y <= 199; y++) v.mem[y * 320 + x] = div(Math.imul(img(q1, x, y), img(q2, x, y)), 10000000) & 255;
      if (x % 4 === 3) yield;
    }
    yield 5000;
  }
  function* quad1(v) {
    pal(v, PAL.DAC_TOTO.TOTO17); v.cls(0);
    const q1 = [1, 1, 1, 1, 5], q2 = [1, 1, 0, 0, 0];
    let c1x = 0, c2x = 0;
    for (let x = 0; x <= 319; x++) {
      c1x++; c2x++;                                   // C1.X, C2.X incrémentés à chaque colonne
      let c1y = 0, c2y = -100;                        // C1.Y, C2.Y remis à zéro / -100 à chaque colonne
      for (let y = 0; y <= 199; y++) {
        c1y++; c2y++;
        v.mem[y * 320 + x] = div(Math.imul(img(q1, c1x, c1y), img(q2, c2x, c2y)), 10000) & 255;
      }
      if (x % 4 === 3) yield;
    }
    yield 5000;
  }
  const credits = c => drawText(c, creditsOps('MATEMATICA 5', 'DECEMBER 1993',
    ['VOLPONE          : CODE ', 'TOTO             : Idea for some Images  '],
    ['PALETTES         : ALL PALETTES ARE RIPED FROM FRACTINT', 'PALETTES         :                     AND TOTO\'S CODE', 'SCREEN CAPTURE   : SHOOT 2 By PHAM CONG-DUC ']));
  sceneDemo({
    id: 'mat5', title: 'Mathematica 5', year: '1993',
    desc: 'Release décembre 1993 · code Volpone, idées de Toto sur les quartiques. Produits de polynômes du second degré en x et y, couleur = quotient modulo 256.',
    source: 'CODE/demosour/mat5/MAT5.PAS',
    scenes: [
      { name: 'Data.000', note: "LoadShoot('data.000') puis Delay(5000)", run: image('mat5', 'data.000') },
      { name: 'Quart_1', note: 'Palette Toto17. (Image(Q1)·Image(Q2)) div 10000.', run: quart1 },
      { name: 'Quart_2', note: 'Palette Blue, quart d\'écran recopié 4 fois. ((Image(Q1)+Image(Q2))·Image(Q3)) div 3 000 000.', run: quart2 },
      { name: 'Quart_3', note: 'Palette Blue. (Image(Q1)·Image(Q2)) div 10 000 000.', run: quart3 },
      { name: 'Quad_1', note: 'Palette Toto17. Même produit que Quart_1 avec des coordonnées décalées (C1, C2 incrémentées).', run: quad1 },
      { name: 'Data.001', note: 'Image', run: image('mat5', 'data.001') },
      { name: 'Crédits', note: 'Page_Credit : 250 ticks (≈ 14 s).', text: credits, run: function* () { yield 250 * TICK; } },
    ],
  });
})();
