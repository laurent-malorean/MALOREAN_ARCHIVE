import sys,struct
from capstone import Cs,CS_ARCH_X86,CS_MODE_16
f=sys.argv[1];start=int(sys.argv[2],16);n=int(sys.argv[3])
b=open(f,'rb').read();last,pages,nreloc,hdr=struct.unpack('<4H',b[2:10]);img=b[hdr*16:]
md=Cs(CS_ARCH_X86,CS_MODE_16);md.skipdata=True
cnt=0
for i in md.disasm(img[start:start+n*6],start):
    print('%04x  %-24s %s %s'%(i.address,i.bytes.hex(),i.mnemonic,i.op_str));cnt+=1
    if cnt>=n:break
