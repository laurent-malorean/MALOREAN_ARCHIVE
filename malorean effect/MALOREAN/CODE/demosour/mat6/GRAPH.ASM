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

   PalVolcano      DB 'c:\tp\pal\volcano.pal'
   a1              db (?)
   PalBlue         DB 'c:\tp\pal\Blue.pal'
   a2              db (?)
   Fichier1        DB 'bit1.4pl$'
   a3              db (?)
   Fichier2        DB 'bit2.4pl$'
   a4              db (?)
   Fichier3        DB 'bit3.4pl$'
   a5              db (?)
   Fichier4        DB 'bit4.4pl$'
   a6              db (?)


   InfoShoot       DB (?)         ;Premier Octet du fichier Shoot
   Palette         DB 772 DUP (?) ; Laisse 3 octets en plus
   PaletteDepart   DB 772 DUP(?)  ; pour mov rapide

   Handle          DW (?)         ;  Handle pour charger fichier

   Mul80           DW 201 DUP (?) ; Tableau de precalque ofset:=80*y+...
   OfsPage         DW 4   DUP (0,16000,32000,48000)
   OfsVram         DW (?)         ;
   NoPage          DW (?)         ;

   Xe              DW (?)         ;
   Ye              DW (?)         ;
   couleur         DW (?)         ;
   PageGraph       DW (?)         ;


   buffer          DB 16000 DUP (?)

   FileTable       DB 'Table.tbl$'
   a9              DB (?)
   COS             DW 255 DUP (?)
   SIN             DW 255 DUP (?)




; DATA pour proc LINE
    Deltax           DW (?)          ;
    Deltay           DW (?)          ;
    Dx2              DW (?)          ;
    Dy2              DW (?)          ;
    X1               DW (?)          ;
    Y1               DW (?)          ;
    X2               DW (?)          ;
    Y2               DW (?)          ;
    X                DW (?)          ;
    Y                DW (?)          ;
    Erreur           DW (?)          ;
    InterChange      DW (?)          ;
    I                DW (?)          ;


    LimNeg           EQU 32767       ;





   .CODE

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

GraphMode4Plan PROC

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

InitGraph1:CMP BX,402
           JA  InitGraph2
           MOV [MUL80+BX],AX  ; Mul80[DI*2(bcp word)]:=AX
           ADD AX,DX          ; Ax:=AX+80
           ADD BX,2
           JMP InitGraph1

InitGraph2:





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

PutPixel4Plan PROC

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


   MOV BX,X         ; BX:=X
   MOV CX,BX         ; CX:=X
   SHR BX,2          ; BX:=Round(X/4)
   ADD BX,AX         ; BX:=80*Y+Round(X/4)
;   ADD BX,PageDeBase ; BX:=80*Y+Round(X/4)+PageDeBase

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
; þ PROCEDURE ChangePage                                            þ
; þ                                                                 þ
; þ Change la page active                                           þ
; þ                                                                 þ
; þ PARAMETRES  : BX : ofset                                        þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX CX                                 þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ

ChangePage PROC

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
; þ PROCEDURE Copy2Page                                             þ
; þ                                                                 þ
; þ Copie un fond ecran vers une des page 0,1                       þ
; þ                                                                 þ
; þ PARAMETRES  : SI: OFFSET BUFFER SOURCE                          þ
; þ               DI: OFFSET PAGE   ARRIVER                         þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ


Copy2Page PROC NEAR

   PUSH AX
   PUSH CX
   PUSH DX
   PUSH DS
   PUSH ES


   MOV DX,3CEh   ; Controleur Graphique
   MOV AX,16645  ; AL=5h Registre 5h
                 ; AH=01000001b Mode Read  0
                 ;              Mode Write 1
                 ;              Vga Mode 256 Couleur
   OUT DX,AX     ;


   MOV AX,0000111100000010b; AL:=2d -> 2em registre "MAP MASK"
                           ; Ah = Masque plan 1 2 3 4 accesibles
   MOV DX,03C4h            ; S‚quenceur VGA
   OUT DX,AX               ; Selectione le port



   MOV AX,0A000h
   MOV ES,AX
   MOV DS,AX

   MOV CX,16000 ;16000 octets a copier
   CLD

   REP MOVSB    ;

   POP ES
   POP DS
   POP DX
   POP CX
   POP AX
   RET

Copy2Page ENDP




; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE ClsAll                                                þ
; þ                                                                 þ
; þ Eface les 4 pages                                               þ
; þ                                                                 þ
; þ PARAMETRES  : Aucun (page)                                      þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX ES DI                              þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ


ClsALL  PROC

        PUSH AX
        PUSH DX
        PUSH ES
        PUSH DI

        MOV AX,0000111100000010b; AL:=2d -> 2em registre "MAP MASK"
                                ; Ah = Masque 4 plan accesible
        MOV DX,03C4h            ; S‚quenceur VGA
        OUT DX,AX               ; Selectione le port


        MOV AX,0A000h
        MOV ES,AX
        MOV DI,0
        MOV AX,0

        Cls2: CMP DI,65532
              JA  Cls1
              MOV ES:[DI],AX
              ADD DI,2
              JMP Cls2

        Cls1:

        POP DI
        POP ES
        POP DX
        POP AX

        RET

ClsALL ENDP


; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ
; þ                                                                 þ
; þ PROCEDURE ClsPage                                               þ
; þ                                                                 þ
; þ Eface 1 page                                                    þ
; þ                                                                 þ
; þ PARAMETRES  : OfsVram                                           þ
; þ                                                                 þ
; þ REGISTRES ENPILE DEPILE : AX ES DI                              þ
; þ                                                                 þ
; þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ


ClsPAge  PROC
         PUSH AX
         PUSH BX
         PUSH DX
         PUSH ES
         PUSH DI

        MOV AX,0000111100000010b; AL:=2d -> 2em registre "MAP MASK"

        MOV DX,03C4h            ; S‚quenceur VGA
        OUT DX,AX               ; Selectione le port

         MOV AX,0A000h
         MOV ES,AX

         MOV DI,OfsVram
         MOV AX,0h

         MOV BX,16000
         ADD BX,OfsVram

         ClsPage2: CMP DI,BX
                   JA ClsPage1
                   MOV ES:[DI],AX
                   ADD DI,2
                   JMP ClsPage2

         ClsPage1:

         POP DI
         POP ES
         POP DX
         POP BX
         POP AX

         RET

ClsPage ENDP




FinCode:

;********************************************************************

   Mov ah, 4ch          ;fonction de d‚sactivation de programme du DOS
   Int 21h              ;appel du DOS

   END
