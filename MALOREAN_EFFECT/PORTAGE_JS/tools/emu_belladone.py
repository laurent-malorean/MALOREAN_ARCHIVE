# Relève les six tables trigonométriques de BELLADONE (DEMO1.EXE) en émulant la boucle d'initialisation de l'unité 3D
# (sinus/cosinus lus dans TRIGO.TBL, multipliés par trois constantes Real).
# Usage : python emu_belladone.py <DEMO1.EXE> <TRIGO.TBL> <sortie.json>   (dans ORIGINAL/DEMO/BELLADONE/build/ et ressources/)
import struct, sys, json
from unicorn import *
from unicorn.x86_const import *
b = open(sys.argv[1], 'rb').read()
last, pages, nreloc, hdr, minalloc, maxalloc, ss, sp, csum, ip, cs, reloff = struct.unpack('<12H', b[2:26])
img = bytearray(b[hdr * 16:])
BASE = 0x1000
for k in range(nreloc):
    off, seg = struct.unpack('<HH', b[reloff + 4 * k:reloff + 4 * k + 4])
    p = seg * 16 + off
    struct.pack_into('<H', img, p, (struct.unpack_from('<H', img, p)[0] + BASE) & 0xFFFF)
uc = Uc(UC_ARCH_X86, UC_MODE_16); uc.mem_map(0, 0x100000)
uc.mem_write(BASE * 16, bytes(img))
DS = 0xb46 + BASE          # segment de données de Turbo Pascal (chargé par l initialisation de la RTL)
trig = open(sys.argv[2], 'rb').read()
BUF = 0x60000
uc.mem_write(BUF, trig)
uc.mem_write(DS * 16 + 0x7e8, struct.pack('<HH', 0, BUF >> 4))
SSEG = 0x8000
for r, v in ((UC_X86_REG_DS, DS), (UC_X86_REG_ES, DS), (UC_X86_REG_SS, SSEG), (UC_X86_REG_SP, 0xf000), (UC_X86_REG_BP, 0xf100), (UC_X86_REG_CS, BASE)): uc.reg_write(r, v)
uc.emu_start(BASE * 16 + 0x6836, BASE * 16 + 0x69be, count=100_000_000)
w = lambda a: list(struct.unpack('<361i', bytes(uc.mem_read(DS * 16 + a, 361 * 4))))
out = {n: w(a) for n, a in (('t0', 0x86c), ('t1', 0xe10), ('t2', 0x13b4), ('t3', 0x1958), ('t4', 0x1efc), ('t5', 0x24a0))}
json.dump(out, open(sys.argv[3], 'w'))
for k, v in out.items(): print(k, v[:6], v[88:91], v[-2:])
