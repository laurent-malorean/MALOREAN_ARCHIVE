//        ╔═══════════════════════════════════════════════╗
//	  ║                 F_Matr2.C                     ║
//	  ║                                               ║
//	  ║           For 2*2 Matrices's uses             ║
//	  ║                                               ║
//	  ║       By Volpone of Malorean Effect           ║
//	  ║     for crazy mathematicians like Toto        ║
//	  ║                                               ║
//	  ║                                               ║
//	  ║               Version 1.0                     ║
//	  ║          Release December 1993                ║
//	  ║                                               ║
//	  ║  Hello to : Toto,Sally,42 Crew,Aghesacha,     ║
//	  ║             Mc2,Sun,Redlight,Locked,Fafa      ║
//	  ║             Silk,Weg,FBI,TmB                  ║
//	  ║                                               ║
//	  ╚═══════════════════════════════════════════════╝



typedef struct {float M11,M12,M21,M22 ;  } FloatMatrix2;


inline FloatMatrix2 Identity       (void);
inline FloatMatrix2 Tr             (FloatMatrix2   U );
inline FloatMatrix2 Inv            (FloatMatrix2   U );
inline FloatMatrix2 Neg            (FloatMatrix2   U );
inline float        Det            (FloatMatrix2   U );
inline FloatMatrix2 operator +     (FloatMatrix2   U,FloatMatrix2  V);
inline FloatMatrix2 operator -     (FloatMatrix2   U,FloatMatrix2  V);
inline FloatMatrix2 operator *     (FloatMatrix2   U,FloatMatrix2  V);
inline FloatMatrix2 operator *     (float          N,FloatMatrix2  V);
inline FloatMatrix2 Care           (FloatMatrix2  U);


//***************** floating part part *******************************


//-----------------------------------------------------------------------
inline FloatMatrix2 Affect         (float A11,float A12,float A21,float A22 )
{ FloatMatrix2 Buffer;
  Buffer.M11=A11;
  Buffer.M12=A12;
  Buffer.M21=A21;
  Buffer.M22=A22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 Identity (void)
{ FloatMatrix2 Buffer;
  Buffer.M11=1.0;
  Buffer.M12=0.0;
  Buffer.M21=0.0;
  Buffer.M22=1.0;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 Tr             (FloatMatrix2   U )
{ FloatMatrix2 Buffer;
  Buffer.M11=U.M11;
  Buffer.M12=U.M21;
  Buffer.M21=U.M12;
  Buffer.M22=U.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 operator +     (FloatMatrix2   U,FloatMatrix2  V)
{ FloatMatrix2 Buffer;
  Buffer.M11=U.M11+V.M11;
  Buffer.M12=U.M12+V.M12;
  Buffer.M21=U.M21+V.M21;
  Buffer.M22=U.M22+V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 operator -     (FloatMatrix2   U,FloatMatrix2  V)
{ FloatMatrix2 Buffer;
  Buffer.M11=U.M11-V.M11;
  Buffer.M12=U.M12-V.M12;
  Buffer.M21=U.M21-V.M21;
  Buffer.M22=U.M22-V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 operator *     (FloatMatrix2   U,FloatMatrix2  V)
{ FloatMatrix2 Buffer;
  Buffer.M11=U.M11*V.M11+U.M12*V.M21;
  Buffer.M21=U.M21*V.M11+U.M22*V.M21;
  Buffer.M12=U.M11*V.M12+U.M12*V.M22;
  Buffer.M22=U.M21*V.M12+U.M22*V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 operator *     (float          N,FloatMatrix2  V)
{ FloatMatrix2 Buffer;
  Buffer.M11=N*V.M11;
  Buffer.M12=N*V.M21;
  Buffer.M21=N*V.M12;
  Buffer.M22=N*V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 Neg            (FloatMatrix2   U )
{ FloatMatrix2 Buffer;
  Buffer.M11=-U.M11;
  Buffer.M12=-U.M21;
  Buffer.M21=-U.M12;
  Buffer.M22=-U.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline float        Det            (FloatMatrix2   U )
{ float Buffer;
  Buffer=U.M11*U.M22-U.M12-U.M21;
  return (Buffer);}
//-----------------------------------------------------------------------
inline FloatMatrix2 Care           (FloatMatrix2  U)
{ FloatMatrix2 Buffer;
  Buffer.M11=U.M11*U.M11+U.M12*U.M21;
  Buffer.M21=U.M21*U.M11+U.M22*U.M21;
  Buffer.M12=U.M11*U.M12+U.M12*U.M22;
  Buffer.M22=U.M21*U.M12+U.M22*U.M22;
  return (Buffer);}
