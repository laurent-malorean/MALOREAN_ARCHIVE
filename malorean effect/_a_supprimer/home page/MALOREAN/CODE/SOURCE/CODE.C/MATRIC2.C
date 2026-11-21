//        ษอออออออออออออออออออออออออออออออออออออออออออออออป
//	  บ                 Matric2.C                     บ
//	  บ                                               บ
//	  บ           For 2*2 Matrices's uses             บ
//	  บ                                               บ
//	  บ       By Volpone of Malorean Effect           บ
//	  บ     for crazy mathematicians like Toto        บ
//	  บ                                               บ
//	  บ                                               บ
//	  บ               Version 1.0                     บ
//	  บ          Release December 1993                บ
//	  บ                                               บ
//	  บ  Hello to : Toto,Sally,42 Crew,Aghesacha,     บ
//	  บ             Mc2,Sun,Redlight,Locked,Fafa      บ
//	  บ             Silk,Weg,FBI,TmB                  บ
//	  บ                                               บ
//	  ศอออออออออออออออออออออออออออออออออออออออออออออออผ



typedef struct {int M11,M12,M21,M22 ;  } IntMatrix2;

inline IntMatrix2 Affect         (int A11,int A12,int A21,int A22 );
inline IntMatrix2 Identity       (void);
inline IntMatrix2 Tr             (IntMatrix2   U );
inline IntMatrix2 Inv            (IntMatrix2   U );
inline IntMatrix2 Neg            (IntMatrix2   U );
inline int        Abs            (IntMatrix2   U );
inline IntMatrix2 operator +     (IntMatrix2   U,IntMatrix2  V);
inline IntMatrix2 operator -     (IntMatrix2   U,IntMatrix2  V);
inline IntMatrix2 operator *     (IntMatrix2   U,IntMatrix2  V);
inline IntMatrix2 operator *     (int          N,IntMatrix2  V);


//-----------------------------------------------------------------------
inline IntMatrix2 Affect         (int A11,int A12,int A21,int A22 )
{ IntMatrix2 Buffer;
  Buffer.M11=A11;
  Buffer.M12=A12;
  Buffer.M21=A21;
  Buffer.M22=A22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 Identity (void)
{ IntMatrix2 Buffer;
  Buffer.M11=1;
  Buffer.M12=0;
  Buffer.M21=0;
  Buffer.M22=1;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 Tr             (IntMatrix2   U )
{ IntMatrix2 Buffer;
  Buffer.M11=U.M11;
  Buffer.M12=U.M21;
  Buffer.M21=U.M12;
  Buffer.M22=U.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 operator +     (IntMatrix2   U,IntMatrix2  V)
{ IntMatrix2 Buffer;
  Buffer.M11=U.M11+V.M11;
  Buffer.M12=U.M12+V.M12;
  Buffer.M21=U.M21+V.M21;
  Buffer.M22=U.M22+V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 operator -     (IntMatrix2   U,IntMatrix2  V)
{ IntMatrix2 Buffer;
  Buffer.M11=U.M11-V.M11;
  Buffer.M12=U.M12-V.M12;
  Buffer.M21=U.M21-V.M21;
  Buffer.M22=U.M22-V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 operator *     (IntMatrix2   U,IntMatrix2  V)
{ IntMatrix2 Buffer;
  Buffer.M11=U.M11*V.M11+U.M12*V.M21;
  Buffer.M21=U.M21*V.M11+U.M22*V.M21;
  Buffer.M12=U.M11*V.M12+U.M12*V.M22;
  Buffer.M22=U.M21*V.M12+U.M22*V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 operator *     (int          N,IntMatrix2  V)
{ IntMatrix2 Buffer;
  Buffer.M11=N*V.M11;
  Buffer.M12=N*V.M21;
  Buffer.M21=N*V.M12;
  Buffer.M22=N*V.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline IntMatrix2 Neg            (IntMatrix2   U )
{ IntMatrix2 Buffer;
  Buffer.M11=-U.M11;
  Buffer.M12=-U.M21;
  Buffer.M21=-U.M12;
  Buffer.M22=-U.M22;
  return (Buffer);}
//-----------------------------------------------------------------------
inline int        Abs            (IntMatrix2   U )
{ int Buffer;
  Buffer=U.M11*U.M22-U.M12-U.M21;
  return (Buffer);}
//-----------------------------------------------------------------------
