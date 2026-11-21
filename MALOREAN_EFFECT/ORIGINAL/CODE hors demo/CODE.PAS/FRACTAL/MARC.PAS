Program Mandel;

Uses GEST_GRAPH;

CONST  Xecr=320; {Nb de pixels en abscice}
       Yecr=200; {Nb de pixels en ordone}
       NbIterMAx = 200; {Nb iteration au bout duquel de calculteur
                          arete la suite}

Procedure Courbe;

Var
Xe,Ye                  : Integer; {Coordonnées du point a l'ecran
                                             dont on va calculer la couleur}
X,Xp,Y                 : Real;    {Z*X+i*Y de Z(n+1)=Zn^2+C}
Amin,Bmin,Amax,Bmax    : Real;    {Les limites de C=A+i*B}
pasX,pasY              : Real;    {Utilsé pour coupepr A et B en parties}
module                 : real;    {Le module de Z}
NbIter                 : Byte;    {Le nbiter}

{C=A+i*B)  dans une  Mandelbrot c'est la valeur de C qui est fonction
de X et de Y ;
A varie de Amin a Amax et est decoupé en Xecr parties
B varie de Bmin a Bmax et est découpé en Yecr parties }

Px                     : Array [0..319] Of Real; {Parties de A}
Py                     : Array [0..199] Of Real; {Parties de B}

Color                  : byte; {La couleur du pt a l'ecran}

Begin; {1}

Amin:= -2  ; {Coordonnée pour avoir une mandelbrot en plein ecran}
Amax:=  0.5;
Bmin:= -1.2;
Bmax:=  1.2;

pasX:=(Amax-Amin)/Xecr; {Coupe A en Xecr parties }
For xe:=0 to 319 do Px [xe]:=amin+pasx*(xe+1);

pasY:=(Bmax-Bmin)/Yecr; {Coupe B en Yecr parties }
For ye:=0 to 199 do Py [ye]:=bmin+pasy*(ye+1);


For Xe:=0 to Xecr Do
For Ye:=0 to Yecr do Begin;
  X:=0;      {Z=0}
  Y:=0;
  module:=0; {Module=0}
  NbIter:=0; {Nbiter=0}

  While      (nbiter<NbIterMax)
  and (Module<4) Do Begin
                    Xp:=SQR(x)-y*y+Px[xe];
                    Y:=2*X*Y   +Py[ye];
                    X:=Xp;
                    NbIter:=NbIter+1;
                    module:=SQR(x)+SQR(y);
                    End;
{Tant que (Nbiter>NbIterMAx) Et (Module<4)
            Z=Z^2+C  Ou C est diferent pour chaque x,y
            Nbiter++
            Module=Module(z)
            }

Color:=NbIter; {Couleur=F(x,y,NbIter,Module);}
PutPixel(Xe,Ye,Color); {Point de coordonnés Xe,Ye et de Couleur Color}

                End;
End;

BEGIN;
GraphMode;
Courbe;
TextMode;
END.