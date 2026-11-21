//        ษอออออออออออออออออออออออออออออออออออออออออออออออป
//	  บ                Quadrique.C                    บ
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
//	  บ             Silk,Weg,FBI,Les castors juniors  บ
//	  บ             TmB,Mickey,Jurassique Marc        บ
//	  บ                                               บ
//	  บ         IF YOU USE THIS DO CREDIT ME          บ
//	  บ                                               บ
//	  ศอออออออออออออออออออออออออออออออออออออออออออออออผ

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