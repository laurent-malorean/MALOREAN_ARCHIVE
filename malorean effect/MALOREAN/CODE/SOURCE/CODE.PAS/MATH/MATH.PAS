 ╔════════════════════════════════════════════════════════════════════════╗
 ║                             Mathematik Formules                        ║
 ║                                                                        ║
 ║    By Volpone of Malorean Effect for crazy mathematicians like Toto    ║
 ║                                                                        ║
 ║    Bibliographie : -Fractint.doc  (Version 17.1)                       ║
 ║                    -Pour l'honneur de l'esprit humain                  ║
 ║                     (les mathématiques aujourd'hui)                    ║
 ║                     Jean Dieudonné                                     ║
 ║                    -My Brain                                           ║
 ║                                                                        ║
 ║                             Version 2.0                                ║
 ║                        Release January 1994                            ║
 ║                                                                        ║
 ╚════════════════════════════════════════════════════════════════════════╝

--------------------------- Constantes Part ---------------------------------

π   =3.14159265359
π/2 =1.5707963268
2*π =6.28318530718
e   =2.71828182846

----------------------- Complexe definitions Part -------------------------------

Z=x+i*y

─
Z=x-i*y

Z=r*e^(i*α)   r=√(x^2+y^2)  Tan(α)=y/x

Re(Z) = x   Im(Z) = y

----------------------- Complexe formules Part -------------------------------

     ─
Z^-1=Z/(│Z│^2)

│Z+Z'│<=│Z│+│Z'│

  ─
Z*Z=│Z│^2

n     n
 √(Z)= √(r)*e^i*(α/n)

│n    │   n
│ √(Z)│ =  √│Z│  = (x^2+y^2)^(1/(2*n))

Z^n=1    -> Z=e^i*(α/n)

----------------------- Z1=√(Z2) Part -------------------------------

Z1=√(Z2)

Re(Z1)=[√(│Z2│+X2)]/4    ║    Im(Z1)=[√(│Z2│-X2)]/4

Re(Z1)/Im(Z1)=(│Z2│+x2)/│y2│

Re(Z1)*Im(Z1)=│y2│/16


------------------  Ln \ Log \ Exp \ Z^C Part ------------------------
   *
xεR  ln(x+iy) = (1/2)ln(x*x + y*y) + i(arctan(y/x) + 2kPi)
                                      (k = 0, +-1, +-2, +-....)
     Ln(i*y)  (y>0) = Ln(y)+i*π/2
              (y<0) = Ln(y)-i*π/2

     z^z = e^(log(z)*z)

     e^i*a    =  Cos(a) + i*Sin(a)
     e^(x+iy) =  e^x * e^(i*y)
              = (Ch(x) + Sh(x)) * (cos(y) + i*sin(y))
              =  e^x * (cos(y) + i*sin(y))
              = (e^x * cos(y)) + i(e^x * sin(y))

     Z=x+i*y  C=a+i*b

   *
xεR                    │Z│^a
     Z^C      =  ----------------- * e^i*(a*ArcTan(y/x) + b*Ln│Z│ )
                  e^(ArcTan(y/x))

--------------------  Circular real function Part --------------------------

xεR yεR

     Sh(x)       = [e^x - e^(-x)]/2
     Ch(x)       = [e^x + e^(-x)]/2
     Th(x)       = Sh(x)/Ch(x)
     Sh(x)+Ch(x) = e^x

     Sin (x+y)   = Sin(x)*Cos(y)+Cos(x)*Sin(y)
     Sin (x-y)   = Sin(x)*Cos(y)-Cos(x)*Sin(y)
     Cos (x+y)   = Cos(x)*Cos(y)-Sin(x)*Sin(y)
     Cos (x-y)   = Cos(x)*Cos(y)+Sin(x)*Sin(y)
     Tan (x+y)   = [Tan(x)+Tan(b)] / [1-Tan(x)*Tan(y)]
     Tan (x-y)   = [Tan(x)-Tan(b)] / [1+Tan(x)*Tan(y)]
     ATan(x+y)   =



-------------------  Circular complex function Part ------------------------

     sin (x+iy) = sin(x)Ch(y) + icos(x)Sh(y)
     cos (x+iy) = cos(x)Ch(y) - isin(x)Sh(y)
     Sh(x+iy) = Sh(x)cos(y) + iCh(x)sin(y)
     Ch(x+iy) = Ch(x)cos(y) + iSh(x)sin(y)

                       sin(2x)               Sh(2y)
     tan(x+iy) = ------------------  + i------------------
                 cos(2x) + Ch(2y)     cos(2x) + Ch(2y)

                      Sh(2x)                sin(2y)
     tanh(x+iy) = ------------------ + i------------------
                  Ch(2x) + cos(2y)    Ch(2x) + cos(2y)

                   sin(2x) - i*Sh(2y)
     cotan(x+iy) = --------------------
                    Ch(2y) - cos(2x)

                    Sh(2x) - i*sin(2y)
     cotanh(x+iy) = --------------------
                     Ch(2x) - cos(2y)



--------------------  Expoly1 Part   -----------------------------
│ The Expoly1 formule is use for the matematica 2                │
│ Expoly1 is create by Volpone Of Malorean Effect                │
------------------------------------------------------------------

P(x)=A.x^2+B.X+C

           d
 P'(x)   = --- P(x)   =  2*A.x+B
           dx

            d
 P''(x)  = --- P'(x)  =  2*A
           dx

            d
 P'''(x) = --- P''(x) =  0
           dx

-The formule
                                  d
Fx(0)=P(X)    Fx(N) = Fx(N-1) +  ----Fx(N-1)
                                  dx

-Example :first number of suite

(Fx(1)=P(x)+P'(x) )
                     d
(Fx(2)=P(x)+P'(x) + ---[P(x)+P'(x)]
                     dx
      =P(x)+P'(x)+[P'(x)+P''(x)]
      =P(x)+2*P'(x)+P''(x)


- The formules
                                      N-1
Fx(N)=A.x^2 + (B+2*A*N).X + C+B*N+2*A*Σ  i
                                      i=1
                       N-1
Fx(N)=P(x) + N*P'(X) + Σ  i *P''(x)
                       i=1

Fx(N+1)=Fx(N)+P'(x)+N*P''(x)


Exemples :  F(x,y) = Px(x) + Px(y) = Color to pixel(x,y) Like Matematica 2


---------------------------- Vector Part -------------------------------

->  │Ux    ->  │Vx
U   │Uy    V   │Vy
    │Uz        │Vy

->  ->                      ║  ->   ->   │Uy*Vz-Vy*Uz
U ∙ V  = Ux*Vx+Uy*Vy+Uz*Vz  ║  U ^  V  = │Uz*Vx-Vz*Ux
                            ║            │Ux*Vy-Vx*Uy

->   ->  ->      ->  ->  ->    ->  ->  ->
U ^ (V ^ W ) =  (U . W )*V  - (U . V )*W


----------------------- Quaternion formules Part -------------------------------

Quarternions has discover by Hamilton in 1843

On pose H = ensembles nombres quarternions

Q εH  -> Q1=A +i*B +j*C +k*D    ╔══════════╦═════════╦════════╦════════╗
Q1εH  -> Q1=A1+i*B1+j*C1+k*D1   ║ i^2=-1   ║ i*j=+k  ║ i*k=-j ║ j*k=+i ║
Q2εH  -> Q2=A2+i*B2+j*C2+k*D2   ║ k^2=-1   ║ j*i=-k  ║ k*i=+j ║ k*j=-i ║
                                ╚══════════╩═════════╩════════╩════════╝


│Q│=√(A^2+B^2+C^2+D^2)

Q1+Q2=(A1+A2)+(B1+B2)*i+(C1+C2)*j+(D1+D2)*k

Q1*Q2= (A1*A2-B1*B2-C1*C2-D1*D2)
      +(A1*B2+B1*A2+C1*D2+D1*C2)*i
      +(A1*C2-B1*D2+C1*A2+D1*B2)*j
      +(A1*D2+B1*C2-C1*B2+D1*D3)*k


------------------ DEVELOPOMENT LIMITE  ------------------------------------

All Maximal Error are tested By an Hewlett Packard 48S Calculator


            3    5      7       9       11           13
           X    X      X       X       X            X
Sin(X)=X - ═ + ═══ - ════ + ══════ - ════════ + ══════════
           6   120   5040   362880   39916800   6227020800

Maximal Error =2.115E-5





      ZORG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!