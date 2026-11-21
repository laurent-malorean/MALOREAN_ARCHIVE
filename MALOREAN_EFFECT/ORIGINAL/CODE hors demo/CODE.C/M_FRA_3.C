#include<STDLIB.H>;
#include <math.h>;
#include "graph.c"   ;
#include "f_matr2.c" ;

float Amin  ;
float Amax  ;
float Bmin  ;
float Bmax  ;
unsigned int MaxIter ;

float 	      A[320];
float 	      B[200];
FloatMatrix2      Z    ;
FloatMatrix2      C    ;
FloatMatrix2      Z0   ;
unsigned int  NbIter;
unsigned char Couleur;
unsigned int  U,V;

void Cord (void)
{ Amin   =-1.30;
  Amax   =+1.00;
  Bmin   =-1.20;
  Bmax   =+1.20;
  MaxIter=+255 ;
  Z0     =Affect(0.0,0.0,0.0,0.0);  }


void Courbe (void)
{ unsigned int X,Y;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;

  for (X=0 ; X<=320 ; X++)
      {
	for (Y=0 ; Y<=199 ; Y++)
		{ C.M11  = B[Y] ;
		  C.M22  = A[X] ;
		  C.M12  = random(100)/50;
		  C.M21  = random(100)/50;

		  NbIter = 0    ;
		  Z      = Z0   ;
		  while ( (NbIter<MaxIter) & (fabs(Det(Z))<4) )
			{ Z=Care(Z)+C;
			  NbIter++;
			 }
		  Couleur=Det(Z);
		  PutPixel(X,Y,Couleur);
		  }

      }
}


void main (void)
{
GraphMode();
Cord();
Courbe();

}