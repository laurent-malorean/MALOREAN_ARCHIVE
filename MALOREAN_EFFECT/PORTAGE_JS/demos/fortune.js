// FORTUNE.EXE : « Fortune plango vulnera » (Volpone, code et musique, août 1994). Port reconstitué depuis le désassemblage de FORTUNE.EXE
// (PKLITE déballé, Turbo Pascal 6). Le programme :
//   1. calcule au départ trois tables de 1000 entiers avec des sinus/cosinus en Real (data/fortune.js) et une table de lignes T[k] = 320·k ;
//   2. pour chaque « phase » (a de 50 à 150, 150 à 250, 250 à 350, 350 à 450, 450 à 550, 700 à 800 deux fois) dessine, pour i de 0 à 99 et j de i à 99,
//        v = T45[i + a] + TC2[j + a] − T14[a]            (entiers 16 bits)
//      avec une variante selon la phase (+ Random(7), or i, xor i), couleur = v mod 256, et écrit le point aux huit positions symétriques ;
//   3. recommence tant qu'une touche n'est pas pressée ; musique SPACE.MOD.
(function () {
  const F = FORTUNE, T = Array.from({ length: 200 }, (_, k) => k * 320), CENTRE = 0x7da0;
  const w16 = x => (x << 16) >> 16;
  // variante de la couleur selon la phase (numérotées comme dans l'exécutable : 0x522, 0x6c3, 0x894, 0xa53, 0xc20, 0xddf, 0xfac)
  const PHASES = [
    { a0: 50, a1: 150, c: (v) => v, note: 'v = T45[i+a] + TC2[j+a] − T14[a].' },
    { a0: 150, a1: 250, c: (v) => v + Math.floor(Math.random() * 7), note: 'Même formule + Random(7) : le grain.' },
    { a0: 250, a1: 350, c: (v) => v, note: 'Même formule que la phase 1.' },
    { a0: 350, a1: 450, c: (v, i) => v | i, note: 'v or i.' },
    { a0: 450, a1: 550, c: (v) => v, note: 'Même formule que la phase 1.' },
    { a0: 700, a1: 800, c: (v, i) => v ^ i, note: 'v xor i.' },
    { a0: 700, a1: 800, c: (v) => v, note: 'Même formule, sur la dernière plage de a.' },
  ];
  function frame(m, a, ph) {                                   // un pas de la boucle sur a : huit points par (i, j)
    for (let i = 0; i <= 99; i++) {
      const ti = T[i];
      for (let j = i; j <= 99; j++) {
        const tj = T[j], c = ph.c(w16(F.t45c[i + a] + F.tc2e[j + a] - F.t1400[a]), i) & 255;
        m[(CENTRE + tj + i) & 0xFFFF] = c; m[(CENTRE + tj - i) & 0xFFFF] = c; m[(CENTRE - tj - i) & 0xFFFF] = c; m[(CENTRE - tj + i) & 0xFFFF] = c;
        m[(CENTRE + ti + j) & 0xFFFF] = c; m[(CENTRE + ti - j) & 0xFFFF] = c; m[(CENTRE - ti - j) & 0xFFFF] = c; m[(CENTRE - ti + j) & 0xFFFF] = c;
      }
    }
  }
  const run = (list, clear = true) => function* (v) {
    v.putDac(F.pal); if (clear) v.cls(0);
    for (const ph of list) for (let a = ph.a0; a <= ph.a1; a++) { frame(v.mem, a, ph); yield; }
  };
  const credits = c => drawText(c, [['fill', 'NOIR'], ['win', 5, 1, 73, 16, 'MALOREAN EFFECT  : " Fortune plango vulnera "', 'BLEU', 'MAGENTA'],
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
    music: 'space',
    id: 'fortune', title: 'Fortune plango vulnera', year: '1994',
    desc: 'Code et musique de Volpone (août 1994). Une seule formule à trois tables, évaluée sur un huitième d\'écran et recopiée par symétrie ; les 7 phases changent la plage du paramètre a et un petit terme (Random, or, xor). Musique SPACE.MOD (bouton ♪).',
    source: 'DEMO/FORTUNE/build/FORTUNE.EXE (reconstitué par désassemblage)',
    scenes: [
      { name: 'Effet complet (7 phases)', note: 'Les sept phases à la suite ; le programme original recommence en boucle jusqu\'à une touche.', run: run(PHASES) },
      ...PHASES.map((p, k) => ({ name: 'Phase ' + (k + 1) + ' : a de ' + p.a0 + ' à ' + p.a1, note: p.note, run: run([p]) })),
      { name: 'Crédits', note: 'Page de fin en mode texte.', text: credits, run: function* () { yield 15000; } },
    ],
  });
})();
