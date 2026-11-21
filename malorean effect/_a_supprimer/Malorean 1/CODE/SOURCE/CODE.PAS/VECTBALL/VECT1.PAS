USES CGraph;


VAR   RAYON        : INTEGER;
      Xb,Yb,Zb     : INTEGER;
      Xl,Yl,Zl     : INTEGER;
      PScalaire    : INTEGER;
      Couleur      : BYTE;
      CouInit      : BYTE;
      NbCouleur    : BYTE;
      Xe,Ye        : WORD;
      Cx,Cy        : WORD;

      VGA          : TGraphVGA;



BEGIN;

CouInit:=0;
NbCouleur:=255;

Xl:=0;
Yl:=0;
Zl:=Rayon;

Cx:=160;
Cy:=100;
Rayon:=50;


VGA.GraphMode;

LoadPal('RedBall.pal');


For Zb:=0 To Rayon Do
    For Xb:=0 To Rayon Do Begin;
                YB:=Round(Sqrt((abs(Rayon*Rayon-Zb*Zb-Xb*Xb))));
                               Xe:=Cx+Xb;
                               Ye:=Cy+Yb;
                               VGA.PutPixel(VGA_Ecran,Xe,Ye,7);
                               End;



END.






                               PScalaire:=Xb*Xl+Yb*Yl+Zb*Zl;
                               Couleur:=CouInit+Round(PScalaire*NbCouleur/(Rayon*Rayon));