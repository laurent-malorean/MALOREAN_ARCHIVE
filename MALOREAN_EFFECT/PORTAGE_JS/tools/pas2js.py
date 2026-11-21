#!/usr/bin/env python3
"""Traducteur Pascal (sous-ensemble des procédures d'effets de DEM2.PAS) vers JavaScript.

Usage : python3 tools/pas2js.py <DEM2.PAS> <sortie.js>

Types Turbo Pascal reproduits : Byte (8 bits), Word (16 bits non signé), Integer (16 bits signé), LongInt (32 bits), Real.
Une opération entière entre Byte/Word reste en Word (retour à 16 bits), entre Integer et Word elle passe en LongInt.
Chaque procédure devient un générateur : un `yield` à la fin de chaque itération d'une boucle `for` de premier niveau qui
contient une autre boucle ; `Pulse:=0; repeat until pulse=N` devient `yield N*TICK` ; `If keypressed then ModifA` est supprimé.
"""
import re, sys

src = open(sys.argv[1], 'rb').read().decode('cp850', 'replace').replace('\r', '')
# ---------------------------------------------------------------- commentaires
src = re.sub(r'\{[^}]*\}', ' ', src, flags=re.S)
src = re.sub(r'\(\*.*?\*\)', ' ', src, flags=re.S)

# ---------------------------------------------------------------- types
SCALAR = {'byte': 'B', 'word': 'W', 'integer': 'I', 'longint': 'L', 'real': 'R', 'boolean': 'BOOL'}
ARR = {'B': 'Uint8Array', 'W': 'Uint16Array', 'I': 'Int16Array', 'L': 'Int32Array', 'R': 'Float64Array'}
# variables globales de DEM2.PAS (types lus dans le source)
G_SCAL = {'a': 'B', 'max2': 'B', 'f': 'W', 'g': 'W', 'c': 'W', 'cou': 'B', 'ofset1_f': 'W', 'ofset2_f': 'W', 'ofset1_g': 'W', 'ofset2_g': 'W',
          'cou1': 'B', 'cou2': 'B', 'cou3': 'B', 'xe': 'W', 'ye': 'W', 'x': 'W', 'p1': 'W', 'p2': 'W', 'p3': 'W', 'ca': 'B',
          'amin': 'R', 'bmin': 'R', 'amax': 'R', 'bmax': 'R', 'pasx': 'R', 'pasy': 'R', 'module': 'R', 'nbiter': 'B', 'partiea': 'R', 'partieb': 'R',
          'ta': 'W', 'tb': 'W', 'tc': 'W', 'td': 'W', 'resultat': 'W', 'pulse': 'W', 'pulsei': 'W', 'pulsef': 'W'}
G_ARR = {'mul1': ('W', 200), 'mul2': ('W', 200), 'tx': ('B', 100), 'ty': ('B', 100), 'ax': ('W', 320), 'bx': ('W', 320), 'cx': ('W', 320),
         'ay': ('W', 200), 'by': ('W', 200), 'cy': ('W', 200), 'az': ('W', 320), 'bz': ('W', 320), 'cz': ('W', 320),
         'px': ('R', 321), 'py': ('R', 201), 'cosy': ('R', 201), 'sinx': ('R', 321), 't': ('W', 200)}
SCREEN = {'v', 'vga_ecran'}                      # V et Vga_Ecran : ABSOLUTE $A000:0

# ---------------------------------------------------------------- lexer
TOK = re.compile(r"\s*(?:(\d+\.\d*(?:[eE][+-]?\d+)?|\d+(?:[eE][+-]?\d+)?|\$[0-9A-Fa-f]+)|([A-Za-z_][A-Za-z_0-9]*)|(:=|<>|<=|>=|\.\.|[-+*/()\[\],;:=<>.]))")
def lex(s):
    out, i = [], 0
    while i < len(s):
        m = TOK.match(s, i)
        if not m:
            if s[i:].strip() == '': break
            raise SyntaxError('caractère inattendu : ' + repr(s[i:i + 30]))
        i = m.end()
        if m.group(1): out.append(('num', m.group(1)))
        elif m.group(2): out.append(('id', m.group(2)))
        else: out.append(('op', m.group(3)))
    return out

# ---------------------------------------------------------------- expressions typées : (code, type)
def w(code, t):
    return {'B': '((%s)&255)', 'W': '((%s)&65535)', 'I': '((%s)<<16>>16)', 'L': '((%s)|0)'}.get(t, '(%s)') % code
def promote(a, b):
    if 'R' in (a, b): return 'R'
    if a == 'C': return b if b != 'C' else 'L'
    if b == 'C': return a
    if 'L' in (a, b): return 'L'
    if 'I' in (a, b): return 'L' if 'W' in (a, b) else 'I'
    return 'W'

class P:
    def __init__(self, toks, env): self.t, self.i, self.env = toks, 0, env
    def peek(self, k=0): return self.t[self.i + k] if self.i + k < len(self.t) else ('eof', '')
    def kw(self, s): tk = self.peek(); return tk[0] in ('id', 'op') and tk[1].lower() == s
    def eat(self, s=None):
        tk = self.peek()
        if s is not None and tk[1].lower() != s: raise SyntaxError('attendu %r, trouvé %r (…%s)' % (s, tk[1], ' '.join(x[1] for x in self.t[self.i - 4:self.i + 4])))
        self.i += 1; return tk
    # --- expression : relationnel < additif < multiplicatif < unaire
    def expr(self):
        a = self.add()
        while self.peek()[1] in ('=', '<>', '<', '>', '<=', '>=') and self.peek()[0] == 'op':
            op = self.eat()[1]; b = self.add()
            js = {'=': '===', '<>': '!=='}.get(op, op)
            a = ('(%s %s %s)' % (a[0], js, b[0]), 'BOOL')
        return a
    def add(self):
        a = self.mul()
        while True:
            tk = self.peek()
            if tk[0] == 'op' and tk[1] in '+-': op = self.eat()[1]
            elif tk[0] == 'id' and tk[1].lower() in ('or', 'xor'): op = self.eat()[1].lower()
            else: return a
            b = self.mul(); a = self.bin(op, a, b)
    def mul(self):
        a = self.unary()
        while True:
            tk = self.peek()
            if tk[0] == 'op' and tk[1] in ('*', '/'): op = self.eat()[1]
            elif tk[0] == 'id' and tk[1].lower() in ('div', 'mod', 'and', 'shl', 'shr'): op = self.eat()[1].lower()
            else: return a
            b = self.unary(); a = self.bin(op, a, b)
    def bin(self, op, a, b):
        (ca, ta), (cb, tb) = a, b
        if ta == 'BOOL' or tb == 'BOOL':
            return ({'and': '(%s && %s)', 'or': '(%s || %s)', 'xor': '(%s !== %s)'}[op] % (ca, cb), 'BOOL')
        t = promote(ta, tb)
        if op == '/': return ('(%s / %s)' % (ca, cb), 'R')
        if op in '+-' and t == 'R': return ('(%s %s %s)' % (ca, op, cb), 'R')
        if op == '*' and t == 'R': return ('(%s * %s)' % (ca, cb), 'R')
        if op in ('+', '-'): return (w('%s %s %s' % (ca, op, cb), t), t)
        if op == '*': return ((('Math.imul(%s,%s)' % (ca, cb)) if t == 'L' else w('%s * %s' % (ca, cb), t)), t)
        if op == 'div': return ('_div(%s,%s)' % (ca, cb), t)
        if op == 'mod': return ('_mod(%s,%s)' % (ca, cb), t)
        if op in ('and', 'or', 'xor'): return (w('%s %s %s' % (ca, {'and': '&', 'or': '|', 'xor': '^'}[op], cb), t), t)
        if op == 'shl': return (w('%s << %s' % (ca, cb), ta if ta != 'C' else 'L'), ta if ta != 'C' else 'L')
        if op == 'shr': return ('((%s) >>> %s)' % (('%s&65535' % ca) if ta in ('W', 'I', 'B') else ca, cb), ta if ta != 'C' else 'L')
        raise SyntaxError(op)
    def unary(self):
        tk = self.peek()
        if tk[0] == 'op' and tk[1] == '-': self.eat(); c, t = self.unary(); return (w('-%s' % c, t) if t != 'C' else '(-%s)' % c, t)
        if tk[0] == 'op' and tk[1] == '+': self.eat(); return self.unary()
        if tk[0] == 'id' and tk[1].lower() == 'not':
            self.eat(); c, t = self.unary(); return (('(!%s)' % c) if t == 'BOOL' else w('~%s' % c, t), t)
        return self.primary()
    def primary(self):
        tk = self.eat()
        if tk[0] == 'num':
            s = tk[1]
            if s.startswith('$'): return (str(int(s[1:], 16)), 'C')
            return (s, 'C' if re.fullmatch(r'\d+', s) else 'R')
        if tk[0] == 'op' and tk[1] == '(':
            e = self.expr(); self.eat(')'); return (e[0], e[1])
        if tk[0] == 'id':
            n = tk[1].lower()
            if n == 'true': return ('true', 'BOOL')
            if n == 'false': return ('false', 'BOOL')
            if n == 'pi': return ('Math.PI', 'R')
            if self.peek()[1] == '(' and self.peek()[0] == 'op' and n in FUNCS:
                self.eat('('); args = [self.expr()]
                while self.peek()[1] == ',': self.eat(','); args.append(self.expr())
                self.eat(')'); return FUNCS[n](args)
            if self.peek()[1] == '[' and self.peek()[0] == 'op':
                self.eat('['); idx = self.expr(); self.eat(']')
                et = self.env.elem(n); return ('%s[%s]' % (self.env.arr(n), idx[0]), et)
            return self.env.var(n)
        raise SyntaxError('expression : %r' % (tk,))

def _sqr(a):
    c, t = a[0]
    return ('(%s*%s)' % (c, c), 'R') if t == 'R' else (('Math.imul(%s,%s)' % (c, c)) if t in ('L', 'C') else w('%s*%s' % (c, c), t), t if t != 'C' else 'L')
FUNCS = {
    'round': lambda a: ('_round(%s)' % a[0][0], 'L'), 'trunc': lambda a: ('Math.trunc(%s)' % a[0][0], 'L'),
    'sqrt': lambda a: ('Math.sqrt(%s)' % a[0][0], 'R'), 'sin': lambda a: ('Math.sin(%s)' % a[0][0], 'R'), 'cos': lambda a: ('Math.cos(%s)' % a[0][0], 'R'),
    'abs': lambda a: ('Math.abs(%s)' % a[0][0], a[0][1]), 'sqr': _sqr, 'int': lambda a: ('Math.trunc(%s)' % a[0][0], 'R'),
    'frac': lambda a: ('(%s - Math.trunc(%s))' % (a[0][0], a[0][0]), 'R'), 'ln': lambda a: ('Math.log(%s)' % a[0][0], 'R'), 'exp': lambda a: ('Math.exp(%s)' % a[0][0], 'R'),
    'arctan': lambda a: ('Math.atan(%s)' % a[0][0], 'R'), 'odd': lambda a: ('((%s&1)===1)' % a[0][0], 'BOOL'),
}

class Env:
    def __init__(self, locs): self.locs = locs
    def var(self, n):
        if n == 'keypressed': return ('KEYPRESSED', 'BOOL')
        if n in self.locs: return (n, self.locs[n][1] if self.locs[n][0] == 's' else 'L')
        if n in G_SCAL: return ('S.' + n, G_SCAL[n])
        raise SyntaxError('variable inconnue : ' + n)
    def arr(self, n):
        if n in SCREEN: return 'mem'
        if n in self.locs and self.locs[n][0] == 'a': return n
        if n in G_ARR: return 'S.' + n
        raise SyntaxError('tableau inconnu : ' + n)
    def elem(self, n):
        if n in SCREEN: return 'B'
        if n in self.locs and self.locs[n][0] == 'a': return self.locs[n][1]
        return G_ARR[n][0]

# ---------------------------------------------------------------- instructions
class Gen:
    def __init__(self, toks, env): self.p = P(toks, env); self.env = env; self.n = 0
    def block(self, depth):
        out = []
        while not self.p.kw('end') and not self.p.kw('until') and self.p.peek()[0] != 'eof':
            s = self.stmt(depth)
            if s: out.append(s)
            if self.p.peek()[1] == ';': self.p.eat(';')
        return out
    def stmt(self, depth):
        p, tk = self.p, self.p.peek()
        if tk[1] == ';': return ''
        if p.kw('begin'):
            p.eat(); b = self.block(depth); p.eat('end'); return '\n'.join(b)
        if p.kw('for'):
            p.eat(); v = p.eat()[1].lower(); p.eat(':='); a = p.expr(); down = p.kw('downto'); p.eat(); b = p.expr(); p.eat('do')
            self.n += 1; e = '_e%d' % self.n; vc = self.env.var(v)[0]
            body = self.stmt(depth + 1)
            y = '\nyield;' if depth == 0 and re.search(r'\bfor \(', body) else ''
            return 'for (%s = %s, %s = %s; %s %s %s; %s%s) {\n%s%s\n}' % (vc, a[0], e, b[0], vc, '>=' if down else '<=', e, vc, '--' if down else '++', body, y)
        if p.kw('if'):
            p.eat(); c = p.expr(); p.eat('then')
            if 'KEYPRESSED' in c[0]: self.stmt(depth); return ''
            t = self.stmt(depth)
            if p.kw('else'): p.eat(); e = self.stmt(depth); return 'if (%s) {\n%s\n} else {\n%s\n}' % (c[0], t, e)
            return 'if (%s) {\n%s\n}' % (c[0], t)
        if p.kw('repeat'):
            p.eat(); b = self.block(depth); p.eat('until'); c = p.expr()
            if re.fullmatch(r'\(pulse === \d+\)', c[0].replace('S.', '')) and not b: return 'yield %s * TICK;' % re.search(r'\d+', c[0]).group()
            if not b: return 'do {} while (!%s);' % c[0]
            return 'do {\n%s\n} while (!%s);' % ('\n'.join(b), c[0])
        if p.kw('while'):
            p.eat(); c = p.expr(); p.eat('do'); return 'while (%s) {\n%s\n}' % (c[0], self.stmt(depth))
        if tk[0] == 'id':
            n = p.eat()[1].lower()
            if n in ('modifa', 'readkey'): return ''
            if n in ('inc', 'dec'):
                p.eat('('); v = p.expr()
                k = ('1', 'C')
                if p.peek()[1] == ',': p.eat(','); k = p.expr()
                p.eat(')'); t = v[1]
                return '%s = %s;' % (v[0], w('%s %s %s' % (v[0], '+' if n == 'inc' else '-', k[0]), t))
            if p.peek()[1] == '[':
                p.eat('['); idx = p.expr(); p.eat(']'); p.eat(':='); e = p.expr()
                return '%s[%s] = %s;' % (self.env.arr(n), idx[0], e[0])
            if p.peek()[1] == ':=':
                p.eat(':='); e = p.expr(); v = self.env.var(n)
                if n == 'pulse': return '/*pulse*/'
                return '%s = %s;' % (v[0], w(e[0], v[1]) if e[1] != 'R' or v[1] == 'R' else '_round(%s)' % e[0])
            raise SyntaxError('instruction inconnue : ' + n)
        raise SyntaxError('instruction : %r' % (tk,))

# ---------------------------------------------------------------- procédures
procs = re.split(r'(?im)^\s*procedure\s+', src)[1:]
EFFECT = re.compile(r'^(carle|rotate|expoly|iter|cong|es)\w*$', re.I)
out = ['// Généré par tools/pas2js.py depuis DEM2.PAS (MATEMATICA 2) : ne pas modifier à la main.',
       '// MAT2_make(mem) crée l\'état des variables globales et renvoie un objet { nom: function* () { … } }.',
       'function MAT2_make(mem) {',
       '  const _div = (a, b) => b ? Math.trunc(a / b) : 0, _mod = (a, b) => b ? a % b : 0, _round = x => x < 0 ? -Math.round(-x) : Math.round(x);',
       '  const S = {']
for n, (t, c) in {k: v for k, v in G_ARR.items()}.items():
    out.append('    %s: new %s(%d),' % (n, ARR[t], c))
for n in G_SCAL: out.append('    %s: 0,' % n)
out += ['  };', '  for (let i = 0; i < 200; i++) S.t[i] = i * 320;', '  const E = {};']
done = []
for blk in procs:
    m = re.match(r'(\w+)\s*;', blk)
    if not m or not EFFECT.match(m.group(1)): continue
    name = m.group(1).lower()
    head, _, body = re.split(r'(?i)\bbegin\b', blk, maxsplit=1)[0], None, re.split(r'(?i)\bbegin\b', blk, maxsplit=1)[1]
    locs = {}
    for lm in re.finditer(r'(?i)\bvar\b\s*((?:[\w, ]+:\s*[\w\[\]\. ]+;\s*)+)', head):
        for decl in re.findall(r'([\w, ]+):\s*([\w\[\]\. ]+);', lm.group(1)):
            names, ty = [x.strip().lower() for x in decl[0].split(',')], decl[1].strip().lower()
            if ty not in SCALAR: continue
            for nm in names: locs[nm] = ('s', SCALAR[ty])
    # fin de procédure : dernier END; suivi du texte hors procédure
    body = re.sub(r'(?is)\bend\s*;\s*$', '', body.strip())
    try:
        g = Gen(lex(body), Env(locs))
        stmts = g.block(0)
    except SyntaxError as e:
        print('ÉCHEC', name, e, file=sys.stderr); continue
    out.append('  E.%s = function* () {' % name)
    ens = sorted(set(re.findall(r'_e\d+', '\n'.join(stmts))))
    if ens: out.append('    let %s;' % ', '.join(ens))
    for nm, (k, t) in locs.items(): out.append('    let %s = 0;' % nm)
    out.append('    ' + '\n    '.join('\n'.join(stmts).split('\n')))
    out.append('  };')
    done.append(name)
out += ['  E.S = S;', '  return E;', '}', 'window.MAT2_make = MAT2_make;', 'window.MAT2_EFFECTS = %s;' % repr(done).replace("'", '"')]
open(sys.argv[2], 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print(len(done), 'procédures traduites :', ' '.join(done))
