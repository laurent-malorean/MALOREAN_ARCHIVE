#include "graph.c"   ;
#include "complex.c" ;


float Amin  ;
float Amax  ;
float Bmin  ;
float Bmax  ;
unsigned int MaxIter ;

float Max_Z_Re   ;
float Max_Z_Im   ;
float Max_Module ;
float Min_Z_Re   ;
float Min_Z_Im   ;
float Min_Module ;



float 	      A[320];
float 	      B[200];
TComplex      Z,z2,z3,z4  ;
TComplex      C    ;

unsigned int  NbIter;
unsigned char Couleur;


unsigned int Bool1,Bool2,Bool3;


void Cord (void)
{ Amin   =-1.00;
  Amax   =+0.40;
  Bmin   =-0.70;
  Bmax   =+0.70;
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

		  Max_Z_Re   = 0    ;
		  Max_Z_Im   = 0    ;
		  Max_Module = 0    ;
		  Min_Z_Re   = 20000;
		  Min_Z_Im   = 20000;
		  Min_Module = 20000;

		  while ( (NbIter<MaxIter) & (Mod2(Z)<4) )
			{ z2=Z2(Z);
			  z3=z2*Z;
			  z4=z3*Z;
			  Z=z4+z3+z2+Z+C;
			  NbIter++;
			  if (Max_Z_Re<fabs(Z.Re)) Max_Z_Re   = fabs(Z.Re);
			  if (Max_Z_Im<fabs(Z.Im)) Max_Z_Im   = fabs(Z.Im);
			  if (Max_Module<Mod2(Z) ) Max_Module = Mod2(Z)   ;
			  if (Min_Z_Re>fabs(Z.Re)) Min_Z_Re   = fabs(Z.Re);
			  if (Min_Z_Im>fabs(Z.Im)) Min_Z_Im   = fabs(Z.Im);
			  if (Min_Module>Mod2(Z) ) Min_Module = Mod2(Z)   ;

			}
//		  Couleur=(Min_Z_Im+Min_Z_Re)*40;

//		  Couleur=0;
//		  if (NbIter>=(MaxIter/2)) Couleur=( (
//			Min_Z_Im+Min_Z_Re)*40 + (Max_Z_Im+Max_Z_Re)*4
//			+Max_Module ) *15;
//			else Couleur=0;
		  if (NbIter>=(MaxIter/3)) { Bool1 = Max_Z_Re*50;
					     Bool2 = Max_Z_Im*50;
					     Couleur=(Min_Z_Im+Min_Z_Re)*500; }
			else Couleur=0;
			Couleur=(Min_Z_Im+Min_Z_Re)*500;
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