// FLAN.EXE : « The Come Back of SuperCustard Tart » (Volpone, code et musique, dédié à Cédric).
// Ce port est reconstitué depuis le désassemblage de FLAN.EXE (pas de source Pascal retrouvé). Ce que fait le programme :
//   1. mode X (320×200 déchaîné : 4 plans, 80 octets par ligne) ; la palette n'est jamais modifiée : c'est la palette VGA par défaut ;
//   2. un fractal en entiers LongInt (échelle 2048) est calculé pour un quart d'écran, puis écrit 16 fois : sur 4 pages de 16 000 octets
//      (adresses 0, 16000, 32000, 48000) et dans les 4 quarts de chaque page par symétrie ;
//   3. l'écran défile sans rien recalculer, en écrivant l'adresse de début d'écran dans le CRTC (registres 0Ch/0Dh) :
//      160 pas de i, puis en boucle 300 pas de i·161 aller, 300 pas retour ;
//   4. à la fin : fondu de la musique (ALICE.MOD, non reproduite ici) puis page de crédits en mode texte.
(function () {
  const rnd = x => x < 0 ? -Math.round(-x) : Math.round(x), div = (a, b) => Math.trunc(a / b), imul = Math.imul;

  // Palette VGA par défaut du BIOS (mode 13h), valeurs 6 bits : 16 couleurs EGA, 16 gris, puis 9 groupes de 24 teintes.
  function defaultVGAPalette() {
    const p = [], put = (r, g, b) => p.push(r, g, b);
    [[0,0,0],[0,0,42],[0,42,0],[0,42,42],[42,0,0],[42,0,42],[42,21,0],[42,42,42],[21,21,21],[21,21,63],[21,63,21],[21,63,63],[63,21,21],[63,21,63],[63,63,21],[63,63,63]].forEach(c => put(...c));
    [0, 5, 8, 11, 14, 17, 20, 24, 28, 32, 36, 40, 45, 50, 56, 63].forEach(g => put(g, g, g));
    const groups = [[0, 16, 31, 47, 63], [31, 39, 47, 55, 63], [45, 49, 54, 58, 63], [0, 7, 14, 21, 28], [14, 17, 21, 24, 28], [20, 22, 24, 26, 28],
                    [0, 4, 8, 12, 16], [8, 10, 12, 14, 16], [11, 12, 13, 15, 16]];
    for (const [lo, v1, v2, v3, hi] of groups) {
      [[lo,lo,hi],[v1,lo,hi],[v2,lo,hi],[v3,lo,hi],[hi,lo,hi],[hi,lo,v3],[hi,lo,v2],[hi,lo,v1],[hi,lo,lo],[hi,v1,lo],[hi,v2,lo],[hi,v3,lo],
       [hi,hi,lo],[v3,hi,lo],[v2,hi,lo],[v1,hi,lo],[lo,hi,lo],[lo,hi,v1],[lo,hi,v2],[lo,hi,v3],[lo,hi,hi],[lo,v3,hi],[lo,v2,hi],[lo,v1,hi]].forEach(c => put(...c));
    }
    while (p.length < 768) put(0, 0, 0);
    return p;
  }

  // Mémoire vidéo du mode X : 4 plans de 64 Ko ; le pixel (x, y) de la page `page` est à l'adresse page + 80·y + (x >> 2), plan x & 3.
  const planes = [0, 1, 2, 3].map(() => new Uint8Array(65536));
  const put = (page, x, y, c) => { planes[x & 3][(page + 80 * y + (x >> 2)) & 0xFFFF] = c; };
  // Ce que la carte affiche pour une adresse de début d'écran : 200 lignes de 80 octets consécutifs (qui se replient sur 64 Ko).
  function show(v, start) {
    const m = v.mem;
    for (let L = 0; L < 200; L++) for (let c = 0; c < 80; c++) {
      const a = (start + 80 * L + c) & 0xFFFF, o = L * 320 + 4 * c;
      m[o] = planes[0][a]; m[o + 1] = planes[1][a]; m[o + 2] = planes[2][a]; m[o + 3] = planes[3][a];
    }
  }
  const FRAME = 1000 / 70;                                     // SetStart attend le retour vertical : une image à 70 Hz par pas

  let computed = false;
  function* fractal(v) {
    v.putDac(defaultVGAPalette()); planes.forEach(p => p.fill(0));
    const Px = [], Py = [], pasX = (-1024 - -4096) / 320, pasY = (3072 - -3072) / 200;
    for (let i = 0; i < 320; i++) Px[i] = rnd(-4096 + pasX * (i + 1));
    for (let j = 0; j < 200; j++) Py[j] = rnd(-3072 + pasY * (j + 1));
    for (let xe = 0; xe <= 160; xe++) {
      for (let ye = 0; ye <= 100; ye++) {
        let x = Px[xe] + 5 * ye + xe, y = Py[ye] + 5 * xe + ye, module = 0, nb = 0;     // départ décalé du point d'orbite
        while (nb < 200 && module < 16777216) {
          const nx = div((imul(x, x) - imul(y, y)) | 0, 2048) + Px[xe];
          y = div(imul(x, y), 1024) + Py[ye]; x = nx; nb++;
          module = (imul(y, y) + imul(x, x)) | 0;
        }
        const c = (div((x + y) | 0, 150) + nb) & 255;
        for (const page of [0, 16000, 32000, 48000]) {
          put(page, xe, ye, c); put(page, xe, 199 - ye, c); put(page, 319 - xe, ye, c); put(page, 319 - xe, 199 - ye, c);
        }
      }
      if (xe % 2) { show(v, 0); yield; }
    }
    show(v, 0); computed = true;
  }
  const scrollTo = (v, start) => { show(v, start & 0xFFFF); };
  function* pan(v) {                                          // for i := 1 to 160 do begin SetStart(i); Delay(3) end
    v.putDac(defaultVGAPalette());
    for (let i = 1; i <= 160; i++) { scrollTo(v, i); yield FRAME; }
  }
  function* diag(v) {                                         // repeat for i := 1 to 300 do SetStart(i*161) … SetStart((300-i)*161)
    v.putDac(defaultVGAPalette());
    for (let i = 1; i <= 300; i++) { scrollTo(v, i * 161); yield FRAME; }
    for (let i = 1; i <= 300; i++) { scrollTo(v, (300 - i) * 161); yield FRAME; }
  }
  // Les scènes 2 et 3 supposent le fractal déjà calculé : si on y arrive directement, on le calcule d'abord sans l'afficher.
  const ensure = function* (v) { if (!computed) { for (const _ of fractal(v)); } };

  const credits = c => drawText(c, [['fill', 'NOIR'], ['win', 5, 1, 73, 16, 'MALOREAN EFFECT  : " The Come Back of SuperCustard Tart "', 'BLEU', 'MAGENTA'],
    ['text', 5, 2, 'GRIS', 'BLEU', ' This Dentro is dedicate to my friend Cédric (A famous Custard Tart) '],
    ['text', 20, 4, 'GRIS', 'MAGENTA', 'VOLPONE          : CODE & MUSIK '],
    ['text', 5, 6, 'GRIS', 'BLEU', '                          SHAREWARE CREDIT                           '],
    ['text', 7, 8, 'GRIS', 'MAGENTA', '   PALETTE              : PALETTE IS RIPED FROM FRACTINT'],
    ['text', 7, 9, 'GRIS', 'MAGENTA', '   PLAYER               : MOD-OBJ By Mark J COX'],
    ['text', 7, 10, 'GRIS', 'MAGENTA', '   TRACKER              : FAST TRACKER By Mr H of Triton'],
    ['text', 5, 12, 'GRIS', 'BLEU', '                               HELLO TO                              '],
    ['text', 7, 13, 'GRIS', 'MAGENTA', '  Fbi,Silk,Weg,TmB,42 Crew,Sally,Jurassique Marc,Sun,Redlight'],
    ['text', 7, 14, 'GRIS', 'MAGENTA', '  Mc2,Locked,Fafa,Les Castors Junior,Mickey,Gaby,Tête de flan'],
    ['text', 7, 15, 'GRIS', 'MAGENTA', '  And all Malorean Effect members or friends'],
    ['text', 5, 16, 'GRIS', 'BLEU', '          BBS        DreamLand   +19  32-39-79-23        BBS         ']]);

  sceneDemo({
    music: 'alice',
    id: 'flan', title: 'The Come Back of SuperCustard Tart', year: 'date inconnue',
    desc: 'Intro dédiée à Cédric : un fractal en entiers dessiné en mode X sur quatre pages, puis défilement matériel de l\'écran (adresse de début d\'écran changée à chaque image). Code et musique de Volpone \u00a0; musique ALICE.MOD (bouton ♪).',
    source: 'DEMO/FLAN/FLAN.EXE (reconstitué par désassemblage)',
    scenes: [
      { name: 'Calcul du fractal', note: 'Mode X, palette VGA par défaut. z₀ = (Px + 5·ye + xe, Py + 5·xe + ye), z ← z² + c, 200 itérations, couleur = ((x+y) div 150 + n) mod 256.', run: fractal },
      { name: 'Défilement horizontal', note: 'SetStart(i) pour i de 1 à 160 : 4 pixels par pas, une ligne plus bas tous les 80 pas.', run: function* (v) { yield* ensure(v); yield* pan(v); } },
      { name: 'Défilement diagonal', note: 'SetStart(i · 161) puis retour : 161 = 2 lignes (160) + 1 octet (4 pixels).', run: function* (v) { yield* ensure(v); yield* diag(v); } },
      { name: 'Crédits', note: 'Page de fin en mode texte, après le fondu de la musique.', text: credits, run: function* () { yield 15000; } },
    ],
  });
})();
