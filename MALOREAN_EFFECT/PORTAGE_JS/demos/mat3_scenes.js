(function () {
// MATHEMATICA 3 — Malorean Effect, release novembre 1993. Code d'origine : Volpone (code), Toto (gfx), Sally (musique).
// Port JavaScript de MAT3.PAS. Chaque procédure Pascal devient un générateur :
//   `yield`        = une étape d'animation (réglable avec le curseur de vitesse)
//   `yield 2000`   = Delay(2000), en millisecondes réelles
// Les arithmétiques 16 bits de Turbo Pascal (Word) sont reproduites avec & 0xFFFF,
// les affectations vers un Byte avec & 255, et ROUND arrondit « loin de zéro » comme en Pascal.

const P = window.PALETTES, SHOOT = window.SHOOT;
const V = 32160;                                   // V : ARRAY ... ABSOLUTE $A000:32160  (= centre de l'écran, 100*320+160)
const pround = x => x < 0 ? -Math.round(-x) : Math.round(x);
const w16 = x => x & 0xFFFF;

// Les 8 écritures symétriques utilisées partout (ordre identique au Pascal)
function sym(mem, xe, ye, c) {
  const a = ye * 320, b = xe * 320;
  mem[V + a + xe] = c; mem[V + b + ye] = c;
  mem[V - a + xe] = c; mem[V - b + ye] = c;
  mem[V - a - xe] = c; mem[V - b - ye] = c;
  mem[V + a - xe] = c; mem[V + b - ye] = c;
}
const somme = () => { const s = new Array(321); s[0] = 0; for (let i = 1; i <= 320; i++) s[i] = s[i - 1] + i; return s; };

// ---------------------------------------------------------------- Procedure Pasm  {extrait du répertoire flower}
function* pasm(vga) {
  const m = vga.mem; vga.putDac(P.PAL4);
  const x2 = [], t1 = new Uint16Array(10000), t2 = new Uint16Array(10000);
  for (let xe = 0; xe <= 99; xe++) x2[xe] = 1 + Math.floor(300 * xe / 99);
  for (let xe = 0; xe <= 99; xe++) for (let ye = xe; ye <= 99; ye++) {
    t1[xe * 100 + ye] = 2 * (x2[xe] + x2[ye]);
    t2[xe * 100 + ye] = w16(x2[xe] * x2[xe] + x2[ye] * x2[ye]);
  }
  for (let x = 1; x <= 300; x++) {
    for (let xe = 0; xe <= 99; xe++) for (let ye = xe; ye <= 99; ye++) {
      const d = t2[xe * 100 + ye];
      sym(m, xe, ye, d ? Math.trunc(w16(t1[xe * 100 + ye] * x) / d) & 255 : 0);
    }
    yield;
  }
}
// ---------------------------------------------------------------- Procedure moy_3  {provient du répertoire moyenne}
function* moy3(vga) {
  const m = vga.mem, S = somme(); vga.putDac(P.BLUE);
  for (let x = 1; x <= 200; x++) {
    for (let xe = 1; xe <= 99; xe++) for (let ye = xe; ye <= 99; ye++) sym(m, xe, ye, w16(S[xe + ye] + S[xe + x]) & 255);
    yield;
  }
}
function* moy4(vga) {
  const m = vga.mem, S = somme(); vga.putDac(P.BLUE);
  for (let x = 1; x <= 100; x++) {
    for (let xe = 1; xe <= 99; xe++) for (let ye = xe; ye <= 99; ye++) sym(m, xe, ye, Math.trunc(w16(x * S[xe + ye]) / (3 * S[xe])) & 255);
    yield;
  }
}
// ---------------------------------------------------------------- RAC_3 / RAC_4
function* rac3(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  for (let xe = 1; xe <= 99; xe++) for (let ye = 1; ye <= xe; ye++) {
    const s = Math.sqrt(xe * xe + ye * ye);
    sym(m, xe, ye, pround(20 * Math.sqrt(s - xe) + 20 * Math.sqrt(s + xe)) & 255);
  }
  yield;
}
function* rac4(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  for (let xe = 1; xe <= 99; xe++) for (let ye = 1; ye <= xe; ye++) {
    const s = Math.sqrt(xe * xe + ye * ye);
    sym(m, xe, ye, pround(100 * (s + xe) / ye) & 255);
  }
  yield;
}
// ---------------------------------------------------------------- POLY8 / POLY10 / OLY14  {répertoire SH_CH}
function* poly8(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  const amin = -20, amax = 20, bmin = -20, bmax = 20, pasX = (amax - amin) / 320, pasY = (bmax - bmin) / 199;
  const sinX = [], cosY = [];
  for (let xe = 0; xe < 320; xe++) { const px = amin + pasX * (xe + 1); sinX[xe] = 50 * px * px * px; }
  for (let ye = 0; ye < 200; ye++) { const py = bmin + pasY * (ye + 1); cosY[ye] = 50 * py * py * py; }
  for (let xe = 0; xe < 320; xe++) {
    for (let ye = 0; ye < 200; ye++) m[ye * 320 + xe] = Math.trunc(pround(sinX[xe] + cosY[ye]) / 20) & 255;
    if (xe % 8 === 7) yield;
  }
  yield;
}
function* poly10(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  const amin = -40, amax = 40, bmin = -60, bmax = 60, pasX = (amax - amin) / 320, pasY = (bmax - bmin) / 199;
  const sinX = [], cosY = [];
  for (let xe = 0; xe < 320; xe++) { const px = amin + pasX * (xe + 1); sinX[xe] = px * px * px; }
  for (let ye = 0; ye < 200; ye++) { const py = bmin + pasY * (ye + 1); cosY[ye] = py * py; }
  for (let xe = 0; xe < 320; xe++) {
    for (let ye = 0; ye <= 100; ye++) {
      const c = (pround(sinX[xe]) + pround(cosY[ye])) & 255;
      m[ye * 320 + xe] = c; m[(199 - ye) * 320 + xe] = c;
    }
    if (xe % 8 === 7) yield;
  }
  yield;
}
function* oly14(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  const xecr = 160, yecr = 150, amax = 1.1, bmax = 1.1;
  let amin = -98, bmin = -98;
  const sinX = [], cosY = [];
  for (let scrool = 1; scrool <= 280; scrool++) {
    amin -= 0.005 * Math.abs(amin); bmin -= 0.005 * Math.abs(bmin);
    const pasX = (amax - amin) / xecr, pasY = (bmax - bmin) / yecr;
    for (let xe = 0; xe <= xecr; xe++) { const px = amin + pasX * (xe + 1); sinX[xe] = px * px; }
    for (let ye = 0; ye <= yecr; ye++) { const py = bmin + pasY * (ye + 1); cosY[ye] = py * py; }
    for (let xe = 0; xe <= (xecr >> 1); xe++) for (let ye = 0; ye <= (yecr >> 1); ye++) {
      const c = pround(sinX[xe] - cosY[ye]) & 255, o = ye * 320;
      m[V + o + xe] = c; m[V + o - xe] = c; m[V - o + xe] = c; m[V - o - xe] = c;
    }
    yield;
  }
}
// ---------------------------------------------------------------- NEW6 / NEW14  {répertoire CONG}
function* new6(vga) {
  const m = vga.mem, base = 75 + 20 * 320; vga.putDac(P.BLUE);
  // Le Pascal ne remplit CARRE que de 0 à 250 alors que F+S monte jusqu'à 300 : ici on remplit jusqu'à 300.
  const carre = []; for (let f = 0; f <= 300; f++) carre[f] = f * f;
  for (let s = 1; s <= 150; s++) {
    for (let g = 1; g <= 150; g++) {
      let ofs = g * 320;
      for (let f = 1; f <= 150; f++) { ofs++; m[base + ofs] = (carre[f + s] - carre[f + g]) & 255; }
    }
    yield;
  }
}
function* new14(vga) {
  const m = vga.mem; vga.putDac(P.BLUE);
  for (let g = 1; g <= 200; g++) {
    const ofs = g * 320, gg = w16(g * g);
    for (let f = 1; f <= 320; f++) {
      const d = w16(gg - w16(f * f)) % f;
      let ca = 0;
      do { ca++; } while (!(d < ca || ca === 250));
      m[ofs + f] = ca;
    }
    if (g % 2 === 0) yield;
  }
}
// ---------------------------------------------------------------- ROTATION  {répertoire "rotation"}
function* rot2(vga) {
  const m = vga.mem; vga.putDac(P.VOLCANO);
  const tx = [], ty = []; for (let i = 0; i <= 99; i++) { tx[i] = i; ty[i] = i; }
  for (let x = 1; x <= 100; x++) {
    const ix = tx[0], iy = ty[99];
    for (let i = 1; i <= 99; i++) tx[i - 1] = tx[i];
    for (let i = 0; i <= 98; i++) ty[i] = ty[i + 1];
    tx[99] = ix; ty[0] = iy;
    for (let xe = 0; xe <= 99; xe++) for (let ye = 1; ye <= xe; ye++) {
      const c = (tx[xe] + ty[ye]) & 255, M = n => n * 320;
      m[M(ye + 100) + xe + 160] = c; m[M(xe + 100) + ye + 160] = c;
      m[M(100 - ye) + xe + 160] = c; m[M(100 - xe) + 160 + ye] = c;
      m[M(100 - ye) - xe + 160] = c; m[M(-xe + 100) - ye + 160] = c;
      m[M(100 + ye) - xe + 160] = c; m[M(100 + xe) + 160 - ye] = c;
    }
    yield;
  }
}
function drawRot(m, tx, ty) {
  for (let xe = 0; xe <= 99; xe++) for (let ye = 0; ye <= xe; ye++) sym(m, xe, ye, (tx[xe] + ty[ye]) & 255);
}
const tabs = f => Array.from({ length: 100 }, (_, i) => f(i) & 255);
function* rot9(vga) { vga.putDac(P.VOLCANO); drawRot(vga.mem, tabs(i => 5 * i), tabs(i => pround(150 * Math.cos(i / 10)))); yield; }
function* rot14(vga) { vga.putDac(P.VOLCANO); drawRot(vga.mem, tabs(i => pround(150 * Math.sin(i / 10))), tabs(i => pround(150 * Math.cos(i / 10)))); yield; }
function* rot20(vga) {
  vga.putDac(P.VOLCANO);
  const tx = new Array(100).fill(0);
  for (let x = 1; x <= 100; x++) {
    for (let xe = 1; xe <= 99; xe++) tx[xe] = (xe + x) % xe;
    drawRot(vga.mem, tx, tabs(i => pround(x * Math.cos(i / 20))));
    yield;
  }
}
function* rot15(vga) {
  vga.putDac(P.VOLCANO);
  const ty = tabs(i => pround(150 * Math.cos(i / 10)));
  for (let x = 1; x <= 400; x++) { drawRot(vga.mem, tabs(i => pround(x * Math.sin(i / 10))), ty); yield; }
}
function* rot16(vga) {
  vga.putDac(P.VOLCANO);
  const ty = tabs(i => pround(150 * Math.cos(i / 10)));
  for (let x = 1; x <= 250; x++) { drawRot(vga.mem, tabs(i => pround(x * Math.sin(x * i / 10) / 4)), ty); yield; }
}

// ---------------------------------------------------------------- Page de crédits (mode texte 80x25)
function drawCredits(canvas) {
  drawText(canvas, creditsOps('MATEMATICA 3', 'DECEMBER 1993',
    ['VOLPONE          : CODE ', 'TOTO             : CODE '],
    ['PALETTES         : ALL PALETTES ARE RIPED FROM FRACTINT   ', 'PLAYER           : MOD-OBJ by MARK J COX ',
     'TRACKER          : PROTRACKER 2.3 ', 'SCREEN CAPTURE   : SHOOT 2 By PHAM CONG-DUC ']));
}

// ---------------------------------------------------------------- Programme principal, découpé en scènes
const mimage = n => function* (vga) { vga.loadShoot(SHOOT[n]); yield 5000; };
window.SCENES = [
  { name: 'Data.000', note: 'LoadShoot(\'Data.000\') puis Delay(5000)', run: mimage('Data.000') },
  { name: 'Moy_3 · Rac_3 · Moy_4 · Rac_4', note: 'Procédures moy_3, rac_3, moy_4, rac_4 (répertoire « moyenne »). Écran en symétrie à 8.',
    run: function* (v) { v.cls(0); yield* moy3(v); yield* rac3(v); yield 2000; yield* moy4(v); yield* rac4(v); yield 2000; } },
  { name: 'Data.004', note: 'Image', run: mimage('Data.004') },
  { name: 'Pasm', note: 'Procédure Pasm (répertoire « flower ») : cou = (T_Cou1 * X) div T_Cou2, X de 1 à 300.',
    run: function* (v) { v.cls(0); yield* pasm(v); } },
  { name: 'Data.001', note: 'Image', run: mimage('Data.001') },
  { name: 'Oly14 · Poly8 · Poly10', note: 'Polynômes (répertoire « SH_CH ») : x²−y² défilant, puis 50x³+50y³ et x³+y².',
    run: function* (v) { v.cls(0); yield* oly14(v); yield 500; yield* poly8(v); yield 5000; yield* poly10(v); yield 5000; } },
  { name: 'Data.005', note: 'Image', run: mimage('Data.005') },
  { name: 'New6 · New14', note: 'Procédures New6 (f+s)²−(f+g)² et New14 (répertoire « CONG »).',
    run: function* (v) { v.cls(1); yield* new6(v); v.cls(1); yield* new14(v); } },
  { name: 'Data.002', note: 'Image', run: mimage('Data.002') },
  { name: 'Rot_2 → Rot_16', note: 'Procédures rot_2, 9, 20, 14, 15, 16 (répertoire « rotation »), palette Volcano.',
    run: function* (v) { v.cls(0); for (const r of [rot2, rot9, rot20, rot14, rot15, rot16]) { yield* r(v); yield 2000; } } },
  { name: 'Data.003', note: 'Image', run: mimage('Data.003') },
  { name: 'Crédits', note: 'Page_Credit : écran texte 80×25, 250 ticks (~14 s).', text: drawCredits, run: function* () { yield 250 * TICK; } },
];
window.drawCredits = drawCredits;
window.MALO = { sym, pround, V };

})();
