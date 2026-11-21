#include <math.h>;
#include "graph.c"   ;
#include "f_matr2.c" ;

float Amin,Amax,Bmin,Bmax,Cmin,Cmax,Dmin,Dmax  ;

float 	      A[320];
float 	      B[200];
float 	      C[320];
float 	      D[200];

FloatMatrix2      Cm    ;
unsigned char Couleur;

void Cord (void)
{ Amin   =-1.50*5;
  Amax   =+2.00*5;
  Bmin   =-2.00*5;
  Bmax   =+2.00*5;
  Cmin   =-5.50*5;
  Cmax   =+1.00*5;
  Dmin   =-2.00*5;
  Dmax   =+0.00*5;

   }


void Courbe (void)
{ unsigned int X,Y,modulo;
  for (X=0 ; X<=319 ; X++) A[X]=Amin+((Amax-Amin)/320)*X;
  for (X=0 ; X<=199 ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;
  for (X=0 ; X<=319 ; X++) C[X]=Cmin+((Cmax+Cmin)/320)*X;
  for (X=0 ; X<=199 ; X++) D[X]=Dmin+((Dmax+Dmin)/200)*X;


  for (X=0 ; X<=319 ; X++)
	for (Y=0 ; Y<=199 ; Y++)
		{ Cm.M11  =cos(A[X]+B[Y]+C[X]+D[Y]);
		  Cm.M22  =sin(A[X]-B[Y]+C[X]+D[Y]);
		  Cm.M12  =sin(A[X]+B[Y]-C[X]+D[Y]);
		  Cm.M21  =cos(A[X]+B[Y]+C[X]-D[Y]);
		  Couleur=5*Det(Cm);
		  PutPixel(X,Y,Couleur);
		  }
}


void main (void)
{
GraphMode();
Cord();
Courbe();

}