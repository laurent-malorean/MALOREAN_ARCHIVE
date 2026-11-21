// Mini-VGA : mode 13h (320x200, 256 couleurs, palette 6 bits) pour un <canvas>.
// Remplace GraphMode / Vga[] / Put_dac / Cls / LoadShoot des unités Pascal GEST_GRA et GEST_DAC.
class VGA {
  constructor(canvas) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.mem = new Uint8Array(65536);          // segment $A000 entier (64 Ko) ; seuls 64000 octets sont affichés
    this.lut = new Uint8Array(256 * 3);        // palette 8 bits (R,V,B)
    this.img = this.ctx.createImageData(320, 200);
    this.px = this.img.data;                  // Uint8ClampedArray RGBA
    this.putDac(new Array(768).fill(0));
  }
  // Put_dac : 768 valeurs 0..63 (R,V,B)
  putDac(p) {
    for (let i = 0; i < 256; i++) {
      const r = Math.round(p[i * 3] * 255 / 63), g = Math.round(p[i * 3 + 1] * 255 / 63), b = Math.round(p[i * 3 + 2] * 255 / 63);
      this.lut[i * 3] = r; this.lut[i * 3 + 1] = g; this.lut[i * 3 + 2] = b;
    }
  }
  cls(c) { this.mem.fill(c & 255); }
  // Format SHOOT : 1 octet d'en-tête, 768 octets de palette (6 bits), 64000 pixels
  loadShoot(base64) {
    const bin = atob(base64), n = bin.length, b = new Uint8Array(n);
    for (let i = 0; i < n; i++) b[i] = bin.charCodeAt(i);
    this.putDac(Array.from(b.subarray(1, 769)));
    this.mem.set(b.subarray(769, 769 + 64000), 0);
  }
  present() {
    const m = this.mem, l = this.lut, px = this.px;
    for (let i = 0, o = 0; i < 64000; i++, o += 4) { const c = m[i] * 3; px[o] = l[c]; px[o + 1] = l[c + 1]; px[o + 2] = l[c + 2]; px[o + 3] = 255; }
    this.ctx.putImageData(this.img, 0, 0);
  }
}
window.VGA = VGA;
