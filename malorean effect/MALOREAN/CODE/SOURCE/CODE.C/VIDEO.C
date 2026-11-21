//  ╔══════════════════════════════════════════════════════════════════╗
//  ║                   Gestionaire  de video en C                     ║
//  ║								       ║
//  ║   Code : Volpone of "Malorean Effect"                            ║
//  ║                                                                  ║
//  ║   Version1 : 23 Novembre 1993                                    ║
//  ║       							       ║
//  ╚══════════════════════════════════════════════════════════════════╝


unsigned int Page;
unsigned int SegVideo;

typedef struct
	{ unsigned char Caract;
	  unsigned char Attrib;
	} Video;


//--------------------------------------------------------------------
void TextMode (void)
{ asm { mov ax,3;
	int 0x10 }
	Page=0; }
//--------------------------------------------------------------------
void ChosePage (unsigned char _Page)
{ asm { mov ah,5;
	mov al,_Page
	int 0x10 }
	Page=_Page; }
//--------------------------------------------------------------------






void main (void)
{          }