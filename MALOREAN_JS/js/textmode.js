// Écran texte 80x25 (mode 3) pour les pages de crédits. Équivalent de Fond_ecran / Write / Win4 de l'unité CSCREEN.
//   ops : ['fill', couleur] · ['text', x, y, fg, bg, chaîne] · ['win', x1, y1, x2, y2, titre, fondTitre?, fondFenêtre?]    (coordonnées 1..80 / 1..25)
const TEXT_COLORS = { BLANC: '#ffffff', BLEU: '#0000aa', BRUN: '#aa5500', MAGENTA: '#aa00aa', NOIR: '#000000', GRIS: '#aaaaaa', VERT: '#00aa00', ROUGE: '#aa0000' };
function drawText(canvas, ops) {
  const c = canvas.getContext('2d'), CW = 8, CH = 16;
  c.font = 'bold 13px Menlo, Consolas, "Courier New", monospace'; c.textBaseline = 'middle';
  const text = (x, y, fg, bg, s) => {
    c.fillStyle = TEXT_COLORS[bg]; c.fillRect((x - 1) * CW, (y - 1) * CH, s.length * CW, CH);
    c.fillStyle = TEXT_COLORS[fg];
    for (let i = 0; i < s.length; i++) c.fillText(s[i], (x - 1 + i) * CW, (y - 1) * CH + CH / 2 + 1);
  };
  for (const op of ops) {
    if (op[0] === 'fill') { c.fillStyle = TEXT_COLORS[op[1]]; c.fillRect(0, 0, 640, 400); }
    else if (op[0] === 'text') text(op[1], op[2], op[3], op[4], op[5]);
    else if (op[0] === 'win') {   // fenêtre magenta, cadre blanc, titre centré sur fond bleu
      const [, x1, y1, x2, y2, titre, tb = 'BLEU', fill = 'MAGENTA'] = op;
      c.fillStyle = TEXT_COLORS[fill]; c.fillRect((x1 - 1) * CW, (y1 - 1) * CH, (x2 - x1 + 1) * CW, (y2 - y1 + 1) * CH);
      c.strokeStyle = TEXT_COLORS.BLANC; c.lineWidth = 2; c.strokeRect((x1 - 1) * CW + 3, (y1 - 1) * CH + 3, (x2 - x1 + 1) * CW - 6, (y2 - y1 + 1) * CH - 6);
      const t = ' ' + titre + ' '; text(Math.round((x1 + x2) / 2) - Math.floor(t.length / 2), y1, 'BLANC', tb, t);
    }
  }
}
// Page de crédits commune aux démos MATHEMATICA : titre, release, rangées « Volpone : code », puis sharewares et salutations.
function creditsOps(title, release, head, shareware) {
  const o = [['fill', 'BRUN'],
    ['text', 1, 1, 'BLANC', 'BLEU', ('MALOREAN EFFECT  : "' + title + '"').padStart(46 + title.length / 2).padEnd(80)],
    ['text', 1, 25, 'BLANC', 'BLEU', ('RELEASE : ' + release).padStart(43 + release.length / 2).padEnd(80)],
    ['win', 10, 5, 70, 22, 'CREDIT FOR THE DEMO']];
  head.forEach((s, i) => o.push(['text', 24, 7 + 2 * i, 'BLANC', 'MAGENTA', s]));
  o.push(['text', 10, 11, 'BLANC', 'BLEU', '                      SHAREWARE CREDIT                       ']);
  shareware.forEach((s, i) => o.push(['text', 12, 13 + i, 'BLANC', 'MAGENTA', s]));
  o.push(['text', 10, 18, 'BLANC', 'BLEU', '                           HELLO TO                          ']);
  o.push(['text', 12, 20, 'BLANC', 'MAGENTA', 'Fbi,Silk,Weg,TmB,42 Crew,Sally,Jurassique Marc,Sun,Redlight']);
  o.push(['text', 12, 21, 'BLANC', 'MAGENTA', 'Mc2,Locked,Fafa']);
  return o;
}
window.drawText = drawText; window.creditsOps = creditsOps;
