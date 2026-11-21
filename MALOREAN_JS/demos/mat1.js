// MATEMATICA 1 (DEMO_1.PAS, septembre 1993) : « the first demo of the M.E team ». Menu texte, puis 13 courbes fractales
// calculées en entiers LongInt 32 bits à virgule fixe (échelle 2048 ou autre). Arithmétique 32 bits reproduite avec Math.imul :
// les débordements de SQR(x) etc. sont ceux de Turbo Pascal (module peut devenir négatif et prolonger l'itération).
//   div = division entière tronquée · shr = décalage logique (>>>) · Round = arrondi loin de zéro.
(function () {
  const imul = Math.imul, sq = x => imul(x, x), rnd = x => x < 0 ? -Math.round(-x) : Math.round(x), div = (a, b) => b ? Math.trunc(a / b) : 0;
  const px = (v, x, y, c) => { v.mem[y * 320 + x] = c & 255; };               // PutPixel / Vga_Ecran[Mul320[y]+x]
  const PX = () => new Array(321), PY = () => new Array(201);
  function bounds(amin, amax, bmin, bmax, pasX = (amax - amin) / 320, pasY = (bmax - bmin) / 200) {
    const Px = PX(), Py = PY();
    for (let i = 0; i < 320; i++) Px[i] = rnd(amin + pasX * (i + 1));
    for (let i = 0; i < 200; i++) Py[i] = rnd(bmin + pasY * (i + 1));
    Px[320] = Px[319]; Py[200] = Py[199];                                      // Px[320] déborde dans le source : on répète la dernière valeur
    return [Px, Py];
  }
  // Une courbe = un générateur ; `row` rend la couleur d'un point ; yield tous les `every` pas de la boucle extérieure.
  let couleur = 0;                                                             // variable de FractNbEntier, conservée d'un pixel à l'autre
  function* courbe1(v) {
    const [Px, Py] = bounds(-4096, 1024, -2458, 2458); let moi = 0;
    for (let ye = 0; ye <= 100; ye++) {
      for (let xe = 0; xe <= 319; xe++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 35 && module < 16777216) {
          const xp = (moi === 0 ? div((sq(x) + sq(y)) | 0, 2048) : div((sq(x) - sq(y)) | 0, 2048)) + Px[xe];
          y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++; moi++; if (moi === 2) moi = 0;
          module = moi === 0 ? (sq(x) + sq(y)) | 0 : (sq(x) - sq(y)) | 0;
        }
        const c = nb & 255; px(v, xe, ye, c); px(v, xe, 198 - ye, c);
      }
      if (ye % 2) yield;
    }
  }
  function* courbe2(v) {
    const [Px, Py] = bounds(rnd(-2.2 * 2048), rnd(0.7 * 2048), rnd(-1.5 * 2048), rnd(1.5 * 2048));
    for (let ye = 0; ye <= 100; ye++) {
      for (let xe = 0; xe <= 319; xe++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 35 && module < 16777216) {
          const xp = div((sq(x) - sq(y)) | 0, 2048) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) - (sq(y) << 4)) | 0;
        }
        if (module > 16777216) couleur = nb & 255;
        if (module < 16777216 && y !== 0) couleur = (x % y) & 255;
        px(v, xe, ye, couleur); px(v, xe, 199 - ye, couleur);
      }
      if (ye % 2) yield;
    }
  }
  function* courbe5(v) {
    const [Px, Py] = bounds(-4096, 2048, rnd(-1.2 * 2048), rnd(1.2 * 2048));
    for (let xe = 0; xe <= 319; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 15 && module < 16777216) {
          const xp = (((sq(x) - imul(x, y)) | 0) >>> 11) + Px[xe]; y = (imul(x, y) >>> 11) + Py[ye]; x = xp; nb++;
          module = (sq(x) + imul(y, y)) | 0;
        }
        const c = nb & 250; px(v, xe, ye, c); px(v, xe, 199 - ye, c);
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* courbe6(v) {
    const [Px, Py] = bounds(-6144, 4096, rnd(-2.2 * 2048), rnd(2.2 * 2048));
    for (let xe = 0; xe <= 319; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 55 && module < 16000000) {
          const xp = div((sq(x) - sq(y)) | 0, 2048) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) + sq(y)) | 0;
        }
        const c = nb & 255; px(v, xe, ye, c); px(v, xe, 199 - ye, c);
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* courbe7(v) {                                                       // échelle 512 ; pasX, pasY sont arrondis (entiers)
    const amin = -1024, amax = 512, bmin = rnd(-1.2 * 512), bmax = rnd(1.2 * 512);
    const pasX = rnd(512 * (amax - amin) / 320), pasY = rnd(512 * (bmax - bmin) / 200), Px = [], Py = [];
    for (let i = 0; i < 320; i++) Px[i] = rnd((amin + pasX * (i + 1)) * 512);
    for (let i = 0; i <= 200; i++) Py[i] = rnd((bmin + pasY * (i + 1)) * 512);
    for (let xe = 0; xe <= 319; xe++) {
      for (let ye = 0; ye <= 200; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 7 && module < 4) {
          const xp = div((sq(x) - sq(y) + Px[xe]) | 0, 512); y = div((imul(2 * x | 0, y) + Py[ye]) | 0, 512); x = xp; nb++;
          module = (sq(x) + sq(y)) | 0;
        }
        if (ye < 200) px(v, xe, ye, nb & 10);                                 // la ligne 200 sort de l'écran
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* courbe8(v) {
    const [Px, Py] = bounds(-2048, 1024, rnd(-1.2 * 1024), rnd(1.2 * 1024));
    for (let xe = 0; xe <= 160; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 35 && module < 16777216) {
          const xp = div((sq(x) - sq(y)) | 0, 1024) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) + sq(y)) | 0;
        }
        const c = nb & 250; px(v, xe, ye, c); px(v, xe, 199 - ye, c); px(v, 319 - xe, ye, c); px(v, 319 - xe, 199 - ye, c);
      }
      if (xe % 2) yield;
    }
  }
  function* courbe9(v) {
    // car^[f] := f*f div 2048 avec f Integer 16 bits ; hors de -8000..8000 le source lit de la mémoire : on prolonge la formule.
    const car = y => div(((y * y) << 16) >> 16, 2048);
    const [Px, Py] = bounds(-4096, 2048, rnd(-1.2 * 2048), rnd(1.2 * 2048));
    for (let xe = 0; xe <= 320; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 150 && module < 16777216) {
          const xp = (((sq(x) - sq(y)) | 0) >>> 11) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) + car(y)) | 0;
        }
        const c = (nb & 30) << 4; px(v, xe, ye, c); px(v, xe, 199 - ye, c);
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* esfrac2(v) {
    const MUL = 256, MUL2 = 128, [Px, Py] = bounds(-512, 128, rnd(-1.2 * MUL), rnd(1.2 * MUL));
    for (let ye = 0; ye <= 99; ye++) {
      for (let xe = 0; xe <= 319; xe++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 50 && module < 2 * MUL * MUL) {
          const xp = div((sq(x) - sq(y)) | 0, MUL) + Px[xe]; y = div(imul(x, y), MUL2) + Py[ye]; x = xp; nb++;
          module = (sq(x) - (sq(y) << 4)) | 0;
        }
        if (module > 16777216) couleur = nb & 255;
        if (module < 16777216 && y !== 0) couleur = (x % y) & 255;
        px(v, xe, ye, couleur); px(v, xe, 199 - ye, couleur);
      }
      if (ye % 2) yield;
    }
  }
  function* esfrac5(v) {
    const MUL = 2048, MUL2 = 1024, [Px, Py] = bounds(0, rnd(0.17 * MUL), 0, rnd(0.115 * MUL)), modmax = div(MUL * MUL, 10);
    for (let ye = 0; ye <= 199; ye++) {
      for (let xe = 0; xe <= 320; xe++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 5 && module < modmax) {
          const xp = (((sq(x) - sq(y)) | 0) & 16711680) + Px[xe]; y = div(imul(x, y), MUL2) + Py[ye]; x = xp; nb++;
          module = (sq(x) - (sq(y) << 4)) | 0;
        }
        if (module > 16777216) couleur = nb & 255;
        if (module < 16777216 && y !== 0) couleur = (x % y) & 255;
        px(v, xe, ye, couleur);
      }
      if (ye % 3 === 2) yield;
    }
  }
  function* l8(v) {
    const [Px, Py] = bounds(-4096, rnd(-1.3 * 2048), rnd(-0.2 * 2048), rnd(0.2 * 2048));
    for (let xe = 0; xe <= 320; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 35 && module < 16777216) {
          const xp = div((sq(x) - imul(x, y)) | 0, 2048) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) + sq(y)) | 0;
        }
        const c = nb & 15; px(v, xe, ye, c); px(v, xe, 199 - ye, c);
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* l15(v) {
    const [Px, Py] = bounds(-4096, -2048, rnd(-0.6 * 2048), rnd(0.6 * 2048));
    for (let xe = 0; xe <= 160; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 57 && module < 16777216) {
          const xp = (((sq(x) - imul(x, y)) | 0) >>> 11) + Px[xe]; y = (imul(x, y) >>> 11) + Py[ye]; x = xp; nb++;
          module = (sq(x) + imul(y, y)) | 0;
        }
        const c = nb & 255; px(v, xe, ye, c); px(v, xe, 199 - ye, c); px(v, 319 - xe, ye, c); px(v, 319 - xe, 199 - ye, c);
      }
      if (xe % 2) yield;
    }
  }
  function* manMag(v) {
    // Le source recopie en assembleur un mot situé 8 octets après `merde1` (adresse dépendant de la pile) dans merde1bis :
    // impossible à reproduire. On suppose l'intention : le mot de poids fort de x*x-y*y, soit (x²-y²) / 65536 en Integer.
    const C2 = 32768, [Px, Py] = bounds(-131072, 65536, -131072, 131072);
    for (let xe = 0; xe <= 319; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 20 && module < 1000000000) {
          const merde1 = (sq(x) - sq(y)) | 0, xp = (merde1 >> 16) + Px[xe]; y = div(imul(x, y), C2) + Py[ye]; x = xp; nb++;
          module = (sq(x) + imul(y, y)) | 0;
        }
        px(v, xe, ye, nb); px(v, xe, 199 - ye, nb);
      }
      if (xe % 4 === 3) yield;
    }
  }
  function* mandel10(v) {
    const [Px, Py] = bounds(-6144, 4096, -4096, 4096);
    for (let ye = 0; ye <= 99; ye++) {
      for (let xe = 1; xe <= 319; xe++) {
        let x = 0, y = 0, module = 0, nb = 0;
        while (nb < 50 && module < 16777216) {
          const xp = div((sq(x) - sq(y)) | 0, 2048) + Px[xe]; y = div(imul(x, y), 1024) + Py[ye]; x = xp; nb++;
          module = (sq(x) - (sq(y) << 4)) | 0;
        }
        const c = (y >>> 5) + nb; px(v, xe, ye, c); px(v, xe, 199 - ye, c);
      }
      if (ye % 2) yield;
    }
  }

  const P = n => PAL.GEST_DAC[n];
  const curve = (name, note, pal, fn) => ({ name, note, run: function* (v) { v.cls(0); if (pal) v.putDac(P(pal)); couleur = 0; yield* fn(v); yield 2000; } });
  // Pages en mode texte (AFFICHE_INTERFACE, AIDE, PCONTACT, PAGE_CREDIT)
  const head = (t, r) => [['text', 1, 1, 'BLANC', 'BLEU', t.padEnd(80)], ['text', 1, 25, 'BLANC', 'BLEU', r.padStart(52).padEnd(80)]];
  const HEAD = ['       MALOREAN EFFECT  : "MATEMATICA 1"  THE FIRST DEMO OF THE M.E TEAM        ', 'RELEASE : SEPTEMBER 1993'];
  const menu = c => drawText(c, [['fill', 'BRUN'], ...head(...HEAD), ['win', 40, 8, 60, 19, 'SETUP BOARD'],
    ...[['DEMO', 10], ['CONTACT', 12], ['ABOUT', 14], ['EXIT', 16]].map(([t, y]) => ['text', 46, y, 'BLANC', 'BLEU', ' ' + t.padEnd(8) + ' ']),
    ['win', 10, 8, 30, 18, 'HI TO'], ...['Sally', 'Sun', "Flying Sock Man's", 'The Masqued Coder', 'Ffred', 'Mc2(AMIGA)', 'Locked'].map((t, i) => ['text', 11, 10 + i, 'BLANC', 'MAGENTA', t])]);
  const about = c => drawText(c, [['fill', 'BRUN'], ...head(...HEAD), ['win', 5, 3, 75, 22, 'ABOUT BOARD', 'VERT', 'BRUN'], ['win', 8, 5, 63, 21, 'ABOUT WINDOWS', 'NOIR', 'ROUGE'],
    ...[[7, 'REQUIREMENT : 286 VGA  (486 DX 33 is recomment)'], [9, '          ALL PICTURES ARE FRACTALES '],
      [11, 'VOLPONE cherche de bons dessinateurs,de preferences'], [12, 'aimant dessiner des dessins très sanglants (style'], [13, 'pochettes Iron Maiden) ou dessin héroique fantasy '], [14, 'mais les autres styles sont accepté.'],
      [16, 'VOLPONE cherche de bons musiciens (protacker ou Midi'], [17, 'sound Blaster sound) : tous styles acceptes'], [18, "Mais j'ai une préférence pour :hard-rock,rock,musique"],
      [19, 'classique,punk,reggea,blue,guitar folk'], [20, 'Mais certains autres membres preferent la Thecno'], [21, 'et la Danse Music']].map(([y, t]) => ['text', 10, y, 'BLANC', 'ROUGE', t])]);
  const contact = c => drawText(c, [['fill', 'BRUN'], ...head(...HEAD), ['win', 2, 5, 77, 22, 'CONTACTS BOARD', 'VERT', 'BRUN'], ['win', 4, 7, 63, 21, 'CONTACTS ADRESSE', 'NOIR', 'ROUGE'],
    ['text', 6, 11, 'BLANC', 'ROUGE', '         Vous pouvez contacter VOLPONE sur RTEL '], ['text', 6, 12, 'BLANC', 'ROUGE', '        en bal VOLPONE  ou en Bal MaloreanEffect'],
    ['text', 6, 16, 'BLANC', 'ROUGE', '         Vous pouvez contacter TOTO sur RTEL '], ['text', 6, 17, 'BLANC', 'ROUGE', '                en Bal  MaloreanEffect']]);
  const credits = c => drawText(c, [['fill', 'BRUN'], ['text', 1, 1, 'BLANC', 'BLEU', '       MALOREAN EFFECT  : "MATHEMATICA 1"  THE FIRST DEMO OF THE M.E TEAM       '],
    ['text', 1, 25, 'BLANC', 'BLEU', '                         RELEASE : SEPTEMBER 1993                               '], ['win', 10, 5, 70, 22, 'CREDIT FOR THE DEMO'],
    ['text', 35, 8, 'BLANC', 'MAGENTA', 'VOLPONE : CODE '], ['text', 35, 10, 'BLANC', 'MAGENTA', 'TOTO    : GFX '],
    ['text', 10, 14, 'BLANC', 'BLEU', '                      SHAREWARE CREDIT                       '],
    ['text', 12, 17, 'BLANC', 'MAGENTA', 'PALETTES         : PALETTES ARE RIPED FROM FRACTINT 17.1 '], ['text', 12, 19, 'BLANC', 'MAGENTA', 'SCREEN CAPTURE   : SHOOT 2.0 by PHAM CONG-DUC ']]);
  const page = (name, note, text, ms) => ({ name, note, text, run: function* () { yield ms; } });

  sceneDemo({
    id: 'mat1', title: 'Mathematica 1', year: '1993',
    desc: 'Release septembre 1993 · « the first demo of the M.E. team ». Code Volpone, gfx Toto. Menu texte puis treize courbes fractales en entiers 32 bits.',
    source: 'CODE/demosour/mat1/SOURCE/DEMO_1.PAS',
    scenes: [
      page('Menu SETUP BOARD', 'Interface texte avec souris dans l\'original (boutons DEMO, CONTACT, ABOUT, EXIT). Ici les pages sont affichées sans interaction.', menu, 6000),
      { name: 'Data.000', note: "LoadShoot('DATA.000') puis Delay(12000)", run: image('mat1', 'data.000', 12000) },
      curve('Courbe1', 'Palette Pal12 · alternance de deux formules, un point sur deux (variable moi).', 'PAL12', courbe1),
      curve('Courbe2', 'Palette Volcano · module = x² − 16y², couleur = x mod y.', 'VOLCANO', courbe2),
      curve('Courbe5', 'Palette Default · décalages logiques (shr 11).', 'DEFAULT', courbe5),
      curve('Courbe6', 'Palette Default · module < 16 000 000, 55 itérations.', 'DEFAULT', courbe6),
      curve('Courbe7', 'Palette Default · échelle 512, 7 itérations, couleur = nb and 10.', 'DEFAULT', courbe7),
      curve('Courbe8', 'Palette Default · quart d\'écran recopié quatre fois.', 'DEFAULT', courbe8),
      curve('Courbe9', 'Palette Default · table de carrés, 150 itérations.', 'DEFAULT', courbe9),
      curve('EsFrac2', 'Palette Volcano · échelle 256.', 'VOLCANO', esfrac2),
      curve('EsFrac5', 'Palette Pal4 · zone 0 à 0,17 × 0 à 0,115, masque 16711680.', 'PAL4', esfrac5),
      curve('L8', 'Palette Default · zone au bord gauche de l\'ensemble.', 'DEFAULT', l8),
      curve('L15', 'Palette Default · quatre quarts.', 'DEFAULT', l15),
      curve('Man_Mag_', 'Palette Pal1 · échelle 65536. Une astuce en assembleur est reconstruite par hypothèse.', 'PAL1', manMag),
      curve('Mandel10', 'Palette Volcano · couleur = (y shr 5) + nb.', 'VOLCANO', mandel10),
      page('Crédits', 'Page_Credit : 150 ticks (≈ 8 s).', credits, 150 * TICK),
      page('ABOUT', 'Page d\'aide du menu.', about, 10000),
      page('CONTACT', 'Page de contacts du menu.', contact, 10000),
    ],
  });
})();
