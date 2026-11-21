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
unsigned int  NbIter;
unsigned char Couleur;


void Cord (void)
{ Amin   =-1.20;
  Amax   =+1.00;
  Bmin   =-1.20;
  Bmax   =+1.20;
  MaxIter=+250;  }


void Courbe (void)
{ unsigned int X,Y;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;

  for (X=0 ; X<=320 ; X++)
      { C.Re=A[X];
	for (Y=0 ; Y<=100 ; Y++)
		{ C.Im=B[Y];
		  NbIter=0;
		  Z=Affect(0,0);
		  while ( (NbIter<MaxIter) & (Mod2(Z)<4) )
			{ Z=ZN(Z,15)+C;
			  NbIter++;
			 }
		  if (NbIter==MaxIter) Couleur=200*Mod2(Z);
		  else Couleur=0;
		  PutPixel(X,Y,Couleur);
		  PutPixel(X,199-Y,Couleur);
		  }

      }
}


void main (void)
{
GraphMode();
//PutDac(Volcano);
Cord();
Courbe();

}