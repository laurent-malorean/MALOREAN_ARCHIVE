// Interpréteur 8086/286 réel (16 bits) minimal : exécute le code machine d'un .EXE DOS dont le source Pascal n'a pas été retrouvé.
// Utilisé par BELLADONE : seul le code de l'auteur et les routines arithmétiques de Turbo Pascal sont exécutés ; la bibliothèque graphique,
// les fichiers, le tas et le clavier sont remplacés par des fonctions JS (« hooks » posés sur les appels lointains).
class X86 {
  constructor() {
    this.mem = new Uint8Array(0x110000);
    this.r = new Uint16Array(8);                    // AX CX DX BX SP BP SI DI
    this.s = new Uint16Array(4);                    // ES CS SS DS
    this.ip = 0; this.cf = this.pf = this.af = this.zf = this.sf = this.of = this.df = 0;
    this.hooks = new Map(); this.stop = false; this.count = 0;
    this.pre = -1; this.rep = 0; this.bad = null;
  }
  // ---- mémoire
  lin(seg, off) { return ((seg << 4) + (off & 0xFFFF)) & 0xFFFFF; }
  rb(seg, off) { return this.mem[this.lin(seg, off)]; }
  rw(seg, off) { const a = this.lin(seg, off); return this.mem[a] | (this.mem[(a + 1) & 0xFFFFF] << 8); }
  wb(seg, off, v) { this.mem[this.lin(seg, off)] = v; }
  ww(seg, off, v) { const a = this.lin(seg, off); this.mem[a] = v & 255; this.mem[(a + 1) & 0xFFFFF] = (v >> 8) & 255; }
  push(v) { this.r[4] = (this.r[4] - 2) & 0xFFFF; this.ww(this.s[2], this.r[4], v); }
  pop() { const v = this.rw(this.s[2], this.r[4]); this.r[4] = (this.r[4] + 2) & 0xFFFF; return v; }
  arg(k) { return this.rw(this.s[2], this.r[4] + k); }       // argument k (en octets) dans la pile d'un appel intercepté
  fetch8() { const v = this.mem[this.lin(this.s[1], this.ip)]; this.ip = (this.ip + 1) & 0xFFFF; return v; }
  fetch16() { const v = this.fetch8(); return v | (this.fetch8() << 8); }
  sx8(v) { return (v << 24) >> 24; }
  sx16(v) { return (v << 16) >> 16; }
  // ---- registres 8 bits : 0-3 AL CL DL BL, 4-7 AH CH DH BH
  g8(i) { return i < 4 ? this.r[i] & 255 : this.r[i - 4] >> 8; }
  p8(i, v) { v &= 255; if (i < 4) this.r[i] = (this.r[i] & 0xFF00) | v; else this.r[i - 4] = (this.r[i - 4] & 0xFF) | (v << 8); }
  // ---- ModRM
  modrm() {
    const b = this.fetch8(); this.mod = b >> 6; this.reg = (b >> 3) & 7; this.rm = b & 7;
    if (this.mod === 3) { this.isReg = true; return; }
    this.isReg = false; const r = this.r; let off = 0, seg = 3;
    switch (this.rm) {
      case 0: off = r[3] + r[6]; break; case 1: off = r[3] + r[7]; break;
      case 2: off = r[5] + r[6]; seg = 2; break; case 3: off = r[5] + r[7]; seg = 2; break;
      case 4: off = r[6]; break; case 5: off = r[7]; break; case 6: off = r[5]; seg = 2; break; case 7: off = r[3]; break;
    }
    if (this.mod === 0 && this.rm === 6) { off = this.fetch16(); seg = 3; }
    else if (this.mod === 1) off += this.sx8(this.fetch8());
    else if (this.mod === 2) off += this.fetch16();
    this.eo = off & 0xFFFF; this.es = this.pre >= 0 ? this.pre : seg;
  }
  gE8() { return this.isReg ? this.g8(this.rm) : this.rb(this.s[this.es], this.eo); }
  gE16() { return this.isReg ? this.r[this.rm] : this.rw(this.s[this.es], this.eo); }
  pE8(v) { if (this.isReg) this.p8(this.rm, v); else this.wb(this.s[this.es], this.eo, v); }
  pE16(v) { if (this.isReg) this.r[this.rm] = v; else this.ww(this.s[this.es], this.eo, v); }
  // ---- arithmétique et drapeaux
  par(v) { v &= 255; v ^= v >> 4; v ^= v >> 2; v ^= v >> 1; return (~v) & 1; }
  alu(op, a, b, w) {                              // 0 add 1 or 2 adc 3 sbb 4 and 5 sub 6 xor 7 cmp ; w = 8 ou 16
    const m = w === 8 ? 0xFF : 0xFFFF, sg = w === 8 ? 0x80 : 0x8000; let t;
    switch (op) {
      case 0: case 2: { const c = op === 2 ? this.cf : 0; t = a + b + c; this.cf = t > m ? 1 : 0; this.of = (~(a ^ b) & (a ^ t) & sg) ? 1 : 0; this.af = ((a ^ b ^ t) & 16) ? 1 : 0; break; }
      case 5: case 7: case 3: { const c = op === 3 ? this.cf : 0; t = a - b - c; this.cf = t < 0 ? 1 : 0; this.of = ((a ^ b) & (a ^ t) & sg) ? 1 : 0; this.af = ((a ^ b ^ t) & 16) ? 1 : 0; break; }
      case 1: t = a | b; this.cf = this.of = 0; break;
      case 4: t = a & b; this.cf = this.of = 0; break;
      case 6: t = a ^ b; this.cf = this.of = 0; break;
    }
    t &= m; this.zf = t === 0 ? 1 : 0; this.sf = t & sg ? 1 : 0; this.pf = this.par(t); return t;
  }
  incdec(v, d, w) {
    const m = w === 8 ? 0xFF : 0xFFFF, sg = w === 8 ? 0x80 : 0x8000, t = (v + d) & m;
    this.of = d > 0 ? (v === sg - 1 ? 1 : 0) : (v === sg ? 1 : 0); this.zf = t === 0 ? 1 : 0; this.sf = t & sg ? 1 : 0; this.pf = this.par(t); this.af = ((v ^ t) & 16) ? 1 : 0; return t;
  }
  shift(op, v, n, w) {
    const bits = w, m = w === 8 ? 0xFF : 0xFFFF, sg = w === 8 ? 0x80 : 0x8000; n &= 31; if (!n) return v;
    let t = v;
    switch (op) {
      case 0: for (let i = 0; i < n; i++) { this.cf = (t & sg) ? 1 : 0; t = ((t << 1) | this.cf) & m; } this.of = ((t & sg) ? 1 : 0) ^ this.cf; return t;   // rol
      case 1: for (let i = 0; i < n; i++) { this.cf = t & 1; t = (t >> 1) | (this.cf ? sg : 0); } this.of = ((t ^ (t << 1)) & sg) ? 1 : 0; return t;       // ror
      case 2: for (let i = 0; i < n; i++) { const c = (t & sg) ? 1 : 0; t = ((t << 1) | this.cf) & m; this.cf = c; } this.of = ((t & sg) ? 1 : 0) ^ this.cf; return t; // rcl
      case 3: for (let i = 0; i < n; i++) { const c = t & 1; t = (t >> 1) | (this.cf ? sg : 0); this.cf = c; } this.of = ((t ^ (t << 1)) & sg) ? 1 : 0; return t;  // rcr
      case 4: case 6: { const o = t; if (n > bits) { t = 0; this.cf = 0; } else { this.cf = (o >> (bits - n)) & 1; t = (o << n) & m; } this.of = ((t & sg) ? 1 : 0) ^ this.cf; break; }          // shl
      case 5: { const o = t; this.cf = n > bits ? 0 : (o >> (n - 1)) & 1; t = n >= bits ? 0 : o >> n; this.of = (o & sg) ? 1 : 0; break; }                                         // shr
      case 7: { const o = w === 8 ? this.sx8(t) : this.sx16(t); this.cf = (o >> Math.min(n - 1, 31)) & 1; t = (o >> Math.min(n, 31)) & m; this.of = 0; break; }                // sar
    }
    this.zf = t === 0 ? 1 : 0; this.sf = t & sg ? 1 : 0; this.pf = this.par(t); return t;
  }
  cond(c) {
    let r;
    switch (c >> 1) {
      case 0: r = this.of; break; case 1: r = this.cf; break; case 2: r = this.zf; break; case 3: r = this.cf | this.zf; break;
      case 4: r = this.sf; break; case 5: r = this.pf; break; case 6: r = this.sf ^ this.of; break; default: r = this.zf | (this.sf ^ this.of);
    }
    return (c & 1) ? !r : !!r;
  }
  flags() { return this.cf | 2 | (this.pf << 2) | (this.af << 4) | (this.zf << 6) | (this.sf << 7) | (1 << 9) | (this.df << 10) | (this.of << 11); }
  setFlags(f) { this.cf = f & 1; this.pf = (f >> 2) & 1; this.af = (f >> 4) & 1; this.zf = (f >> 6) & 1; this.sf = (f >> 7) & 1; this.df = (f >> 10) & 1; this.of = (f >> 11) & 1; }
  callFar(seg, off, retIp) {
    const h = this.hooks.get(this.lin(seg, off));
    if (this.trace) this.trace(seg, off, !!h);
    if (h) { h(this); return; }
    this.push(this.s[1]); this.push(retIp); this.s[1] = seg; this.ip = off;
  }
  // ---- exécution : au plus n instructions, ou jusqu'à this.stop
  run(n) {
    const r = this.r, s = this.s;
    while (n-- > 0 && !this.stop) {
      if (s[1] === 0xF000) { this.stop = true; break; }
      this.pre = -1; this.rep = 0;
      let op = this.fetch8();
      for (;;) {                                   // préfixes
        if (op === 0x26) this.pre = 0; else if (op === 0x2E) this.pre = 1; else if (op === 0x36) this.pre = 2; else if (op === 0x3E) this.pre = 3;
        else if (op === 0xF3) this.rep = 1; else if (op === 0xF2) this.rep = 2; else break;
        op = this.fetch8();
      }
      this.count++;
      if (op < 0x40 && (op & 7) < 6) {             // ALU
        const k = op >> 3, f = op & 7;
        if (f === 0) { this.modrm(); const t = this.alu(k, this.gE8(), this.g8(this.reg), 8); if (k !== 7) this.pE8(t); }
        else if (f === 1) { this.modrm(); const t = this.alu(k, this.gE16(), r[this.reg], 16); if (k !== 7) this.pE16(t); }
        else if (f === 2) { this.modrm(); const t = this.alu(k, this.g8(this.reg), this.gE8(), 8); if (k !== 7) this.p8(this.reg, t); }
        else if (f === 3) { this.modrm(); const t = this.alu(k, r[this.reg], this.gE16(), 16); if (k !== 7) r[this.reg] = t; }
        else if (f === 4) { const t = this.alu(k, r[0] & 255, this.fetch8(), 8); if (k !== 7) this.p8(0, t); }
        else { const t = this.alu(k, r[0], this.fetch16(), 16); if (k !== 7) r[0] = t; }
        continue;
      }
      switch (op) {
        case 0x06: this.push(s[0]); break; case 0x07: s[0] = this.pop(); break;
        case 0x0E: this.push(s[1]); break; case 0x16: this.push(s[2]); break; case 0x17: s[2] = this.pop(); break;
        case 0x1E: this.push(s[3]); break; case 0x1F: s[3] = this.pop(); break;
        case 0x40: case 0x41: case 0x42: case 0x43: case 0x44: case 0x45: case 0x46: case 0x47: r[op & 7] = this.incdec(r[op & 7], 1, 16); break;
        case 0x48: case 0x49: case 0x4A: case 0x4B: case 0x4C: case 0x4D: case 0x4E: case 0x4F: r[op & 7] = this.incdec(r[op & 7], -1, 16); break;
        case 0x50: case 0x51: case 0x52: case 0x53: case 0x54: case 0x55: case 0x56: case 0x57: this.push(op === 0x54 ? (r[4] - 2) & 0xFFFF : r[op & 7]); break;
        case 0x58: case 0x59: case 0x5A: case 0x5B: case 0x5C: case 0x5D: case 0x5E: case 0x5F: { const v = this.pop(); r[op & 7] = v; break; }
        case 0x60: { const sp = r[4]; for (const k of [0, 1, 2, 3]) this.push(r[k]); this.push(sp); this.push(r[5]); this.push(r[6]); this.push(r[7]); break; }
        case 0x61: { r[7] = this.pop(); r[6] = this.pop(); r[5] = this.pop(); this.pop(); r[3] = this.pop(); r[2] = this.pop(); r[1] = this.pop(); r[0] = this.pop(); break; }
        case 0x68: this.push(this.fetch16()); break;
        case 0x6A: this.push(this.sx8(this.fetch8()) & 0xFFFF); break;
        case 0x69: case 0x6B: { this.modrm(); const a = this.sx16(this.gE16()), b = op === 0x69 ? this.sx16(this.fetch16()) : this.sx8(this.fetch8()), t = a * b; r[this.reg] = t & 0xFFFF; this.cf = this.of = (t < -32768 || t > 32767) ? 1 : 0; break; }
        case 0x70: case 0x71: case 0x72: case 0x73: case 0x74: case 0x75: case 0x76: case 0x77: case 0x78: case 0x79: case 0x7A: case 0x7B: case 0x7C: case 0x7D: case 0x7E: case 0x7F: {
          const d = this.sx8(this.fetch8()); if (this.cond(op & 15)) this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0x80: case 0x81: case 0x82: case 0x83: {
          this.modrm(); const w = op & 1 ? 16 : 8, a = w === 8 ? this.gE8() : this.gE16();
          const b = op === 0x81 ? this.fetch16() : op === 0x83 ? this.sx8(this.fetch8()) & 0xFFFF : this.fetch8();
          const t = this.alu(this.reg, a, w === 8 ? b & 255 : b, w); if (this.reg !== 7) { if (w === 8) this.pE8(t); else this.pE16(t); } break; }
        case 0x84: { this.modrm(); this.alu(4, this.gE8(), this.g8(this.reg), 8); break; }
        case 0x85: { this.modrm(); this.alu(4, this.gE16(), r[this.reg], 16); break; }
        case 0x86: { this.modrm(); const t = this.gE8(); this.pE8(this.g8(this.reg)); this.p8(this.reg, t); break; }
        case 0x87: { this.modrm(); const t = this.gE16(); this.pE16(r[this.reg]); r[this.reg] = t; break; }
        case 0x88: this.modrm(); this.pE8(this.g8(this.reg)); break;
        case 0x89: this.modrm(); this.pE16(r[this.reg]); break;
        case 0x8A: this.modrm(); this.p8(this.reg, this.gE8()); break;
        case 0x8B: this.modrm(); r[this.reg] = this.gE16(); break;
        case 0x8C: this.modrm(); this.pE16(s[this.reg & 3]); break;
        case 0x8D: this.modrm(); r[this.reg] = this.eo; break;
        case 0x8E: this.modrm(); s[this.reg & 3] = this.gE16(); break;
        case 0x8F: this.modrm(); { const v = this.pop(); this.pE16(v); } break;
        case 0x90: break;
        case 0x91: case 0x92: case 0x93: case 0x94: case 0x95: case 0x96: case 0x97: { const t = r[0]; r[0] = r[op & 7]; r[op & 7] = t; break; }
        case 0x98: r[0] = this.sx8(r[0] & 255) & 0xFFFF; break;
        case 0x99: r[2] = (r[0] & 0x8000) ? 0xFFFF : 0; break;
        case 0x9A: { const o = this.fetch16(), sg = this.fetch16(); this.callFar(sg, o, this.ip); break; }
        case 0x9C: this.push(this.flags()); break; case 0x9D: this.setFlags(this.pop()); break;
        case 0x9E: this.setFlags((this.flags() & 0xFF00) | (r[0] >> 8)); break; case 0x9F: r[0] = (r[0] & 255) | ((this.flags() & 255) << 8); break;
        case 0xA0: { const o = this.fetch16(); this.p8(0, this.rb(this.pre >= 0 ? s[this.pre] : s[3], o)); break; }
        case 0xA1: { const o = this.fetch16(); r[0] = this.rw(this.pre >= 0 ? s[this.pre] : s[3], o); break; }
        case 0xA2: { const o = this.fetch16(); this.wb(this.pre >= 0 ? s[this.pre] : s[3], o, r[0] & 255); break; }
        case 0xA3: { const o = this.fetch16(); this.ww(this.pre >= 0 ? s[this.pre] : s[3], o, r[0]); break; }
        case 0xA4: case 0xA5: case 0xA6: case 0xA7: case 0xAA: case 0xAB: case 0xAC: case 0xAD: case 0xAE: case 0xAF: this.str(op); break;
        case 0xA8: this.alu(4, r[0] & 255, this.fetch8(), 8); break;
        case 0xA9: this.alu(4, r[0], this.fetch16(), 16); break;
        case 0xB0: case 0xB1: case 0xB2: case 0xB3: case 0xB4: case 0xB5: case 0xB6: case 0xB7: this.p8(op & 7, this.fetch8()); break;
        case 0xB8: case 0xB9: case 0xBA: case 0xBB: case 0xBC: case 0xBD: case 0xBE: case 0xBF: r[op & 7] = this.fetch16(); break;
        case 0xC0: case 0xC1: case 0xD0: case 0xD1: case 0xD2: case 0xD3: {
          this.modrm(); const w = op & 1 ? 16 : 8, n = op < 0xD0 ? this.fetch8() : op < 0xD2 ? 1 : r[1] & 255;
          const v = this.shift(this.reg, w === 8 ? this.gE8() : this.gE16(), n, w); if (w === 8) this.pE8(v); else this.pE16(v); break; }
        case 0xC2: { const n = this.fetch16(); this.ip = this.pop(); r[4] = (r[4] + n) & 0xFFFF; break; }
        case 0xC3: this.ip = this.pop(); break;
        case 0xC4: case 0xC5: { this.modrm(); const o = this.rw(s[this.es], this.eo), sg = this.rw(s[this.es], this.eo + 2); r[this.reg] = o; s[op === 0xC4 ? 0 : 3] = sg; break; }
        case 0xC6: this.modrm(); this.pE8(this.fetch8()); break;
        case 0xC7: this.modrm(); this.pE16(this.fetch16()); break;
        case 0xC8: { const sz = this.fetch16(), lv = this.fetch8() & 31; this.push(r[5]); const fp = r[4]; if (lv) throw new Error('enter niveau > 0'); r[5] = fp; r[4] = (r[4] - sz) & 0xFFFF; break; }
        case 0xC9: r[4] = r[5]; r[5] = this.pop(); break;
        case 0xCA: { const n = this.fetch16(); this.ip = this.pop(); s[1] = this.pop(); r[4] = (r[4] + n) & 0xFFFF; break; }
        case 0xCB: this.ip = this.pop(); s[1] = this.pop(); break;
        case 0xCD: { const v = this.fetch8(); if (this.onInt) this.onInt(v, this); else throw new Error('int ' + v.toString(16)); break; }
        case 0xCF: this.ip = this.pop(); s[1] = this.pop(); this.setFlags(this.pop()); break;
        case 0xD7: this.p8(0, this.rb(this.pre >= 0 ? s[this.pre] : s[3], r[3] + (r[0] & 255))); break;
        case 0xE0: case 0xE1: case 0xE2: { const d = this.sx8(this.fetch8()); r[1] = (r[1] - 1) & 0xFFFF; const c = r[1] !== 0 && (op === 0xE2 || (op === 0xE1 ? this.zf : !this.zf)); if (c) this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0xE3: { const d = this.sx8(this.fetch8()); if (r[1] === 0) this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0xE4: case 0xE5: case 0xE6: case 0xE7: this.fetch8(); if (op === 0xE4) this.p8(0, 0); break;
        case 0xEC: this.p8(0, 0); break; case 0xED: r[0] = 0; break; case 0xEE: case 0xEF: break;
        case 0xE8: { const d = this.sx16(this.fetch16()); this.push(this.ip); this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0xE9: { const d = this.sx16(this.fetch16()); this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0xEA: { const o = this.fetch16(), sg = this.fetch16(); this.ip = o; s[1] = sg; break; }
        case 0xEB: { const d = this.sx8(this.fetch8()); this.ip = (this.ip + d) & 0xFFFF; break; }
        case 0xF4: this.stop = true; break;
        case 0xF5: this.cf ^= 1; break; case 0xF8: this.cf = 0; break; case 0xF9: this.cf = 1; break;
        case 0xFA: case 0xFB: break; case 0xFC: this.df = 0; break; case 0xFD: this.df = 1; break;
        case 0xF6: case 0xF7: this.grp3(op & 1 ? 16 : 8); break;
        case 0xFE: { this.modrm(); const v = this.gE8(); this.pE8(this.incdec(v, this.reg === 0 ? 1 : -1, 8)); break; }
        case 0xFF: this.grp5(); break;
        case 0x0F: this.op0f(); break;
        default: throw new Error('opcode ' + op.toString(16) + ' à ' + s[1].toString(16) + ':' + ((this.ip - 1) & 0xFFFF).toString(16));
      }
    }
  }
  op0f() {
    const op = this.fetch8();
    if (op >= 0x80 && op <= 0x8F) { const d = this.sx16(this.fetch16()); if (this.cond(op & 15)) this.ip = (this.ip + d) & 0xFFFF; return; }
    if (op === 0xAF) { this.modrm(); const t = this.sx16(this.r[this.reg]) * this.sx16(this.gE16()); this.r[this.reg] = t & 0xFFFF; this.cf = this.of = (t < -32768 || t > 32767) ? 1 : 0; return; }
    if (op === 0xB6) { this.modrm(); this.r[this.reg] = this.gE8(); return; }
    if (op === 0xBE) { this.modrm(); this.r[this.reg] = this.sx8(this.gE8()) & 0xFFFF; return; }
    throw new Error('opcode 0f ' + op.toString(16));
  }
  grp3(w) {
    this.modrm(); const r = this.r, k = this.reg; let v = w === 8 ? this.gE8() : this.gE16();
    if (k === 0 || k === 1) { this.alu(4, v, w === 8 ? this.fetch8() : this.fetch16(), w); return; }
    if (k === 2) { const t = ~v & (w === 8 ? 0xFF : 0xFFFF); if (w === 8) this.pE8(t); else this.pE16(t); return; }
    if (k === 3) { const t = this.alu(5, 0, v, w); this.cf = v ? 1 : 0; if (w === 8) this.pE8(t); else this.pE16(t); return; }
    if (w === 8) {
      if (k === 4) { const t = (r[0] & 255) * v; r[0] = t & 0xFFFF; this.cf = this.of = (t >> 8) ? 1 : 0; }
      else if (k === 5) { const t = this.sx8(r[0] & 255) * this.sx8(v); r[0] = t & 0xFFFF; this.cf = this.of = (t < -128 || t > 127) ? 1 : 0; }
      else if (k === 6) { const d = r[0]; if (!v) throw new Error('division par zéro'); r[0] = ((d % v) << 8) | (Math.floor(d / v) & 255); }
      else { const d = this.sx16(r[0]), dv = this.sx8(v); if (!dv) throw new Error('division par zéro'); const q = Math.trunc(d / dv), m = d - q * dv; r[0] = ((m & 255) << 8) | (q & 255); }
    } else {
      if (k === 4) { const t = r[0] * v; r[0] = t & 0xFFFF; r[2] = Math.floor(t / 65536) & 0xFFFF; this.cf = this.of = r[2] ? 1 : 0; }
      else if (k === 5) { const t = this.sx16(r[0]) * this.sx16(v); r[0] = t & 0xFFFF; r[2] = (t >> 16) & 0xFFFF; this.cf = this.of = (t < -32768 || t > 32767) ? 1 : 0; }
      else if (k === 6) { const d = r[2] * 65536 + r[0]; if (!v) throw new Error('division par zéro'); const q = Math.floor(d / v); r[0] = q & 0xFFFF; r[2] = d % v; }
      else { const d = (r[2] << 16 | r[0]) | 0, dv = this.sx16(v); if (!dv) throw new Error('division par zéro'); const q = Math.trunc(d / dv); r[0] = q & 0xFFFF; r[2] = (d - q * dv) & 0xFFFF; }
    }
  }
  grp5() {
    this.modrm(); const k = this.reg, s = this.s;
    if (k === 0) this.pE16(this.incdec(this.gE16(), 1, 16));
    else if (k === 1) this.pE16(this.incdec(this.gE16(), -1, 16));
    else if (k === 2) { const t = this.gE16(); this.push(this.ip); this.ip = t; }
    else if (k === 3) { const o = this.rw(s[this.es], this.eo), sg = this.rw(s[this.es], this.eo + 2); this.callFar(sg, o, this.ip); }
    else if (k === 4) this.ip = this.gE16();
    else if (k === 5) { this.ip = this.rw(s[this.es], this.eo); s[1] = this.rw(s[this.es], this.eo + 2); }
    else if (k === 6) this.push(this.gE16());
    else throw new Error('FF /' + k);
  }
  str(op) {
    const r = this.r, s = this.s, w = op & 1, sz = w ? 2 : 1, d = this.df ? -sz : sz, srcSeg = this.pre >= 0 ? s[this.pre] : s[3];
    const once = () => {
      switch (op & 0xFE) {
        case 0xA4: { if (w) this.ww(s[0], r[7], this.rw(srcSeg, r[6])); else this.wb(s[0], r[7], this.rb(srcSeg, r[6])); r[6] = (r[6] + d) & 0xFFFF; r[7] = (r[7] + d) & 0xFFFF; break; }
        case 0xAA: { if (w) this.ww(s[0], r[7], r[0]); else this.wb(s[0], r[7], r[0] & 255); r[7] = (r[7] + d) & 0xFFFF; break; }
        case 0xAC: { if (w) r[0] = this.rw(srcSeg, r[6]); else this.p8(0, this.rb(srcSeg, r[6])); r[6] = (r[6] + d) & 0xFFFF; break; }
        case 0xA6: { const a = w ? this.rw(srcSeg, r[6]) : this.rb(srcSeg, r[6]), b = w ? this.rw(s[0], r[7]) : this.rb(s[0], r[7]); this.alu(7, a, b, w ? 16 : 8); r[6] = (r[6] + d) & 0xFFFF; r[7] = (r[7] + d) & 0xFFFF; break; }
        case 0xAE: { const b = w ? this.rw(s[0], r[7]) : this.rb(s[0], r[7]); this.alu(7, w ? r[0] : r[0] & 255, b, w ? 16 : 8); r[7] = (r[7] + d) & 0xFFFF; break; }
      }
    };
    if (!this.rep) { once(); return; }
    const cmp = (op & 0xFE) === 0xA6 || (op & 0xFE) === 0xAE;
    while (r[1] !== 0) { once(); r[1] = (r[1] - 1) & 0xFFFF; if (cmp && (this.rep === 1 ? !this.zf : this.zf)) break; }
  }
}
window.X86 = X86;
