import struct,sys
from unicorn import *
from unicorn.x86_const import *
b=open(sys.argv[1],'rb').read()
last,pages,nreloc,hdr,minalloc,maxalloc,ss,sp,csum,ip,cs,reloff=struct.unpack('<12H',b[2:26])
image=b[hdr*16:]
PSP=0x1000;BASE=PSP+0x10
uc=Uc(UC_ARCH_X86,UC_MODE_16);uc.mem_map(0,0x100000)
uc.mem_write(PSP*16,b'\xcd\x20'+b'\0'*254)
uc.mem_write(BASE*16,image)
# PSP : mémoire haute = fin conventionnelle
uc.mem_write(PSP*16+2,struct.pack('<H',0x9FC0))
for r,v in ((UC_X86_REG_DS,PSP),(UC_X86_REG_ES,PSP),(UC_X86_REG_SS,(ss+BASE)&0xFFFF),(UC_X86_REG_SP,sp),(UC_X86_REG_CS,(cs+BASE)&0xFFFF),(UC_X86_REG_IP,ip)):
    uc.reg_write(r,v)
written=set()
def on_write(uc,access,addr,size,value,ud): written.add(addr>>4)
uc.hook_add(UC_HOOK_MEM_WRITE,on_write)
log=[]
def on_intr(uc,n,ud):
    ah=uc.reg_read(UC_X86_REG_AX)>>8
    log.append(('int',hex(n),hex(ah),hex(uc.reg_read(UC_X86_REG_CS)),hex(uc.reg_read(UC_X86_REG_IP))))
    if n==0x21 and ah==0x4c: uc.emu_stop()
uc.hook_add(UC_HOOK_INTR,on_intr)
from capstone import Cs,CS_ARCH_X86,CS_MODE_16
md=Cs(CS_ARCH_X86,CS_MODE_16)
far=[]
def on_code(uc,addr,size,ud):
    if uc.reg_read(UC_X86_REG_CS)==0x1482:
        print('entrée du programme déballé à CS:IP = 1482:%x'%uc.reg_read(UC_X86_REG_IP),'SS:SP = %x:%x'%(uc.reg_read(UC_X86_REG_SS),uc.reg_read(UC_X86_REG_SP)));uc.emu_stop();return
    code=bytes(uc.mem_read(addr,size))
    if code[0] in (0xea,0xcb,0xca,0xcf) or (code[0]==0xff and size>=2 and (code[1]>>3)&7 in (3,5)):
        far.append((hex(addr),code.hex(),hex(uc.reg_read(UC_X86_REG_CS)),hex(uc.reg_read(UC_X86_REG_IP)),hex(uc.reg_read(UC_X86_REG_SP))))
        if len(far)>6: uc.emu_stop()
uc.hook_add(UC_HOOK_CODE,on_code)
try: uc.emu_start((((cs+BASE)&0xFFFF)<<4)+ip,0,count=3_000_000)
except UcError as e: print('erreur',e,'à CS:IP',hex(uc.reg_read(UC_X86_REG_CS)),hex(uc.reg_read(UC_X86_REG_IP)))
print('interruptions',log[:6]);print('sauts/retours lointains',far)
print('CS:IP final',hex(uc.reg_read(UC_X86_REG_CS)),hex(uc.reg_read(UC_X86_REG_IP)))
open(sys.argv[2],'wb').write(bytes(uc.mem_read(PSP*16,0x20000)))
