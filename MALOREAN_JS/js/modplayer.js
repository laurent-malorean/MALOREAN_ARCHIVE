// Lecteur de modules ProTracker « M.K. » (4 voix) pour le navigateur : remplace MOD-OBJ de Mark J. Cox utilisé par les démos.
//   const mod = MODPlayer.parse(arrayBuffer);  const p = new MODPlayer(mod); p.start(); p.stop();
// Effets : arpège 0, glissandos 1-2, portamento 3, vibrato 4, 5, 6, tremolo 7, décalage 9, volume A et C, saut B, fin de motif D,
// E1 E2 E5 EA EB EC, vitesse/tempo F. Mixage à interpolation linéaire, panoramique gauche-droite-droite-gauche.
class MODPlayer {
  static SINE = Array.from({ length: 32 }, (_, i) => Math.round(255 * Math.sin(Math.PI * i / 32)));
  static PAULA = 7093789.2;                                  // horloge Amiga PAL : fréquence d'échantillon = PAULA / (2 · période)

  static parse(buf) {
    const b = new Uint8Array(buf), dv = new DataView(buf);
    const mod = { title: String.fromCharCode(...b.subarray(0, 20)).replace(/\0.*$/, ''), samples: [], order: Array.from(b.subarray(952, 952 + 128)), len: b[950] || 1 };
    for (let i = 0; i < 31; i++) {
      const o = 20 + i * 30, ft = b[o + 24] & 15;
      mod.samples.push({ len: dv.getUint16(o + 22) * 2, fine: ft > 7 ? ft - 16 : ft, vol: Math.min(64, b[o + 25]),
        loopStart: dv.getUint16(o + 26) * 2, loopLen: dv.getUint16(o + 28) * 2, data: null });
    }
    const pats = Math.max(...mod.order) + 1; mod.patterns = [];
    for (let p = 0; p < pats; p++) {
      const rows = [];
      for (let r = 0; r < 64; r++) {
        const row = [];
        for (let c = 0; c < 4; c++) {
          const o = 1084 + p * 1024 + r * 16 + c * 4, a = b[o], bb = b[o + 1], cc = b[o + 2], d = b[o + 3];
          row.push({ sample: (a & 0xF0) | (cc >> 4), period: ((a & 15) << 8) | bb, eff: cc & 15, x: d >> 4, y: d & 15, p: d });
        }
        rows.push(row);
      }
      mod.patterns.push(rows);
    }
    let off = 1084 + pats * 1024;
    for (const s of mod.samples) {
      const n = Math.max(0, Math.min(s.len, b.length - off)); s.data = new Float32Array(n);
      for (let i = 0; i < n; i++) s.data[i] = ((b[off + i] << 24) >> 24) / 128;
      off += s.len;
    }
    return mod;
  }

  constructor(mod) { this.mod = mod; this.rate = 44100; this.ctx = null; this.src = null; this.reset(); }
  reset() {
    this.speed = 6; this.tempo = 125; this.tick = 0; this.row = 0; this.pos = 0; this.nextPos = -1; this.nextRow = -1; this.left = 0;
    this.loopRow = 0; this.loopCount = 0; this.samples = 0; this.loop = null;
    this.ch = Array.from({ length: 4 }, () => ({ s: 0, period: 0, base: 0, target: 0, vol: 64, ptr: 0, step: 0, eff: 0, x: 0, y: 0, p: 0,
      portaSpeed: 0, vibSpeed: 0, vibDepth: 0, vibPos: 0, tremSpeed: 0, tremDepth: 0, tremPos: 0, slide: 0, fine: 0, cut: -1, volDelta: 0 }));
  }
  // Rend toute la musique en mémoire (jusqu'au retour au début du morceau) : { L, R } à la fréquence `rate`.
  renderLoop(rate, maxSeconds = 300) {
    this.rate = rate; this.reset(); this.visited = new Map();
    const chunk = 4096, parts = []; let total = 0;
    while (total < maxSeconds * rate && !this.loop) {
      const L = new Float32Array(chunk), R = new Float32Array(chunk); this.render(L, R); parts.push([L, R]); total += chunk;
    }
    this.visited = null;
    const end = this.loop ? Math.min(this.loop.end, total) : total, start = this.loop ? this.loop.start : 0;
    const L = new Float32Array(end), R = new Float32Array(end); let o = 0;
    for (const [l, r] of parts) { const n = Math.min(chunk, end - o); if (n <= 0) break; L.set(l.subarray(0, n), o); R.set(r.subarray(0, n), o); o += n; }
    return { L, R, start: start / rate, end: end / rate, seconds: end / rate };
  }
  start() {
    if (this.src) return;
    const AC = window.AudioContext || window.webkitAudioContext; this.ctx = new AC();
    const { L, R, start, end } = this.renderLoop(this.ctx.sampleRate), buf = this.ctx.createBuffer(2, L.length, this.ctx.sampleRate);
    buf.copyToChannel(L, 0); buf.copyToChannel(R, 1);
    this.src = this.ctx.createBufferSource(); this.src.buffer = buf; this.src.loop = true; this.src.loopStart = start; this.src.loopEnd = end; this.src.connect(this.ctx.destination); this.src.start();
    if (this.ctx.state === 'suspended') this.ctx.resume();
  }
  stop() {
    if (!this.src) return;
    try { this.src.stop(); } catch (e) {} this.src.disconnect(); this.src = null; this.ctx.close(); this.ctx = null;
  }
  get playing() { return !!this.src; }

  setPeriod(c, p) { c.period = Math.max(113, Math.min(856, p)); c.step = MODPlayer.PAULA / (c.period * 2) / this.rate; }

  // ---- tick 0 : lecture de la ligne
  startRow() {
    const m = this.mod, row = m.patterns[m.order[this.pos]][this.row];
    if (this.visited) {                                       // retour sur une position déjà jouée, au moins 8 s plus tard : le morceau boucle
      const key = this.pos * 64 + this.row, t0 = this.visited.get(key);
      if (t0 === undefined) this.visited.set(key, this.samples);
      else if (!this.loop && this.samples - t0 > 8 * this.rate) this.loop = { start: t0, end: this.samples };
    }
    for (let i = 0; i < 4; i++) {
      const c = this.ch[i], n = row[i];
      c.eff = n.eff; c.x = n.x; c.y = n.y; c.p = n.p; c.slide = 0; c.volDelta = 0; c.cut = -1;
      if (n.sample) { const s = m.samples[n.sample - 1]; if (s) { c.s = n.sample; c.vol = s.vol; c.fine = s.fine; } }
      if (n.period) {
        const per = c.fine ? Math.round(n.period * Math.pow(2, -c.fine / 96)) : n.period;
        if (n.eff === 3 || n.eff === 5) c.target = per;
        else { c.base = per; this.setPeriod(c, per); c.ptr = n.eff === 9 ? n.p * 256 : 0; if (!(c.vibWave & 4)) c.vibPos = 0; }
      }
      switch (n.eff) {
        case 1: c.slide = -n.p; break;
        case 2: c.slide = n.p; break;
        case 3: if (n.p) c.portaSpeed = n.p; break;
        case 4: if (n.x) c.vibSpeed = n.x; if (n.y) c.vibDepth = n.y; break;
        case 7: if (n.x) c.tremSpeed = n.x; if (n.y) c.tremDepth = n.y; break;
        case 5: case 6: case 10: c.volDelta = n.x ? n.x : -n.y; break;
        case 11: this.nextPos = n.p; this.nextRow = 0; break;
        case 12: c.vol = Math.min(64, n.p); break;
        case 13: this.nextRow = n.x * 10 + n.y; if (this.nextPos < 0) this.nextPos = this.pos + 1; break;
        case 15: if (n.p) { if (n.p < 32) this.speed = n.p; else this.tempo = n.p; } break;
        case 14:
          if (n.x === 1) this.setPeriod(c, c.period - n.y); else if (n.x === 2) this.setPeriod(c, c.period + n.y);
          else if (n.x === 5) c.fine = n.y > 7 ? n.y - 16 : n.y;
          else if (n.x === 6) {
            if (n.y === 0) this.loopRow = this.row;
            else { this.loopCount = this.loopCount === 0 ? n.y : this.loopCount - 1; if (this.loopCount > 0) { this.nextRow = this.loopRow; if (this.nextPos < 0) this.nextPos = this.pos; } }
          }
          else if (n.x === 10) c.vol = Math.min(64, c.vol + n.y); else if (n.x === 11) c.vol = Math.max(0, c.vol - n.y);
          else if (n.x === 12) c.cut = n.y;
          break;
      }
    }
  }
  // ---- ticks 1 … speed-1
  tickEffects(t) {
    for (const c of this.ch) {
      if (c.cut === t) c.vol = 0;
      switch (c.eff) {
        case 0: if (c.p && c.base) { const k = t % 3, semi = k === 0 ? 0 : k === 1 ? c.x : c.y; this.setPeriod(c, Math.round(c.base * Math.pow(2, -semi / 12))); } break;
        case 1: case 2: this.setPeriod(c, c.period + c.slide); c.base = c.period; break;
        case 3: this.porta(c); break;
        case 5: this.porta(c); c.vol = Math.max(0, Math.min(64, c.vol + c.volDelta)); break;
        case 4: this.vibrato(c); break;
        case 6: this.vibrato(c); c.vol = Math.max(0, Math.min(64, c.vol + c.volDelta)); break;
        case 10: c.vol = Math.max(0, Math.min(64, c.vol + c.volDelta)); break;
      }
    }
  }
  porta(c) {
    if (!c.target || c.period === c.target) return;
    this.setPeriod(c, c.period < c.target ? Math.min(c.target, c.period + c.portaSpeed) : Math.max(c.target, c.period - c.portaSpeed)); c.base = c.period;
  }
  vibrato(c) {
    const d = (MODPlayer.SINE[c.vibPos & 31] * c.vibDepth) >> 7;
    this.setPeriod(c, c.base + ((c.vibPos & 32) ? -d : d)); c.vibPos = (c.vibPos + c.vibSpeed) & 63;
  }
  advance() {
    if (++this.tick < this.speed) return;
    this.tick = 0;
    if (this.nextPos >= 0 || this.nextRow >= 0) {
      if (this.nextPos >= 0) this.pos = this.nextPos >= this.mod.len ? 0 : this.nextPos; else this.pos++;
      this.row = Math.max(0, this.nextRow); this.nextPos = this.nextRow = -1;
    } else if (++this.row >= 64) { this.row = 0; this.pos++; }
    if (this.pos >= this.mod.len) this.pos = 0;
  }
  render(L, R) {
    const n = L.length; let i = 0;
    while (i < n) {
      if (this.left <= 0) {
        if (this.tick === 0) this.startRow(); else this.tickEffects(this.tick);
        this.left = this.rate * 2.5 / this.tempo;
      }
      const chunk = Math.min(n - i, Math.ceil(this.left));
      for (let k = 0; k < chunk; k++) {
        let l = 0, r = 0;
        for (let v = 0; v < 4; v++) {
          const c = this.ch[v]; if (!c.s || !c.step) continue;
          const s = this.mod.samples[c.s - 1], d = s.data, len = d.length; if (!len) continue;
          let p = c.ptr;
          if (s.loopLen > 2) { const end = s.loopStart + s.loopLen; if (p >= end) p = c.ptr = s.loopStart + ((p - s.loopStart) % s.loopLen); }
          else if (p >= len) continue;
          const ip = p | 0, ip2 = (s.loopLen > 2 && ip + 1 >= s.loopStart + s.loopLen) ? s.loopStart : ip + 1;
          const a = d[ip], b = ip2 < len ? d[ip2] : 0, amp = (a + (b - a) * (p - ip)) * (c.vol / 64) * 0.45;
          if (v === 0 || v === 3) l += amp; else r += amp;
          c.ptr += c.step;
        }
        L[i + k] = l > 1 ? 1 : l < -1 ? -1 : l; R[i + k] = r > 1 ? 1 : r < -1 ? -1 : r;
      }
      i += chunk; this.left -= chunk; this.samples += chunk;
      if (this.left <= 0) this.advance();
    }
  }
}
window.MODPlayer = MODPlayer;
