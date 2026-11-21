#include <math.h>  ;
#include "math.c"  ;

typedef struct { float  R,I,J,K  ; } IntQuaternion ;

typedef struct { float R,I,J,K  ; } FloatQuaternion ;


inline IntQuaternion operator +(IntQuaternion Q1, IntQuaternion Q2);
inline IntQuaternion operator -(IntQuaternion Q1, IntQuaternion Q2);
inline IntQuaternion operator *(IntQuaternion Q1, IntQuaternion Q2);
inline IntQuaternion operator *(long int      A , IntQuaternion Q );
inline IntQuaternion operator *(IntQuaternion Q , long int      A );
inline IntQuaternion Deg2      (IntQuaternion Q                   );
inline float         Mod       (IntQuaternion Q                   );
inline long int      Mod2      (IntQuaternion Q                   );
inline float         ModLin2   (IntQuaternion Q                   );
inline IntQuaternion	  Affect    (float A,float B,float C,float D);

// ******************** non floatint point part ****************************

inline IntQuaternion operator +(IntQuaternion Q1, IntQuaternion Q2)
{ IntQuaternion Buffer;
  Buffer.R=Q1.R+Q2.R  ;
  Buffer.I=Q1.I+Q2.I  ;
  Buffer.J=Q1.J+Q2.J  ;
  Buffer.K=Q1.K+Q2.K  ;
  return (Buffer)     ;
}

//----------------------------------------------------------------------

inline IntQuaternion operator -(IntQuaternion Q1, IntQuaternion Q2)
{ IntQuaternion Buffer;
  Buffer.R=Q1.R-Q2.R  ;
  Buffer.I=Q1.I-Q2.I  ;
  Buffer.J=Q1.J-Q2.J  ;
  Buffer.K=Q1.K-Q2.K  ;
  return (Buffer)     ;
}

//----------------------------------------------------------------------

inline IntQuaternion operator *(IntQuaternion Q1, IntQuaternion Q2)
{ IntQuaternion Buffer;
  Buffer.R=Q1.R*Q2.R-Q1.I*Q2.I-Q1.J*Q2.J-Q1.K-Q2.K;
  Buffer.I=Q1.R*Q2.I+Q1.I*Q2.R+Q1.J*Q2.K-Q1.K-Q2.J;
  Buffer.J=0;
  Buffer.K=0;
  return (Buffer)     ;
}

//----------------------------------------------------------------------

inline IntQuaternion operator *(long int  A , IntQuaternion Q )
{ IntQuaternion Buffer;
  Buffer.R=A*Q.R;
  Buffer.I=A*Q.I;
  Buffer.J=A*Q.J;
  Buffer.K=A*Q.K;
  return (Buffer)     ;
}

//----------------------------------------------------------------------
inline IntQuaternion operator *(IntQuaternion Q , long int      A )
{ return (A*Q)     ; }

//----------------------------------------------------------------------

inline IntQuaternion Deg2      (IntQuaternion Q)
{ IntQuaternion Buffer;
  Buffer.R=Q.R*Q.R-Q.I*Q.I-Q.J*Q.J-Q.K-Q.K;
  Buffer.I=Q.R*Q.I+Q.I*Q.R+Q.J*Q.K-Q.K-Q.J;
  Buffer.J=0;
  Buffer.K=0;
  return (Buffer)     ;
}

//----------------------------------------------------------------------

inline long int  Mod2      (IntQuaternion Q)
{ long int  Buffer;
  Buffer=Deg2(Q.R)+Deg2(Q.I)+Deg2(Q.J)+Deg2(Q.K);
  return (Buffer); }

//----------------------------------------------------------------------

inline float  Mod      (IntQuaternion Q)
{ float  Buffer;
  Buffer=sqrt(Mod2(Q));
  return (Buffer); }
//----------------------------------------------------------------------
inline float         ModLin2   (IntQuaternion Q                   )
{ return ( fabs(Q.R)+fabs(Q.I)+fabs(Q.J)+fabs(Q.K) );  }
//----------------------------------------------------------------------
inline IntQuaternion      Affect    (float A,float B,float C,float D)
{IntQuaternion Buffer;
 Buffer.R=A;
 Buffer.I=B;
 Buffer.J=C;
 Buffer.K=D;
 return (Buffer); }






