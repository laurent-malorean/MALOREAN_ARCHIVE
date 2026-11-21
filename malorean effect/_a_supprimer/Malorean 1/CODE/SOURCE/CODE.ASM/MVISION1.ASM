; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                      þ
; þ                      SOURCE POUR GERER                               þ
; þ                                                                      þ
; þ          LES 4 PLANS DE BYTE EN VGA 320*200 256 COULEURS             þ
; þ                 LA PALETTE DAC 256 COULEURS                          þ
; þ                 CHARGER DES FICHIERS IMAGES                          þ
; þ                                                                      þ
; þ            1993 VOLPONE for MALOREAN EFFFECT TEAM                    þ
; þ                                                                      þ
; þ                                                                      þ
; þ                     DEBUT          : Juillet 1993                    þ
; þ                     DERNIERE MODIF : Juillet 1993                    þ
; þ                                                                      þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ


   .286
   DOSSEG
   .MODEL LARGE
   org 100h

   .STACK 1024

   .DATA

   PalPal4         DB 'pal4.pal'
   a1              db (?)

   Handle          DW (?)
   OfsVram         DW (?)

   Palette         DB 772 DUP (?) ; Laisse 3 octets en plus

   Mul80           DW 201 DUP (?) ; Tableau de precalque ofset:=80*y+...

   x               DW (?)         ;
   y               DW (?)         ;
   couleur         DW (?)         ;
   PageGraph       DW (?)         ;

   segRetour       DW (?)         ;
   OfsRetour       DW (?)         ;






   .CODE

   PUBLIC GraphMode4Plan
   PUBLIC PutPixel4Plan
   PUBLIC SCROOL
   PUBLIC LoadPal

   MOV AX,@data
   MOV DS,AX


   JMP FinCode

; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE GraphMode4Plan                                        þ
; þ                                                                 þ
; þ Initialise le mode graphique en 320*200 256 couleurs 4 plan     þ
; þ                                                                 þ
; þ PARAMETRES  : Aucun                                             þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX                           þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

GraphMode4Plan PROC FAR

   PUSH AX
   PUSH BX
   PUSH CX
   PUSH DX



   ; Initialisation du mode 320*200 256 couleurs , 4 plans de bite , 4 pages

   MOV AX,0012h  ; Passage en mode 320*200 16 couleurs 4 plans
   INT 10h       ; pour netoyer les 256 ko de Vram
   MOV AX,013h   ; Passage en mode 320*200 256 couleur
   INT 10h       ; sans plan de bit

   MOV DX,03C4h  ; S‚quenceur registre 4 "memory mode"
   MOV AX,0604h  ; Masque 110b  byte 1->256k Vram
                 ;              byte 2->Mode odd/even d‚sactiv‚
                 ;                      traitement lin‚aire d'un plande bite
   OUT DX,AX     ; Ecriture dans le port

   MOV DL,0D4h   ; Controleur CRT
   MOV AX,0014h  ; Registre 14h M
                 ; Masque 00000000b  -> Vire le mode Double Word

   OUT DX,AX     ;  Ecriture dans le port

   MOV AX,0E317h ;  Registre 17h
                 ;  Masque 11100011b -> Passe en mode Byte
   OUT DX,AX     ;  Ecriture dans le port


   ; Initialisation de la table de precalque


             MOV DX,80
             MOV AX,0
             MOV BX,0

InitGraph1 : CMP BX,402
             JA  InitGraph2
             MOV [MUL80+BX],AX      ; Mul80[DI*2(bcp word)]:=AX
             ADD AX,DX           ; Ax:=AX+80
             ADD BX,2
             JMP InitGraph1

InitGraph2 :

    POP DX
    POP CX
    POP BX
    POP AX


             RET
GraphMode4Plan ENDP

; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE TextMode                                              þ
; þ                                                                 þ
; þ Initialise le mode texte 80*25 16 couleurs                      þ
; þ                                                                 þ
; þ PARAMETRES  : Aucun                                             þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX                                    þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

Text_Mode PROC

   PUSH AX

   MOV AX,03h
   Int 10h

   POP AX

   RET
Text_Mode ENDP

; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE Putpixel4Plan                                         þ
; þ                                                                 þ
; þ Fait un point a l'ecran                                         þ
; þ                                                                 þ
; þ PARAMETRES  : Variables X Y Couleur                             þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

PutPixel4Plan PROC FAR

  POP OfsRetour
  POP SegRetour
  POP OfsVram
  POP Couleur
  POP Y
  POP X
  PUSH SegRetour
  PUSH OfsRetour

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI


;  Donnne le segment du point

   MOV AX,0A000h     ;
   MOV ES,AX         ; Segment de la vram

; Determine l'ofset du point

   MOV BX,Y
   SHL BX,1          ; y:=2*y because tableau de word
   MOV AX,Mul80[BX]  ; AX:=y*80


   MOV BX,X          ; BX:=X
   MOV CX,BX         ; CX:=X
   SHR BX,2          ; BX:=Round(X/4)
   ADD BX,AX         ; BX:=80*Y+Round(X/4)
   ADD BX,OfsVram ; BX:=80*Y+Round(X/4)+PageDeBase

;  Determine le plan de bit et masque les autre

   AND CL,011b       ; Cl:=X mod 4=nø du plan de bit
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Sera combin‚ avec SHL pour le masque
   SHL AH,CL         ; Le masque est cr‚e
   MOV DX,03C4h      ; S‚quenceur VGA
   OUT DX,AX         ; Selectione le port


;  Affiche le pixel dans la VRAM

   MOV AL,BYTE PTR Couleur
   MOV Es:[BX],AL

  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX


   RET
PutPixel4Plan ENDP

; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE LoadPal                                               þ
; þ                                                                 þ
; þ Charge une palette depuis le disque  et la rend active          þ
; þ                                                                 þ
; þ PARAMETRES  : DS :Adresse de segment du nom du fichier          þ
; þ               DX : Adrese d'ofset du nom du fichier             þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

LoadPAl PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI


; il faut fournir ds:dx
; Ouverture du fichier º INT 21h Fonction 3Dh

  MOV AX,@data
  MOV DS,AX
  MOV DX,Offset(PalPal4[0]);

  MOV AH,3Dh
  MOV AL,0h
  INT 21h
  MOV Handle,AX       ; On a trouver le Handle


; Lire un fichier      º INT 21h Fonction 3Fh

  MOV DX,Offset(Palette[0])
  MOV CX,768          ; 768 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h

; Fermer le fichier    º INT 21h Fonction 3Eh
  MOV AH,3Eh
  MOV BX,Handle
  INT 21h

; La palette charge devient la palette active

          MOV BX,@data
          MOV DS,BX
          MOV SI,Offset(Palette[0]);

;          MOV SI,BX      ; Offset de palette dans SI

          MOV BX,0       ; BX =compteur de 0 a 255

LoadPal1: CMP BX,256
          JA LoadPal2    ;

          MOV DX,3C8h    ; Port 3C8h met nø DAC Dadant
          MOV AL,BL      ;
          OUT DX,AL      ;


          MOV DX,3C9h    ; Port 3C8h met R puis V puis B incrementation
                         ; est gerer par le materiel
          MOV AL,DS:[SI] ; R[BX] -> AH
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ; V[BX] -> AH
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ; B[BX] -> AH
          OUT DX,AL
          INC SI

          INC BX         ; Incremente le compteur
          JMP LoadPAl1

LoadPal2:


  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX
  RET
LOadPal ENDP



; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE ChangePage                                            þ
; þ                                                                 þ
; þ Change la page active                                           þ
; þ                                                                 þ
; þ PARAMETRES  : BX : ofset                                        þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX CX                                 þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

ChangePage PROC NEAR

PUSH AX
PUSH DX

;attent le retour blanking

MOV DX,03DAh  ; Registre generale port 03DAh

ChangePage1: IN   AL,DX      ; Je suis dans le Retrace vertical
             TEST AL,8
             JZ ChangePage1  ; Non alors on boucle


;donne les nouvellles coordonn‚es de la memoire video
MOV DX,03D4h; Controleur CRT
MOV AL,0Dh  ; Registre 0Dh "START ADRESS LOW"
MOV AH,BL   ; Transmet octet de poid faible du debut de la vram
OUT DX,AX   ; Octet transmit
MOV AL,0Ch  ; Registre 0Dh "START ADRESS HIGHT"
MOV AH,BH   ; Transmet octet de poid fort du debut de la vram
OUT DX,AX   ; Octet transmit


POP DX
POP AX
   RET
ChangePage ENDP


; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE DacUp                                                 þ
; þ                                                                 þ
; þ Variation de palette                                            þ
; þ                                                                 þ
; þ PARAMETRES  AUCUN                                               þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

DacUp PROC NEAR


  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI

  mov bx,@data
  mov DS,BX
  MOV BX,0
  mov si,0


  MOV AH,Palette[0]
  MOV AL,Palette[1]
  MOV CL,Palette[2]


DacUp1: CMP BX,765
        JA DacUP2
        MOV dl,Palette[bx+3]
        MOV Palette[BX],dl
        Inc BX
        JMP DacUp1
DacUp2:


MOV Palette[765],AH
MOV Palette[766],AL
MOV Palette[767],CL

;attent le retour blanking

MOV DX,03DAh  ; Registre generale port 03DAh

DacUp27: IN   AL,DX      ; Je suis dans le Retrace vertical
             TEST AL,8
             JZ DacUp27 ;alors on boucle




; La palette charge devient la palette active

          MOV BX,@data
          MOV DS,BX
          MOV SI,Offset(Palette[0]); Offset de palette dans SI

          MOV BX,0       ; BX =compteur de 0 a 255

DacUp3: CMP BX,257
          JA DacUp4    ;

          MOV DX,3C8h    ; Port 3C8h met nø DAC Dadant
          MOV AL,BL      ;
          OUT DX,AL      ;


          MOV DX,3C9h    ; Port 3C8h met R puis V puis B incrementation
                         ; est gerer par le materiel
          MOV AL,DS:[SI] ; R[BX] -> AH
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ; V[BX] -> AH
          OUT DX,AL
          INC SI

          MOV AL,DS:[SI] ; B[BX] -> AH
          OUT DX,AL
          INC SI

          INC BX         ; Incremente le compteur
          JMP DacUp3

DacUp4:





  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX

  RET
DacUp ENDP




; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE ATTENT                                                þ
; þ                                                                 þ
; þ ATTENT                                                          þ
; þ                                                                 þ
; þ PARAMETRES                                                      þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX                           þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

ATTENT PROC FAR

   push bx

   mov bx,0

aa: cmp bx,25
    ja aa1
    nop
    inc bx
    jmp aa

   aa1:
   pop bx

   RET
ATTENT ENDP


SCROOL PROC FAR

mov ax,0

moi:
cmp ax,1
inc ax
ja finfin
MOV BX,0
moi1: CMP BX,48000
      JA   moi2
      Call ChangePage
      Call Attent
      add  bx,80
      jmp  moi1

moi2:
moi3: CMP BX,80
      JB moi4
      Call ChangePage
      Call Attent
      SUB bx,80
      jmp moi3

moi4:

jmp moi

finfin:

MOV AX,0

coucoucou:
CMP AX,1000
JA finfinfin
Call DacUp
call attent
INC AX
jmp coucoucou




finfinfin:

RET
SCROOL ENDP





FinCode:





;********************************************************************

   Mov ah, 4ch          ;fonction de d‚sactivation de programme du DOS
   Int 21h              ;appel du DOS

   END
