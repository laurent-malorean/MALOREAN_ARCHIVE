//        ╔═══════════════════════════════════════════════╗
//	  ║                    Demo                       ║
//	  ║                                               ║
//	  ║       By Volpone of Malorean Effect           ║
//	  ║                                               ║
//	  ║          Release December 1993                ║
//	  ║                                               ║
//	  ║  Hello to : Toto,Sally,42 Crew,Aghesacha,     ║
//	  ║             Mc2,Sun,Redlight,Locked,Fafa      ║
//	  ║             Silk,Weg,FBI,Les castors juniors  ║
//	  ║             TmB,Mickey,Jurassique Marc        ║
//	  ╚═══════════════════════════════════════════════╝

#include <math.h>   ;
#include "graph.c";

const NbCercleTotal = 200;
const NbCercleEcran = 50;


const NbPt     = 50 ;

const Alpha    = 2  ; // Le cercle final est Alpha fois
		      //  plus petit que le premier

int   Rayon    = 35 ; //le plus petit rayon

const DxMax    = 50 ;
const DyMax    = 40 ;


int  Dx[NbCercleTotal+10000]  	    ;
int  Dy[NbCercleTotal+10000]  	    ;

int   X[NbCercleEcran][NbPt]   ;
int   Y[NbCercleEcran][NbPt]   ;


int   Cx            ;
int   Cy	    ;

int   CercleReel       ; //N° du cercle que l'on dessine
int   CercleVirtuel    ; //N° du cercle que l'on dessine parmis tous
			 //meme ceux que l'on ne vois pas


void CalcDxDy (void)
{ unsigned int F1 ;
  for (F1=0 ; F1<=NbCercleTotal ; F1++)
	  { Dx[F1]=DxMax*cos(2*6.28/NbCercleTotal*F1);
	    Dy[F1]=DyMax*sin(2*6.28/NbCercleTotal*F1);  }

}
//********************************************************************
void CalcRayon (void)
{ unsigned int F1 ;
  unsigned int F2 ;
  float        Ri ;
  float        ANGLEi;


  for (F1=0 ; F1<=NbCercleEcran ; F1++)
   { Ri=Rayon*(1+(Alpha-1)*F1/NbCercleEcran);
     for (F2=0 ; F2<=NbPt          ; F2++);
       { ANGLEi=(6.28/NbPt)*F2;
	 X[F1][F2]=Ri*cos(ANGLEi);
	 Y[F1][F2]=Ri*sin(ANGLEi);
       }
   }
}
//********************************************************************
void Affiche (void)
{ unsigned int F1 ;
  unsigned int F2 ;

  for (F1=0 ; F1<=NbCercleEcran ; F1++)
  for (F2=0 ; F2<=NbPt          ; F2++)
  {  PutPixel(X[F1][F2]+160,Y[F1][F2]+100,7);
  }

 }

void main (void)
{  GraphMode();
   CalcDxDy ();
   CalcRayon();
   Affiche  ();
}