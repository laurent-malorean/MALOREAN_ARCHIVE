program demototo; {Ah que Toto il est content}
{$A+} {Alignement des donn‚es sur des adresses paires}
{$B-} {Tests des bool‚ens minimum}
{$D-} {Pas d'information de d‚boggage}
{$E-} {Pas d'‚mulation 8087}
{$F-} {Les appels sont NEAR}
{$G+} {Instructions 80286}
{$I-} {Pas de v‚rification des entr‚es et sorties}
{$L-} {Pas d'information de d‚boggage (Le Retour!...)}
{$M 16384,0,0} {Pas de tas et petite pile}
{$N-} {Pas de 8087}
{$O-} {Pas de recouvrements de partiel}
{$R-} {Pas d'information de d‚boggage (La Revanche!...)}
{$S-} {Pas d'information de d‚boggage (La Retraite!...)}
{$V+} {Cette information de d‚boggage ne modifie pas le fichier EXE}
{$X-} {Pas de syntaxe ‚tendue}
uses dos,crt; {Pas vraiment indispensables ces deux l…}
type typemcga=array[0..64000] of byte;
     palette=array[0..768] of byte;
     m=array[1..6,0..850] of word; {Type du fichier MOUVE.}
var mcgaecran:typemcga absolute $a000:$0000;
    pal:palette;
    reg:registers;
    vieuxmode:byte;
const s1:string[50]='²“š‘ßº™™šœ‹ß¾““ß°‰šß«—šß¨“›ß²›šß½†ß«—’Œß';
var i,j,q:word;
    k,l:byte;
    ii:real;
    xa,ya,xb,yb,xc,yc:m;
const s2:string[50]='½Œš†Œß±’‘›–šÓß¹‘œšÓßºŠšÓßº‹—Óß²–“”†ß';
var s,t:array[0..199] of word; {Doivent rester globals}
    decorseg,tamponseg,globseg:word; {Segments}
    ymax,ymin,xmax,xmin:word;
    c:string; som:word;
const s3:string[4]='¨†Ş';

procedure modemcga; {Passage en mode MCGA}
begin
  reg.ah:=$0f; intr($10,reg); vieuxmode:=reg.al;
  reg.ah:=$00; reg.al:=19; intr($10,reg);
end;

procedure changecouleur(n,r,v,b:byte); {Modifie une couleur dans la palette}
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

procedure defpalette; {Calcul de la palette}
var i:byte;
    cr,cv,cb:real;
begin
  for i:=0 to 127 do
  begin
    if i<61 then
    begin
      cr:=i*i*0.0175; cv:=i*i*0.0175; cb:=sqrt(i/60)*63;
    end
    else
    begin
      cr:=63-0.5*i+30; cv:=63-0.5*i+30; cb:=63-0.5*i+31;
    end;
    if cr<0 then cr:=0; if cv<0 then cv:=0; if cb<0 then cb:=0;
    if cr>63 then cr:=63; if cv>63 then cv:=63; if cb>63 then cb:=63;
    pal[i*3]:=round(cr); pal[i*3+1]:=round(cv); pal[i*3+2]:=round(cb);
    pal[(i+128)*3]:=round(cb); pal[(i+128)*3+1]:=round(cv); pal[(i+128)*3+2]:=round(cr);
  end;
end;

function reservemem(p:word):word; {Reserve les segments}
begin
  reg.ah:=$48; reg.bx:=p; intr($21,reg); reservemem:=reg.ax;
end;

procedure liberemem(s,p:word); {Lib‚re les segments * TRES IMPORTANT *}
begin
  reg.ah:=$49; reg.bx:=p; reg.es:=s; intr($21,reg);
end;

procedure copiemem(sega,ofsa,segb,ofsb,i:word);
  {Copie d'une zone m‚moire}
  {Segment source: sega, ofset source: ofsa}
  {Segment destination: segb, ofset destination: ofsb}
  {Taille DIV 2: i}
begin
asm  
push ds 
  mov ds,sega
  mov es,segb
  mov si,ofsa
  mov di,ofsb
  cld
  mov cx,i
  rep movsw
pop ds
end;
end;

procedure copiecarre(sega,segb,x,y,xx,yy:word);
  {Copie d'une zone rectangulaire de l'‚cran * LA ZONE NE SE DEPLACE PAS *}
  {Segment source: sega}
  {Segment destination: segb}
  {Coordonn‚es de la zone: x,y}
  {Largeur et hauteur de la zone: xx,yy}
begin
y:=y*320;        
xx:=round(xx/2); 
asm              
push ds          
  mov ds,sega    
  mov es,segb    
  cld
  mov bx,y
  mov dx,x
  mov ax,yy
  inc ax
  @debut:
    mov si,dx
    add si,bx
    mov di,si
    mov cx,xx
    rep movsw
    add bx,320
    dec ax
  cmp ax,0
  ja @debut
pop ds
end;
end;

procedure lutin(sega,segb,x,y,xx,yy,xf,yf:word);
  {Copie d'une zone rectangulaire de l'‚cran … l'exclusion de la couleur 255}
  {Segment source: sega}
  {Segment destination: segb}
  {Coordonn‚es dans l'image source: x,y}
  {Largeur et hauteur: xx,yy}
  {Coordonn‚es dans l'image destination: xf,yf}
begin
y:=y*320;
yf:=yf*320;                                  
asm
push ds
  mov ds,sega
  mov es,segb
  mov bx,0
  cld
  mov ax,yy
  @debut:
    mov si,x
    add si,y
    add si,bx
    mov di,xf
    add di,yf
    add di,bx
    mov cx,xx
      @boucle:
      mov dl,ds:[si]
      cmp dl,255
      je @paspoint
        movsb
      jmp @point
      @paspoint:
        inc si
        inc di
      @point:
      dec cx
      cmp cx,0
      jne @boucle
    add bx,320
    dec ax
  cmp ax,0
  ja @debut
pop ds
end;
end;

procedure finmcga; {Retour au mode utilis‚ avant le lancemement de cette d‚mo}
begin
  reg.ah:=$00; reg.al:=vieuxmode; intr($10,reg);
end;

procedure bresenhamtableau(segs,ofss,xi,yi,xf,yf:word);
  {Calcul un segment de droite (au sens math‚matique) d'extr‚mit‚es (xi,yi)}
  {et (xf,yf) avec l'algorithme de Bresenham, et place la coordonn‚e x de  }
  {chaque point dans un tableau indic‚ par y, de segment (au sens          }
  {informatique) segs et d'ofset ofss}
var xx,yy,i,f:word;
    fi:integer;
begin
if xi>xmax then xmax:=xi; {On en profite pour ‚valuer la zone de l'‚cran}
if yi>ymax then ymax:=yi; {recouverte par le volume 3D}
if xf>xmax then xmax:=xf;
if yf>ymax then ymax:=yf;
if xi<xmin then xmin:=xi;
if yi<ymin then ymin:=yi;
if xf<xmin then xmin:=xf;
if yf<ymin then ymin:=yf;
fi:=xf-xi; xx:=fi; if fi<0 then xx:=-fi;
fi:=yf-yi; yy:=fi; if fi<0 then yy:=-fi;
i:=yi shl 1+ofss; f:=yf shl 1+ofss;
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
{***** yf>yi, xf>xi, yy>xx *****}      { C }
      mov ax,0                         { ' }
      @debut1:                         { e }
      mov ds:[si],bx                   { s }
      inc si                           { t }
      inc si
      add ax,dx                        { l }
      cmp ax,cx                        { o }
      jb @suite1                       { n }
        sub ax,cx                      { g }
        inc bx
      @suite1:                         { m }
      cmp si,di                        { a }
      jbe @debut1                      { i }
    jmp @fin                           { s }
    @lab31:
{***** yf>yi, xf>xi, yy<xx *****}      { c }
      mov ax,0                         { ' }
      @debut2:                         { e }
      mov ds:[si],bx                   { s }
      inc bx                           { t }
      add ax,cx
      cmp ax,dx                        { t }
      jb @suite2                       { o }
        sub ax,dx                      { u }
        inc si                         { j }
        inc si                         { o }
      @suite2:                         { u }
      cmp bx,xf                        { r }
      jbe @debut2                      { s }
    jmp @fin
  @lab21:                              { l }
    cmp cx,dx                          { a }
    jb @lab32
{***** yf>yi, xf<xi, yy>xx *****}      { m }
      mov ax,0                         { ‚ }
      @debut3:                         { m }
      mov ds:[si],bx                   { e }
      inc si
      inc si                           { c }
      add ax,dx                        { h }
      cmp ax,cx                        { o }
      jb @suite3                       { s }
        sub ax,cx                      { e }
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
  {Affiche une facette de coins (xa,ya), (xb,yb) et (xc,yc) (trois coins}
  {suffisent puisque les facettes sont cens‚es ‚tre rectangulaires) et  }
  {d'"indice de r‚fraction" c}
var xs,ys,xt,yt,segs,segt,ofss,ofst:word;
begin
segs:=seg(s); ofss:=ofs(s); segt:=seg(t); ofst:=ofs(t);
asm
push ds
  mov bx,segs {Mise … z‚ro des tableaux s et t * TRES IMPORTANT *}
  mov ds,bx
  mov bx,ofss
  mov ax,0
  mov cx,0
  @debut1:
    mov [bx],ax
    inc bx
    inc cx
  cmp cx,199
  jne @debut1
  mov bx,segt
  mov ds,bx
  mov bx,ofst
  mov cx,0
  @debut2:
    mov [bx],ax
    inc bx
    inc cx
  cmp cx,199
  jne @debut2
pop ds
end;
{* IMPORTANT * Tri des arr‚tes afin que les deux qui vont remplir le tableau}
{s soient l'une au dessus de l'autre mais jamais l'une … cot‚ de l'autre}
if not ((ya<yb) and (yb<yc)) then
begin
  if not ((yc<yb) and (yb<ya)) then
  begin
    xt:=xc; yt:=yc; xs:=xb; ys:=yb; xc:=xb; yc:=yb; xb:=xa; yb:=ya;
    xa:=xa+xt-xs; ya:=ya+yt-ys;
  end;
end;
bresenhamtableau(segs,ofss,xa,ya,xb,yb);
bresenhamtableau(segs,ofss,xc,yc,xb,yb);
{Maintenant on peut remplir le tableau t avec les deux autres arr‚tes qui}
{sont forc‚ment l'une au dessus de l'autre (prend deux aspirines)}
xb:=xa+xc-xb; yb:=ya+yc-yb;
bresenhamtableau(segt,ofst,xa,ya,xb,yb);
bresenhamtableau(segt,ofst,xc,yc,xb,yb);
{On commence par chercher le premier octet remplit de s et t}
if yc<ya then
begin
  yt:=yc; ys:=ya;
end
else
begin
  yt:=ya; ys:=yc;
end;
{L… il s'agit de tracer la facette en tra‡ant des droites horizontales}
{grace aux tableaux s et t}
xt:=yt*320; yt:=yt*2; xs:=ys*320;
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
  push tamponseg
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
end; {Ouf, c'est fini!}

procedure chargeimagebit(nom:string); {Chargement des images}
var bidon:byte;
    fichier:file;
begin
  assign(Fichier,nom); reset(Fichier,1); blockread(fichier,bidon,1);
  blockread(fichier,pal,768); blockread(fichier,mcgaecran,64000); close(fichier);
end;

procedure chargemouvement; {Chargement des mouvements}
var i,j:longint;
    fm:file of m;
begin
  assign(fm,'MALODATA.001'); reset(fm);
  read(fm,xa); read(fm,ya); read(fm,xb); read(fm,yb); read(fm,xc); read(fm,yc);
  close(fm);
end;

begin {* PROGRAMME PRINCIPAL *}
if paramstr(1)='ş' then begin
clrscr;
som:=0;
c:=' ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿';
som:=som+ord(c[0]); writeln(c);
c:='É³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍ»';
som:=som+ord(c[0]); writeln(c);
c:='º³ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ³º';
som:=som+ord(c[0]); writeln(c);
c:='ÈÍ»           °±²Û mALOREAn eFFECt aLl oVEr tHe wORLd Û²±°            ÉÍ¼';
som:=som+ord(c[0]); writeln(c);
c:=' ³º             cODe & gRAPHISMe: tOTo ş cODe & gFx: tOTo             º³';
som:=som+ord(c[0]); writeln(c);
c:='É³¼    fONCTIONNe cORRECTEMENt sUr:    ş     wORk cORRECTLy on:       È³»';
som:=som+ord(c[0]); writeln(c);
c:='º³       - Portable Compaq 486-25      ş - Compaq 486-25 Notebook      ³º';
som:=som+ord(c[0]); writeln(c);
c:='ÈÍ»      - Tulip 386-25                ş - Tulip 386-25               ÉÍ¼';
som:=som+ord(c[0]); writeln(c);
c:=' ³º      - 386-20 & 386-33 … bas prix  ş - Low prices 386-20 & 386-33 º³';
som:=som+ord(c[0]); writeln(c);
c:='É³¼    mAIs fOIRe sUr:                 ş        bUt bUg on:           È³»';
som:=som+ord(c[0]); writeln(c);
c:='º³       - 486-66 avec carte Fahrenheitş - 486-66 with Fahrenheit card ³º';
som:=som+ord(c[0]); writeln(c);
c:='ÈÍ»                   mINIMUm: 80286 & MCGA 320*200*256               ÉÍ¼';
som:=som+ord(c[0]); writeln(c);
c:=' ³º                                                                   º³';
som:=som+ord(c[0]); writeln(c);
c:='É³¼                                                                   È³»';
som:=som+ord(c[0]); writeln(c);
c:='º³ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ÚÄ¿ ³º';
som:=som+ord(c[0]); writeln(c);
c:='ÈÍÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍÍ³ÍÍ¼';
som:=som+ord(c[0]); writeln(c);
c:=' ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ ÀÄÙ';
som:=som+ord(c[0]); writeln(c);
if som=1236 then begin
tamponseg:=reservemem(4000); {On r‚serve de la m‚moire}
decorseg:=reservemem(4000);
globseg:=reservemem(1640);
{On s'assure que la m‚moire a effectivement ‚t‚ r‚serv‚e}
if (tamponseg>8) and (decorseg>8) and (globseg>8) then
begin
chargemouvement;
delay(4000);
modemcga;
for l:=0 to 255 do begin changecouleur(l,0,0,0); end;
chargeimagebit('MALODATA.002');
copiemem($a000,0,globseg,0,13120);
chargeimagebit('MALODATA.003');
copiemem($a000,0,decorseg,0,32000);
copiemem(decorseg,0,tamponseg,0,32000);
defpalette;
i:=0; k:=0; j:=0;
q:=577; {Si q=j alors les deux cubes sont confondus sinon -1<q<851}
ymax:=160; ymin:=40; xmax:=300; xmin:=20;
{* ROUTINE PRINCIPALE *}
repeat
  {On met le d‚cor dans le segment "tampon"}
  copiecarre(decorseg,tamponseg,xmin-6,ymin-6,xmax-xmin+12,ymax-ymin+12);
  {On y ajoute les globes}
  case k of
    0..1:lutin(globseg,tamponseg,0,0,33,37,51,105);
    2..3:lutin(globseg,tamponseg,40,0,33,37,51,105);
    4..5:lutin(globseg,tamponseg,80,0,33,37,51,105);
    6..7:lutin(globseg,tamponseg,120,0,33,37,51,105);
    8..9:lutin(globseg,tamponseg,160,0,33,37,51,105);
    10..11:lutin(globseg,tamponseg,200,0,33,37,51,105);
    12..13:lutin(globseg,tamponseg,240,0,33,37,51,105);
    14..15:lutin(globseg,tamponseg,280,0,33,37,51,105);
    16..17:lutin(globseg,tamponseg,0,40,33,37,51,105);
    18..19:lutin(globseg,tamponseg,40,40,33,37,51,105);
    20..21:lutin(globseg,tamponseg,80,40,33,37,51,105);
    22..23:lutin(globseg,tamponseg,120,40,33,37,51,105);
  end;
  case k of
    0..1:lutin(globseg,tamponseg,0,0,33,37,238,62);
    2..3:lutin(globseg,tamponseg,40,0,33,37,238,62);
    4..5:lutin(globseg,tamponseg,80,0,33,37,238,62);
    6..7:lutin(globseg,tamponseg,120,0,33,37,238,62);
    8..9:lutin(globseg,tamponseg,160,0,33,37,238,62);
    10..11:lutin(globseg,tamponseg,200,0,33,37,238,62);
    12..13:lutin(globseg,tamponseg,240,0,33,37,238,62);
    14..15:lutin(globseg,tamponseg,280,0,33,37,238,62);
    16..17:lutin(globseg,tamponseg,0,40,33,37,238,62);
    18..19:lutin(globseg,tamponseg,40,40,33,37,238,62);
    20..21:lutin(globseg,tamponseg,80,40,33,37,238,62);
    22..23:lutin(globseg,tamponseg,120,40,33,37,238,62);
  end;
  {Trac‚ des douze facettes directement dans le segment "tampon"}
  ymax:=0; ymin:=199; xmax:=0; xmin:=319;
  bord(xa[1,j],ya[1,j],xb[1,j],yb[1,j],xc[1,j],yc[1,j],4);
  bord(xa[2,j],ya[2,j],xb[2,j],yb[2,j],xc[2,j],yc[2,j],6);
  bord(xa[3,j],ya[3,j],xb[3,j],yb[3,j],xc[3,j],yc[3,j],5);
  bord(xa[4,j],ya[4,j],xb[4,j],yb[4,j],xc[4,j],yc[4,j],7);
  bord(xa[5,j],ya[5,j],xb[5,j],yb[5,j],xc[5,j],yc[5,j],4);
  bord(xa[6,j],ya[6,j],xb[6,j],yb[6,j],xc[6,j],yc[6,j],6);
  bord(xa[1,q],ya[1,q],xb[1,q],yb[1,q],xc[1,q],yc[1,q],5);
  bord(xa[2,q],ya[2,q],xb[2,q],yb[2,q],xc[2,q],yc[2,q],7);
  bord(xa[3,q],ya[3,q],xb[3,q],yb[3,q],xc[3,q],yc[3,q],4);
  bord(xa[4,q],ya[4,q],xb[4,q],yb[4,q],xc[4,q],yc[4,q],6);
  bord(xa[5,q],ya[5,q],xb[5,q],yb[5,q],xc[5,q],yc[5,q],5);
  bord(xa[6,q],ya[6,q],xb[6,q],yb[6,q],xc[6,q],yc[6,q],4);
  {On affiche le segment "tampon" mais seulement ce qui a ‚t‚ modifi‚}
  copiecarre(tamponseg,$a000,xmin-6,ymin-6,xmax-xmin+12,ymax-ymin+12);
  copiecarre(tamponseg,$a000,51,105,33,37);
  copiecarre(tamponseg,$a000,238,62,33,37);
  {Les variables varient}
  inc(j); inc(k); inc(q);
  if k>23 then k:=0; if j>850 then j:=0; if q>850 then q:=0;
  if i<255 then begin {Tentative de fondu au d‚but de la d‚mo}
    ii:=i/255;
    for l:=0 to 255 do
    begin
changecouleur(l,round(pal[l*3]*ii),round(pal[l*3+1]*ii),round(pal[l*3+2]*ii));
    end;
  end else begin
    delay(1); {Les 486DX2-66 n'iront pas trop vite}
  end;
  inc(i);
until i>=1000;
finmcga;
liberemem(decorseg,4000); {Lib‚ration de la m‚moire * SINON... *}
liberemem(tamponseg,4000);
liberemem(globseg,1640);
{if readkey='t' then begin
  c:=s1+s2+s3;
  for i:=1 to length(c) do begin c[i]:=chr(not ord(c[i])); end;
  writeln(c);
end else begin}
writeln('ÉÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍ»');
writeln('ºÚ³Ä¿ ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»Ú³Ä¿ º');
writeln('ÇÙ³ ³Ú¶          °±²Û mALOREAn eFFECt aLl oVEr tHe wORLd Û²±°          ÇÙ³ ³Ú¶');
writeln('º ÀÄ³Ùº            cODe & gRAPHISMe: tOTo ş cODe & gFx: tOTo           º ÀÄ³Ùº');
writeln('º ÚÄÙ º        mERCi de ne pAs bOUSILLEr! ş no mODIFICATIOn pLEASe!    º ÚÄÙ º');
writeln('ºÚ³Ä¿ º(oUi, oUi, l''aLTERNANCe mAJUSCULEs ş (yEs, i wANt to uSe lOw aNdºÚ³Ä¿ º');
writeln('ÇÙ³ ³Ú¶        mINUSCULes eSt vOLONTAIRe) ş up cASEs tHIs wAy)         ÇÙ³ ³Ú¶');
writeln('º ÀÄ³Ùº   dESOLe pOUr mOn mAUVAIS aNGLAIs ş sORRy fOr my bAd eNGLISh   º ÀÄ³Ùº');
writeln('º ÚÄÙ º   de tOUTe fA€On vOUs n''aVEz qu''… ş aNYWAy yOu sHOULd sPEAk    º ÚÄÙ º');
writeln('ºÚ³Ä¿ º           pARLEr fRAN€AIs... sPa? ş fRENCh... sHOULd''nt yOu?   ºÚ³Ä¿ º');
writeln('ÇÙ³ ³Ú¶ °±²Û²±°±²Û²±°±²Û²±°±²Û²±° mALOREAn eFFECt ²Û²±°±²Û²±°±²Û²±°±²Û ÇÙ³ ³Ú¶');
writeln('º ÀÄ³Ùº ± vOLPONe "J''ai faim! j''ai soif!" ş vOLPONe "''am hungry,     ² º ÀÄ³Ùº');
writeln('º ÚÄÙ º ² & sEs ğ                         ş ''am thirsty!" & hIs ğ    ± º ÚÄÙ º');
writeln('ºÚ³Ä¿ º Û sALLy, 42 cREw...                                          ° ºÚ³Ä¿ º');
writeln('ÇÙ³ ³Ú¶ ²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²±°±²Û²± ÇÙ³ ³Ú¶');
writeln('º ÀÄ³Ùº       mALOREAn eFFECt sALUt:      ş   mALOREAn eFFECt hi to:   º ÀÄ³Ùº');
writeln('º ÚÄÙ ºsUn, lOCKEd, mC2...                                             º ÚÄÙ º');
writeln('ºÚ³Ä¿ º          sALUt pERSONNEl:         ş      pERSONNAl hi to:      ºÚ³Ä¿ º');
writeln('ÇÙ³ ³Ú¶wEg, fBi, p. bOISSEl, g.v. (= XXX 21...), p.v., jURASSIQUe mARc,ÇÙ³ ³Ú¶');
writeln('º ÀÄ³ÙºmICKEy...                                  1993 mADe in fRANCe. º ÀÄ³Ùº');
writeln('º ÚÄÙ ºaUTREs (oTHEr) dEMOs: mATHEMATICa I,II,III,IV... XVII... MCCX...º ÚÄÙ º');
writeln('ºÚ³Ä¿ ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼Ú³Ä¿ º');
writeln('ÈÏÏÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÏÍÏÍ¼');
delay(6500);
{end;}
end else begin
writeln('!!! Probl‚me d''allocation m‚moire (?) ş Problem in memory allocation (?) !!!');
end;
end else begin
writeln('!! Probl‚me d''int‚grit‚ du program (?) ş Problem in program integrity (?) !!');
end;
end else begin
writeln('!!! N‚cessite MALOREAN.EXE (?) ş Need MALOREAN.EXE (?) !!!');
end;
end
.