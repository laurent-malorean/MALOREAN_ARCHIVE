program primitives_pour_csg;
{$g+}
{$m 16384,0,0}
uses dos,crt,graph;
var pilote,mode:integer;
    x,y:longint;
    xt,yt:word;
    xx,yy,xxx,yyy,xxxx,yyyy,res,res2,res3:longint;
    coul:array[0..767] of byte;
    reg:registers;
    vieuxmode:byte;
    c,cc:longint;
    xa,ya,xxa,yya,xxxa,yyya,xr,yr,xxr,yyr,xxxr,yyyr:byte;
    zr,zzr,zzzr:word;
var ax,ay,bx,by,cx,cy,dx,dy,ex,ey:word;
    aax,aay,bbx,bby,ccx,ccy,ddx,ddy,eex,eey:word;
    gax,gay,gbx,gby,gcx,gcy,gdx,gdy,gex,gey:integer;
    d:array[0..120,0..120] of byte;
    co:byte;
    cot:word;
    xo,yo,i:word;
    j:byte;
    jt,k:word;
    a:char;
var tx,ty:array[0..400] of byte;
    tvx,tvy:array[0..400] of integer;
var con:word;

procedure modemcga;
begin
  reg.ah:=$0f;
  intr($10,reg);
  vieuxmode:=reg.al;
  reg.ah:=$00;
  reg.al:=19;
  intr($10,reg);
end;

procedure changecouleur(n,r,v,b:byte);
begin
asm
  mov dx,$3c5
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
  r:=random/20; rr:=random/2+0.5;
  v:=random/20; vv:=random/3+0.5;
  b:=random/20; bb:=random/2+0.5;
  for i:=0 to 255 do
  begin
    coul[i*3]:=round((sin(i*r-1.57)*31+32)*rr);
    coul[i*3+1]:=round((sin(i*v-1.57)*31+32)*vv);
    coul[i*3+2]:=round((sin(i*b-1.57)*31+32)*bb);
    if coul[i*3]>-i+255 then coul[i*3]:=-i+255;
    if coul[i*3+1]>-i+255 then coul[i*3+1]:=-i+255;
    if coul[i*3+2]>-i+255 then coul[i*3+2]:=-i+255;
    changecouleur(i,coul[i*3],coul[i*3+1],coul[i*3+2]);
  end;
end;

procedure finmcga;
begin
  reg.ah:=$00;
  reg.al:=vieuxmode;
  intr($10,reg);
end;

function couleur:byte;
var xx,yy,xxx,yyy,xxxx,yyyy,res,res2,res3:longint;
begin
  xx:=x-190; yy:=y-140;
  xxx:=x-130; yyy:=y-100;
  xxxx:=x-80; yyyy:=y-50;
  res:=trunc((2*xx*xx+5*yy*yy-20000));
  res2:=trunc((3*xxx*xxx+yyy*yyy-10000));
  res3:=trunc((2*xxxx*xxxx+5*yyyy*yyyy-15000));
  couleur:=trunc(res/2000*res2/2000*res3/2000);
end;

begin
if (paramstr(1)='ü') then begin
{ Initialisation graphique }
modemcga; paletteplus;
{ Initialisation fonction de degr‚ six }
xa:=trunc(random*256); ya:=trunc(random*256);
xxa:=trunc(random*256); yya:=trunc(random*256);
xxxa:=trunc(random*256); yyya:=trunc(random*256);
xr:=trunc(random*10); yr:=trunc(random*10); zr:=trunc(random*30000);
xxr:=trunc(random*10); yyr:=trunc(random*10); zzr:=trunc(random*30000);
xxxr:=trunc(random*10); yyyr:=trunc(random*10); zzzr:=trunc(random*30000);
{ Affichage fonction de degr‚ six }
y:=0;
repeat
  x:=0;
  yt:=y*320;
  xx:=x-xa; yy:=y-ya; xxx:=x-xxa; yyy:=y-yya; xxxx:=x-xxxa; yyyy:=y-yyya;
  res:=trunc((xr*xx*xx+yr*yy*yy-zr));
  res2:=trunc((xxr*xxx*xxx+yyr*yyy*yyy-zzr));
  res3:=trunc((xxxr*xxxx*xxxx+yyyr*yyyy*yyyy-zzzr));
  cc:=trunc(res/3000*res2/3000*res3/3000);
  mem[$a000:x+yt]:=cc;
  repeat
    x:=x+2;
    xx:=x-xa; yy:=y-ya; xxx:=x-xxa; yyy:=y-yya; xxxx:=x-xxxa; yyyy:=y-yyya;
    res:=trunc((xr*xx*xx+yr*yy*yy-zr));
    res2:=trunc((xxr*xxx*xxx+yyr*yyy*yyy-zzr));
    res3:=trunc((xxxr*xxxx*xxxx+yyyr*yyyy*yyyy-zzzr));
    c:=trunc(res/3000*res2/3000*res3/3000);
    mem[$a000:x-1+yt]:=(cc+c) shr 1;
    mem[$a000:x+yt]:=c;
    cc:=c
  until (x>319);
  y:=y+1;
until (y>199);
{ Initialisation des points mobiles }
ax:=round(random*100+110); ay:=round(random*100+50);
bx:=round(random*100+110); by:=round(random*100+50);
cx:=round(random*100+110); cy:=round(random*100+50);
dx:=round(random*100+110); dy:=round(random*100+50);
ex:=round(random*100+110); ey:=round(random*100+50);
gax:=0; gay:=0; gbx:=0; gby:=0; gcx:=0; gcy:=0;
gdx:=0; gdy:=0; gex:=0; gey:=0;
{ Pr‚calcul de 1/exp(û(xý+yý)) }
for xo:=0 to 120 do begin
  for yo:=0 to 120 do begin
    d[xo,yo]:=round(75/exp(sqrt(xo*xo+yo*yo)/30));
  end;
end;
{ Animation des points mobiles }
con:=0;
repeat
  yo:=60;
  repeat
    xo:=120;
    repeat
      if ax>=xo then begin
        aax:=ax-xo;
      end else begin
        aax:=xo-ax;
      end;
      if ay>=yo then begin
        aay:=ay-yo;
      end else begin
        aay:=yo-ay;
      end;
      if bx>=xo then begin
        bbx:=bx-xo;
      end else begin
        bbx:=xo-bx;
      end;
      if by>=yo then begin
        bby:=by-yo;
      end else begin
        bby:=yo-by;
      end;
      if cx>=xo then begin
        ccx:=cx-xo;
      end else begin
        ccx:=xo-cx;
      end;
      if cy>=yo then begin
        ccy:=cy-yo;
      end else begin
        ccy:=yo-cy;
      end;
      if dx>=xo then begin
        ddx:=dx-xo;
      end else begin
        ddx:=xo-dx;
      end;
      if dy>=yo then begin
        ddy:=dy-yo;
      end else begin
        ddy:=yo-dy;
      end;
      if ex>=xo then begin
        eex:=ex-xo;
      end else begin
        eex:=xo-ex;
      end;
      if ey>=yo then begin
        eey:=ey-yo;
      end else begin
        eey:=yo-ey;
      end;
      co:=d[aax,aay]+d[bbx,bby]+d[ccx,ccy]+d[ddx,ddy]+d[eex,eey];
      cot:=co;
      memw[$a000:xo+320*yo]:=co+cot shl 8;
      xo:=xo+2;
    until (xo>200);
    inc(yo);
  until (yo>140);
  if ax<=170 then begin
    if gax<8 then inc(gax);
  end else begin
    if gax>-8 then dec(gax);
  end;
  if ay<=110 then begin
    if gay<8 then inc(gay);
  end else begin
    if gay>-8 then dec(gay);
  end;
  if bx<=ax then begin
    if gbx<8 then inc(gbx);
  end else begin
    if gbx>-8 then dec(gbx);
  end;
  if by<=ay then begin
    if gby<8 then inc(gby);
  end else begin
    if gby>-8 then dec(gby);
  end;
  if cx<=160 then begin
    if gcx<8 then inc(gcx);
  end else begin
    if gcx>-8 then dec(gcx);
  end;
  if cy<=90 then begin
    if gcy<8 then inc(gcy);
  end else begin
    if gcy>-8 then dec(gcy);
  end;
  if dx<=cx then begin
    if gdx<8 then inc(gdx);
  end else begin
    if gdx>-8 then dec(gdx);
  end;
  if dy<=cy then begin
    if gdy<8 then inc(gdy);
  end else begin
    if gdy>-8 then dec(gdy);
  end;
  ax:=ax+gax;
  ay:=ay+gay;
  bx:=bx+gbx;
  by:=by+gby;
  cx:=cx+gcx;
  cy:=cy+gcy;
  dx:=dx+gdx;
  dy:=dy+gdy;
  ex:=320-bx;
  ey:=200-by;
inc(con);
until con>=250;
{ Retra‡age de la fonction de degr‚ six }
y:=60;
repeat
  x:=120;
  xx:=x-xa; yy:=y-ya; xxx:=x-xxa; yyy:=y-yya; xxxx:=x-xxxa; yyyy:=y-yyya;
  res:=trunc((xr*xx*xx+yr*yy*yy-zr));
  res2:=trunc((xxr*xxx*xxx+yyr*yyy*yyy-zzr));
  res3:=trunc((xxxr*xxxx*xxxx+yyyr*yyyy*yyyy-zzzr));
  cc:=trunc(res/3000*res2/3000*res3/3000);
  yt:=320*y;
  mem[$a000:x+yt]:=cc;
  repeat
    x:=x+2;
    xx:=x-xa; yy:=y-ya; xxx:=x-xxa; yyy:=y-yya; xxxx:=x-xxxa; yyyy:=y-yyya;
    res:=trunc((xr*xx*xx+yr*yy*yy-zr));
    res2:=trunc((xxr*xxx*xxx+yyr*yyy*yyy-zzr));
    res3:=trunc((xxxr*xxxx*xxxx+yyyr*yyyy*yyyy-zzzr));
    c:=trunc(res/3000*res2/3000*res3/3000);
    mem[$a000:x-1+yt]:=(cc+c) shr 1;
    mem[$a000:x+yt]:=c;
    cc:=c;
  until (x>200);
  y:=y+1;
until (y>140);
{ Cycle de couleur }
con:=0;
xo:=0;
repeat
  yo:=0;
  j:=xo;
  repeat
    inc(yo);
    inc(j);
    if j>255 then j:=0;
    jt:=j*3;
    changecouleur(j,coul[jt],coul[jt+1],coul[jt+2]);
  until yo>255;
  inc(xo);
  if xo>255 then xo:=0;
inc(con);
until con>=1000;
{ Retour aux couleurs d'origine }
for j:=0 to 255 do begin
  jt:=j*3;
  changecouleur(j,coul[jt],coul[jt+1],coul[jt+2]);
end;
{ Initialisation des chainettes }
for i:=0 to 400 do begin
  tvx[i]:=0;
  tvy[i]:=0;
  tx[i]:=trunc(random*255);
  ty[i]:=trunc(random*199);
end;
{ Animation des chainettes }
con:=0;
repeat
  for xo:=1 to 10 do begin
    if tx[0]<tx[400] then begin
      if tvx[0]<2 then tvx[0]:=tvx[i]+1;
    end;
    if ty[0]<ty[400] then begin
      if tvy[0]<2 then tvy[0]:=tvy[i]+1;
    end;
    if tx[0]>tx[400] then begin
      if tvx[0]>-2 then tvx[0]:=tvx[i]-1;
    end;
    if ty[0]>ty[400] then begin
      if tvy[0]>-2 then tvy[0]:=tvy[i]-1;
    end;
    tx[0]:=tx[0]+tvx[0];
    ty[0]:=ty[0]+tvy[0];
    if ty[0]>197 then begin
      ty[0]:=trunc(random*255);
      tx[0]:=trunc(random*255);
      tvx[0]:=0;
      tvy[0]:=0;
    end;
    for i:=1 to 400 do begin
      if i mod 2=0 then begin
        if tx[i]<tx[i-1] then begin
          if tvx[i]<3 then tvx[i]:=tvx[i]+1;
        end;
        if ty[i]<ty[i-1] then begin
          if tvy[i]<2 then tvy[i]:=tvy[i]+1;
        end;
        if tx[i]>tx[i-1] then begin
          if tvx[i]>-3 then tvx[i]:=tvx[i]-1;
        end;
        if ty[i]>ty[i-1] then begin
          if tvy[i]>-2 then tvy[i]:=tvy[i]-1;
        end;
      end else begin
        if tx[i]<tx[i-1] then begin
          if tvx[i]<2 then tvx[i]:=tvx[i]+1;
        end;
        if ty[i]<ty[i-1] then begin
          if tvy[i]<3 then tvy[i]:=tvy[i]+1;
        end;
        if tx[i]>tx[i-1] then begin
          if tvx[i]>-2 then tvx[i]:=tvx[i]-1;
        end;
        if ty[i]>ty[i-1] then begin
          if tvy[i]>-3 then tvy[i]:=tvy[i]-1;
        end;
      end;
    xt:=ty[i]*320+32+tx[i];
    memw[$a000:xt]:=0;
    xt:=xt+319;
    memw[$a000:xt]:=0;
    xt:=xt+2;
    memw[$a000:xt]:=0;
    xt:=xt+318;
    memw[$a000:xt]:=0;
    xt:=xt+2;
    memw[$a000:xt]:=0;
    xt:=xt+319;
    memw[$a000:xt]:=0;
    tx[i]:=tx[i]+tvx[i];
    ty[i]:=ty[i]+tvy[i];
    if ty[i]>197 then begin
      ty[i]:=trunc(random*255);
      tx[i]:=trunc(random*255);
      tvx[i]:=0;
      tvy[i]:=0;
    end;
    cot:=i+i shl 8;
    xt:=ty[i]*320+32+tx[i];
    memw[$a000:xt]:=cot;
    xt:=xt+319;
    memw[$a000:xt]:=cot;
    xt:=xt+2;
    memw[$a000:xt]:=cot;
    xt:=xt+318;
    memw[$a000:xt]:=cot;
    xt:=xt+2;
    memw[$a000:xt]:=cot;
    xt:=xt+319;
    memw[$a000:xt]:=cot;
  end;
end;
  ty[0]:=trunc(random*255);
  tx[0]:=trunc(random*255);
  tvx[0]:=0;
  tvy[0]:=0;
inc(con);
until con>=150;
finmcga;
writeln(' ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄmALOREAn eFFECt aAl oVEr tHe wORLd');
writeln('ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>cODeÄÄÄÄÄÄÄÄÄÄÄÄ>tOTo');
writeln('ÀÄÂÄÄÄÄ>vOLPONe "Vieille ponne!" (sORRy cAn''t be tRADUCEd)');
writeln(' ÚÁÄÄÄÄ>sALLy        ÚÄÄÄÄ>sUnÄÄÄÄÄÄÄÄÄÄÂÄÄÄ>mC2');
writeln('ÚÅÄÄÄÄÄ>42 cREw      ³ ÚÄÄÄÄÄÄÄ>lOCKEdÄÄÙ');
writeln('³ÀÄ>sALUt (hi to):ÄÄÂÁÄÁÂÄÄÄÄÄ>wEgÄÄÄÄÄÄÄÄ>fBiÄÄÄÄÄÄÄÄ>p.v.ÄÄ¿');
writeln('³                   ³   ÀÄ>p. bOISSElÄÄÄÄ>g.v. (=XXX21)<ÄÄÄÄÄÙ');
writeln('³  jURASSIQUe mARc<ÄÁÄÄÄÄÄÄÄÄÄÄÄÄ>mICKEy');
writeln('Ã>aUTREs (oTHEr) dEMOsÄÄÄÄÄ>mATHEMATICaÄÄÄÂÄ>IÄÄÄ>II');
writeln('³   ÚÄÄÄÄÄÄÄ>1993                         ÃÄÄÄÄ>III');
writeln('ÀÂÄÄÁÄÄÄÄÄ>mADe in fRANCe                 ÀÄ>IV');
writeln(' ÀÄÄÄÄÄÄ>iCi, rIEn (hERe, nOTHINg)');
delay(5000);
end else begin
writeln('!!! N‚cessite MALOREAN.EXE (?) þ Need MALOREAN.EXE (?) !!!');
end;
end
.
