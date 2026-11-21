
Unit TGraph;


Interface


Uses Dos,Crt;

Type PetitDac                           =Array[1..3] of Byte;
     TDac                               =Array[0..255] of PetitDac;
     PtoDS                              =Record Dep     :Word;
                                                Seg     :Word;
                                                End;

Var Regs                                :Registers;
    LastTextMode,Result                 :Byte;
    ActPage                             :Byte;
    Dac                                 :TDac;
    Attrb                               :Byte;


{Gestion Generale}

Procedure Hires;
Procedure Text;




{Procedures de gestion des couleurs}

Procedure SetRGBPalette    (Num,R,V,B         :Byte);
Procedure ReadRGBPalette   (Num               :Byte;
                        Var R                 :Byte;
                        Var V                 :Byte;
                        Var B                 :Byte);
Procedure PaletteDown      (Deb,Fin           :Byte);
Procedure PaletteUp        (Deb,Fin           :Byte);
Procedure Black            (K                 :Real;
                            Deb,Fin           :Byte);
Procedure White            (K                 :Real;
                            Deb,Fin           :Byte;
                        Var D                 :TDac);
Procedure LisPalette;
Procedure Palette      (Var D                 :TDac;
                            Deb,Fin           :Byte);


{Procedure de Dessin}

Procedure Line             (Xd,Yd,Xf,Yf       :Word);
Function  GetPixel         (X,Y               :Word)             :Byte;
Procedure PutPixel         (X,Y,Col           :Word);
Procedure HLine            (Xd,Xf,Y,Col       :Word);
Procedure VLine            (X,Yd,Yf,Col       :Word);


{Gestion de blocs d'images}

Function  ImageSize        (Xd,Yd,Xf,Yf       :Word)             :Word;
Procedure Getimage         (Xd,Yd,Xf,Yf       :Word;
                            P                 :Pointer);
Procedure Putimage         (Xd,Yd             :Word;
                            P                 :Pointer);


Implementation




Procedure Hires;
Var Bol           :Boolean;
Begin
Regs.Ah:=0;
Regs.Al:=$13;
Intr ($10,Registers (Regs));
Regs.Ah:=$F;
Intr ($10,Registers (Regs));
If Regs.Al<>$13 Then Result:=1 Else Result:=0;
ActPage:=0;
End;



Procedure Text;
Var Bol           :Boolean;
Begin
Regs.Ah:=0;
Regs.Al:=$3;
Intr ($10,Registers (Regs));
Regs.Ah:=$F;
Intr ($10,Registers (Regs));
If Regs.Al<>$3 Then Result:=1 Else Result:=0;
ActPage:=0;
End;









Procedure PutPixel;
Begin
Mem [$A000:(Y*320)+X]:=Col;
End;



Function GetPixel;
Begin
Getpixel:=Mem [$A000:(Y*320)+X];
End;


Procedure SetRGBPalette;
Begin
Port[$3C8]:=Num;
Port[$3C9]:=R;
Port[$3C9]:=V;
Port[$3C9]:=B;
End;


Procedure ReadRGBPalette;
Begin
Port[$3C7]:=Num;
R:=Port[$3C9];
V:=Port[$3C9];
B:=Port[$3C9];
End;



Procedure LisPalette;
Var I     :Byte;
Begin
Port[$3C7]:=0;
For I:=0 to 255 do Begin
   Dac[I,1]:=Port[$3C9];
   Dac[I,2]:=Port[$3C9];
   Dac[I,3]:=Port[$3C9];
   End;
End;



Procedure PaletteDown;
Var Psg   :PetitDac;
    I     :Byte;
Begin
Psg:=Dac[Fin];
Move (Dac[Deb],Dac[Deb+1],3*(Fin-Deb));
Dac[Deb]:=Psg;
Port[$3C8]:=Deb;
For I:=Deb to Fin do Begin
   Port[$3C9]:=Dac[I,1];
   Port[$3C9]:=Dac[I,2];
   Port[$3C9]:=Dac[I,3];
   End;
End;




Procedure Palette;
Var I      :Byte;
Begin
Port[$3C8]:=Deb;                     {Couleur a changer --->Port $3C8}
For I:=Deb to Fin do Begin
   Port[$3C9]:=D[I,1];               {R puis V puis B --->Port $3C9}
   Port[$3C9]:=D[I,2];
   Port[$3C9]:=D[I,3];
   End;                              {Incrementation automatique}
End;






Procedure PaletteUp;
Var Psg   :PetitDac;
    I     :Byte;
    P     :^TDac;
Begin
New (P);
Psg:=Dac[Deb];
Move (Dac[Deb+1],P^,3*(Fin-Deb));
Move (P^,Dac[Deb],3*(Fin-Deb));
Dac[Fin]:=Psg;
Release (P);
Port[$3C8]:=Deb;
For I:=Deb to Fin do Begin
   Port[$3C9]:=Dac[I,1];
   Port[$3C9]:=Dac[I,2];
   Port[$3C9]:=Dac[I,3];
   End;
End;



Procedure Black;
Var I    :Byte;
    R    :Real;
    D    :TDac;
Begin
LisPalette;
D:=Dac;
R:=1;
Repeat;
For I:=Deb to Fin do Begin
   D[I,1]:=Trunc(Dac[I,1]/R);
   D[I,2]:=Trunc(Dac[I,2]/R);
   D[I,3]:=Trunc(Dac[I,3]/R);
   End;
Palette (D,Deb,Fin);
R:=R+K;
K:=K+(K/10);
Until (63/R)<5;
FillChar (D,Sizeof (D),0);
Palette (D,Deb,Fin);
End;





Procedure White;
Var I    :Byte;
    R    :Real;
    D2   :TDac;
Begin
D2:=D;
K:=K+0.7;
R:=8;
Repeat;
For I:=Deb to Fin do Begin
   D2[I,1]:=Trunc(D[I,1]/R);
   D2[I,2]:=Trunc(D[I,2]/R);
   D2[I,3]:=Trunc(D[I,3]/R);
   End;
Palette (D2,Deb,Fin);
R:=R-K;
K:=K-(K/10);
Until R<1;
Palette (D,Deb,Fin);
End;





Procedure Line;
Var ImpY           :Real;
    YPos           :Real;
    X              :Word;
Begin
{ImpY:=(Yf-Yd)/(Xf-Xd);}
Putpixel (Xd,Yd,15);
Putpixel (Xf,Yf,15);
End;




Procedure HLine;
Var I,Dep       :Word;
Begin
Dep:=Y*320;
For I:=Xd to Xf do Mem[$A000:Dep+I]:=Col;
End;


Procedure VLine;
Var I         :Word;
Begin
For I:=Yd to Yf do Mem[$A000:(I*320)+X]:=Col;
End;




Function ImageSize;
Begin
ImageSize:=((Xf-Xd)+1)*((Yf-Yd)+1)+4;
End;



Procedure GetImage;
Var Line,Y,Cpt    :Word;
    S             :PtoDS;
Begin
S:=PtoDS(P);
Memw [S.Seg:S.Dep]:=(Xf-Xd)+1;
Memw [S.Seg:S.Dep+2]:=(Yf-Yd)+1;
Cpt:=4;  Line:=(Xf-Xd)+1;
For Y:=Yd to Yf do Begin
   Move (Mem [$A000:(Y*320)+Xd],Mem [S.Seg:S.Dep+Cpt],Line);
   Cpt:=Cpt+Line;
   End;
End;




Procedure Putimage;
Var Line,Hau,Y,Cpt,Long   :Word;
    S                     :PtoDs;
Begin
S:=PtoDS(P);
Line:=Memw [S.Seg:S.Dep];
Hau:=Memw [S.Seg:S.Dep+2];
Cpt:=4;
If Yd+Hau>199 Then Hau:=199-Yd;
If Hau<1 Then Exit;
Long:=Line;
If Xd+Line>319 Then Long:=319-Xd;
If Long<1 Then Exit;
For Y:=1 to Hau do Begin
   Move (Mem [S.Seg:S.Dep+Cpt],Mem [$A000:(Y*320)+(Yd*320)+Xd],Long);
   Cpt:=Cpt+Line;
   End;
End;




End.