// MATEMATICA 2 (DEM2.PAS, septembre 1993) : la « DEMO_NORMALE » enchaîne les effets CARLE, ROTATE, EXPOLY, ITER, CONG et ES,
// séparés par des images à palette tournante. Les 69 procédures d'effets sont traduites automatiquement du Pascal par
// tools/pas2js.py (demos/mat2_effects.js). Ici : l'enchaînement, les palettes (DATA.000) et les pages de texte.
//
(function () {
  const ARETE = { v: 86 };                                   // « arête » : taille de la fenêtre, lue dans DEMO.CFG (octet 86) ; + et - la changent dans l'original
  const pal = n => PAL_MAT2[n];
  // IncDac127 / IncDac256 : rotation des entrées 1..n de la palette, une par tick
  function rot(p, n) { const o = p.slice(); for (let f = 2; f <= n; f++) for (let k = 0; k < 3; k++) p[f * 3 + k] = o[(f - 1) * 3 + k]; for (let k = 0; k < 3; k++) p[3 + k] = o[n * 3 + k]; }
  const cyc = (img, n) => function* (v) { v.loadImage('mat2', img); const p = v.pal.slice(); for (let i = 0; i < 200; i++) { rot(p, n); v.putDac(p); yield TICK; } };
  // Enchaîne des procédures de DEM2.PAS sur le même écran ; wait = attente en ticks après chacune ; cls = effacement avant chacune
  const fx = (names, palette, { cls = false, wait = 0, clsFirst = true } = {}) => function* (v) {
    const E = MAT2_make(v.mem), S = E.S;
    for (let f = 0; f < 200; f++) { S.mul1[f] = (f + 100) * 320 + 160; S.mul2[f] = (-f + 100) * 320 + 160; }
    if (clsFirst) v.cls(0);
    if (palette) v.putDac(pal(palette));
    for (const n of names) {
      if (cls && n !== names[0]) v.cls(0);
      const g = E[n.toLowerCase()]();
      for (;;) { S.a = ARETE.v; const r = g.next(); if (r.done) break; yield r.value; }
      if (wait) yield wait * TICK;
    }
  };
  const wait = ticks => function* () { yield ticks * TICK; };
  const seq = (...gens) => function* (v) { for (const g of gens) yield* g(v); };
  const head = ['text', 1, 1, 'BLANC', 'BLEU', '       MALOREAN EFFECT  : "MATEMATICA 2"  THE SECOND DEMO OF THE M.E TEAM       '];
  const foot = ['text', 1, 25, 'BLANC', 'BLEU', '                         RELEASE : SEPTEMBER 1993                               '];
  const board = (...o) => c => drawText(c, [['fill', 'BRUN'], head, foot, ...o]);
  const menu = board(['win', 10, 5, 70, 22, 'SETUP BOARD'], ['text', 15, 7, 'BLANC', 'BLEU', '  SOUND SOURCE FREQUENCE  '],
    ...['08 MHZ', '10 MHZ', '12 MHZ', '15 MHZ', '17 MHZ', '20 MHZ', '22 MHZ', '25 MHZ', '30 MHZ'].map((t, i) => ['text', 15, 8 + i, 'BLANC', 'MAGENTA', ((i === 3 ? '(•) ' : '( ) ') + t).padEnd(26)]),
    ['text', 15, 19, 'BLANC', 'MAGENTA', '[ ] PERPETUAL MOVEMENT'], ...[['DEMO', 8], ['SAVE', 10], ['CONTACT', 12], ['ABOUT', 14], ['EXIT', 16]].map(([t, y]) => ['text', 49, y, 'BLANC', 'BLEU', ' ' + t.padEnd(8) + ' ']));
  const about = board(['win', 5, 3, 75, 22, 'ABOUT BOARD', 'VERT', 'BRUN'], ['win', 8, 5, 63, 21, 'ABOUT WINDOWS', 'NOIR', 'ROUGE'],
    ...[[8, 'During the demo use + and - to change window size'], [10, 'VOLPONE cherche de bons dessinateurs,de preferences'], [11, 'aimant dessiner des dessins très sanglants (style'],
      [12, 'pochettes Iron Maiden) ou dessin héroique fantasy '], [13, 'mais les autres styles sont accepté.'], [15, 'VOLPONE cherche de bons musiciens (protacker ou Midi'],
      [16, 'sound Blaster sound) : tous styles acceptes'], [17, "Mais j'ai une préférence pour :hard-rock,rock,musique"], [18, 'classique,punk,reggea,blue,guitar folk'],
      [19, 'Mais certains autres membres preferent la Thecno'], [20, 'et la Danse Music']].map(([y, t]) => ['text', 10, y, 'BLANC', 'ROUGE', t]));
  const contact = board(['win', 2, 5, 77, 22, 'CONTACTS BOARD', 'VERT', 'BRUN'], ['win', 4, 7, 63, 21, 'CONTACTS ADRESSE', 'NOIR', 'ROUGE'],
    ...[[11, '         Vous pouvez contacter VOLPONE sur RTEL '], [12, '        en bal VOLPONE  ou en Bal MaloreanEffect'], [14, '         Vous pouvez contacter TOTO sur RTEL '],
      [15, '                en Bal  MaloreanEffect'], [17, '         Vous pouvez contacter SUN sur RTEL '], [18, '                en Bal  SUNDRD']].map(([y, t]) => ['text', 6, y, 'BLANC', 'ROUGE', t]));
  const credits = board(['win', 10, 5, 70, 22, 'CREDIT FOR THE DEMO'], ['text', 26, 8, 'BLANC', 'MAGENTA', 'VOLPONE          : CODE '], ['text', 26, 9, 'BLANC', 'MAGENTA', 'TOTO             : CODE/GFX '],
    ['text', 26, 10, 'BLANC', 'MAGENTA', 'SUN/DreamDealers : MUSIC   '], ['text', 10, 14, 'BLANC', 'BLEU', '                      SHAREWARE CREDIT                       '],
    ['text', 12, 17, 'BLANC', 'MAGENTA', 'PALETTES         : PALETTES ARE RIPED FROM FRACTINT 17.1 '], ['text', 12, 18, 'BLANC', 'MAGENTA', 'TRACKER          : MOD-OBJ by MARK J COX '],
    ['text', 12, 19, 'BLANC', 'MAGENTA', 'SCREEN CAPTURE   : SHOOT 2.0 by PHAM CONG-DUC '], ['text', 12, 20, 'BLANC', 'MAGENTA', 'TRACKER          : PROTRACKER 2.3 ']);
  const sc = (name, note, run, extra) => Object.assign({ name, note, run }, extra);
  const page = (name, note, text, ms) => ({ name, note, text, run: function* () { yield ms; } });
  const cong = (names, p, w = 80) => fx(names, p, { cls: true, wait: w });

  sceneDemo({
    music: 'tknodoom',
    id: 'mat2', title: 'Mathematica 2', year: '1993',
    desc: 'Release septembre 1993 · code Volpone, Toto (code et gfx), musique Sun/DreamDealers. Une soixantaine d\'effets entiers : Carle, rotations, polynômes, congruences et fonctions trigonométriques.',
    source: 'DEMO/MAT_2/code/SOURCE/DEM2.PAS',
    extra(bar) {
      bar.insertAdjacentHTML('beforeend', '<label>Arête <input type="range" id="m2a" min="30" max="100" value="86"><span class="rv" id="m2av">86</span></label>');
      bar.querySelector('#m2a').oninput = e => { ARETE.v = +e.target.value; bar.querySelector('#m2av').textContent = e.target.value; };
    },
    scenes: [
      page('Menu SETUP BOARD', 'Interface texte de l\'original (choix de la fréquence du son, mouvement perpétuel, DEMO / SAVE / CONTACT / ABOUT / EXIT). Affichage seul.', menu, 5000),
      sc('Data.006', 'Image de départ, attente de 100 ticks.', function* (v) { v.loadImage('mat2', 'data.006'); yield 100 * TICK; }),
      sc('Carle0', 'Palette Volcano · cou = (f+g−c) or c·f·g', fx(['carle0'], 'VOLCANO')),
      sc('Carle1', 'Palette Blue.', fx(['carle1'], 'BLUE')),
      sc('Carle2 · Carle3', 'Palette Volcano.', fx(['carle2', 'carle3'], 'VOLCANO')),
      sc('Carle5', 'Palette Blue.', fx(['carle5'], 'BLUE')),
      sc('Carle8', 'Palette Volcano.', fx(['carle8'], 'VOLCANO')),
      sc('Carle12 → 20', 'Palette Blue · neuf formules à la suite sur le même écran.', fx(['carle12', 'carle13', 'carle14', 'carle15', 'carle16', 'carle17', 'carle18', 'carle19', 'carle20'], 'BLUE')),
      sc('Carle21 → 33', 'Palette Volcano · huit formules.', fx(['carle21', 'carle24', 'carle25', 'carle26', 'carle27', 'carle28', 'carle30', 'carle33'], 'VOLCANO')),
      sc('Carle39 → 42', 'Palette Blue.', fx(['carle39', 'carle41', 'carle42'], 'BLUE')),
      sc('Carle46 · 47', 'Palette Volcano.', fx(['carle46', 'carle47'], 'VOLCANO')),
      sc('Data.008 · palette qui tourne', 'Image, palette décalée (entrées 1 à 127) à chaque tick pendant 200 ticks.', cyc('data.008', 127)),
      sc('Rotate5 · 7 · 12', 'Palette Volcano · tableaux Tx, Ty décalés (rotations de bits).', fx(['rotate5', 'rotate7', 'rotate12'], 'VOLCANO')),
      sc('Data.003 · palette qui tourne', 'Image, palette décalée, puis 40 ticks.', seq(cyc('data.003', 127), wait(40))),
      sc('ExPoly (9 procédures)', 'Palette Blue · polynômes en x et y dont les coefficients suivent une récurrence.', seq(fx(['expoly5_v16', 'expoly1', 'expoly5', 'expoly6', 'expoly8', 'expoly9', 'expoly10', 'expoly11', 'expoly15'], 'BLUE'), wait(40))),
      sc('Data.004 · palette qui tourne', 'Image, palette décalée, puis 40 ticks.', seq(cyc('data.004', 127), wait(40))),
      sc('Iter1', 'Palette Blue · ia = f and g, ib = f − g, quotient et carré.', seq(fx(['iter1'], 'BLUE'), wait(40))),
      sc('Data.007 · palette qui tourne', 'Image, palette décalée, puis 40 ticks.', seq(cyc('data.007', 127), wait(40))),
      sc('Cong 1 → 10', 'Palette Pal1 · plus petit diviseur ca tel que g mod ca = f (maximum 250), attente de 80 ticks après chacune.', cong(['cong1', 'cong2', 'cong5', 'cong6', 'cong8', 'cong9', 'cong10'], 'PAL1')),
      sc('Cong 11 → 13', 'Palette Pal4.', cong(['cong11', 'cong12', 'cong13'], 'PAL4')),
      sc('Cong14', 'Palette Pal2, puis 40 ticks.', seq(cong(['cong14'], 'PAL2'), wait(40))),
      sc('Data.002 · palette qui tourne', 'Image, palette décalée (entrées 1 à 255), puis 40 ticks.', seq(cyc('data.002', 255), wait(40))),
      sc('Es2', 'Palette Default · fonctions sinus : round((x+y)·sin x).', cong(['es2'], 'DEFAULT')),
      sc('Es3 → 7', 'Palette Pal1.', cong(['es3', 'es4', 'es5', 'es6', 'es7'], 'PAL1')),
      sc('Es15', 'Palette Blue.', cong(['es15'], 'BLUE')),
      sc('Es16 → 27', 'Palette Pal4.', cong(['es16', 'es17', 'es20', 'es23', 'es24', 'es25', 'es26', 'es27'], 'PAL4')),
      sc('Es30', 'Palette Pal1.', cong(['es30'], 'PAL1')),
      page('Crédits', 'Page_Credit : 250 ticks.', credits, 250 * TICK),
      page('ABOUT', 'Page d\'aide du menu.', about, 10000),
      page('CONTACT', 'Page de contacts du menu.', contact, 10000),
    ],
  });
})();
