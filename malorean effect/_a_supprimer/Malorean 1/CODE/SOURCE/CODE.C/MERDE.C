//        ษอออออออออออออออออออออออออออออออออออออออออออออออป
//	  บ                  Vector.C                     บ
//	  บ                                               บ
//	  บ       By Volpone of Malorean Effect           บ
//	  บ     for crazy mathematicians like Toto        บ
//	  บ                                               บ
//	  บ                                               บ
//	  บ               Version 1.0                     บ
//	  บ          Release November 1993                บ
//	  บ                                               บ
//	  บ  Hello to : Toto,Sally,42 Crew,Aghesacha,     บ
//	  บ             Mc2,Sun,Redlight,Locked,Fafa      บ
//	  บ                                               บ
//	  ศอออออออออออออออออออออออออออออออออออออออออออออออผ

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


