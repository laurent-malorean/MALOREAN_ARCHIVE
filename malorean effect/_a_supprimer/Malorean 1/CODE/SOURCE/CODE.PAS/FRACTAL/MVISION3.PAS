Program Mandel;

Uses CGraph,Crt,Math,GESt_DAC;

Var Cga                    : TGraphVga;

Procedure Courbe;
Var
Xe,Ye                  : Integer;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;
module                 : real;
NbIter                 : Byte;
cou : byte;

Px                     : Array [0..319] Of Real;
Py                     : Array [0..199] Of Real;

Begin; {1}

Amin:= -8;
Amax:=  8;
Bmin:= -8;
Bmax:=  8;
pasX:=(Amax-Amin)/99;
pasY:=(Bmax-Bmin)/99;
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);

For Xe:=0 to 99 Do
For Ye:=Xe to 99 do Begin; {1.1.1}

Cou:=Round(Px[xe]*Cos(Py[Ye])+Py[Ye]*(abs(Px[Xe])));
Vga_Ecran[t[ye+100]+xe+160]:=Cou;
Vga_Ecran[t[xe+100]+ye+160]:=cou;
Vga_Ecran[t[100-ye]+xe+160]:=Cou;
Vga_Ecran[t[100-xe]+160+ye]:=Cou;
Vga_Ecran[t[100-ye]+-xe+160]:=Cou;
vga_Ecran[t[-xe+100]-ye+160]:=cou;
Vga_Ecran[t[100+ye]-xe+160]:=Cou;
Vga_Ecran[t[100+xe]+160-ye]:=Cou;

                    End;    {1.1.1}

End; {1}


BEGIN;
Cga.GraphMode;
PUT_DAC(pal1);
Courbe;
delay(5000);
END.





