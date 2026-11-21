// Généré par tools/pas2js.py depuis DEM2.PAS (MATEMATICA 2) : ne pas modifier à la main.
// MAT2_make(mem) crée l'état des variables globales et renvoie un objet { nom: function* () { … } }.
function MAT2_make(mem) {
  const _div = (a, b) => b ? Math.trunc(a / b) : 0, _mod = (a, b) => b ? a % b : 0, _round = x => x < 0 ? -Math.round(-x) : Math.round(x);
  const S = {
    mul1: new Uint16Array(200),
    mul2: new Uint16Array(200),
    tx: new Uint8Array(100),
    ty: new Uint8Array(100),
    ax: new Uint16Array(320),
    bx: new Uint16Array(320),
    cx: new Uint16Array(320),
    ay: new Uint16Array(200),
    by: new Uint16Array(200),
    cy: new Uint16Array(200),
    az: new Uint16Array(320),
    bz: new Uint16Array(320),
    cz: new Uint16Array(320),
    px: new Float64Array(321),
    py: new Float64Array(201),
    cosy: new Float64Array(201),
    sinx: new Float64Array(321),
    t: new Uint16Array(200),
    a: 0,
    max2: 0,
    f: 0,
    g: 0,
    c: 0,
    cou: 0,
    ofset1_f: 0,
    ofset2_f: 0,
    ofset1_g: 0,
    ofset2_g: 0,
    cou1: 0,
    cou2: 0,
    cou3: 0,
    xe: 0,
    ye: 0,
    x: 0,
    p1: 0,
    p2: 0,
    p3: 0,
    ca: 0,
    amin: 0,
    bmin: 0,
    amax: 0,
    bmax: 0,
    pasx: 0,
    pasy: 0,
    module: 0,
    nbiter: 0,
    partiea: 0,
    partieb: 0,
    ta: 0,
    tb: 0,
    tc: 0,
    td: 0,
    resultat: 0,
    pulse: 0,
    pulsei: 0,
    pulsef: 0,
  };
  for (let i = 0; i < 200; i++) S.t[i] = i * 320;
  const E = {};
  E.carle0 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 400; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f + S.g)&65535) - S.c)&65535) | ((((S.c * S.f)&65535) * S.g)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle1 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 260; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((((S.f - S.g)&65535) * ((S.g - S.c)&65535))&65535) * ((S.c - S.f)&65535))&65535) & S.f)&65535) + ((S.g * S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle2 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 190; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((((S.f - S.g)&65535) * ((S.g - S.c)&65535))&65535) * ((S.c - S.f)&65535))&65535) ^ S.f)&65535) - S.g)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle3 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 100; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f + S.g)&65535) + S.g)&65535) * ((((((((((S.f + S.f)&65535) + S.g)&65535) + S.c)&65535) + S.c)&65535) + S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle5 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 100; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((((((S.f - S.g)&65535) * ((S.g - S.c)&65535))&65535) * ((S.c - S.f)&65535))&65535) & S.f)&65535) * S.g)&65535) + S.c)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle8 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 310; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((S.c + ((((S.c - S.f)&65535) * S.g)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle12 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 350; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((S.f * ((S.c - S.g)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle13 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 300; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((S.f * S.g)&65535) * S.c)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle14 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 300; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f * ((S.c - S.g)&65535))&65535) & S.f)&65535) * S.g)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle15 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 300; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((S.f * ((S.c - S.g)&65535))&65535) | ((S.f * S.g)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle16 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6, _e7, _e8, _e9;
    let c1 = 0;
    c1 = ((0)&65535);
    for (S.c = 1, _e1 = 100; S.c <= _e1; S.c++) {
    c1 = ((c1 + 1)&65535);
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((_div(((S.f * ((c1 - S.g)&65535))&65535),((((S.f * S.g)&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    if ((c1 === 1)) {
    /*pulse*/
    yield 40 * TICK;
    }
    yield;
    }
    for (S.c = 100, _e4 = 300; S.c <= _e4; S.c++) {
    c1 = ((c1 + 40)&65535);
    for (S.f = 0, _e5 = S.a; S.f <= _e5; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e6 = S.a; S.g <= _e6; S.g++) {
    S.cou = ((_div(((S.f * ((c1 - S.g)&65535))&65535),((((S.f * S.g)&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
    for (S.c = 300, _e7 = 380; S.c <= _e7; S.c++) {
    c1 = ((c1 + 500)&65535);
    for (S.f = 0, _e8 = S.a; S.f <= _e8; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e9 = S.a; S.g <= _e9; S.g++) {
    S.cou = ((_div(((S.f * ((c1 - S.g)&65535))&65535),((((S.f * S.g)&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle17 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 600; S.c <= _e1; S.c++) {
    S.c = ((S.c + 5)&65535);
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((_mod(((S.f + ((S.c - S.g)&65535))&65535),((((S.f * S.g)&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle18 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 150; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((_mod(((S.f & ((S.c - S.g)&65535))&65535),((((S.f * S.g)&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle19 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 130; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((S.f & _mod(S.c,S.g))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle20 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 120; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((_mod(((((S.f + S.g)&65535) + S.g)&65535),((((((((((((1 + S.f)&65535) + S.f)&65535) + S.g)&65535) + S.c)&65535) + S.c)&65535) + S.c)&65535)) * S.c)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle21 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 180; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f + S.g)&65535) + S.g)&65535) & ((((((((((((1 + S.f)&65535) + S.f)&65535) + S.g)&65535) + S.c)&65535) + S.c)&65535) + S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle24 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 100; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((S.f + S.g)&65535) + S.g)&65535) + S.g)&65535) * ((((((S.f + S.f)&65535) + S.g)&65535) + S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle25 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 120; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((_mod(_mod(((S.f * S.g)&65535),S.c),((((S.f + _mod(S.c,S.g))&65535) + 1)&65535)))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle26 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 140; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((_mod(((S.f * S.g)&65535),S.c) | ((_mod(S.f,S.g) + 1)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle27 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 105; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((_mod(S.c,S.f) * _mod(S.c,S.g))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle28 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 130; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((_mod(((S.f & S.g)&65535),S.c))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle30 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 300; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.c - ((S.f * S.g)&65535))&65535) + ((S.g - ((S.c * S.f)&65535))&65535))&65535) + ((S.f - ((S.g * S.c)&65535))&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle33 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 150; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((S.c - ((S.f * ((S.g - ((S.c * S.f)&65535))&65535))&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle39 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 100; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f - ((((S.c * S.g)&65535) << 2)&65535))&65535) * S.g)&65535) * S.g)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle41 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 160; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((S.f - S.c)&65535) * S.g)&65535) * S.g)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle42 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 40; S.c <= _e1; S.c++) {
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((_mod(((((S.f + S.g)&65535) + S.g)&65535),((((((((S.f + S.f)&65535) + S.g)&65535) + S.c)&65535) + S.c)&65535)) * S.c)&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle46 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 200; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((S.f - S.g)&65535) & ((S.g - S.f)&65535))&65535) & ((S.f - S.c)&65535))&65535) | ((S.g - S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.carle47 = function* () {
    let _e1, _e2, _e3;
    for (S.c = 1, _e1 = 200; S.c <= _e1; S.c++) {
    for (S.f = 0, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    S.cou = ((((((((((S.f - S.g)&65535) & ((S.g - S.f)&65535))&65535) | ((S.f - S.c)&65535))&65535) | ((S.g - S.c)&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.rotate2 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    for (S.f = 0, _e1 = 99; S.f <= _e1; S.f++) {
    S.tx[S.f] = S.f;
    }
    for (S.f = 0, _e2 = 99; S.f <= _e2; S.f++) {
    S.ty[S.f] = S.f;
    }
    for (S.c = 0, _e3 = 200; S.c <= _e3; S.c++) {
    for (S.f = 1, _e4 = S.a; S.f <= _e4; S.f++) {
    S.tx[S.f] = ((((S.tx[S.f]&65535) >>> 1) + ((((S.ty[S.f] & 1)&255) << 7)&255))&65535);
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e5 = S.a; S.g <= _e5; S.g++) {
    S.ty[S.g] = ((((S.ty[S.g]&65535) >>> 1) + ((((S.tx[S.g] & 1)&255) << 7)&255))&65535);
    S.cou = ((((S.tx[((S.c + S.f)&65535)] + S.ty[((S.c + S.g)&65535)])&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.rotate5 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    for (S.f = 0, _e1 = 99; S.f <= _e1; S.f++) {
    S.tx[S.f] = S.f;
    }
    for (S.f = 0, _e2 = 99; S.f <= _e2; S.f++) {
    S.ty[S.f] = S.f;
    }
    for (S.c = 0, _e3 = 200; S.c <= _e3; S.c++) {
    for (S.f = 1, _e4 = S.a; S.f <= _e4; S.f++) {
    S.tx[S.f] = ((((S.tx[S.f]&65535) >>> 1) + ((((S.ty[S.f] & 1)&255) << 7)&255))&65535);
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e5 = S.a; S.g <= _e5; S.g++) {
    S.ty[S.g] = ((((S.ty[S.g]&65535) >>> 1) + ((((S.tx[S.g] & 1)&255) << 7)&255))&65535);
    S.cou = ((((S.tx[Math.abs(((S.c - S.f)&65535))] + S.ty[Math.abs(((S.c - S.g)&65535))])&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.rotate7 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    for (S.f = 0, _e1 = 99; S.f <= _e1; S.f++) {
    S.tx[S.f] = S.f;
    }
    for (S.f = 0, _e2 = 99; S.f <= _e2; S.f++) {
    S.ty[S.f] = S.f;
    }
    for (S.c = 0, _e3 = 200; S.c <= _e3; S.c++) {
    for (S.f = 1, _e4 = S.a; S.f <= _e4; S.f++) {
    S.tx[S.f] = ((((S.tx[S.f]&65535) >>> 1) + ((((S.ty[S.f] & 1)&255) << 7)&255))&65535);
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e5 = S.a; S.g <= _e5; S.g++) {
    S.ty[S.g] = ((((S.ty[S.g]&65535) >>> 1) + ((((S.tx[S.g] & 1)&255) << 7)&255))&65535);
    S.cou = ((((S.tx[((S.c + S.g)&65535)] + ((S.ty[((S.c + S.f)&65535)] & ((((S.f + S.g)&65535) + S.c)&65535))&65535))&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.rotate12 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    for (S.f = 0, _e1 = 99; S.f <= _e1; S.f++) {
    S.tx[S.f] = S.f;
    }
    for (S.f = 0, _e2 = 99; S.f <= _e2; S.f++) {
    S.ty[S.f] = S.f;
    }
    for (S.c = 0, _e3 = 40; S.c <= _e3; S.c++) {
    for (S.f = 1, _e4 = S.a; S.f <= _e4; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e5 = S.a; S.g <= _e5; S.g++) {
    S.tx[S.f] = ((S.tx[S.f] + ((Math.abs(((((S.cou + S.ty[S.f])&65535) - S.tx[S.g])&65535))&65535) >>> 3))&65535);
    S.ty[S.g] = Math.abs(((((S.c - S.ty[S.g])&65535) + S.tx[S.f])&65535));
    S.cou = ((((S.tx[S.f] + S.ty[S.f])&65535))&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly5_v16 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6, _e7;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 280; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.max2; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = 1, _e5 = S.xe; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535))&65535);
    S.cou = ((((S.p1 + S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.xe)&65535)] + S.a)&65535) + 160)&65535) - S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.ye)&65535)] + S.a)&65535) + 160)&65535) - S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.ye)&65535)] - S.a)&65535) + 160)&65535) + S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.xe)&65535)] - S.a)&65535) + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.xe)&65535)] - S.a)&65535) + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.ye)&65535)] - S.a)&65535) + 160)&65535) + S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.ye)&65535)] + S.a)&65535) + 160)&65535) - S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.xe)&65535)] + S.a)&65535) + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    for (S.xe = S.max2, _e6 = S.a; S.xe <= _e6; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = 1, _e7 = ((S.a - S.xe)&65535); S.ye <= _e7; S.ye++) {
    S.p2 = ((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535))&65535);
    S.cou = ((((S.p1 + S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.xe)&65535)] + S.a)&65535) + 160)&65535) - S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.ye)&65535)] + S.a)&65535) + 160)&65535) - S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.ye)&65535)] - S.a)&65535) + 160)&65535) + S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 + S.a)&255) - S.xe)&65535)] - S.a)&65535) + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.xe)&65535)] - S.a)&65535) + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.ye)&65535)] - S.a)&65535) + 160)&65535) + S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.ye)&65535)] + S.a)&65535) + 160)&65535) - S.xe)&65535)] = S.cou;
    mem[((((((S.t[((((100 - S.a)&255) + S.xe)&65535)] + S.a)&65535) + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly1 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 135; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((((S.p1 + S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly5 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 140; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535))&65535);
    S.cou = ((((S.p1 + S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly6 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 200; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((((S.p1 + S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly8 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 180; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 500; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((((S.p1 - S.p2)&65535))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly9 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 1000; S.x <= _e3; S.x++) {
    S.x = ((S.x + 4)&65535);
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((_div(S.p1,S.p2))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly10 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 500; S.x <= _e3; S.x++) {
    S.x = ((S.x + 1)&65535);
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((_mod(S.p1,S.p2))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly11 = function* () {
    let _e1, _e2, _e3, _e4, _e5;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    for (S.x = 1, _e3 = 200; S.x <= _e3; S.x++) {
    for (S.xe = 0, _e4 = S.a; S.xe <= _e4; S.xe++) {
    S.p1 = ((((((((((S.ax[S.xe] * S.x)&65535) * S.x)&65535) + ((S.bx[S.xe] * S.x)&65535))&65535) + S.cx[S.xe])&65535))&65535);
    for (S.ye = S.xe, _e5 = S.a; S.ye <= _e5; S.ye++) {
    S.p2 = ((((((((((S.ay[S.ye] * S.ye)&65535) * S.ye)&65535) + ((S.by[S.ye] * S.ye)&65535))&65535) + S.cy[S.ye])&65535))&65535);
    S.cou = ((_mod(S.p2,S.p1))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.expoly15 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6, _e7;
    S.ax[0] = 1;
    S.bx[0] = 2;
    S.cx[0] = 3;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    S.ax[S.f] = S.ax[((S.f - 1)&65535)];
    S.bx[S.f] = ((((2 * S.ax[((S.f - 1)&65535)])&65535) + S.bx[((S.f - 1)&65535)])&65535);
    S.cx[S.f] = ((S.bx[((S.f - 1)&65535)] + S.cx[((S.f - 1)&65535)])&65535);
    }
    S.ay[0] = 1;
    S.by[0] = 3;
    S.cy[0] = 2;
    for (S.f = 1, _e2 = 199; S.f <= _e2; S.f++) {
    S.ay[S.f] = S.ay[((S.f - 1)&65535)];
    S.by[S.f] = ((((2 * S.ay[((S.f - 1)&65535)])&65535) + S.by[((S.f - 1)&65535)])&65535);
    S.cy[S.f] = ((S.by[((S.f - 1)&65535)] + S.cy[((S.f - 1)&65535)])&65535);
    }
    S.az[0] = 1;
    S.bz[0] = 7;
    S.cz[0] = 4;
    for (S.xe = 1, _e3 = 319; S.xe <= _e3; S.xe++) {
    for (S.ye = 1, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.az[S.xe] = ((((2 * S.bx[((S.ye - 1)&65535)])&65535) + S.cx[S.xe])&65535);
    S.bz[S.ye] = ((S.ax[((S.xe - 1)&65535)] - S.bx[S.ye])&65535);
    S.cz[S.xe] = ((_mod(S.az[S.xe],5) + ((3 * S.bz[S.xe])&65535))&65535);
    }
    yield;
    }
    for (S.x = 1, _e5 = 180; S.x <= _e5; S.x++) {
    for (S.xe = 1, _e6 = S.a; S.xe <= _e6; S.xe++) {
    for (S.ye = S.xe, _e7 = S.a; S.ye <= _e7; S.ye++) {
    S.p3 = ((((((((S.az[((S.xe - S.ye)&65535)] * S.x)&65535) + ((S.bz[S.ye] * S.x)&65535))&65535) + S.cz[S.xe])&65535))&65535);
    S.cou = ((_div(S.p3,S.ye))&255);
    mem[((((S.t[((S.ye + 100)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((S.xe + 100)&65535)] + S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 - S.xe)&65535)] + 160)&65535) + S.ye)&65535)] = S.cou;
    mem[((((S.t[((100 - S.ye)&65535)] + ((-S.xe)&65535))&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((((-S.xe)&65535) + 100)&65535)] - S.ye)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.ye)&65535)] - S.xe)&65535) + 160)&65535)] = S.cou;
    mem[((((S.t[((100 + S.xe)&65535)] + 160)&65535) - S.ye)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.iter1 = function* () {
    let _e1, _e2, _e3;
    let cc = 0;
    let ia = 0;
    let ib = 0;
    let ap = 0;
    let bp = 0;
    let res = 0;
    let nbiter = 0;
    S.c = ((0)&65535);
    for (cc = 0, _e1 = 150; cc <= _e1; cc++) {
    S.c = ((((S.c + 1)&65535))&65535);
    for (S.f = 1, _e2 = S.a; S.f <= _e2; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e3 = S.a; S.g <= _e3; S.g++) {
    ia = ((((S.f & S.g)&65535))&65535);
    ib = ((((S.f - S.g)&65535))&65535);
    if ((ib === 0)) {
    ib = ((ia)&65535);
    }
    ap = ((ia)&65535);
    bp = ((ib)&65535);
    ia = ((((((ap * ap)&65535) + _div(((S.c * bp)&65535),4))&65535))&65535);
    ib = ((_div(ap,bp))&65535);
    res = ((((ia + ib)&65535))&65535);
    S.cou = ((res)&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    }
    yield;
    }
  };
  E.cong1 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 99; S.f <= _e1; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e2 = 99; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((_mod(S.g,S.ca) === S.f) || (S.ca === 250)));
    S.cou = ((S.ca)&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.cong2 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 99; S.f <= _e1; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e2 = 99; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((_mod(S.g,S.f) === S.ca) || (S.ca === 250)));
    S.cou = ((S.ca)&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.cong5 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 99; S.f <= _e1; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e2 = 99; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f & S.g)&65535) === S.ca) || (S.ca === 250)));
    S.cou = ((S.ca)&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.cong6 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 99; S.f <= _e1; S.f++) {
    S.ofset1_f = ((S.mul1[S.f])&65535);
    S.ofset2_f = ((S.mul2[S.f])&65535);
    for (S.g = S.f, _e2 = 99; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f | S.g)&65535) === S.ca) || (S.ca === 250)));
    S.cou = ((S.ca)&255);
    S.ofset1_g = ((S.mul1[S.g])&65535);
    S.ofset2_g = ((S.mul2[S.g])&65535);
    mem[((S.ofset1_g + S.f)&65535)] = S.cou;
    mem[((S.ofset1_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g + S.f)&65535)] = S.cou;
    mem[((S.ofset2_f + S.g)&65535)] = S.cou;
    mem[((S.ofset2_g - S.f)&65535)] = S.cou;
    mem[((S.ofset2_f - S.g)&65535)] = S.cou;
    mem[((S.ofset1_g - S.f)&65535)] = S.cou;
    mem[((S.ofset1_f - S.g)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.cong8 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 240; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f | S.g)&65535) === S.ca) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong9 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 240; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f ^ S.g)&65535) === S.ca) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong10 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 320; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f & S.ca)&65535) === S.g) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong11 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 240; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f & S.g)&65535) === ((S.ca ^ S.f)&65535)) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong12 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 320; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f - S.g)&65535) === ((S.ca ^ S.f)&65535)) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong13 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 320; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f - S.g)&65535) === ((S.ca ^ S.g)&65535)) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.cong14 = function* () {
    let _e1, _e2;
    for (S.f = 1, _e1 = 319; S.f <= _e1; S.f++) {
    for (S.g = 0, _e2 = 199; S.g <= _e2; S.g++) {
    S.ca = ((1)&255);
    do {
    S.ca = ((S.ca + 1)&255);
    } while (!((((S.f - ((S.g & S.ca)&65535))&65535) === S.ca) || (S.ca === 250)));
    mem[((S.t[S.g] + S.f)&65535)] = S.ca;
    }
    yield;
    }
  };
  E.es2 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    S.partieb = (S.px[S.xe]);
    for (S.ye = 0, _e6 = 99; S.ye <= _e6; S.ye++) {
    S.cou = ((_round(((S.partieb + S.py[S.ye]) * S.partiea)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    S.cou = ((_round((((-S.px[S.xe]) + S.py[S.ye]) * S.partiea)))&255);
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    S.cou = ((_round(((S.px[S.xe] - S.py[S.ye]) * S.partiea)))&255);
    mem[((S.t[((199 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    S.cou = ((_round(((-(S.px[S.xe] + S.py[S.ye])) * S.partiea)))&255);
    mem[((((S.t[((199 - S.ye)&65535)] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es3 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = ((S.px[S.xe] * S.sinx[S.xe]));
    for (S.ye = 0, _e6 = 99; S.ye <= _e6; S.ye++) {
    S.partieb = ((S.py[S.ye] * S.cosy[S.ye]));
    S.cou = ((Math.imul(_round((S.partiea + S.partieb)),2))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    S.cou = ((Math.imul(_round((S.partiea - S.partieb)),2))&255);
    mem[((S.t[((198 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    mem[((((S.t[((198 - S.ye)&65535)] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es4 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 99; S.ye <= _e6; S.ye++) {
    S.partieb = ((S.partiea * S.py[S.ye]));
    S.cou = ((_round(((S.px[S.xe] + S.partieb) + S.cosy[S.ye])))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    S.cou = ((_round(((S.px[S.xe] - S.partieb) + S.cosy[S.ye])))&255);
    mem[((S.t[((199 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    S.cou = ((_round((((-S.px[S.xe]) - S.partieb) + S.cosy[S.ye])))&255);
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    S.cou = ((_round((((-S.px[S.xe]) + S.partieb) + S.cosy[S.ye])))&255);
    mem[((((S.t[((199 - S.ye)&65535)] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es5 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    for (S.ye = 0, _e6 = 99; S.ye <= _e6; S.ye++) {
    S.partiea = (((S.sinx[S.xe] * S.py[S.ye]) * S.cosy[S.ye]));
    S.cou = ((_round((S.px[S.xe] + S.partiea)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    S.cou = ((_round((S.px[S.xe] - S.partiea)))&255);
    mem[((S.t[((199 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    S.cou = ((_round(((-S.px[S.xe]) - S.partiea)))&255);
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    S.cou = ((_round(((-S.px[S.xe]) + S.partiea)))&255);
    mem[((((S.t[((199 - S.ye)&65535)] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es6 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = ((S.px[S.xe] * S.sinx[S.xe]));
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (((S.partiea * S.py[S.ye]) * S.cosy[S.ye]));
    S.cou = ((_round(S.partieb))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    S.cou = ((((255 - S.cou)&255))&255);
    mem[((S.t[((199 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    mem[((((S.t[((199 - S.ye)&65535)] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es7 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-10));
    S.amax = (10);
    S.bmin = ((-10));
    S.bmax = (10);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.cou = ((_round(((S.px[S.ye] * S.sinx[S.xe]) + (S.py[S.ye] * S.sinx[S.ye]))))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es15 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-8));
    S.amax = (8);
    S.bmin = ((-8));
    S.bmax = (8);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (Math.sin(S.px[S.xe]) * (Math.exp(S.px[S.xe]) + Math.exp((-S.px[S.xe]))));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (Math.cos(S.py[S.ye]) * (Math.exp(S.py[S.ye]) - Math.exp((-S.py[S.ye]))));
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((_round((S.partiea + S.partieb)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es16 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-15));
    S.amax = (15);
    S.bmin = ((-15));
    S.bmax = (15);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (25 * (Math.sin(S.px[S.xe]) + Math.cos((2 * S.px[S.xe]))));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (25 * (Math.cos(S.py[S.ye]) + Math.sin((2 * S.py[S.ye]))));
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((_round((S.partiea + S.partieb)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es17 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-15));
    S.amax = (15);
    S.bmin = ((-15));
    S.bmax = (15);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (25 * (Math.sin(S.px[S.xe]) + Math.cos((-S.px[S.xe]))));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (25 * (Math.cos(S.py[S.ye]) + Math.sin((-S.py[S.ye]))));
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((_round((S.partiea + S.partieb)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es20 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (5);
    S.bmin = ((-4));
    S.bmax = (0);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (25 * (Math.sin(S.px[S.xe]) + Math.exp(S.px[S.xe])));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (25 * (Math.cos(S.py[S.ye]) + ((S.py[S.ye] * S.py[S.ye]) + (3 * S.py[S.ye]))));
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 99; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((_round((S.partiea + S.partieb)))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((S.t[((199 - S.ye)&65535)] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es23 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (25);
    S.bmin = ((-25));
    S.bmax = (30);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (100 * Math.log((Math.abs(S.px[S.xe]) + 1)));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (100 * Math.exp((S.py[S.ye] / 8)));
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((((_round(S.partiea) + _round(S.partieb))|0))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es24 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (25);
    S.bmin = ((-25));
    S.bmax = (30);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (100 * Math.log((Math.abs(S.px[S.xe]) + 1)));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (100 * Math.exp((S.py[S.ye] / 8)));
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((((_round(S.partiea) & _round(S.partieb))|0))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es25 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (25);
    S.bmin = ((-25));
    S.bmax = (30);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (100 * Math.log((Math.abs(S.px[S.xe]) + 1)));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (100 * Math.exp((S.py[S.ye] / 8)));
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((((_round(S.partiea) | _round(S.partieb))|0))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es26 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (25);
    S.bmin = ((-25));
    S.bmax = (30);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (100 * Math.log((Math.abs(S.px[S.xe]) + 1)));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (100 * Math.exp((S.py[S.ye] / 8)));
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((((_round(S.partiea) ^ _round(S.partieb))|0))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es27 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (0);
    S.bmin = ((-25));
    S.bmax = (0);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = (100 * Math.log((Math.abs(S.px[S.xe]) + 1)));
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = (100 * Math.exp((S.py[S.ye] / 8)));
    }
    for (S.xe = 0, _e5 = 319; S.xe <= _e5; S.xe++) {
    S.partiea = (S.sinx[S.xe]);
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.partieb = (S.cosy[S.ye]);
    S.cou = ((((_round(S.partiea) ^ _round(S.partieb))|0))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.es30 = function* () {
    let _e1, _e2, _e3, _e4, _e5, _e6;
    S.amin = ((-25));
    S.amax = (25);
    S.bmin = ((-25));
    S.bmax = (25);
    S.pasx = (((S.amax - S.amin) / 320));
    S.pasy = (((S.bmax - S.bmin) / 199));
    for (S.xe = 0, _e1 = 319; S.xe <= _e1; S.xe++) {
    S.px[S.xe] = (S.amin + (S.pasx * ((S.xe + 1)&65535)));
    }
    for (S.ye = 0, _e2 = 199; S.ye <= _e2; S.ye++) {
    S.py[S.ye] = (S.bmin + (S.pasy * ((S.ye + 1)&65535)));
    }
    for (S.xe = 0, _e3 = 319; S.xe <= _e3; S.xe++) {
    S.sinx[S.xe] = Math.sin(S.px[S.xe]);
    }
    for (S.ye = 0, _e4 = 199; S.ye <= _e4; S.ye++) {
    S.cosy[S.ye] = Math.cos(S.py[S.ye]);
    }
    for (S.xe = 0, _e5 = 159; S.xe <= _e5; S.xe++) {
    for (S.ye = 0, _e6 = 199; S.ye <= _e6; S.ye++) {
    S.cou = ((_round((((S.px[S.xe] * S.sinx[S.xe]) + S.py[S.ye]) + S.cosy[S.ye])))&255);
    mem[((S.t[S.ye] + S.xe)&65535)] = S.cou;
    mem[((((S.t[S.ye] + 319)&65535) - S.xe)&65535)] = S.cou;
    }
    yield;
    }
  };
  E.S = S;
  return E;
}
window.MAT2_make = MAT2_make;
window.MAT2_EFFECTS = ["carle0", "carle1", "carle2", "carle3", "carle5", "carle8", "carle12", "carle13", "carle14", "carle15", "carle16", "carle17", "carle18", "carle19", "carle20", "carle21", "carle24", "carle25", "carle26", "carle27", "carle28", "carle30", "carle33", "carle39", "carle41", "carle42", "carle46", "carle47", "rotate2", "rotate5", "rotate7", "rotate12", "expoly5_v16", "expoly1", "expoly5", "expoly6", "expoly8", "expoly9", "expoly10", "expoly11", "expoly15", "iter1", "cong1", "cong2", "cong5", "cong6", "cong8", "cong9", "cong10", "cong11", "cong12", "cong13", "cong14", "es2", "es3", "es4", "es5", "es6", "es7", "es15", "es16", "es17", "es20", "es23", "es24", "es25", "es26", "es27", "es30"];
