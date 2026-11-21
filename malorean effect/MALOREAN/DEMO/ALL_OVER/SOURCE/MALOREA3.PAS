program demoreserve;
{$M 16384,0,65536}
{$g+}
uses dos,crt;
type m=array[1..6,0..850] of word; {Type du fichier MOUVE.}
var reg:registers;
    vieuxmode:byte;
    i,ii,j,k,q,c:word;
    s,t:array[0..199] of word;
    coul:array[0..767] of byte;
    segs,segt,ofss,ofst:word;
    xa,ya,xb,yb,xc,yc:m;
    con:word;

procedure modemcga;
begin
  reg.ah:=$0f;
  intr($10,reg);
  vieuxmode:=reg.al;
  reg.ah:=$00;
  reg.al:=19;
  intr($10,reg);
end;

procedure paletteplus;
var a,b,c,k,aa,bb,cc,aaa,bbb,ccc:real;
begin
  randomize;
  a:=random*5;
  b:=random*5;
  c:=random*5;
  aa:=round(random*2);
  bb:=round(random*2);
  cc:=round(random*2);
  k:=6.28/255;
  for i:=0 to 255 do
  begin
    aaa:=round(sin(aa*i*k+1.57)*31);
    bbb:=round(sin(bb*i*k+1.57)*31);
    ccc:=round(sin(cc*i*k+1.57)*31);
    coul[i*3]:=round(sin(a*i*k-1.57)*aaa+32);
    coul[i*3+1]:=round(sin(b*i*k-1.57)*bbb+32);
    coul[i*3+2]:=round(sin(c*i*k-1.57)*ccc+32);
  end;
    reg.ah:=$10;
    reg.al:=$12;
    reg.bx:=0;
    reg.cx:=255;
    reg.es:=seg(coul);
    reg.dx:=ofs(coul);
    intr($10,reg);
end;

procedure chargemouvement; {Chargement des mouvements}
var i,j:longint;
    fm:file of m;
begin
assign(fm,'malodata.001');
reset(fm);
  read(fm,xa);
  read(fm,ya);
  read(fm,xb);
  read(fm,yb);
  read(fm,xc);
  read(fm,yc);
close(fm);
end;

procedure point(x,y:word;c:byte);
begin
x:=x+320*y;
asm
  push ds
  mov ax,$a000
  mov ds,ax
  mov bx,x
  mov dl,c
  mov [bx],dl
  pop ds
end;
end;

procedure finmcga;
begin
  reg.ah:=$00;
  reg.al:=vieuxmode;
  intr($10,reg);
end;

procedure bresenhamtableau(segs,ofss,xi,yi,xf,yf:word);
var xx,yy,i,f:word;
    fi:integer;
begin
fi:=xf-xi;
xx:=fi;
if fi<0 then xx:=-fi;
fi:=yf-yi;
yy:=fi;
if fi<0 then yy:=-fi;
i:=2*yi+ofss;
f:=2*yf+ofss;
asm
push ds
mov ax,segs
mov ds,ax
mov cx,yy
mov dx,xx
mov si,i
cmp cx,0
je @horizontale
mov di,f
mov ax,yf
mov bx,yi
cmp ax,bx
jb @lab1
  mov ax,xf
  mov bx,xi
  cmp ax,bx
  jb @lab21
    cmp cx,dx
    jb @lab31
{***** yf>yi, xf>xi, yy>xx *****}
      mov ax,0
      @debut1:
      mov ds:[si],bx
      inc si
      inc si
      add ax,dx
      cmp ax,cx
      jb @suite1
        sub ax,cx
        inc bx
      @suite1:
      cmp si,di
      jbe @debut1
    jmp @fin
    @lab31:
{***** yf>yi, xf>xi, yy<xx *****}
      mov ax,0
      @debut2:
      mov ds:[si],bx
      inc bx
      add ax,cx
      cmp ax,dx
      jb @suite2
        sub ax,dx
        inc si
        inc si
      @suite2:
      cmp bx,xf
      jbe @debut2
    jmp @fin
  @lab21:
    cmp cx,dx
    jb @lab32
{***** yf>yi, xf<xi, yy>xx *****}
      mov ax,0
      @debut3:
      mov ds:[si],bx
      inc si
      inc si
      add ax,dx
      cmp ax,cx
      jb @suite3
        sub ax,cx
        dec bx
      @suite3:
      cmp si,di
      jbe @debut3
    jmp @fin
    @lab32:
{***** yf>yi, xf<xi, yy<xx *****}
      mov ax,0
      @debut4:
      mov ds:[si],bx
      dec bx
      add ax,cx
      cmp ax,dx
      jb @suite4
        sub ax,dx
        inc si
        inc si
      @suite4:
      cmp bx,xf
      jae @debut4
    jmp @fin
@lab1:
  mov ax,xf
  mov bx,xi
  cmp ax,bx
  jb @lab22
    cmp cx,dx
    jb @lab33
{***** yf<yi, xf>xi, yy>xx *****}
      mov ax,0
      @debut5:
      mov ds:[si],bx
      dec si
      dec si
      add ax,dx
      cmp ax,cx
      jb @suite5
        sub ax,cx
        inc bx
        @suite5:
      cmp si,di
      jae @debut5
    jmp @fin
    @lab33:
{***** yf<yi, xf>xi, yy<xx *****}
      mov ax,0
      @debut6:
      mov ds:[si],bx
      inc bx
      add ax,cx
      cmp ax,dx
      jb @suite6
        sub ax,dx
        dec si
        dec si
      @suite6:
      cmp bx,xf
      jbe @debut6
    jmp @fin
  @lab22:
    cmp cx,dx
    jb @lab34
{***** yf<yi, xf<xi, yy>xx *****}
      mov ax,0
      @debut7:
      mov ds:[si],bx
      dec si
      dec si
      add ax,dx
      cmp ax,cx
      jb @suite7
        sub ax,cx
        dec bx
      @suite7:
      cmp si,di
      jae @debut7
    jmp @fin
    @lab34:
{***** yf<yi, xf<xi, yy<xx *****}
      mov ax,0
      @debut8:
      mov ds:[si],bx
      dec bx
      add ax,cx
      cmp ax,dx
      jb @suite8
        sub ax,dx
        dec si
        dec si
      @suite8:
      cmp bx,xf
      jae @debut8
    jmp @fin
@horizontale:
  mov ax,xf
  mov bx,xi
  cmp ax,bx
  jb @cas2
  @cas1:
    mov ds:[si],bx
    inc bx
    cmp bx,ax
    jbe @cas1
  @cas2:
    mov ds:[si],bx
    dec bx
    cmp bx,ax
    jae @cas2
@fin:
pop ds
end;
end;

procedure bord(xa,ya,xb,yb,xc,yc:word;c:byte);
var xs,ys,xt,yt:word;
begin
for i:=0 to 199 do
begin
  s[i]:=0;
  t[i]:=0;
end;
if not ((ya<yb) and (yb<yc)) then
begin
  if not ((yc<yb) and (yb<ya)) then
  begin
    xt:=xc;
    yt:=yc;
    xs:=xb;
    ys:=yb;
    xc:=xb;
    yc:=yb;
    xb:=xa;
    yb:=ya;
    xa:=xa+xt-xs;
    ya:=ya+yt-ys;
  end;
end;
bresenhamtableau(segs,ofss,xa,ya,xb,yb);
bresenhamtableau(segs,ofss,xc,yc,xb,yb);
xb:=xa+xc-xb;
yb:=ya+yc-yb;
bresenhamtableau(segt,ofst,xa,ya,xb,yb);
bresenhamtableau(segt,ofst,xc,yc,xb,yb);
if yc<ya then
begin
  yt:=yc;
  ys:=ya;
end
else
begin
  yt:=ya;
  ys:=yc;
end;
xt:=yt*320;
yt:=yt*2;
xs:=ys*320;
asm
push ds
mov ax,segs
mov ds,ax
mov ax,segt
mov es,ax
mov si,ofss
add si,yt
mov di,ofst
add di,yt
mov dx,xt
mov cl,c
@debut:
  mov bx,ds:[si]
  add bx,dx
  mov ax,es:[di]
  add ax,dx
  push ds
  push $a000
  pop ds
  cmp ax,bx
  jb @cas2
  @cas1:
    add [bx],cl
    inc bx
    cmp bx,ax
    jbe @cas1
  jmp @fin
  @cas2:
    add [bx],cl
    dec bx
    cmp bx,ax
    jae @cas2
@fin:
pop ds
add dx,320
inc si
inc si
inc di
inc di
cmp bx,xs
jbe @debut
pop ds
end;
end;

begin
if paramstr(1)='๚' then begin
segs:=seg(s);
ofss:=ofs(s);
segt:=seg(t);
ofst:=ofs(t);
chargemouvement;
modemcga;
paletteplus;
i:=0;
repeat
j:=0;
repeat
  if (i xor j<160) then begin
    point(j,i,(i) mod 255);
  end else begin
  c:=round(sqrt((i-100)*(i-100)+(j-160)*(j-160)));
  case c of
    0..20:point(j,i,(i+j) mod 255);
    21..40:point(j,i,(i xor j) mod 128+32);
    41..60:point(j,i,(i-j) mod 255);
    61..80:point(j,i,(i*j) mod 128+32);
    81..100:point(j,i,(i+j) mod 255);
    101..120:point(j,i,((i+j)*(i-j)) mod 128+32);
    121..140:point(j,i,(i-j) mod 255);
    141..200:point(j,i,((i+j) xor (i-j)) mod 128+32);
  end;
  end;
  j:=j+1;
until j>319;
i:=i+1;
until i>199;
{i:=0;
repeat
j:=0;
repeat
  mem[$a000:320*j+i+1]:=(mem[$a000:320*j+i]+mem[$a000:320*j+i+2]) shr 1;
  mem[$a000:320*(j+1)+i]:=(mem[$a000:320*j+i]+mem[$a000:320*(j+2)+i]) shr 1;
  mem[$a000:320*(j+1)+i+1]:=(mem[$a000:320*j+i]+mem[$a000:320*(j+2)+i+2]) shr 1;
  j:=j+2;
until j>198;
i:=i+2;
until i>318;}
con:=0;
c:=0;
ii:=520;
k:=500;
j:=0;
q:=20;
repeat
bord(xa[1,q],ya[1,q],xb[1,q],yb[1,q],xc[1,q],yc[1,q],1);
bord(xa[4,ii],ya[4,ii],xb[4,ii],yb[4,ii],xc[4,ii],yc[4,ii],1);
if c<20 then begin
  inc(c);
end else begin
  bord(xa[1,j],ya[1,j],xb[1,j],yb[1,j],xc[1,j],yc[1,j],255);
  bord(xa[4,k],ya[4,k],xb[4,k],yb[4,k],xc[4,k],yc[4,k],255);
end;
  inc(ii);
  inc(q);
  inc(k);
  inc(j);
  if ii>850 then ii:=0;
  if k>850 then k:=0;
  if j>850 then j:=0;
  if q>850 then q:=0;
inc(con);
until con>=3000;
finmcga;
writeln('     ษปษอป                                              ษอปษป');
writeln('     ศบผษบออออออออออออออออออออออออออออออออออออออออออออออบปศบผ');
writeln('ษปษอป บ ศผ      mALOREAn eFFECt aAl oVEr tHe wORLd      ศผ บ ษอปษป');
writeln('ศบผษบอบออออออออออออออออออออออออออออออออออออออออออออออออออออออบปศบผ');
writeln(' บ ศผ บ             cODe: tOTo þ cODe: tOTo                บ ศผ บ');
writeln(' บ m  บ Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿ mALOREAn eFFECt Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü บ    บ');
writeln(' บ A  บ vOLPONe "Lolo les bons þ vOLPONe (sORRy, cAn''t be  บ  e บ');
writeln(' บ L  บ tuyaux"                þ tRADUCEd)                 บ  F บ');
writeln(' บ O  บ sALLy, 42 cREw...                                  บ  F บ');
writeln(' บ R  บ Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿Ü฿ บ  E บ');
writeln(' บ E  บ  sALUt (hi to): sUn, lOCKEd, mC2, wEg, fBi, p.v.,  บ  C บ');
writeln(' บ A  บ p. bOISSEl, g.v. (=XXX 21), jURASSIQUe mARc, mICKEyบ  t บ');
writeln(' บ n  บ  aUTREs (oTHEr) dEMOs: mATHEMATICa I,II,III,IV...  บ    บ');
writeln(' บ ษป บ              1993 mADe in fRANCe                   บ ษป บ');
writeln('ษบปศบออออออออออออออออออออออออออออออออออออออออออออออออออออออบอบผษบป');
writeln('ศผศอผ บ ษป      mALOREAn eFFECt aAl oVEr tHe wORLd      ษป บ ศอผศผ');
writeln('     ษบปศบออออออออออออออออออออออออออออออออออออออออออออออบผษบป');
writeln('     ศผศอผ                                              ศอผศผ');
delay(4000);
end else begin
writeln('!!! Ncessite MALOREAN.EXE (?) þ Need MALOREAN.EXE (?) !!!');
end;
end
.