#include "graph.c"   ;
#include "complex.c" ;
#include <conio.h>

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
{ Amin   =-2.00;
  Amax   =-1.80;
  Bmin   =-0.08;
  Bmax   =+0.08;
  MaxIter=+200 ;
  Z0=Affect(0,0);  }


void Courbe (void)
{ unsigned int X,Y;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;

  for (X=0 ; X<=320 ; X++)
      { C.Re=A[X];
	for (Y=0 ; Y<=100 ; Y++)
		{ C.Im  = B[Y] ;
		  NbIter= 0    ;
		  Z     = Z0   ;
		  while ( (NbIter<MaxIter) & (ModLin2(Z)<4) )
			{ Z=ZN(Z*Z,-4)+C;
			  Z.Re=Z.Re/1.5;
			  Z.Im=Z.Im/1.5;
			  NbIter++;
			 }
		  Couleur=NbIter*Z.Re*5 ;
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
//getch();

}