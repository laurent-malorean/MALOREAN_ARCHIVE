Uses CGraph,crt;
Var    VGA      : TGraphVga;
       f        : byte;
       g        : byte;
       c        : word ;
       cou      : byte;
       seg_mul_plus : Word;
       ofs_mul_plus : Word;

       carle    : byte;
       h  : Byte;
       VDI : word;
       hh : word;

       MUL_Plus : array [0..199] of Word;
       MUL_Moin : array [0..199] of Word;


Begin;
Vga.GraphMode;
Seg_Mul_Plus:=Seg(Mul_Plus);
Seg_Mul_Plus:=ofs(Mul_Plus);

for f:=0 to 99 do MUL_Plus[f]:=(f+100)*320+160;
for f:=0 to 199 do MUL_Moin[f]:=(100-f)*320+160;
loadpal ('c:\tp\pal\volcano.pal');
for c:=0 to 550  do Begin;
                    for f:=0 to 99 do
                     for g:=f to 99 do Begin;
{                                     ASM;
                                     MOV BL,F
                                     MOV BH,G
                                     MOV CL,C
                                     MOV AL,CL
                                     SUB AL,BL {c-f}
 {                                    MUL BH
                                     ADD AL,CL
                                     MOV Cou,AL {Cou:=c+g*(c-f)}
  {                                   MOV Bh,0 {bx:=f}
   {                                  MOV Ch,0
                                     MOV CL,g {cx:=g};

    {                                 END;}
                                      cou:=g*(c-g)-c;
                                      Vga_Ecran[Mul_Plus[g]+f]:=Cou;
                                      Vga_Ecran [Mul_Plus[g]-f]:=Cou;

                                      Vga_Ecran[Mul_Plus[f]+g]:=cou;
                                      Vga_Ecran[Mul_Plus[f]-g]:=Cou;

                                      Vga_Ecran[Mul_Moin[g]+f]:=Cou;
                                      Vga_Ecran[Mul_Moin[f]+g]:=Cou;
                                      Vga_Ecran[Mul_Moin[g]+-f]:=Cou;
                                      Vga_Ecran[Mul_Moin[f]-g]:=cou;

                                      end;
                    end;
VGA.TextMode;

END.