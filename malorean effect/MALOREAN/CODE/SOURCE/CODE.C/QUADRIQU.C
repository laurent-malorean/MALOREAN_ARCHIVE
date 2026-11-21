//        ╔═══════════════════════════════════════════════╗
//	  ║                Quadrique.C                    ║
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
//	  ║             Silk,Weg,FBI,Les castors juniors  ║
//	  ║             TmB,Mickey,Jurassique Marc        ║
//	  ║                                               ║
//	  ║         IF YOU USE THIS DO CREDIT ME          ║
//	  ║                                               ║
//	  ╚═══════════════════════════════════════════════╝

#include <math.h>   ;
#include "complex.c";

typedef struct { float A,B,C    ; } FQuadrique ; //A*X^2+B*X+C
typedef struct { int   A,B,C    ; } IQuadrique ;

inline IQuadrique operator +(IQuadrique  U,IQuadrique V);
inline IQuadrique operator -(IQuadrique  U,IQuadrique V);
inline DoubleComplex Racines   (IQuadrique  U);

//************************************************************************
inline IQuadrique operator +(IQuadrique U,
			     IQuadrique V)
{ IQuadrique Buf ;
  Buf.A=U.A+V.A;
  Buf.B=U.B+V.B;
  Buf.C=U.C+V.C;
  return (Buf);
};

//************************************************************************
inline IQuadrique operator -(IQuadrique U,
			   IQuadrique V)
{ IQuadrique Buf ;
  Buf.A=U.A-V.A;
  Buf.B=U.B-V.B;
  Buf.C=U.C-V.C;
  return (Buf);
};

//************************************************************************
inline DoubleComplex Racines   (IQuadrique  U)
{ float Delta,SqrDelta;
  TComplex R1,R2;
  DoubleComplex Buffer;
  Delta=U.B*U.B-4*U.A*U.C;
  if (Delta>=0 ) {R1.Re=(-U.B+sqrt(Delta)) / (2*U.A);
		  R1.Im=0;
		  R2.Re=(-U.B-sqrt(Delta)) / (2*U.A);
		  R2.Im=0;}
  if (Delta< 0 ) {R1.Re=(-U.B) / (2*U.A);
		  R1.Im=(sqrt(-Delta)) / (2*U.A);
		  R2=Conj(R1);}
  Buffer.C1=R1;
  Buffer.C2=R2;
  return (Buffer);
}

//************************************************************************