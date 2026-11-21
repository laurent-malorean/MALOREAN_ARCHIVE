//   ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
//   บ                              Dac.C                                  บ
//   บ                                                                     บ
//   บ   By Volpone of Malorean Effect for use 256 colors whit 320*200     บ
//   บ                                                                     บ
//   บ                           Version 1.0                               บ
//   บ                      Release January  1994                          บ
//   บ                                                                     บ
//   บ  Hi to : Toto,Sally,42 Crew,Aghesacha,Mc2,Sun,Redlight,Locked,Fafa  บ
//   บ          Silk,Weg,FBI,TmB,Jurasique Marc,Mickey,Les castors Junior  บ
//   บ                                                                     บ
//   บ                   IF YOU USES THIS DO CREDIT ME                     บ
//   บ                                                                     บ
//   ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

#include "fractint.c";
#include <dos.h>;

typedef struct { unsigned char R,V,B    ; } T1Dac ;
typedef T1Dac  TDac[255];
typedef unsigned char T2Dac[767];



TDac    DacActive;

void    PutColor ( unsigned char N,  //Number of Dac
		   unsigned char R,
		   unsigned char V,
		   unsigned char B  ) ;

void    PutDac   ( TDac DAC);
void    C2B      ( TDac DAC);  // Color to Black
void    C2W      ( TDac DAC);  // color to white
void    B2C      ( TDac DAC);  // Black to color
void    W2C      ( TDac DAC);  // White to color

void    StandVBL (void) ; // stand the return blancking

//************************************************************************
void PutColor (unsigned char N,unsigned char R,
	       unsigned char V,unsigned char B  )
{ asm {  mov dx,0x3c8
	 mov al,N
	 out dx,al
	 mov dx,0x3c9
	 mov al,R
	 out dx,al
	 mov al,V
	 out dx,al
	 mov al,B
	 out dx,al }


}
//************************************************************************
void    PutDac   ( T2Dac Dac )
{ unsigned int F;

  unsigned int Ofs_DacActive;
  unsigned int Seg_DacActive;
  unsigned int Ofs_Dac;
  unsigned int Seg_Dac;

  Seg_DacActive = FP_SEG(DacActive) ;
  Ofs_DacActive = FP_OFF(DacActive) ;
  Seg_Dac       = FP_SEG(Dac)       ;
  Ofs_Dac       = FP_OFF(Dac) 	    ;

	    asm mov ax,Seg_DacActive
	    asm	mov es,ax
	    asm	mov di,Ofs_DacActive
	    asm	mov ax,Seg_Dac
	    asm	mov ds,ax
	    asm	mov si,Ofs_Dac

	    asm	mov cx,256*3-1
	    asm	mov bx,0

  Return1 : asm mov ax         , ds:[si+bx]
	    asm mov es:[di+bx] , ax
	    asm inc bx
	    asm cmp cx,bx
	    asm jbe Return1

  for (F=0 ; F=255 ; F++ ) PutColor(F,DacActive[F].R,
				      DacActive[F].V,
				      DacActive[F].B);
}
//************************************************************************

//************************************************************************
void    StandVBL (void)
{          asm   mov  dx,0x03DA  // Registre generale port 03DAh
StandVBL1: asm   IN   al,dx      // Je suis dans le Retrace vertical
	   asm   test al,8
	   asm   jz   StandVBL1  // Non alors on boucle
}
//************************************************************************

