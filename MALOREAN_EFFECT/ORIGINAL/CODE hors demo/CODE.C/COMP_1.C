#include <math.h>;
#include "graph.c"   ;
#include "complex.c" ;

float Rmin,Rmax,Imin,Imax  ;

float 	      R[320];
float 	      I[200];
unsigned char Couleur;
TComplex      C1,C2;

void Cord (void)
{ Rmin   =+0.00;
  Rmax   =+2.00*99;
  Imin   =+1.00*10;
  Imax   =+2.00*99;   }


void Courbe (void)
{ unsigned int X,Y,modulo;
  for (X=0 ; X<=319 ; X++) R[X]=Rmin+((Rmax-Rmin)/320)*X;
  for (X=0 ; X<=199 ; X++) I[X]=Imin+((Imax-Imin)/200)*X;

  for (X=0 ; X<=319 ; X++)
  for (Y=0 ; Y<=199 ; Y++)
    { C1=Affect(R[X],I[Y]);
      Couleur =35*Mod2(C1)*Arg(C1);
      PutPixel(X,Y,Couleur);  }
}


void main (void)
{ GraphMode();
  Cord();
  Courbe(); }