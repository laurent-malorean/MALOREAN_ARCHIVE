// BELLADONE : « Posseded To 3D » (Carle, Turbo Pascal 6, septembre 1992, mode CGA 320×200 en 4 couleurs). Aucun source retrouvé, seulement DEMO1.EXE.
// Ce port exécute le code machine de l'auteur (dix procédures d'effet, moteur 3D en fil de fer, unité de texte) avec l'interpréteur 8086 de js/x86.js ;
// tout ce qui venait de Turbo Pascal/BGI/DOS est remplacé par du JS : tas, fichiers .CGA, Delay, Line de la BGI, BIOS vidéo.
// Les calculs (entiers 32 bits, nombres Real 6 octets, tables trigonométriques) sont ceux de l'original, pas une approximation.
(function () {
  const B = BELLADONE, BASE = 0x1000, DSEG = 0xb46 + BASE, SSEG = B.ss + BASE, VID = 0xB8000;
  const unb64 = s => Uint8Array.from(atob(s), c => c.charCodeAt(0));
  const IMAGE = unb64(B.image), FILES = {}; for (const k in B.files) FILES[k] = unb64(B.files[k]);
  // palettes CGA (6 bits) : BGI mode CGAC0 (le programme appelle InitGraph(CGA, 0)), et la palette cyan/magenta/blanc (CGAC1)
  const PALS = { c0: [0, 0, 0, 21, 63, 21, 63, 21, 21, 63, 63, 21], c1: [0, 0, 0, 21, 63, 63, 63, 21, 63, 63, 63, 63] };
  const pal = { cur: 'c0' };
  const EGA = ['#000', '#00a', '#0a0', '#0aa', '#a00', '#a0a', '#a50', '#aaa', '#555', '#55f', '#5f5', '#5ff', '#f55', '#f5f', '#ff5', '#fff'];
  const CP437 = 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■ ';

  class Machine {
    constructor() {
      const c = this.cpu = new X86(); this.gfx = true; this.color = 3; this.done = false; this.files = new Map(); this.heap = 0x3000; this.frames = 0;
      c.mem.set(IMAGE, BASE * 16);
      for (const [off, seg] of B.relocs) { const a = BASE * 16 + seg * 16 + off, w = IMAGE[seg * 16 + off] | (IMAGE[seg * 16 + off + 1] << 8), v = (w + BASE) & 0xFFFF; c.mem[a] = v & 255; c.mem[a + 1] = v >> 8; }
      c.s[3] = c.s[0] = DSEG; c.s[2] = SSEG; c.r[4] = B.sp; c.r[5] = 0;
      c.onInt = (n) => {};                                     // int 10h/21h/33h directs : sans effet ici
      this.hooks();
    }
    hooks() {
      const c = this.cpu, self = this;
      const H = (seg, off, pop, fn) => c.hooks.set(c.lin(seg + BASE, off), cpu => { fn(cpu); cpu.r[4] = (cpu.r[4] + pop) & 0xFFFF; });
      const pstr = (seg, off) => { let n = c.rb(seg, off), s = ''; for (let i = 1; i <= n; i++) s += String.fromCharCode(c.rb(seg, off + i)); return s; };
      const fkey = (seg, off) => c.lin(seg, off);
      // --- tas
      H(0xa2b, 0x23f, 2, cpu => { const n = cpu.arg(0), seg = self.heap; self.heap += ((n + 15) >> 4) + 1; cpu.r[0] = 0; cpu.r[2] = seg; });
      H(0xa2b, 0x254, 6, () => {});
      // --- fichiers (Assign, Reset, BlockRead, Close)
      H(0xa2b, 0xf33, 8, cpu => { const name = pstr(cpu.arg(2), cpu.arg(0)).split(/[\\/]/).pop().toUpperCase(); self.files.set(fkey(cpu.arg(6), cpu.arg(4)), { name, rec: 128 }); });
      H(0xa2b, 0xf61, 6, cpu => { const f = self.files.get(fkey(cpu.arg(4), cpu.arg(2))); f.rec = cpu.arg(0); f.pos = 0; });
      H(0xa2b, 0x1016, 4, cpu => {
        const f = self.files.get(fkey(cpu.arg(6), cpu.arg(4))), data = FILES[f.name]; if (!data) throw new Error('fichier absent : ' + f.name);
        const dst = c.lin(cpu.arg(2), cpu.arg(0)), n = Math.min(f.rec, data.length - f.pos); c.mem.set(data.subarray(f.pos, f.pos + n), dst); f.pos += n;
      });
      H(0xa2b, 0xfe2, 4, () => {});
      H(0xa2b, 0xe9, 0, () => { self.done = true; c.stop = true; });                   // Halt
      // --- Move (recopie ; une écriture dans B800 termine une image)
      H(0xa2b, 0x90c, 10, cpu => {
        const n = cpu.arg(0), d = c.lin(cpu.arg(4), cpu.arg(2)), s = c.lin(cpu.arg(8), cpu.arg(6));
        if (cpu.arg(4) === 0xB800) { self.shot = c.mem.slice(VID, VID + 0x4000); self.frames++; c.stop = true; }   // image terminée = écran juste avant d'être réécrit
        c.mem.copyWithin(d, s, s + n);
      });
      H(0x9c9, 0x29c, 2, () => {});                                                    // Delay : la cadence est réglée par le curseur de vitesse
      H(0x414, 0, 4, () => {}); H(0x414, 0xc, 4, () => {});                            // souris (int 33h)
      // --- BIOS : Dos.Intr(numéro, regs)
      H(0x677, 0xb, 6, cpu => {
        const no = cpu.arg(4), seg = cpu.arg(2), off = cpu.arg(0), ax = c.rw(seg, off), ah = ax >> 8, al = ax & 255;
        if (no !== 0x10) return;
        if (ah === 0) self.gfx = al >= 4 && al <= 6;
        else if (ah === 6) { const attr = c.rb(seg, off + 7), a = (attr << 8) | 32; for (let i = 0; i < 2000; i++) { c.mem[VID + 2 * i] = 32; c.mem[VID + 2 * i + 1] = attr; } }
      });
      // --- bibliothèque graphique (BGI) : InitGraph, CloseGraph, SetColor, Line
      H(0x69c, 0x746, 12, () => { self.gfx = true; c.mem.fill(0, VID, VID + 0x4000); });
      H(0x69c, 0xa4d, 0, () => { self.gfx = false; });
      H(0x69c, 0x1499, 2, cpu => { self.color = cpu.arg(0) & 3; });
      H(0x69c, 0x135d, 8, cpu => self.line(c.sx16(cpu.arg(6)), c.sx16(cpu.arg(4)), c.sx16(cpu.arg(2)), c.sx16(cpu.arg(0))));
    }
    plot(x, y) {
      if (x < 0 || x > 319 || y < 0 || y > 199) return;
      const a = VID + (y & 1) * 0x2000 + (y >> 1) * 80 + (x >> 2), sh = 6 - 2 * (x & 3), m = this.cpu.mem;
      m[a] = (m[a] & ~(3 << sh)) | (this.color << sh);
    }
    line(x0, y0, x1, y1) {                                     // Line de la BGI : Bresenham, fenêtre 320×200 (découpage de Cohen-Sutherland)
      const code = (x, y) => (x < 0 ? 1 : x > 319 ? 2 : 0) | (y < 0 ? 4 : y > 199 ? 8 : 0);
      let c0 = code(x0, y0), c1 = code(x1, y1);
      for (let g = 0; g < 20; g++) {
        if (!(c0 | c1)) break; if (c0 & c1) return;
        const co = c0 || c1; let x, y;
        if (co & 8) { x = x0 + (x1 - x0) * (199 - y0) / (y1 - y0); y = 199; } else if (co & 4) { x = x0 + (x1 - x0) * (0 - y0) / (y1 - y0); y = 0; }
        else if (co & 2) { y = y0 + (y1 - y0) * (319 - x0) / (x1 - x0); x = 319; } else { y = y0 + (y1 - y0) * (0 - x0) / (x1 - x0); x = 0; }
        x = Math.round(x); y = Math.round(y);
        if (co === c0) { x0 = x; y0 = y; c0 = code(x0, y0); } else { x1 = x; y1 = y; c1 = code(x1, y1); }
      }
      const dx = Math.abs(x1 - x0), dy = -Math.abs(y1 - y0), sx = x0 < x1 ? 1 : -1, sy = y0 < y1 ? 1 : -1; let e = dx + dy;
      for (;;) { this.plot(x0, y0); if (x0 === x1 && y0 === y1) break; const e2 = 2 * e; if (e2 >= dy) { e += dy; x0 += sx; } if (e2 <= dx) { e += dx; y0 += sy; } }
    }
    // appelle une procédure lointaine du programme et l'exécute jusqu'au retour (ou jusqu'à la prochaine image si frame = true)
    call(seg, off) { const c = this.cpu; c.push(0xF000); c.push(0); c.s[1] = seg + BASE; c.ip = off; this.ret = true; }
    runUntil(fn) { const c = this.cpu; for (let g = 0; g < 4000; g++) { c.stop = false; c.run(50000); if (c.stop || c.s[1] === 0xF000) return; } }
    boot() {                                                   // préambule du programme principal : unité 3D (tables trigonométriques), tampon d'image
      const c = this.cpu;
      c.wb(DSEG, 0x7e4, 0);
      this.call(0x67e, 0xa); while (c.s[1] !== 0xF000 && !this.done) this.runUntil();
      c.s[3] = c.s[0] = DSEG;
      const seg = this.heap; this.heap += 0x3ff + 1; c.ww(DSEG, 0x6b4, 0); c.ww(DSEG, 0x6b6, seg);
      c.mem.fill(0, VID, VID + 0x4000);
    }
    startEffect(off) { this.call(0, off); }
    finished() { return this.done || this.cpu.s[1] === 0xF000; }
    // dessine l'écran CGA 2 bits dans la mémoire VGA 320×200 (indices 0..3)
    present(v, live) {
      const m = (!live && this.shot) ? this.shot : this.cpu.mem, o = v.mem, VID = (!live && this.shot) ? 0 : 0xB8000;
      for (let y = 0; y < 200; y++) { const base = VID + (y & 1) * 0x2000 + (y >> 1) * 80, row = y * 320; for (let x = 0; x < 320; x += 4) { const b = m[base + (x >> 2)]; o[row + x] = b >> 6; o[row + x + 1] = (b >> 4) & 3; o[row + x + 2] = (b >> 2) & 3; o[row + x + 3] = b & 3; } }
    }
  }
  const effect = off => {
    return function* (v) {
      const m = new Machine(); m.boot(); m.startEffect(off);
      const p = PALS[pal.cur], full = new Array(768).fill(0); for (let i = 0; i < 12; i++) full[i] = p[i]; v.putDac(full);
      for (;;) {
        m.runUntil();
        const q = PALS[pal.cur]; for (let i = 0; i < 12; i++) full[i] = q[i]; v.putDac(full);
        m.present(v, m.finished());
        if (m.finished()) break;
        yield;
      }
    };
  };
  // page finale en mode texte (80×25) : on exécute la procédure d'origine puis on lit le tampon de B800
  function textPage(canvas) {
    const m = new Machine(); m.gfx = false; m.boot(); m.call(0, 0x3739);
    for (let g = 0; g < 200 && !m.finished(); g++) m.runUntil();
    const c = canvas.getContext('2d'), mem = m.cpu.mem; c.font = 'bold 13px Menlo, Consolas, "Courier New", monospace'; c.textBaseline = 'middle';
    for (let y = 0; y < 25; y++) for (let x = 0; x < 80; x++) {
      const ch = mem[VID + 2 * (y * 80 + x)], at = mem[VID + 2 * (y * 80 + x) + 1];
      c.fillStyle = EGA[(at >> 4) & 7]; c.fillRect(x * 8, y * 16, 8, 16);
      if (ch > 32) { c.fillStyle = EGA[at & 15]; c.fillText(ch < 128 ? String.fromCharCode(ch) : CP437[ch - 128], x * 8, y * 16 + 9); }
    }
  }
  const E = [['Présentation', 'PRESENTE.CGA et un cube en fil de fer qui grandit puis tourne (six séquences de rotation).', 0xd],
    ['Solide et morphing', 'MANDEL8.CGA : un polyèdre qui se transforme en un autre par interpolation (nombres Real).', 0x27d],
    ['Solides en fil de fer', 'BELLADON.CGA : deux solides successifs.', 0xaec],
    ['Polyèdre qui tourne', 'MANDEL1.CGA : polyèdre à 16 sommets.', 0xf91],
    ['Grand solide', 'MANDEL5.CGA : solide à 54 sommets.', 0x1112],
    ['Trois fonds', 'UNI1.CGA, UNI2.CGA, UNI4.CGA : objets déplacés par pas.', 0x13fd],
    ['Solides sur Mandelbrot', 'MANDEL6.CGA.', 0x191a],
    ['Cube et pyramide liés', 'BELLADON.CGA : objets à deux niveaux de sommets.', 0x1bdd],
    ['Cubes en trajectoires', 'MANDEL4.CGA : une trentaine de cubes sur des courbes.', 0x239d],
    ['Cube et pyramide', 'BELLADON.CGA : cube, pyramide, déplacements.', 0x2ec7]];
  window.BELLADONE_API = { Machine, PALS };
  sceneDemo({
    id: 'belladone', title: 'Belladone : Posseded To 3D', year: '1992',
    desc: 'Démo CGA 320×200 en 4 couleurs de Carle (août-septembre 1992), groupe Belladone : fractales précalculées (Mandelbrot) et objets 3D en fil de fer. Le source n\'existe plus : le code machine de DEMO1.EXE est exécuté par un interpréteur 8086 en JS, avec la bibliothèque de Turbo Pascal remplacée par du JS.',
    source: 'DEMO/BELLADONE/build/DEMO1.EXE (+ ressources/*.CGA, TRIGO.TBL)',
    extra(bar) {
      bar.insertAdjacentHTML('beforeend', '<label>Couleurs <select id="bpal"><option value="c0">CGAC0 vert/rouge/jaune</option><option value="c1">cyan/magenta/blanc</option></select></label>');
      bar.querySelector('#bpal').onchange = e => { pal.cur = e.target.value; };
    },
    scenes: [...E.map(([name, note, off], i) => ({ name: (i + 1) + '. ' + name, note, run: effect(off) })),
      { name: 'Page finale (texte)', note: 'Message de fin en mode texte 80×25, produit par l\'unité de fenêtres de l\'auteur.', text: textPage, run: function* () { yield 15000; } }],
  });
})();
