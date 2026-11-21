program experienceddd;
{$g+}
uses crt,dos;
type typpoint=record
       x,y:real;
       fonction:byte;
       poids:real;
     end;
const pilote:integer=9;
      mode:integer=2;
      maxpoint=20;
var t:array[1..MaxPoint] of typpoint;
    i,j:real;
    ii,jj:word;
    l:byte;
    reg:registers;
    vieuxmode:byte;
    coul:array[0..767] of byte;
    a:char;

procedure modemcga;
begin
  reg.ah:=$0f;
  intr($10,reg);
  vieuxmode:=reg.al;
  reg.ah:=$00;
  reg.al:=19;
  intr($10,reg);
end;

procedure point(x,y:word;c:byte);
begin
if (x<320) and (y<199) then begin
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
end;

function pixel(x,y:word):byte;
var c:byte;
begin
if (x<320) and (y<199) then begin
x:=x+320*y;
asm
  push ds
  mov ax,$a000
  mov ds,ax
  mov bx,x
  mov dl,[bx]
  mov c,dl
  pop ds
end;
pixel:=c;
end else begin
pixel:=0;
end;
end;

procedure changecouleur(n,r,v,b:byte);
begin
asm
  mov dx,$3c8
  mov al,n
  out dx,al
  mov dx,$3c9
  mov al,r
  out dx,al
  mov al,v
  out dx,al
  mov al,b
  out dx,al
end;
end;

procedure paletteplus;
var i,j,k:byte;
    r,v,b,rr,vv,bb:real;
begin
  randomize;
  r:=random/10; rr:=random/2+0.5;
  v:=random/10; vv:=random/2+0.5;
  b:=random/10; bb:=random/2+0.5;
  for i:=0 to 255 do
  begin
    coul[i*3]:=round((sin(i*r-1.57)*31+32)*rr);
    coul[i*3+1]:=round((sin(i*v-1.57)*31+32)*vv);
    coul[i*3+2]:=round((sin(i*b-1.57)*31+32)*bb);
    if coul[i*3]>-i+255 then coul[i*3]:=-i+255;
    if coul[i*3+1]>-i+255 then coul[i*3+1]:=-i+255;
    if coul[i*3+2]>-i+255 then coul[i*3+2]:=-i+255;
    changecouleur(i,coul[i*3],coul[i*3+1],coul[i*3+2]);
    point(i,198,i);
  end;
end;

procedure finmcga;
begin
  reg.ah:=$00;
  reg.al:=vieuxmode;
  intr($10,reg);
end;

function distance(i,j:real;k:byte):real;
var x,y:real;
begin
x:=i-t[k].x;
y:=j-t[k].y;
distance:=sqrt(x*x+y*y);
end;

function calcul(i,j:real):byte;
var k:byte;
    coef,num,den,res,d:real;
begin
num:=0; den:=0;
for k:=1 to maxpoint do begin
  d:=distance(i,j,k);
  case t[k].fonction of
    1:coef:=1/d;
    2:coef:=d;
    3:coef:=1/(d*d);
    4:coef:=d*d;
    5:coef:=exp(d/10);
    6:coef:=1/exp(d/10);
    7:coef:=ln(d);
  end;
  num:=num+coef*t[k].poids;
  den:=den+coef;
end;
calcul:=trunc(num/den) mod 255;
end;

procedure affichepoints;
var i:byte;
    p:real;
begin
for i:=1 to maxpoint do begin
  point(round(t[i].x)+1,round(t[i].y),round(random*255));
  point(round(t[i].x)-1,round(t[i].y),round(random*255));
  p:=0;
  if t[i].poids>=0 then begin
    repeat
      point(round(t[i].x),round(t[i].y+p/4),round(random*255));
      p:=p+4;
    until p>t[i].poids;
  end else begin
    repeat
      point(round(t[i].x),round(t[i].y+p/4),round(random*255));
      p:=p-4;
    until p<t[i].poids;
  end;
end;
end;

begin
modemcga;
paletteplus;
randomize;
for l:=1 to maxpoint do begin
  t[l].x:=random*170+50;
  t[l].y:=random*100+50;
  t[l].fonction:=6;
  t[l].poids:=(random-0.5)*512;
end;
affichepoints;
jj:=0;
repeat
  ii:=0;
  repeat
    i:=ii;
    j:=jj;
    point(ii,jj,calcul(i,j));
    inc(ii);
    inc(ii);
  until (ii>319) or keypressed;
  inc(jj);
  inc(jj);
until (jj>198) or keypressed;
jj:=0;
repeat
  ii:=1;
  repeat
    point(ii,jj,(pixel(ii-1,jj)+pixel(ii+1,jj)) shr 1);
    inc(ii);
    inc(ii);
  until (ii>318) or keypressed;
  inc(jj);
  inc(jj);
until (jj>198) or keypressed;
jj:=1;
repeat
  ii:=0;
  repeat
    point(ii,jj,(pixel(ii,jj-1)+pixel(ii+1,jj+1)) shr 1);
    inc(ii);
  until (ii>318) or keypressed;
  inc(jj);
  inc(jj);
until (jj>198) or keypressed;
{affichepoints;}
l:=0;
{repeat
jj:=l;
for ii:=0 to 255 do begin
  inc(jj);
  if jj>255 then jj:=0;
  changecouleur(jj,coul[ii*3],coul[ii*3+1],coul[ii*3+2]);
end;
delay(1);
inc(l);
if l>255 then l:=0;
until keypressed;}
a:=readkey;
a:=readkey;
for ii:=0 to 255 do begin
  jj:=((ii div 2) mod 2)*31;
  changecouleur(ii,jj,jj,jj);
end;
repeat until keypressed;
finmcga;
end
.