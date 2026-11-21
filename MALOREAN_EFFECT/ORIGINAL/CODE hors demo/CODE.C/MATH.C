#include <math.h>;

typedef long int MathLongInt;

inline MathLongInt Deg2  (MathLongInt X );
inline MathLongInt Deg3  (MathLongInt X );
inline MathLongInt Deg4  (MathLongInt X );
inline float    Deg2  (float X );
inline float    Deg3  (float X );
inline float    Deg4  (float X );

inline float Sqrt   (float X);
inline float SqrtN  (float X,float N);

//inline float aCosh  (float Angle);
inline float aSinh  (float Angle);
inline float aTanh  (float Angle);

inline float Exposant (float X,float N);

//  Code Code Code Code Code Code Code Code Code Code Code Code Code Code


inline MathLongInt Deg2  (MathLongInt X )  {  return (X*X)    ; }
inline MathLongInt Deg3  (MathLongInt X )  {  return (X*X*X)  ; }
inline MathLongInt Deg4  (MathLongInt X )  {  return (X*X*X*X); }
inline float    Deg2  (float X ) { return (X*X);     }
inline float    Deg3  (float X ) { return (X*X*X);   }
inline float    Deg4  (float X ) { return (X*X*X*X); }

inline float Exposant (float X,float N)
{ float Buffer;
  if (X==0) return(0) ;
  else
  if (X>0) Buffer=exp(N*log(X));
  else     Buffer=1/( exp(N*log(-X)) );
  return (Buffer);
}

// ------------------- Circular Function Part -----------------------------
//inline float aCosh  (float Angle)
//{ float Buffer;
//  if (Angle>=1)  Buffer=log(Angle+sqrt(Angle*Angle-1));
//	   else  Buffer=0      ;
//  return (Buffer);
//}
