//        ╔═══════════════════════════════════════════════╗
//	  ║                Polynome.C                     ║
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


typedef struct { char D0,D1,D2,D3,D4    ; } Poly;
typedef enum   {Deriv1,Deriv2,Deriv3,Deriv4} Deg;

Poly operator +(Poly  U,Poly V);
Poly operator -(Poly  U,Poly V);
Poly operator *(char  U,Poly V);

Poly   Derive (Poly U,Deg Degres);
int    Image  (Poly P,int X      );
float  Image  (Poly P,float X    );

//************************************************************************

Poly operator +(Poly U,
		Poly V)
{ Poly Buf ;
  Buf.D0=U.D0+V.D0;
  Buf.D1=U.D0+V.D1;
  Buf.D2=U.D0+V.D2;
  Buf.D3=U.D0+V.D3;
  Buf.D4=U.D0+V.D4;
  return (Buf);
};

//************************************************************************
Poly operator -(Poly U,
		Poly V)
{ Poly Buf ;
  Buf.D0=U.D0-V.D0;
  Buf.D1=U.D0-V.D1;
  Buf.D2=U.D0-V.D2;
  Buf.D3=U.D0-V.D3;
  Buf.D4=U.D0-V.D4;
  return (Buf);
};


//************************************************************************



Poly operator *(char    U,
		Poly    V )
{ Poly Buf ;
  Buf.D0=U*V.D0;
  Buf.D1=U*V.D1;
  Buf.D2=U*V.D2;
  Buf.D3=U*V.D3;
  Buf.D4=U*V.D4;

  return (Buf);
};

//************************************************************************
Poly Derive (Poly U,Deg Degres)
{ Poly Buf   ;

  if (Degres=1) { Buf.D0=  U.D1	 ;
		  Buf.D1=2*U.D2	 ;
		  Buf.D2=3*U.D3	 ;
		  Buf.D3=4*U.D4  ;
		  Buf.D4=0	 ; };

  if (Degres=2) { Buf.D0=2 *U.D2 ;
		  Buf.D1=6 *U.D3 ;
		  Buf.D2=12*U.D4 ;
		  Buf.D3=0	 ;
		  Buf.D4=0	 ; };

  if (Degres=3) { Buf.D0=6 *U.D3 ;
		  Buf.D1=24*U.D4 ;
		  Buf.D2=0	 ;
		  Buf.D3=0	 ;
		  Buf.D4=0	 ; };

  if (Degres=4) { Buf.D0=24*U.D4 ;
		  Buf.D1=0	 ;
		  Buf.D2=0	 ;
		  Buf.D3=0	 ;
		  Buf.D4=0	 ; };

  return (Buf);
}

//************************************************************************

int  Image  (Poly P,int X    )
{ int Buf;
  Buf=P.D4*X*X*X*X+P.D3*X*X*X+P.D2*X*X+P.D1*X+P.D0;
  return (Buf);

}