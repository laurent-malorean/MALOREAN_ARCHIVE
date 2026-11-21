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
{ Amin   =-2.00;
  Amax   =+2.00;
  Bmin   =-2.00;
  Bmax   =+2.00;
  MaxIter=+50;  }


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
			{ Z=Z2(Z)+Z+C;
			  NbIter++;
			 }
		  Couleur=NbIter;
		  PutPixel(X,Y,Couleur);
		  PutPixel(X,199-Y,Couleur);
		  }

      }
}


void main (void)
{
GraphMode();
Cord();
Courbe();

}