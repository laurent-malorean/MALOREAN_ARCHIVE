#include "graph.c"   ;
#include "quaterni.c" ;

float Amin  ;
float Amax  ;
float Bmin  ;
float Bmax  ;
unsigned int MaxIter ;

float 	      A[320];
float 	      B[200];
IntQuaternion      Z    ;
IntQuaternion      C    ;
IntQuaternion      Z0   ;
unsigned int  NbIter;
unsigned char Couleur;
unsigned int  U,V;

void Cord (void)
{ Amin   =-1.05;
  Amax   =-0.65;
  Bmin   =-0.35;
  Bmax   =+0.35;
  MaxIter=+50 ;
  Z0=Affect(0,0,0,0);  }


void Courbe (void)
{ unsigned int X,Y;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;

  for (X=0 ; X<=320 ; X++)
      { C.I=A[X];
	for (Y=0 ; Y<=199 ; Y++)
		{ //C.I  = 0 ;
		  C.J  = B[Y];
		  NbIter= 0    ;
		  Z     = Z0   ;
		  while ( (NbIter<MaxIter) & (Mod2(Z)<16) )
			{ Z=(Deg2(Z))+C;
			  NbIter++;
			 }
		  Couleur=NbIter ;
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