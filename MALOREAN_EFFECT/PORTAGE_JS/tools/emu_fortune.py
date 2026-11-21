import struct,sys
from unicorn import *
from unicorn.x86_const import *
import os
B=open(os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','..','ORIGINAL','DEMO','FORTUNE','ressources','FORTUNE_decompresse.bin'),'rb').read()
uc=Uc(UC_ARCH_X86,UC_MODE_16);uc.mem_map(0,0x100000)
uc.mem_write(0x10100,B)
DS=0x157f
for r,v in ((UC_X86_REG_DS,DS),(UC_X86_REG_ES,DS),(UC_X86_REG_SS,0x1800),(UC_X86_REG_SP,0xff00),(UC_X86_REG_CS,0x1010)): uc.reg_write(r,v)
d0=DS*16
w=lambda a,n:struct.unpack('<%dh'%n,bytes(uc.mem_read(d0+a,2*n)))
print('T1 avant',w(0x1bda,6), 'T45c avant',w(0x45c,4))
STOP=0x12d7
from capstone import Cs,CS_ARCH_X86,CS_MODE_16
md=Cs(CS_ARCH_X86,CS_MODE_16);n=[0]
def hk(uc,a,sz,_):
    n[0]+=1
    if n[0]<0:
        c=bytes(uc.mem_read(a,sz));i=next(md.disasm(c,a-0x10100,1),None);print(hex(a),i.mnemonic if i else c.hex(),i.op_str if i else '', 'sp',hex(uc.reg_read(UC_X86_REG_SP)))
uc.hook_add(UC_HOOK_CODE,hk)
try: uc.emu_start(0x10100+0x11aa, 0x10100+STOP, count=400_000_000)
except UcError as e: print(e,hex(uc.reg_read(UC_X86_REG_CS)),hex(uc.reg_read(UC_X86_REG_IP)),hex(uc.reg_read(UC_X86_REG_SP)))
import json
out={'t1bda':w(0x1bda,100),'t45c':w(0x45c,1001),'tc2e':w(0xc2e,1001),'t1400':w(0x1400,1001)}
json.dump(out,open(sys.argv[1],'w'))
for k,v in out.items(): print(k,v[:12],v[-3:])
