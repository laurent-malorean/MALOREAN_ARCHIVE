//        ษอออออออออออออออออออออออออออออออออออออออออออออออป
//	  บ                 Complex.C                     บ
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
//	  บ             Silk,Weg,FBI,TmB                  บ
//	  บ                                               บ
//	  ศอออออออออออออออออออออออออออออออออออออออออออออออผ

#include <math.h>;
#include "math.c" ;

#define Pi      3.1415926;
#define PiDiv2  1.5707963268;

typedef struct { float Re,Im    ; } TComplex ;

inline TComplex operator +(TComplex  U,TComplex V);
inline TComplex operator -(TComplex  U,TComplex V);
inline TComplex operator *(TComplex  U,TComplex V);
inline TComplex operator *(float     N,TComplex V);
inline TComplex operator /(TComplex  U,TComplex V);
inline TComplex operator /(float     N,TComplex V);
inline TComplex operator ^(TComplex  U,TComplex V);
inline TComplex operator ^(TComplex  U,float N);
inline TComplex Z2        (TComplex  U);
inline TComplex ZN        (TComplex  U,float N);


inline float    Re      (TComplex U);
inline float    Im      (TComplex U);
inline float    Mod     (TComplex U);
inline float    Mod2    (TComplex U);
inline float    ModLin  (TComplex U);
inline float    ModLin2 (TComplex U);

inline TComplex Conj (TComplex U);
inline TComplex Sqrt (TComplex U);

inline TComplex Exp (TComplex U);
inline TComplex Ln  (TComplex U);


inline TComplex Affect (float Re,float Im);


//************************************************************************

inline TComplex operator +(TComplex U,
			   TComplex V)
{ TComplex Buf ;
  Buf.Re=U.Re+V.Re;
  Buf.Im=U.Im+V.Im;
  return (Buf);
};

//************************************************************************
inline TComplex operator -(TComplex U,
			   TComplex V)
{ TComplex Buf ;
  Buf.Re=U.Re-V.Re;
  Buf.Im=U.Im-V.Im;
  return (Buf);
};

//************************************************************************

inline TComplex operator *(TComplex    U,
			   TComplex    V )
{ TComplex Buf ;
  Buf.Re=U.Re*V.Re-U.Im*V.Im;
  Buf.Im=U.Re*V.Im+U.Im*V.Re;
  return (Buf);
};
//************************************************************************
inline TComplex operator *(float     N,TComplex V)
{ TComplex Buf ;
  Buf.Re=N*V.Re;
  Buf.Im=N*V.Im;
  return (Buf);
};


//************************************************************************
inline TComplex Z2        (TComplex  U)
{ TComplex Buf ;
  Buf.Re=U.Re*U.Re-U.Im*U.Im;
  Buf.Im=2*U.Re*U.Im;
  return(Buf);
}
//************************************************************************
inline float  Re (TComplex U)
{ return (U.Re); }

//************************************************************************
inline float  Im (TComplex U)
{ return (U.Im); }

//************************************************************************
inline float    Mod  (TComplex U)
{ return (sqrt(U.Re*U.Re+U.Im*U.Im));  }

//************************************************************************
inline float    Mod2  (TComplex U)
{ return (U.Re*U.Re+U.Im*U.Im);  }

//************************************************************************
inline float    ModLin2 (TComplex U)
{ return ( fabs(U.Re)+fabs(U.Im) );  }
//************************************************************************
inline TComplex Conj (TComplex U)
{ U.Im=-U.Im;
  return (U); }
//************************************************************************
inline TComplex Sqrt  (TComplex U)
{ TComplex Buf;
  Buf.Re= sqrt(Mod(U)+U.Re)/4;
  Buf.Im= sqrt(Mod(U)-U.Re)/4;
  return (Buf); }
//************************************************************************
inline TComplex Affect (float Re,float Im)
{ TComplex Buffer;
  Buffer.Re=Re;
  Buffer.Im=Im;
  return(Buffer);

}
//************** Ln Exp Part **********************************************
inline TComplex Exp (TComplex U)
{ TComplex Buffer;
  Buffer.Re=cos(U.Im);
  Buffer.Im=sin(U.Im);
  Buffer=exp(U.Re)*Buffer;
  return(Buffer);
}
//************************************************************************
inline TComplex operator ^(TComplex  U,float N)
{ TComplex Buffer;
  float    Buffer2;
  if (U.Re=0) { Buffer.Re=0;
		Buffer.Im=-Exposant(U.Im,N);} //pas sure du signe
  else
  if (U.Im=0) { Buffer.Re=Exposant(U.Re,N);
		Buffer.Im=0;}
  else
			      {Buffer.Re=0;
			       Buffer.Im=N*atan(U.Im/U.Re);
			       Buffer2=Exposant(Mod(U),N);
			       Buffer=Buffer2*Buffer;}
  return (Buffer);

}




//************** Circular function part  ********************************
inline TComplex aCosh (float  Angle)
{ TComplex Buffer;
  if (Angle>=1)  { Buffer.Re=log(Angle+sqrt(Angle*Angle-1));
		   Buffer.Im=0; }
  if (Angle<=-1) { Buffer.Re=log(Angle+sqrt(Angle*Angle-1));
		   Buffer.Im=Pi; }

}


//************************************************************************
inline TComplex Ln (TComplex U)
{ TComplex Buffer;
  if (U.Im==0) { if (U.Re==0) { Buffer.Re=0        ;
				Buffer.Im=0        ;
				return (Buffer)    ; }
		 if (U.Re>0 ) { Buffer.Re=log(U.Re);
				Buffer.Im=0	   ;
				return (Buffer)    ; }
		 if (U.Re<0 ) { Buffer.Re=log(-U.Re);
				Buffer.Im=Pi	   ;
				return (Buffer)    ; }
	       }

  if (U.Re==0) { if (U.Im==0) { Buffer.Re=0        ;
				Buffer.Im=0        ;
				return (Buffer)    ; }
		 if (U.Im>0 ) { Buffer.Re=log(U.Im);
				Buffer.Im=PiDiv2   ;
				return (Buffer)    ; }
		 if (U.Im<0 ) { Buffer.Re=log(-U.Im);
				Buffer.Im=-PiDiv2   ;
				return (Buffer)    ; }
	      }
  Buffer.Re=0.5*log(Mod2(U));
  Buffer.Im=atan(U.Im/U.Re);
  return(Buffer);

}
//************************************************************************


//************************************************************************

//************************************************************************



inline TComplex ZN        (TComplex  U,float N)
{ TComplex Buffer;
  float    Buffer2;
  TComplex Vide;
  Vide=U;
  if (Vide.Re==0) { Buffer.Re=0;
		Buffer.Im=-Exposant(U.Im,N);
		return(Buffer);} //pas sure du signe
  if (Vide.Im==0) { Buffer.Re=Exposant(U.Re,N);
		Buffer.Im=0;
		return(Buffer);}
   Buffer.Re=N*atan(U.Im/U.Re);
   Buffer.Im=Buffer.Re;
   Buffer.Re=cos(Buffer.Re);
   Buffer.Im=sin(Buffer.Im);
   Buffer2=Exposant(Mod(U),N);
   Buffer=Buffer2*Buffer;
  return (Buffer);

}
