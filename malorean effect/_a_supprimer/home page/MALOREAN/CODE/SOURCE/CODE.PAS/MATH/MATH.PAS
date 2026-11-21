 ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                             Mathematik Formules                        บ
 บ                                                                        บ
 บ    By Volpone of Malorean Effect for crazy mathematicians like Toto    บ
 บ                                                                        บ
 บ    Bibliographie : -Fractint.doc  (Version 17.1)                       บ
 บ                    -Pour l'honneur de l'esprit humain                  บ
 บ                     (les mathmatiques aujourd'hui)                    บ
 บ                     Jean Dieudonn                                     บ
 บ                    -My Brain                                           บ
 บ                                                                        บ
 บ                             Version 2.0                                บ
 บ                        Release January 1994                            บ
 บ                                                                        บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

--------------------------- Constantes Part ---------------------------------

ใ   =3.14159265359
ใ/2 =1.5707963268
2*ใ =6.28318530718
e   =2.71828182846

----------------------- Complexe definitions Part -------------------------------

Z=x+i*y

ฤ
Z=x-i*y

Z=r*e^(i*เ)   r=๛(x^2+y^2)  Tan(เ)=y/x

Re(Z) = x   Im(Z) = y

----------------------- Complexe formules Part -------------------------------

     ฤ
Z^-1=Z/(ณZณ^2)

ณZ+Z'ณ<=ณZณ+ณZ'ณ

  ฤ
Z*Z=ณZณ^2

n     n
 ๛(Z)= ๛(r)*e^i*(เ/n)

ณn    ณ   n
ณ ๛(Z)ณ =  ๛ณZณ  = (x^2+y^2)^(1/(2*n))

Z^n=1    -> Z=e^i*(เ/n)

----------------------- Z1=๛(Z2) Part -------------------------------

Z1=๛(Z2)

Re(Z1)=[๛(ณZ2ณ+X2)]/4    บ    Im(Z1)=[๛(ณZ2ณ-X2)]/4

Re(Z1)/Im(Z1)=(ณZ2ณ+x2)/ณy2ณ

Re(Z1)*Im(Z1)=ณy2ณ/16


------------------  Ln \ Log \ Exp \ Z^C Part ------------------------
   *
x๎R  ln(x+iy) = (1/2)ln(x*x + y*y) + i(arctan(y/x) + 2kPi)
                                      (k = 0, +-1, +-2, +-....)
     Ln(i*y)  (y>0) = Ln(y)+i*ใ/2
              (y<0) = Ln(y)-i*ใ/2

     z^z = e^(log(z)*z)

     e^i*a    =  Cos(a) + i*Sin(a)
     e^(x+iy) =  e^x * e^(i*y)
              = (Ch(x) + Sh(x)) * (cos(y) + i*sin(y))
              =  e^x * (cos(y) + i*sin(y))
              = (e^x * cos(y)) + i(e^x * sin(y))

     Z=x+i*y  C=a+i*b

   *
x๎R                    ณZณ^a
     Z^C      =  ----------------- * e^i*(a*ArcTan(y/x) + b*LnณZณ )
                  e^(ArcTan(y/x))

--------------------  Circular real function Part --------------------------

x๎R y๎R

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
ณ The Expoly1 formule is use for the matematica 2                ณ
ณ Expoly1 is create by Volpone Of Malorean Effect                ณ
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
Fx(N)=A.x^2 + (B+2*A*N).X + C+B*N+2*A*ไ  i
                                      i=1
                       N-1
Fx(N)=P(x) + N*P'(X) + ไ  i *P''(x)
                       i=1

Fx(N+1)=Fx(N)+P'(x)+N*P''(x)


Exemples :  F(x,y) = Px(x) + Px(y) = Color to pixel(x,y) Like Matematica 2


---------------------------- Vector Part -------------------------------

->  ณUx    ->  ณVx
U   ณUy    V   ณVy
    ณUz        ณVy

->  ->                      บ  ->   ->   ณUy*Vz-Vy*Uz
U ๙ V  = Ux*Vx+Uy*Vy+Uz*Vz  บ  U ^  V  = ณUz*Vx-Vz*Ux
                            บ            ณUx*Vy-Vx*Uy

->   ->  ->      ->  ->  ->    ->  ->  ->
U ^ (V ^ W ) =  (U . W )*V  - (U . V )*W


----------------------- Quaternion formules Part -------------------------------

Quarternions has discover by Hamilton in 1843

On pose H = ensembles nombres quarternions

Q ๎H  -> Q1=A +i*B +j*C +k*D    ษออออออออออหอออออออออหออออออออหออออออออป
Q1๎H  -> Q1=A1+i*B1+j*C1+k*D1   บ i^2=-1   บ i*j=+k  บ i*k=-j บ j*k=+i บ
Q2๎H  -> Q2=A2+i*B2+j*C2+k*D2   บ k^2=-1   บ j*i=-k  บ k*i=+j บ k*j=-i บ
                                ศออออออออออสอออออออออสออออออออสออออออออผ


ณQณ=๛(A^2+B^2+C^2+D^2)

Q1+Q2=(A1+A2)+(B1+B2)*i+(C1+C2)*j+(D1+D2)*k

Q1*Q2= (A1*A2-B1*B2-C1*C2-D1*D2)
      +(A1*B2+B1*A2+C1*D2+D1*C2)*i
      +(A1*C2-B1*D2+C1*A2+D1*B2)*j
      +(A1*D2+B1*C2-C1*B2+D1*D3)*k


------------------ DEVELOPOMENT LIMITE  ------------------------------------

All Maximal Error are tested By an Hewlett Packard 48S Calculator


            3    5      7       9       11           13
           X    X      X       X       X            X
Sin(X)=X - อ + อออ - ออออ + ออออออ - ออออออออ + ออออออออออ
           6   120   5040   362880   39916800   6227020800

Maximal Error =2.115E-5





      ZORG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!