// Lecteur de scènes partagé. Une scène = { name, note, text?, run(vga) } où run est un générateur :
//   `yield`       = une étape d'animation (cadence réglable, étapes par seconde)
//   `yield 2000`  = Delay(2000) en millisecondes réelles
class ScenePlayer {
  constructor(vga, scenes, hooks = {}) {
    Object.assign(this, { vga, scenes, hooks, idx: 0, gen: null, paused: false, wait: 0, acc: 0, speed: 24, raf: 0 });
    this.last = performance.now();
    this._f = t => this.frame(t);
  }
  run() { this.start(0); this.raf = requestAnimationFrame(this._f); }
  destroy() { cancelAnimationFrame(this.raf); }
  start(i) {
    const n = this.scenes.length;
    this.idx = ((i % n) + n) % n;
    const s = this.scenes[this.idx];
    this.gen = s.run(this.vga); this.wait = 0; this.acc = 0;
    if (this.hooks.onScene) this.hooks.onScene(s, this.idx);
  }
  next() { this.start(this.idx + 1); }
  prev() { this.start(this.idx - 1); }
  frame(t) {
    const dt = Math.min(100, t - this.last); this.last = t;
    if (!this.paused) {
      if (this.wait > 0) this.wait -= dt;
      else {
        this.acc = Math.min(this.acc + dt * this.speed / 1000, 4);
        while (this.acc >= 1) {
          this.acc--;
          const r = this.gen.next();
          if (r.done) { this.next(); break; }
          if (typeof r.value === 'number') { this.wait = r.value; break; }
        }
      }
    }
    this.vga.present();
    this.raf = requestAnimationFrame(this._f);
  }
}
window.ScenePlayer = ScenePlayer;
