// ALL OVER THE WORLD : MALOREAN.EXE lance MALOREA1.EXE, MALOREA2.EXE puis MALOREA3.EXE (code et graphisme : Toto, 1993).
// Port de MALOREA1.PAS (cubes de verre au-dessus d'un décor), MALOREA2.PAS (fonction de degré six, boules de potentiel,
// cycle de palette, chaînettes) et MALOREA3.PAS (décor arithmétique et traînées de facettes), avec les trajectoires de MALODATA.001.
(function () {
  const b64 = s => { const t = atob(s), u = new Uint8Array(t.length); for (let i = 0; i < t.length; i++) u[i] = t.charCodeAt(i); return u; };
  const rnd = x => x < 0 ? -Math.round(-x) : Math.round(x), rand = () => Math.random(), w16 = x => x & 0xFFFF;
  const MV = b64(MALODATA.mv), mv = new Uint16Array(MV.buffer.slice(MV.byteOffset, MV.byteOffset + MV.length));
  const GLOBE = b64(MALODATA.globe).subarray(769), DECOR = b64(MALODATA.decor).subarray(769);
  // xa,ya,xb,yb,xc,yc : tableaux [1..6, 0..850] de mots, rangés les uns après les autres dans MALODATA.001
  const traj = (a, f, j) => mv[a * 6 * 851 + (f - 1) * 851 + j];
  const FRAME = 25;

  // ---- Bresenham : place pour chaque ligne y l'abscisse x de la droite (une seule valeur par ligne, la dernière écrite)
  function bres(a, xi, yi, xf, yf) {
    const xx = Math.abs(xf - xi), yy = Math.abs(yf - yi);
    if (yy === 0) { a[yi] = xf; return; }
    const sx = xf > xi ? 1 : -1, sy = yf > yi ? 1 : -1;
    let x = xi, y = yi, e = 0;
    if (yy >= xx) { for (;;) { a[y] = x; y += sy; e += xx; if (e >= yy) { e -= yy; x += sx; } if (sy > 0 ? y > yf : y < yf) break; } }
    else { for (;;) { a[y] = x; x += sx; e += yy; if (e >= xx) { e -= xx; y += sy; } if (sx > 0 ? x > xf : x < xf) break; } }
  }
  // ---- bord : facette « rectangulaire » donnée par trois coins ; chaque pixel reçoit + c (indice de réfraction) dans `mem`
  const S = new Int32Array(512), T = new Int32Array(512);
  function bord(mem, xa, ya, xb, yb, xc, yc, c) {
    S.fill(0); T.fill(0);
    if (!(ya < yb && yb < yc) && !(yc < yb && yb < ya)) {
      const xt = xc, yt = yc, xs = xb, ys = yb;
      xc = xb; yc = yb; xb = xa; yb = ya; xa = xa + xt - xs; ya = ya + yt - ys;
    }
    bres(S, xa, ya, xb, yb); bres(S, xc, yc, xb, yb);
    xb = xa + xc - xb; yb = ya + yc - yb;
    bres(T, xa, ya, xb, yb); bres(T, xc, yc, xb, yb);
    const top = Math.min(ya, yc), bot = Math.max(ya, yc);
    for (let y = top; y <= bot && y < 200; y++) {
      const p = S[y] + y * 320, q = T[y] + y * 320;
      if (q < p) for (let a = p; a >= q; a--) mem[a] = (mem[a] + c) & 255; else for (let a = p; a <= q; a++) mem[a] = (mem[a] + c) & 255;
    }
  }

  // =================================================================== MALOREA1
  function defpalette() {                                       // palette calculée (6 bits) : dégradé gris-bleu, moitié haute inversée R↔B
    const p = new Array(768).fill(0), cl = v => v < 0 ? 0 : v > 63 ? 63 : v;
    for (let i = 0; i < 128; i++) {
      let cr, cv, cb;
      if (i < 61) { cr = i * i * 0.0175; cv = cr; cb = Math.sqrt(i / 60) * 63; } else { cr = 63 - 0.5 * i + 30; cv = cr; cb = 63 - 0.5 * i + 31; }
      cr = rnd(cl(cr)); cv = rnd(cl(cv)); cb = rnd(cl(cb));
      p[i * 3] = cr; p[i * 3 + 1] = cv; p[i * 3 + 2] = cb; p[(i + 128) * 3] = cb; p[(i + 128) * 3 + 1] = cv; p[(i + 128) * 3 + 2] = cr;
    }
    return p;
  }
  const GLOBES = [[0,0],[40,0],[80,0],[120,0],[160,0],[200,0],[240,0],[280,0],[0,40],[40,40],[80,40],[120,40]];
  function lutin(src, dst, x, y, w, h, xf, yf) {                // copie sans la couleur 255
    for (let r = 0; r < h; r++) for (let c = 0; c < w; c++) { const v = src[(y + r) * 320 + x + c]; if (v !== 255) dst[(yf + r) * 320 + xf + c] = v; }
  }
  function* part1(v) {
    const pal = defpalette(), buf = new Uint8Array(65536);
    const base = new Array(768).fill(0); v.putDac(base);
    let i = 0, j = 0, k = 0, q = 577;
    while (i < 1000) {
      buf.set(DECOR, 0);
      const [gx, gy] = GLOBES[k >> 1];
      lutin(GLOBE, buf, gx, gy, 33, 37, 51, 105); lutin(GLOBE, buf, gx, gy, 33, 37, 238, 62);
      [[1, j, 4], [2, j, 6], [3, j, 5], [4, j, 7], [5, j, 4], [6, j, 6], [1, q, 5], [2, q, 7], [3, q, 4], [4, q, 6], [5, q, 5], [6, q, 4]].forEach(([f, n, c]) =>
        bord(buf, traj(0, f, n), traj(1, f, n), traj(2, f, n), traj(3, f, n), traj(4, f, n), traj(5, f, n), c));
      v.mem.set(buf.subarray(0, 64000), 0);
      j++; k++; q++; if (k > 23) k = 0; if (j > 850) j = 0; if (q > 850) q = 0;
      if (i < 255) { const f = i / 255; v.putDac(pal.map(x => rnd(x * f))); }    // « tentative de fondu au début de la démo »
      else if (i === 255) v.putDac(pal);
      i++; yield FRAME;
    }
  }

  // =================================================================== MALOREA2
  const clampB = x => x & 255;
  function* part2(v) {
    const mem = v.mem; mem.fill(0);
    // paletteplus : trois sinusoïdes, plafonnées à 255 - i
    const r = rand() / 20, rr = rand() / 2 + 0.5, g = rand() / 20, gg = rand() / 3 + 0.5, b = rand() / 20, bb = rand() / 2 + 0.5, coul = new Array(768).fill(0);
    for (let i = 0; i < 256; i++) {
      coul[i * 3] = clampB(rnd((Math.sin(i * r - 1.57) * 31 + 32) * rr)); coul[i * 3 + 1] = clampB(rnd((Math.sin(i * g - 1.57) * 31 + 32) * gg)); coul[i * 3 + 2] = clampB(rnd((Math.sin(i * b - 1.57) * 31 + 32) * bb));
      for (let c = 0; c < 3; c++) if (coul[i * 3 + c] > 255 - i) coul[i * 3 + c] = 255 - i;
    }
    v.putDac(coul);
    // fonction de degré six : produit de trois formes quadratiques, valeur / 3000
    const xa = [0, 0, 0].map(() => Math.trunc(rand() * 256)), ya = [0, 0, 0].map(() => Math.trunc(rand() * 256)),
          xr = [0, 0, 0].map(() => Math.trunc(rand() * 10)), yr = [0, 0, 0].map(() => Math.trunc(rand() * 10)), zr = [0, 0, 0].map(() => Math.trunc(rand() * 30000));
    // les trois facteurs sont combinés comme res/3000*res2/3000*res3/3000 (division après chaque produit)
    const f6b = (x, y) => { const r0 = xr[0] * (x - xa[0]) ** 2 + yr[0] * (y - ya[0]) ** 2 - zr[0], r1 = xr[1] * (x - xa[1]) ** 2 + yr[1] * (y - ya[1]) ** 2 - zr[1], r2 = xr[2] * (x - xa[2]) ** 2 + yr[2] * (y - ya[2]) ** 2 - zr[2]; return Math.trunc(r0 / 3000 * r1 / 3000 * r2 / 3000); };
    const drawF6 = (y0, y1, x0, x1) => { for (let y = y0; y <= y1; y++) { let x = x0, cc = f6b(x, y); mem[x + y * 320] = cc & 255; do { x += 2; const c = f6b(x, y); mem[x - 1 + y * 320] = ((cc + c) >> 1) & 255; mem[x + y * 320] = c & 255; cc = c; } while (x <= x1); } };
    for (let y = 0; y <= 199; y++) { drawF6(y, y, 0, 319); if (y % 4 === 3) yield FRAME; }
    // boules de potentiel : cinq points mobiles, champ = somme de 75/exp(distance/30)
    const d = new Uint8Array(121 * 121); for (let xo = 0; xo <= 120; xo++) for (let yo = 0; yo <= 120; yo++) d[xo * 121 + yo] = rnd(75 / Math.exp(Math.sqrt(xo * xo + yo * yo) / 30));
    let P = [0, 1, 2, 3, 4].map(() => [rnd(rand() * 100 + 110), rnd(rand() * 100 + 50)]), G = [0, 1, 2, 3].map(() => [0, 0]);
    for (let con = 0; con < 250; con++) {
      for (let yo = 60; yo <= 140; yo++) for (let xo = 120; xo <= 200; xo += 2) {
        let co = 0; for (const [px, py] of P) co += d[Math.abs(px - xo) * 121 + Math.abs(py - yo)] | 0;
        co &= 255; mem[xo + 320 * yo] = co; mem[xo + 1 + 320 * yo] = co;
      }
      const tgt = [[170, 110], [P[0][0], P[0][1]], [160, 90], [P[2][0], P[2][1]]];
      for (let n = 0; n < 4; n++) for (let a = 0; a < 2; a++) { const pos = P[n][a], t = tgt[n][a], gv = G[n][a]; G[n][a] = pos <= t ? (gv < 8 ? gv + 1 : gv) : (gv > -8 ? gv - 1 : gv); }
      for (let n = 0; n < 4; n++) { P[n][0] = w16(P[n][0] + G[n][0]); P[n][1] = w16(P[n][1] + G[n][1]); }
      P[4] = [w16(320 - P[1][0]), w16(200 - P[1][1])];
      yield 40;
    }
    drawF6(60, 140, 120, 200); yield FRAME;
    // cycle de couleur : l'indice du DAC n'est pas réglé (port 3C5 au lieu de 3C8) : les triplets s'écrivent à la suite, d'où une rotation
    for (let con = 0, xo = 0; con < 1000; con++, xo = (xo + 1) & 255) {
      const p = new Array(768); for (let n = 0; n < 256; n++) { const s = ((xo + 1 + n) & 255) * 3; p[n * 3] = coul[s]; p[n * 3 + 1] = coul[s + 1]; p[n * 3 + 2] = coul[s + 2]; }
      v.putDac(p); yield FRAME;
    }
    v.putDac(coul);
    // chaînettes : 400 points qui se suivent
    const tx = new Uint8Array(401), ty = new Uint8Array(401), tvx = new Int16Array(401), tvy = new Int16Array(401);
    for (let i = 0; i <= 400; i++) { tx[i] = Math.trunc(rand() * 255); ty[i] = Math.trunc(rand() * 199); }
    const shape = [0, 319, 321, 639, 641, 960];                  // six écritures de 2 pixels autour du point
    const draw = (xt, val) => { for (const o of shape) { const a = xt + o; mem[a] = val & 255; mem[a + 1] = (val >> 8) & 255; } };
    for (let con = 0; con < 150; con++) {
      for (let xo = 1; xo <= 10; xo++) {
        if (tx[0] < tx[400]) { if (tvx[0] < 2) tvx[0] = tvx[400] + 1; } if (ty[0] < ty[400]) { if (tvy[0] < 2) tvy[0] = tvy[400] + 1; }
        if (tx[0] > tx[400]) { if (tvx[0] > -2) tvx[0] = tvx[400] - 1; } if (ty[0] > ty[400]) { if (tvy[0] > -2) tvy[0] = tvy[400] - 1; }
        tx[0] += tvx[0]; ty[0] += tvy[0];
        if (ty[0] > 197) { ty[0] = Math.trunc(rand() * 255); tx[0] = Math.trunc(rand() * 255); tvx[0] = 0; tvy[0] = 0; }
        for (let i = 1; i <= 400; i++) {
          const ev = (i % 2 === 0), mx = ev ? 3 : 2, my = ev ? 2 : 3;
          if (tx[i] < tx[i - 1]) { if (tvx[i] < mx) tvx[i]++; } if (ty[i] < ty[i - 1]) { if (tvy[i] < my) tvy[i]++; }
          if (tx[i] > tx[i - 1]) { if (tvx[i] > -mx) tvx[i]--; } if (ty[i] > ty[i - 1]) { if (tvy[i] > -my) tvy[i]--; }
          draw(ty[i] * 320 + 32 + tx[i], 0);
          tx[i] += tvx[i]; ty[i] += tvy[i];
          if (ty[i] > 197) { ty[i] = Math.trunc(rand() * 255); tx[i] = Math.trunc(rand() * 255); tvx[i] = 0; tvy[i] = 0; }
          draw(ty[i] * 320 + 32 + tx[i], w16(i + (i << 8)));
        }
      }
      ty[0] = Math.trunc(rand() * 255); tx[0] = Math.trunc(rand() * 255); tvx[0] = 0; tvy[0] = 0;
      yield 60;
    }
  }

  // =================================================================== MALOREA3
  function* part3(v) {
    const mem = v.mem;
    // paletteplus (MALOREA3) : sinusoïdes modulées, 255 entrées chargées (l'entrée 255 reste noire)
    const a = rand() * 5, b = rand() * 5, c = rand() * 5, aa = rnd(rand() * 2), bb = rnd(rand() * 2), cc = rnd(rand() * 2), k = 6.28 / 255, pal = new Array(768).fill(0);
    for (let i = 0; i < 255; i++) {
      pal[i * 3] = rnd(Math.sin(a * i * k - 1.57) * rnd(Math.sin(aa * i * k + 1.57) * 31) + 32);
      pal[i * 3 + 1] = rnd(Math.sin(b * i * k - 1.57) * rnd(Math.sin(bb * i * k + 1.57) * 31) + 32);
      pal[i * 3 + 2] = rnd(Math.sin(c * i * k - 1.57) * rnd(Math.sin(cc * i * k + 1.57) * 31) + 32);
    }
    v.putDac(pal);
    // décor : arithmétique entière sur les mots (i = y, j = x), par couronnes autour du point (160, 100)
    for (let i = 0; i <= 199; i++) {
      for (let j = 0; j <= 319; j++) {
        let col;
        if ((i ^ j) < 160) col = i % 255;
        else {
          const cr = rnd(Math.sqrt((i - 100) * (i - 100) + (j - 160) * (j - 160)));
          if (cr <= 20) col = w16(i + j) % 255; else if (cr <= 40) col = (i ^ j) % 128 + 32; else if (cr <= 60) col = w16(i - j) % 255;
          else if (cr <= 80) col = w16(i * j) % 128 + 32; else if (cr <= 100) col = w16(i + j) % 255; else if (cr <= 120) col = w16(w16(i + j) * w16(i - j)) % 128 + 32;
          else if (cr <= 140) col = w16(i - j) % 255; else col = w16(w16(i + j) ^ w16(i - j)) % 128 + 32;
        }
        mem[i * 320 + j] = col;
      }
      if (i % 4 === 3) yield FRAME;
    }
    // traînées : deux facettes (faces 1 et 4) ajoutent +1 ; vingt images plus tard, elles sont retirées (+255 = -1)
    let con = 0, cnt = 0, ii = 520, kk = 500, jj = 0, q = 20;
    while (con < 3000) {
      bord(mem, traj(0, 1, q), traj(1, 1, q), traj(2, 1, q), traj(3, 1, q), traj(4, 1, q), traj(5, 1, q), 1);
      bord(mem, traj(0, 4, ii), traj(1, 4, ii), traj(2, 4, ii), traj(3, 4, ii), traj(4, 4, ii), traj(5, 4, ii), 1);
      if (cnt < 20) cnt++;
      else {
        bord(mem, traj(0, 1, jj), traj(1, 1, jj), traj(2, 1, jj), traj(3, 1, jj), traj(4, 1, jj), traj(5, 1, jj), 255);
        bord(mem, traj(0, 4, kk), traj(1, 4, kk), traj(2, 4, kk), traj(3, 4, kk), traj(4, 4, kk), traj(5, 4, kk), 255);
      }
      ii++; q++; kk++; jj++; if (ii > 850) ii = 0; if (kk > 850) kk = 0; if (jj > 850) jj = 0; if (q > 850) q = 0;
      con++; if (con % 2 === 0) yield FRAME;
    }
  }

  // ---- écrans texte (lignes brutes de writeln, en CP437)
  const page = lines => c => drawText(c, [['fill', 'NOIR'], ...lines.map((l, i) => ['text', 1, i + 1, 'GRIS', 'NOIR', l])]);
  const TXT = ALLOVER_TEXT;
  const text = (name, note, lines, ms) => ({ name, note, text: page(lines), run: function* () { yield ms; } });
  const gfx = (name, note, fn) => ({ name, note, run: function* (v) { v.cls(0); v.putDac(new Array(768).fill(0)); yield* fn(v); } });

  sceneDemo({
    id: 'allover', title: 'All Over The World', year: '1993',
    desc: 'Code et graphisme de Toto. MALOREAN.EXE enchaîne trois programmes : des cubes de verre qui réfractent un décor, une fonction de degré six avec boules de potentiel et chaînettes, puis des traînées de facettes sur un décor arithmétique.',
    source: 'DEMO/ALL_OVER/code/MALOREAN.PAS, MALOREA1.PAS, MALOREA2.PAS, MALOREA3.PAS · DEMO/ALL_OVER/ressources/MALODATA.00x',
    scenes: [
      text('Écran de départ (MALOREA1)', 'Message de compatibilité affiché pendant 4 s avant le passage en mode MCGA.', TXT.intro, 4000),
      gfx('1 · Cubes de verre', 'Deux cubes (12 facettes) animés par les trajectoires de MALODATA.001 ; chaque facette ajoute son « indice de réfraction » (4 à 7) aux indices de couleur du décor. Deux globes à 12 images. Fondu de palette pendant les 255 premières images.', part1),
      text('Crédits (MALOREA1)', 'Texte de fin de MALOREA1.', TXT.end1, 6500),
      gfx('2 · Fonction de degré six', 'Produit de trois formes quadratiques divisé par 3000 (paramètres tirés au hasard), puis cinq boules de potentiel 75/exp(r/30), un cycle de palette et 400 chaînettes. Le hasard rend chaque lancement différent.', part2),
      text('Crédits (MALOREA2)', 'Texte de fin de MALOREA2.', TXT.end2, 5000),
      gfx('3 · Traînées de facettes', 'Décor calculé en arithmétique entière sur les mots, par couronnes ; deux facettes laissent une traîne de 20 images (+1 à l\'aller, −1 en retard).', part3),
      text('Crédits (MALOREA3)', 'Texte de fin de MALOREA3.', TXT.end3, 4000),
    ],
  });
})();
