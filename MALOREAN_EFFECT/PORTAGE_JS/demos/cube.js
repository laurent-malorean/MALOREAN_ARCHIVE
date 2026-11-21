// Cube 3D et test de visibilité, d'après MATH1.DOC.
// Convention de MATH1.DOC : vecteurs ligne, P' = P·R, avec Rx, Ry, Rz telles qu'écrites dans le document.
// Visibilité : N normale de la face, V vecteur vision (de la face vers la caméra), visible si V·N > 0.
(function () {
  const VT = [[-1,-1,-1],[1,-1,-1],[1,1,-1],[-1,1,-1],[-1,-1,1],[1,-1,1],[1,1,1],[-1,1,1]];
  const FC = [{ n: 'avant', v: [0,1,2,3], c: [220,80,60] }, { n: 'arrière', v: [5,4,7,6], c: [60,160,220] },
    { n: 'gauche', v: [4,0,3,7], c: [90,190,110] }, { n: 'droite', v: [1,5,6,2], c: [230,190,60] },
    { n: 'haut', v: [3,2,6,7], c: [170,100,220] }, { n: 'bas', v: [4,5,1,0], c: [240,130,40] }];
  const sub = (a, b) => [a[0]-b[0], a[1]-b[1], a[2]-b[2]];
  const cross = (a, b) => [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]];
  const dot = (a, b) => a[0]*b[0]+a[1]*b[1]+a[2]*b[2], len = a => Math.hypot(a[0], a[1], a[2]);
  const mul = (A, B) => A.map((_, i) => [0,1,2].map(j => A[i][0]*B[0][j] + A[i][1]*B[1][j] + A[i][2]*B[2][j]));
  const rowVec = (p, R) => [0,1,2].map(j => p[0]*R[0][j] + p[1]*R[1][j] + p[2]*R[2][j]);
  function rot(x, y, z) {
    const cx = Math.cos(x), sx = Math.sin(x), cy = Math.cos(y), sy = Math.sin(y), cz = Math.cos(z), sz = Math.sin(z);
    const Rx = [[1,0,0],[0,cx,sx],[0,-sx,cx]], Ry = [[cy,0,-sy],[0,1,0],[sy,0,cy]], Rz = [[cz,sz,0],[-sz,cz,0],[0,0,1]];
    return mul(mul(Rx, Ry), Rz);
  }
  DEMOS.push({
    id: 'cube', title: 'Cube et visibilité', year: '1993', group: 'demo',
    desc: 'Cube 3D filaire avec le test de visibilité de MATH1.DOC : une face est visible si V·N est positif. Matrices de rotation de ton document.',
    source: 'math/MATH1.DOC',
    mount(el) {
      el.innerHTML = `
        <div class="two">
          <div class="screen sq"><canvas id="cuc" width="640" height="640"></canvas></div>
          <div class="col">
            <div class="box"><h2>Rotation</h2>
              <label><span class="n">X</span><input type="range" id="cux" min="-180" max="180" value="-24"><span class="rv" id="cuxv"></span></label>
              <label><span class="n">Y</span><input type="range" id="cuy" min="-180" max="180" value="32"><span class="rv" id="cuyv"></span></label>
              <label><span class="n">Z</span><input type="range" id="cuz" min="-180" max="180" value="0"><span class="rv" id="cuzv"></span></label>
              <label><input type="checkbox" id="cua" checked><span>rotation automatique (glisser sur le cube)</span></label></div>
            <div class="box"><h2>Affichage</h2>
              <label><input type="checkbox" id="cuv" checked><span>test de visibilité V·N &gt; 0</span></label>
              <label><input type="checkbox" id="cuh" checked><span>faces cachées en pointillés</span></label>
              <label><input type="checkbox" id="cun" checked><span>normales N</span></label>
              <p class="hint">Décoche le test : toutes les faces sont dessinées dans l'ordre du tableau, et le cube devient faux.</p></div>
            <div class="box"><h2>Test par face</h2><div class="scroll"><table id="cut"></table></div></div>
            <div class="box"><h2>R = Rx · Ry · Rz</h2><div class="scroll"><pre id="cum"></pre></div></div>
          </div>
        </div>`;
      const $ = id => el.querySelector('#' + id), cv = $('cuc'), c = cv.getContext('2d');
      const st = { x: -24 * Math.PI / 180, y: 32 * Math.PI / 180, z: 0 };
      const css = n => getComputedStyle(document.documentElement).getPropertyValue(n).trim();
      const sync = () => ['x','y','z'].forEach(k => { let v = Math.round(st[k]*180/Math.PI); v = ((v+180)%360+360)%360-180; $('cu'+k).value = v; $('cu'+k+'v').textContent = v+'°'; });
      ['x','y','z'].forEach(k => $('cu'+k).oninput = () => { st[k] = $('cu'+k).value*Math.PI/180; $('cu'+k+'v').textContent = $('cu'+k).value+'°'; });
      sync();
      let drag = null;
      cv.onpointerdown = e => { cv.setPointerCapture(e.pointerId); drag = { x: e.clientX, y: e.clientY }; };
      cv.onpointermove = e => { if (!drag) return; st.y += (e.clientX-drag.x)*0.01; st.x += (e.clientY-drag.y)*0.01; drag = { x: e.clientX, y: e.clientY }; sync(); };
      cv.onpointerup = cv.onpointercancel = () => drag = null;
      const D = 5.2, FOC = 520, W = 640, H = 640;
      function draw() {
        const R = rot(st.x, st.y, st.z);
        const P = VT.map(p => { const r = rowVec(p, R); return [r[0], r[1], r[2] + D]; });
        const S = P.map(p => [W/2 + p[0]*FOC/p[2], H/2 - p[1]*FOC/p[2]]), centre = [0, 0, D];
        const proj = p => [W/2 + p[0]*FOC/p[2], H/2 - p[1]*FOC/p[2]];
        const info = FC.map(f => {
          let N = cross(sub(P[f.v[1]], P[f.v[0]]), sub(P[f.v[2]], P[f.v[0]]));
          const fc = [0,1,2].map(k => f.v.reduce((s, i) => s + P[i][k], 0) / 4);
          if (dot(N, sub(fc, centre)) < 0) N = N.map(v => -v);
          const l = len(N); N = N.map(v => v / l);
          const Vv = fc.map(v => -v), vl = len(Vv);
          return { f, N, fc, vn: dot(Vv.map(v => v/vl), N) };
        });
        const useVis = $('cuv').checked, showH = $('cuh').checked, showN = $('cun').checked, bg = css('--canvas'), mute = css('--mute');
        c.fillStyle = bg; c.fillRect(0, 0, W, H);
        const path = f => { c.beginPath(); f.v.forEach((i, k) => k ? c.lineTo(S[i][0], S[i][1]) : c.moveTo(S[i][0], S[i][1])); c.closePath(); };
        const light = [-0.35, -0.55, 0.75];
        if (useVis) {
          if (showH) { c.save(); c.setLineDash([5, 6]); c.strokeStyle = mute; c.globalAlpha = .65; c.lineWidth = 1.2; info.forEach(d => { if (d.vn <= 0) { path(d.f); c.stroke(); } }); c.restore(); }
          info.forEach(d => { if (d.vn > 0) {
            const k = Math.max(.3, Math.min(1, .4 + .6*Math.abs(dot(d.N, light))));
            c.fillStyle = `rgb(${d.f.c.map(v => Math.round(v*k)).join(',')})`; path(d.f); c.fill(); c.strokeStyle = bg; c.lineWidth = 2.5; c.stroke(); } });
        } else info.forEach(d => { c.fillStyle = `rgba(${d.f.c.join(',')},.92)`; path(d.f); c.fill(); c.strokeStyle = bg; c.lineWidth = 2.5; c.stroke(); });
        if (showN) info.forEach(d => {
          const vis = d.vn > 0; if (useVis && !vis) return;
          const a = proj(d.fc), b = proj(d.fc.map((v, i) => v + d.N[i]*1.1));
          c.strokeStyle = c.fillStyle = vis ? css('--ok') : css('--bad'); c.lineWidth = 2;
          c.beginPath(); c.moveTo(a[0], a[1]); c.lineTo(b[0], b[1]); c.stroke(); c.beginPath(); c.arc(b[0], b[1], 3.5, 0, 7); c.fill(); });
        $('cut').innerHTML = '<tr><th>face</th><th>V·N</th><th>visible</th></tr>' + info.map(d => `<tr><td>${d.f.n}</td><td>${d.vn >= 0 ? '+' : ''}${d.vn.toFixed(3)}</td><td class="${d.vn > 0 ? 'yes' : 'no'}">${d.vn > 0 ? 'oui' : 'non'}</td></tr>`).join('');
        $('cum').textContent = R.map(r => r.map(v => (v < 0 ? '' : ' ') + v.toFixed(3)).join('  ')).join('\n');
      }
      let raf = 0, last = performance.now();
      const frame = t => { const dt = Math.min(.05, (t-last)/1000); last = t;
        if ($('cua').checked && !drag) { st.y += dt*.6; st.x += dt*.25; sync(); }
        draw(); raf = requestAnimationFrame(frame); };
      raf = requestAnimationFrame(frame);
      return () => cancelAnimationFrame(raf);
    }
  });
})();
