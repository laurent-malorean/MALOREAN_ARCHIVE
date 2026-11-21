//  ╔══════════════════════════════════════════════════════════════════╗
//  ║                   Gestionaire  de souris en C                    ║
//  ║								       ║
//  ║   Code : Volpone of "Malorean Effect"                            ║
//  ║                                                                  ║
//  ║   Version1 : 23 Novembre 1993                                    ║
//  ║       							       ║
//  ╚══════════════════════════════════════════════════════════════════╝


unsigned int  MouseButton1;
unsigned int  MouseButton2;
unsigned int  MouseButton12;

void          InitMouse           (void)  ;
//Initialise la souris

void 	      ShowMouse           (void)  ;
// affiche la souris

void 	      HideMouse           (void)  ;
//cache la souris

void 	      ButtonMouse         (void);
//si bouton gauche          enfoncé -> MouseButton1  =1
//          droite                  -> MouseButton2  =1
//          gauche et droite        -> MouseButton12 =1
//           		            -> MouseButton1  =1
//				    -> MouseButton2  =1

void          GotoMouse           (unsigned int X,unsigned int Y);
//place le cuseur de la souris en (X,Y)

void          LimitMouse          (unsigned int X1,unsigned int Y1,
				   unsigned int X2,unsigned int Y2);
//la souris ne peut plus se deplacer qu'en en rectangle définni
// par le deux extrémités (X1,Y1) (X2,Y2)

unsigned int  NbLeftClick         (void);
//renvois le nombre de clicks du bouton gauche depuis que cette
//fonction a été apelé

unsigned int  NbRightClick        (void);
//renvois le nombre de clicks du bouton droit depuis que cette
//fonction a été apelé


void 	      ExcludeMouse        (unsigned int X1,unsigned int Y1,
				   unsigned int X2,unsigned int Y2);
//la souris peut se promener partout(dans le rectangle définit
//par LimitMouse) sauf dans la partie définie par le rectangle
// (X1,Y1 (X2,Y2)

void          DisableExcludeMouse (void);
//vire le mode d'exclusion d'une partie de l'écran

void          ChosePageMouse      (unsigned int Page);
//choisit la page écran ou la souris est afiché
//sera surement coiplé avec une unit de gestion écran

//----------------------------------------------------------------
void InitMouse (void)
{ asm { mov ax,0x0000;
	int 0x33     ; } }
//----------------------------------------------------------------
void ShowMouse (void)
{ asm { mov ax,1 ;
	int 0x33 ;  } }
//----------------------------------------------------------------
void HideMouse (void)
{ asm { mov ax,2
	int 0x33; } }
//----------------------------------------------------------------
void ButtonMouse (void)
{ unsigned int  Buffer ;
  asm { mov ax,3;
	int 0x33;
	mov Buffer,bx  }
	if (Buffer==1) {MouseButton1=1 ;
			MouseButton2=0 ;
			MouseButton12=0;}

	if (Buffer==2) {MouseButton1=0 ;
			MouseButton2=1 ;
			MouseButton12=0;}


	if (Buffer==3) {MouseButton1=1 ;
			MouseButton2=1 ;
			MouseButton12=1;}
	 }
//----------------------------------------------------------------
void GotoMouse (unsigned int X,unsigned int Y)
{ asm { mov ax,4;
	mov cx,X
	shl cx,3
	mov dx,Y
	shl dx,3
	int 0x33     ; } }
//----------------------------------------------------------------
void LimitMouse (unsigned int X1,unsigned int Y1,unsigned int X2,unsigned int Y2)
{ asm { mov ax,7;
	mov cx,X1
	shl cx,3
	mov dx,X2
	shl dx,3
	int 0x33
	mov ax,8;
	mov cx,Y1
	shl cx,3
	mov dx,Y2
	shl dx,3
	int 0x33 } }
//----------------------------------------------------------------
unsigned int  NbLeftClick (void)
{ unsigned int Buffer  ;
  asm { mov ax,5
	mov bx,0
	int 0x33;
	mov Buffer,bx}
	return (Buffer); }
//----------------------------------------------------------------
unsigned int  NbRightClick (void)
{ unsigned int Buffer  ;
  asm { mov ax,5
	mov bx,1
	int 0x33;
	mov Buffer,bx}
	return (Buffer); }
//----------------------------------------------------------------
void ExcludeMouse (unsigned int X1,unsigned int Y1,unsigned int X2,unsigned int Y2)
{ asm { mov ax,0x10;
	mov cx,X2
	shl cx,3
	mov dx,Y2
	shl dx,3
	mov si,X1
	shl si,3
	mov di,Y1
	shl di,3
	int 0x33 } }
//----------------------------------------------------------------
void DisableExcludeMouse (void)
{ ShowMouse(); }
//----------------------------------------------------------------
void  ChosePageMouse (unsigned int Page)
{
  asm { mov ax,0x01d
	mov bx,Page
	int 0x33;  }  }
//----------------------------------------------------------------

