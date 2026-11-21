#include <math.h>;
#include "graph.c"   ;
#include "f_matr2.c" ;


float Amin,Amax,Bmin,Bmax,Cmin,Cmax,Dmin,Dmax  ;

float 	      A[3200];
float 	      B[2000];
float 	      C[3200];
float 	      D[2000];
int           Xmax= 160 ;
int           Ymax= 100 ;


FloatMatrix2      Cm    ;
unsigned char Couleur;

void Cord (void)
{ Amin   =-1.50*2+5;
  Amax   =+2.00*2+5;
  Bmin   =-2.00*2+5;
  Bmax   =+2.00*2+5;
  Cmin   =-5.50*2+5;
  Cmax   =+1.00*2+5;
  Dmin   =-2.00*2+5;
  Dmax   =+0.00*2+5;
   }


void Courbe (void)
{ unsigned int X,Y,modulo;
  for (X=0 ; X<=Xmax ; X++) A[X]=Amin+((Amax-Amin)/Xmax)*X;
  for (X=0 ; X<=Ymax ; X++) B[X]=Bmin+((Bmax-Bmin)/200)*X;
  for (X=0 ; X<=Xmax ; X++) C[X]=Cmin+((Cmax-Cmin)/Xmax)*X;
  for (X=0 ; X<=Ymax ; X++) D[X]=Dmin+((Dmax-Dmin)/200)*X;


  for (X=0 ; X<=Xmax ; X++)
	for (Y=0 ; Y<=Ymax ; Y++)
		{ Cm.M11  =cos(A[X]+B[Y]+C[X]+D[Y]);
		  Cm.M22  =sin(A[X]-B[Y]+C[X]-D[Y]);
		  Cm.M12  =sin(A[X]+B[Y]-C[X]+D[Y]);
		  Cm.M21  =cos(A[X]+B[Y]+C[X]-D[Y]);
		  Couleur =5*Det(Cm);
		  PutPixel(X,Y,Couleur);
		  }
}


void main (void)
{
GraphMode();
Cord();
Courbe();

}