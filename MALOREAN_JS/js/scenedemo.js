// Enregistre une démo « à scènes » : écran VGA 320x200 + écran texte, boutons précédent/pause/suivant, liste de scènes, vitesse.
//   meta : { id, title, year, desc, source, group?, music? (clé de data/music.js), scenes: [{ name, note, run(vga), text?: (canvas)=>void }] }
//   scene.text : fonction qui dessine la page en mode texte (drawText) ; la scène affiche alors l'écran texte.
const TICK = 1000 / 18.2065;                              // 1 « pulse » Pascal = 1 tick BIOS ($0040:$006C) ≈ 54,9 ms
const image = (demo, name, ms = 5000) => function* (v) { v.loadImage(demo, name); yield ms; };
function sceneDemo(meta) {
  DEMOS.push(Object.assign({ group: 'demo' }, meta, {
    mount(el) {
      el.innerHTML = `
        <div class="screen"><canvas class="px" width="320" height="200"></canvas><canvas class="px" width="640" height="400" hidden></canvas></div>
        <div class="bar">
          <button data-a="prev" title="Scène précédente (←)">⏮</button><button data-a="play">⏸ Pause</button><button data-a="next" title="Scène suivante (→)">⏭</button>
          <select aria-label="Scène"></select>
          <label>Vitesse <input type="range" min="5" max="120" value="24"><span class="rv">24 /s</span></label>
        </div>
        <div class="info"><b></b><p></p></div>
        <p class="hint">Espace : pause · ← → : changer de scène. Les « Delay » du Pascal restent en temps réel ; la vitesse règle le nombre d'images calculées par seconde.</p>`;
      if (meta.extra) meta.extra(el.querySelector('.bar'));
      const q = s => el.querySelector(s), [vcv, tcv] = el.querySelectorAll('canvas'), sel = q('select'), play = q('[data-a=play]');
      meta.scenes.forEach((s, i) => sel.add(new Option(String(i + 1).padStart(2, '0') + ' · ' + s.name, i)));
      const pl = new ScenePlayer(new VGA(vcv), meta.scenes, { onScene(s, i) {
        sel.value = i; q('.info b').textContent = s.name; q('.info p').textContent = s.note || '';
        tcv.hidden = !s.text; vcv.hidden = !!s.text; if (s.text) s.text(tcv);
      } });
      q('[data-a=prev]').onclick = () => pl.prev(); q('[data-a=next]').onclick = () => pl.next(); sel.onchange = () => pl.start(+sel.value);
      play.onclick = () => { pl.paused = !pl.paused; play.textContent = pl.paused ? '▶ Lecture' : '⏸ Pause'; };
      q('input').oninput = e => { pl.speed = +e.target.value; q('.rv').textContent = e.target.value + ' /s'; };
      const key = e => {
        if (e.target.tagName === 'SELECT') return;
        if (e.key === ' ') { e.preventDefault(); play.click(); } else if (e.key === 'ArrowRight') pl.next(); else if (e.key === 'ArrowLeft') pl.prev();
      };
      let mp = null;
      if (meta.music) {
        const mb = document.createElement('button'); mb.textContent = '♪ Musique'; mb.title = 'Joue le module ' + meta.music + ' (le navigateur exige un clic pour lancer le son)';
        q('[data-a=next]').after(mb);
        mb.onclick = () => {
          if (mp && mp.playing) { mp.stop(); mb.textContent = '♪ Musique'; return; }
          mb.textContent = '… calcul'; mb.disabled = true;
          setTimeout(() => {
            try {
              mp = new MODPlayer(MODPlayer.parse(musicBuffer(meta.music))); mp.start(); mb.textContent = '■ Musique';
              setTimeout(() => { if (mp && mp.ctx && mp.ctx.state !== 'running') mb.textContent = '■ Musique (son bloqué par le navigateur : clique encore)'; }, 600);
            } catch (e) { mb.textContent = '♪ Musique (erreur : ' + e.message + ')'; }
            mb.disabled = false;
          }, 30);
        };
      }
      addEventListener('keydown', key); pl.run();
      return () => { pl.destroy(); removeEventListener('keydown', key); if (mp) mp.stop(); };
    }
  }));
}
window.sceneDemo = sceneDemo; window.image = image; window.TICK = TICK;
