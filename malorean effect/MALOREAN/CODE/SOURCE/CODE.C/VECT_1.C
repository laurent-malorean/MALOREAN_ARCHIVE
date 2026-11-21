#include "vector.c";
#include "graph.c";

typedef float Tabl[500];

unsigned int  X,Y ;          //Coordonneés des pixel a l'écran
unsigned char Color;
unsigned int  NbIter;

Cvector      U,V,W;
Tabl         Xu,Yu,Zu ;
Tabl         Xv,Yv,Zv ;

unsigned int MaxIter=20;
float        Au=+1.5;    //Au*X+Bu*Y+Cu*Z=0 Plan de coupe Idem V
float        Bu=+2.0;
float        Cu=+5.0;
float        Av=-2.0;
float        Bv=+3.7;
float        Cv=+1.2;

float        XuMin=-5.0;
float        XuMax=+5.0;
float        YuMin=-5.0;
float        YuMax=+5.0;
float        XvMin=-5.0;
float        XvMax=+5.0;
float        YvMin=-5.0;
float        YvMax=+5.0;

void Init (void)
{
for (X=0 ; X<=320 ; X++) { Xu[X]=XuMin+(XuMax-XuMin)/320*X;
			   Xv[X]=XvMin+(XvMax-XvMin)/320*X; }
for (Y=0 ; Y<=200 ; Y++) { Yu[Y]=YuMin+(YuMax-YuMin)/320*Y;
			   Yv[Y]=YvMin+(YvMax-YvMin)/320*Y; }
}


void Courbe (void)
{
  for (X=0 ; X<=320 ; X++)
	for (Y=0 ; Y<=199 ; Y++)
		{ U.X=Xu[X];
		  U.Y=Yu[Y];
		  U.Z=(-Au*Xu[X]-Bu*Yu[Y])/Cu;
		  V.X=Xv[X];
		  V.Y=Yv[Y];
		  V.Z=(-Av*Xv[X]-Bv*Yv[Y])/Cv;
		  NbIter= 0    ;

		  W=U^V;
//		  while ( (NbIter<MaxIter)  )
//			{ W=W^U;
//			  NbIter++;
 //			 }
		  W=W/Abs(W);
		  Color=(W.X+W.Y+W.Z)*255/3+7;
		  PutPixel(X,Y,Color);
		}


}

void main (void)
{
GraphMode();
Init();
Courbe();
}
