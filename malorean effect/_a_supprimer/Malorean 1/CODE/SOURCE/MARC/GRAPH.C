#define   VgaSeg   0a000h;
#define   IntVideo 10h	 ;
#define   Graph    13h   ;
#define   Text     03h	 ;

unsigned int Mul320[210] ;

void Table (void)
{
unsigned char F1;
for (F1=0 ; F1<201 ; F1++) Mul320[F1]=320*F1;
}



void PutPixel (unsigned int X,unsigned int Y,unsigned char Color)
{ unsigned int Ofset;
  Ofset=320*Y+X;
  asm { mov ax,VgaSeg;
	mov es,ax
	mov di,Ofset
	mov al,Color
	mov es:[di],al  }
}

void GraphMode (void)
{ asm { mov ax,Graph ;
	int IntVideo ; }

}

void TextMode (void)
{ asm { mov ax,Text  ;
	int IntVideo ; }

}
