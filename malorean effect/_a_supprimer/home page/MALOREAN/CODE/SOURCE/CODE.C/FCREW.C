//        ษอออออออออออออออออออออออออออออออออออออออออออออออป
//	  บ                    Demo                       บ
//	  บ                                               บ
//	  บ       By Volpone of Malorean Effect           บ
//	  บ                                               บ
//	  บ          Release December 1993                บ
//	  บ                                               บ
//	  บ  Hello to : Toto,Sally,42 Crew,Aghesacha,     บ
//	  บ             Mc2,Sun,Redlight,Locked,Fafa      บ
//	  บ             Silk,Weg,FBI,Les castors juniors  บ
//	  บ             TmB,Mickey                        บ
//	  ศอออออออออออออออออออออออออออออออออออออออออออออออผ

#include <math.h>   ;

const NbCercleTotal = 200;
const NbCercleEcran = 50;


const NbPt     = 50 ;

const Alpha    = 2  ; // Le cercle final est Alpha fois
		      //  plus petit que le premier

const Rayon    = 50 ;

const DxMax    = 50 ;
const DyMax    = 40 ;


int  Dx[NbCercleTotal+10000]  	    ;
int  Dy[NbCercleTotal+10000]  	    ;

int   X[NbCercleEcran][NbPt]   ;
int   Y[NbCercleEcran][NbPt]   ;

int   Cx            ;
int   Cy	    ;

int   CercleReel       ; //N๘ du cercle que l'on dessine
int   CercleVirtuel    ; //N๘ du cercle que l'on dessine parmis tous
			 //meme ceux que l'on ne vois pas


void CalcDxDy (void)
{ unsigned int F1 ;
  for (F1=0 ; F1<=NbCercleTotal ; F1++)
	  { Dx[F1]=DxMax*cos(2*6.28/NbCercleTotal*F1);
	    Dy[F1]=DyMax*sin(2*6.28/NbCercleTotal*F1);  }

}



void main (void)
{
CalcDxDy();

}


