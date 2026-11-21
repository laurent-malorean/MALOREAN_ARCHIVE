//        ╔═══════════════════════════════════════════════╗
//	  ║                  Vector.C                     ║
//	  ║                                               ║
//	  ║       By Volpone of Malorean Effect           ║
//	  ║     for crazy mathematicians like Toto        ║
//	  ║                                               ║
//	  ║                                               ║
//	  ║               Version 1.0                     ║
//	  ║          Release November 1993                ║
//	  ║                                               ║
//	  ║  Hello to : Toto,Sally,42 Crew,Aghesacha,     ║
//	  ║             Mc2,Sun,Redlight,Locked,Fafa      ║
//	  ║                                               ║
//	  ╚═══════════════════════════════════════════════╝

#include <math.h>


typedef struct { float X,Y,Z    ; } Cvector;
typedef struct { float R,Fi,Z   ; } Pvector;

Cvector operator +(Cvector U,Cvector V);
Pvector operator +(Pvector U,Pvector V);
Cvector operator -(Cvector U,Cvector V);
float   operator *(Cvector U,Cvector V);
Cvector operator *(float   U,Cvector V);
Cvector operator ^(Cvector U,Cvector V);
Cvector operator /(Cvector U,Cvector V);

Cvector DVP       (Cvector U,Cvector V,Cvector W);
//     -> -> ->     ->   ->  ->
// DVP(U, V, W  ) = U ^ (V ^ V);

Pvector PolarConvert (Cvector U);


