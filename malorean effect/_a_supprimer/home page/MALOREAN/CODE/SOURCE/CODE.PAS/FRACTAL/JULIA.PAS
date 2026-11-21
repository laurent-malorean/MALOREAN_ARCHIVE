Program Mandel;

Uses CGraph,Crt;

Const
Xmax=319;
Ymax=200;

Type
Im_a  = Array[1..320,1..200] Of byte;

Var

a,b                    : Real;
X,Xp,Y                 : Real;
Amin,Bmin,Amax,Bmax    : Real;
pasX,pasY              : Real;

module : real;
NbIter                 : Integer;
Xpt,Ypt                : Integer;
c : integer;
ImA                     :^Im_A;
F_ima                   : File Of Im_A;

Procedure sauve_fichier;
Var
chemin    : String;
Begin;
chemin:=('c:\turbo\new3.vga');
Assign(F_ImA,chemin);
Rewrite (F_ImA);
Write(F_ImA,Ima^);
Close(F_Ima);
sound(400);delay(100);nosound;
End;

Procedure init_graph;
Var
Vga : tgraphvga;
Begin;
vga.graphmode;
End;




Procedure Courbe;
Var
Xe,Ye        : Integer;
cx,cy : real;
Begin; {1}

{Amin:=-1.7;
Amax:=+1.7;
Bmin:=-0.8;
Bmax:=+0.8;
Cx:=-1;
Cy:=0;}

Amin:=-1;
Amax:=+1;
Bmin:=-1.5;
Bmax:=+1.5;
Cx:=-0.32;
Cy:=0.043;



pasX:=(Amax-Amin)/Xmax;
pasY:=(Bmax-Bmin)/Ymax;


x:=amin;
xe:=1;
ye:=1;

For xe:=1 to 100 do
For ye:=1 to 100  do begin; {1.1.1}
                     X:=amin+Xe*pasx;
                     Y:=bmin+Ye*pasy;
                     NbIter:=0;
                     module:=0;
                     While (nbiter<50)
                     and (x*x+y*y<4) Do Begin {1.1.1.1}
                                        Xp:=X*X-Y*Y+Cx;
                                        Y:=2*X*Y   +Cy;
                                        X:=Xp;
                                        NbIter:=NbIter+1;
                                        module:=x*x+y*y;
                                        End;   {1.1.1.1}


{If x*x+y*y<4 then Begin;
                  c:=round(module*10) ;
                  c:=c mod 3 +1;
                   putpixel(xe,ye,c);
                    putpixel(xe,200-ye,c);
                    putpixel(320-xe,200-ye,c);
                    putpixel(320-xe,ye,c);
                    Ima^[xe,ye]:=nbiter mod 256;
                    Ima^[320-xe,ye]:=nbiter mod 256;
                    Ima^[xe,200-ye]:=nbiter mod 256;
                    Ima^[320-xe,200-ye]:=nbiter mod 256;
                   end;}

                  c:=nbiter mod 20;
                   Vga_Ecran[t[ye]+xe]:=c;;
                    Ima^[xe,ye]:=nbiter mod 256;


   end;
End; {1}


BEGIN;
Init_Graph;
new(ima);
Courbe;
sauve_fichier;

END.




