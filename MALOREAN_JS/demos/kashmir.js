// KASHMIR : diaporama des images retrouvées (aucun source Pascal ni EXE). Les CYCLE1…12 (GIF de juin 1993) sont des images à palette tournante :
// ici la palette est décalée d'une entrée par tick (IncDac), comme dans les autres démos. Les MALOREAN.0xx sont des captures SHOOT 1993-94.
(function () {
  const K = {}; KASHMIR.forEach(([n, b]) => K[n] = b);
  const rot = (p, n) => { const o = p.slice(); for (let f = 2; f <= n; f++) for (let k = 0; k < 3; k++) p[f * 3 + k] = o[(f - 1) * 3 + k]; for (let k = 0; k < 3; k++) p[3 + k] = o[n * 3 + k]; };
  const slide = (name, note, key, cycle, ticks = 150) => ({ name, note, run: function* (v) {
    v.loadShoot(K[key]);
    const p = v.pal.slice();
    for (let i = 0; i < ticks; i++) { if (cycle) { rot(p, 255); v.putDac(p); } yield TICK; }
  } });
  const scenes = [
    slide('Intro', 'INTRO.GIF', 'INTRO', false), slide('Malorean Effect', 'MALOEFF.GIF', 'MALOEFF', false),
    slide('Château', 'CHATEAU.GIF', 'CHATEAU', false), slide('Benoît', 'BENOIT.GIF', 'BENOIT', false), slide('Lauren', 'LAUREN2.GIF', 'LAUREN2', false),
  ];
  for (let i = 1; i <= 12; i++) scenes.push(slide('Cycle ' + i, 'CYCLE' + i + '.GIF · palette qui tourne (entrées 1 à 255)', 'CYCLE' + i, true, 200));
  KASHMIR.filter(([n]) => /^(MALOREAN|LIN|LN)_/.test(n)).forEach(([n]) => scenes.push(slide('Image ' + n.replace('_', '.'), 'IMG_DIV/' + n.replace('_', '.') + ' (SHOOT)', n, false, 120)));
  sceneDemo({
    id: 'kashmir', title: 'Kashmir', year: '1993–94',
    desc: 'Diaporama : ' + scenes.length + ' images de la démo Kashmir (dont 12 à palette tournante). Le programme lui-même n\'a pas été retrouvé.',
    source: 'CODE/demosour/kashmir/IMAGES/*.GIF · IMG_DIV/*',
    scenes,
  });
})();
