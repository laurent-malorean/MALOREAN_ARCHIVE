import sys
from capstone import Cs,CS_ARCH_X86,CS_MODE_16
img=open(sys.argv[1],'rb').read();start=int(sys.argv[2],16);n=int(sys.argv[3])
md=Cs(CS_ARCH_X86,CS_MODE_16);md.skipdata=True;c=0
for i in md.disasm(img[start:start+n*6],start):
    print('%05x  %-20s %s %s'%(i.address,i.bytes.hex(),i.mnemonic,i.op_str));c+=1
    if c>=n:break
