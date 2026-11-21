#include "graph.c"   ;
#include "complex.c" ;

float Amin  ;
float Amax  ;
float Bmin  ;
float Bmax  ;
unsigned int MaxIter ;

float 	      A[320];
float 	      B[200];
TComplex      Z    ;
TComplex      C    ;
TComplex      Z0   ;
unsigned int  NbIter;
unsigned char Couleur;
unsigned int  U,V;

void Cord (void)
{ Amin   =-1.10;
  Amax   =+1.10;
  Bmin   =-1.10;
  Bmax   =+1.10;
  MaxIter=+50 ;
  Z0=Affect(0,0);  }


void Courbe (void)
{ unsigned int X,Y;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;

  for (X=0 ; X<=320 ; X++)
      { C.Re=A[X];
	for (Y=0 ; Y<=199 ; Y++)
		{ C.Im  = B[Y] ;
		  NbIter= 0    ;
		  Z   = Z0;
		  while ( (NbIter<MaxIter) & (Mod2(Z)<4) )
			{ Z=Z2(Z2(Z2(Z2(Z2(Z)))))+C;
			  NbIter++;
			 }
//		  if (NbIter==MaxIter) Couleur=20*ModLin2(Z)*Mod2(Z)*(Z.Re+Z.Im);
		  if (NbIter==MaxIter) Couleur=20*(Z.Re+Z.Im);
		  else Couleur=7;
		  PutPixel(X,Y,Couleur);
//		  PutPixel(X,199-Y,Couleur);
		  }

      }
}


void main (void)
{
GraphMode();
Cord();
Courbe();

}