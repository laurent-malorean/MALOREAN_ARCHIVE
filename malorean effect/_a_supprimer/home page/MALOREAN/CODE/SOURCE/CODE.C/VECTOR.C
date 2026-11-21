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
Cvector operator /(Cvector U,float R  );

float   Abs        (Cvector U);
Cvector DVP       (Cvector U,Cvector V,Cvector W);
//     -> -> ->     ->   ->  ->
// DVP(U, V, W  ) = U ^ (V ^ V);

Pvector PolarConvert (Cvector U);


//************************************************************************

Cvector operator +(Cvector U,
		   Cvector V)
{ Cvector Buf ;
  Buf.X=U.X+V.X;
  Buf.X=U.Y+V.Y;
  Buf.X=U.Z+V.Z;
  return (Buf);
};
Pvector operator +(Pvector U,
		   Pvector V)
{ Pvector Buf ;
  Buf.R=U.R+V.R;
  Buf.Fi=U.Fi+V.Fi;
  Buf.Z=U.Z+V.Z;
  return (Buf);
};

//************************************************************************

Cvector operator -(Cvector U,
		   Cvector V)
{ Cvector Buf ;
  Buf.X=U.X-V.X;
  Buf.X=U.Y-V.Y;
  Buf.X=U.Z-V.Z;
  return (Buf);
};

//************************************************************************

float   operator *(Cvector U,
		   Cvector V)
{ float Buf ;
  Buf=U.X*V.X+U.Y*V.Y+U.Z*V.Z;
  return (Buf);
};

//************************************************************************

Cvector operator *(float   U,
		   Cvector V )
{ Cvector Buf ;
  Buf.X=U*V.X;
  Buf.Y=U*V.Y;
  Buf.Z=U*V.Z;
  return (Buf);
};

//************************************************************************

Cvector operator ^(Cvector U,
		   Cvector V  )

{ Cvector Buf ;
  Buf.X=U.Y*V.Z-V.Y*U.Z;
  Buf.Y=U.Z*V.X-V.Z*U.X;
  Buf.Z=U.X*V.Y-V.X*U.Y;
  return (Buf);
};

//************************************************************************

Cvector operator /(Cvector U,
		   Cvector V  )

{ Cvector Buf ;
  Buf.X=U.Y*V.Z-V.Y*U.Z;
  Buf.Y=U.Z*V.X-V.Z*U.X;
  Buf.Z=U.X*V.Y-V.X*U.Y;
  return (Buf);
};
//************************************************************************
Cvector operator /(Cvector U,float R  )
{ Cvector Buf ;
if (R!=0) { Buf.X=U.X/R;
	    Buf.Y=U.Y/R;
	    Buf.Z=U.Z/R;
	  }
  return (Buf);
};

//************************************************************************
Cvector DVP       (Cvector U,Cvector V,Cvector W)
{ Cvector Buf ;
  Buf=(U*W)*V-(U*V)*W;
  return (Buf);

}

//************************************************************************
Pvector PolarConvert (Cvector U)
{ Pvector Buf ;
		  Buf.R  = sqrt(U.X*U.X+U.Y*U.Y);
  if (U.X=0)      Buf.Fi = 0 			;
	     else Buf.Fi = atan(U.Y/U.X)	;
		  Buf.Z  = U.Z			;

  return (Buf);
}
//************************************************************************
float   Abs        (Cvector U)
{ float Buffer;
  Buffer=sqrt(U.X*U.X+U.Y*U.Y+U.Z*U.Z);

  return (Buffer);
}
