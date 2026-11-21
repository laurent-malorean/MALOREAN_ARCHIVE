; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                      ■
; ■                      SOURCE POUR GERER                               ■
; ■                                                                      ■
; ■          LES 4 PLANS DE BYTE EN VGA 320*200 256 COULEURS             ■
; ■                 LA PALETTE DAC 256 COULEURS                          ■
; ■                 CHARGER DES FICHIERS IMAGES                          ■
; ■                                                                      ■
; ■            1993 VOLPONE for MALOREAN EFFFECT TEAM                    ■
; ■                                                                      ■
; ■                                                                      ■
; ■                     DEBUT          : Juillet 1993                    ■
; ■                     DERNIERE MODIF : Juillet 1993                    ■
; ■                                                                      ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


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

; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE ATTENT                                                ■
; ■                                                                 ■
; ■ ATTENT                                                          ■
; ■                                                                 ■
; ■ PARAMETRES                                                      ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX                           ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

ATTENT PROC

   push bx

   mov bx,0

aa: cmp bx,60000
    ja aa1
    nop
    inc bx

    jmp aa
   aa1:
   pop bx

   RET
ATTENT ENDP


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE GraphMode4Plan                                        ■
; ■                                                                 ■
; ■ Initialise le mode graphique en 320*200 256 couleurs 4 plan     ■
; ■                                                                 ■
; ■ PARAMETRES  : Aucun                                             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX                           ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

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

           MOV DX,03C4h  ; Séquenceur registre 4 "memory mode"
           MOV AX,0604h  ; Masque 110b  byte 1->256k Vram
                         ;              byte 2->Mode odd/even désactivé
                         ;                      traitement linéaire d'un plande bite
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

; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE GraphMode1Plan                                        ■
; ■                                                                 ■
; ■ Initialise le mode graphique en 320*200 256 couleurs 1 plan     ■
; ■                                                                 ■
; ■ PARAMETRES  : Aucun                                             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX                           ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

GraphMode1Plan PROC

           PUSH AX

           MOV AX,13h;
           INT 10h;

           POP AX

           RET
GraphMode1Plan ENDP




; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE TextMode                                              ■
; ■                                                                 ■
; ■ Initialise le mode texte 80*25 16 couleurs                      ■
; ■                                                                 ■
; ■ PARAMETRES  : Aucun                                             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX                                    ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

Text_Mode PROC

   PUSH AX

   MOV AX,03h
   Int 10h

   POP AX

   RET
Text_Mode ENDP

; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE Putpixel4Plan                                         ■
; ■                                                                 ■
; ■ Fait un point a l'ecran                                         ■
; ■                                                                 ■
; ■ PARAMETRES  : Variables X Y Couleur                             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

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

   AND CL,011b       ; Cl:=X mod 4=n° du plan de bit
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Sera combiné avec SHL pour le masque
   SHL AH,CL         ; Le masque est crée
   MOV DX,03C4h      ; Séquenceur VGA
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
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE Putpixel1Plan                                         ■
; ■                                                                 ■
; ■ Fait un point a l'ecran                                         ■
; ■                                                                 ■
; ■ PARAMETRES  : Variables X Y Couleur                             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

PutPixel1Plan PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI

  MOV  AX,0A000h
  MOV  ES,AX

  MOV  AX,Y
  MOV  BX,320
  MUL  BX
  ADD  AX,X
  MOV  DI,AX
  MOV  AX,Couleur
  MOV  ES:[DI],AX



  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX


   RET
PutPixel1Plan ENDP

; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE ChangePage                                            ■
; ■                                                                 ■
; ■ Change la page active                                           ■
; ■                                                                 ■
; ■ PARAMETRES  : BX : ofset                                        ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX CX                                 ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

ChangePage PROC

PUSH AX
PUSH DX

;attent le retour blanking

MOV DX,03DAh  ; Registre generale port 03DAh

ChangePage1: IN   AL,DX      ; Je suis dans le Retrace vertical
             TEST AL,8
             JZ ChangePage1  ; Non alors on boucle


;donne les nouvellles coordonnées de la memoire video
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




; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE Copy2Page                                             ■
; ■                                                                 ■
; ■ Copie un fond ecran vers une des page 0,1                       ■
; ■                                                                 ■
; ■ PARAMETRES  : SI: OFFSET BUFFER SOURCE                          ■
; ■               DI: OFFSET PAGE   ARRIVER                         ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


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
   MOV DX,03C4h            ; Séquenceur VGA
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




; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE ClsAll                                                ■
; ■                                                                 ■
; ■ Eface les 4 pages                                               ■
; ■                                                                 ■
; ■ PARAMETRES  : Aucun (page)                                      ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX ES DI                              ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


ClsALL  PROC

        PUSH AX
        PUSH DX
        PUSH ES
        PUSH DI

        MOV AX,0000111100000010b; AL:=2d -> 2em registre "MAP MASK"
                                ; Ah = Masque 4 plan accesible
        MOV DX,03C4h            ; Séquenceur VGA
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


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE ClsPage                                               ■
; ■                                                                 ■
; ■ Eface 1 page                                                    ■
; ■                                                                 ■
; ■ PARAMETRES  : OfsVram                                           ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX ES DI                              ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


ClsPAge  PROC
         PUSH AX
         PUSH BX
         PUSH DX
         PUSH ES
         PUSH DI

        MOV AX,0000111100000010b; AL:=2d -> 2em registre "MAP MASK"

        MOV DX,03C4h            ; Séquenceur VGA
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






; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE LoadPal                                               ■
; ■                                                                 ■
; ■ Charge une palette depuis le disque  et la rend active          ■
; ■                                                                 ■
; ■ PARAMETRES  : DS :Adresse de segment du nom du fichier          ■
; ■               DX : Adrese d'ofset du nom du fichier             ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

LoadPAl PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI


; il faut fournir ds:dx
; Ouverture du fichier ║ INT 21h Fonction 3Dh

  MOV AH,3Dh
  MOV AL,0h
  INT 21h
  MOV Handle,AX       ; On a trouver le Handle


; Lire un fichier      ║ INT 21h Fonction 3Fh

  MOV DX,Offset(Palette[0])
  MOV CX,768          ; 768 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h

; Fermer le fichier    ║ INT 21h Fonction 3Eh
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

          MOV DX,3C8h    ; Port 3C8h met n° DAC Dadant
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



; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE CHARGE SHOOT 4 PLAN                                   ■
; ■                                                                 ■
; ■ Charge un FICHIER ET L4AFECTE A LA PAGE N°                      ■
; ■                                                                 ■
; ■ PARAMETRES  DS      : Adresse de segment du nom du fichier      ■
; ■             DX      : Adrese d'ofset du nom du fichier          ■
; ■         Var OfsVram : Ofset du debut du chargement              ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

ChargeShoot4Plan PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI



; il faut fournir ds:dx

; Ouverture du fichier ║ INT 21h Fonction 3Dh

  MOV AH,3Dh
  MOV AL,0h
  INT 21h
  MOV Handle,AX       ; On a trouver le Handle



; Lire un fichier      ║ INT 21h Fonction 3Fh
; Lit Byte d'info fichier Shoot

  MOV DX,Offset(InfoShoot)
  MOV CX,768          ; 768 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h

  ; DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h
  ; Pour lire la palette

    MOV AH,42h
    MOV AL,0      ; La distance se rapporte au debut du fichier
    MOV BX,Handle
    MOV CX,0      ; Mot fort   de la distance
    MOV DX,1      ; Mot faible de la distance
    INT 21h



; Lire un fichier      ║ INT 21h Fonction 3Fh
; Lit La Palette
  MOV DX,Offset(Palette)
  MOV CX,768          ; 768 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



; La palette charge devient la palette active

          MOV BX,@data
          MOV DS,BX
          MOV SI,Offset(Palette[0]); Offset de palette dans SI

          MOV BX,0       ; BX =compteur de 0 a 255

LoadS1: CMP BX,256
          JA LoadS2    ;

          MOV DX,3C8h    ; Port 3C8h met n° DAC Dadant
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
          JMP LoadS1

LoadS2:




; TRANSFERT DU PREMIER PLAN DE BIT

  ; DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h
  ; Pour lire le premier plan de bite

    MOV AH,42h
    MOV AL,0      ; La distance se rapporte au debut du fichier
    MOV BX,Handle
    MOV CX,0      ; Mot fort   de la distance
    MOV DX,769    ; Mot faible de la distance
    INT 21h

  ;Masque les plans 2,3,4
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Masque
   MOV DX,03C4h      ; Séquenceur VGA
   OUT DX,AX         ; Ecrit dans le port


  ; Cherche seg:ofs du buffer de 16000 octets
   mov DX,offset(buffer)
   mov ax,@data
   mov DS,ax

  ; Lit le premier plan de bite  ║ INT 21h Fonction 3Fh
  MOV CX,16000          ; 16000 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



  ;Transfer les 160000 octets du buffer vers le plan 0

  MOV AX,0A000h
  MOV ES,AX
  MOV DI,OfsVram

  MOV AX,0

  mov DX,offset(buffer)
  MOV SI,DX


LOAD1: CMP AX,8000
       JA LOAD2
       MOV BX,DS:[SI]
       MOV ES:[DI],BX
       ADD DI,2
       ADD SI,2
       INC AX
       JMP load1


LOAD2:


; TRANSFERT DU DEUXIEME PLAN DE BIT


  ;DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h
  ;Pour lire le deuxieme plan de bite

   MOV AH,42h
   MOV AL,0      ; La distance se rapporte au debut du fichier
   MOV BX,Handle
   MOV CX,0      ; Mot fort   de la distance
   MOV DX,16769  ; Mot faible de la distance
   INT 21h

  ;Masque les plans 1,3,4
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Masque
   SHL AH,1
   MOV DX,03C4h      ; Séquenceur VGA
   OUT DX,AX         ; Ecrit dans le port


  ; Cherche seg:ofs du buffer de 16000 octets
   mov DX,offset(buffer)
   mov ax,@data
   mov DS,ax

  ; Lit le deuxieme plan de bite  ║ INT 21h Fonction 3Fh
  MOV CX,16000          ; 16000 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



  ;Transfer les 160000 octets du buffer vers le plan 0

  MOV AX,0A000h
  MOV ES,AX
  MOV DI,OfsVram

  MOV AX,0

  mov DX,offset(buffer)
  MOV SI,DX


LOAD3: CMP AX,8000
       JA LOAD4
       MOV BX,DS:[SI]
       MOV ES:[DI],BX
       ADD DI,2
       ADD SI,2
       INC AX
       JMP load3


LOAD4:


; TRANSFERT DU TROISIEME PLAN DE BIT


  ; DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h
  ; Pour lire le deuxieme plan de bite

  MOV AH,42h
  MOV AL,0      ; La distance se rapporte au debut du fichier
  MOV BX,Handle
  MOV CX,0      ; Mot fort   de la distance
  MOV DX,32769    ; Mot faible de la distance
  INT 21h

  ;Masque les plans 1,2,4
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Masque
   SHL AH,2
   MOV DX,03C4h      ; Séquenceur VGA
   OUT DX,AX         ; Ecrit dans le port


  ; Cherche seg:ofs du buffer de 16000 octets
   mov DX,offset(buffer)
   mov ax,@data
   mov DS,ax

  ; Lit le troisieme plan de bite  ║ INT 21h Fonction 3Fh
  MOV CX,16000          ; 16000 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



  ;Transfer les 160000 octets du buffer vers le plan 3

  MOV AX,0A000h
  MOV ES,AX
  MOV DI,OfsVram

  MOV AX,0

  mov DX,offset(buffer)
  MOV SI,DX


LOAD5: CMP AX,8000
       JA LOAD6
       MOV BX,DS:[SI]
       MOV ES:[DI],BX
       ADD DI,2
       ADD SI,2
       INC AX
       JMP load5


LOAD6:


; TRANSFERT DU QUATRIEME PLAN DE BIT


  ; DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h
  ; Pour lire le deuxieme plan de bite

  MOV AH,42h
  MOV AL,0      ; La distance se rapporte au debut du fichier
  MOV BX,Handle
  MOV CX,0      ; Mot fort   de la distance
  MOV DX,48769    ; Mot faible de la distance
  INT 21h

  ;Masque les plans 1,2,3
   MOV AX,0102h      ; AL:=2d -> 2em registre "MAP MASK"
                     ; AH:=1b -> Masque
   SHL AH,3
   MOV DX,03C4h      ; Séquenceur VGA
   OUT DX,AX         ; Ecrit dans le port


  ; Cherche seg:ofs du buffer de 16000 octets
   mov DX,offset(buffer)
   mov ax,@data
   mov DS,ax

  ; Lit le troisieme plan de bite  ║ INT 21h Fonction 3Fh
  MOV CX,16000          ; 16000 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



  ;Transfer les 160000 octets du buffer vers le plan 3

  MOV AX,0A000h
  MOV ES,AX
  MOV DI,OfsVram

  MOV AX,0

  mov DX,offset(buffer)
  MOV SI,DX


LOAD8: CMP AX,8000
       JA LOAD7
       MOV BX,DS:[SI]
       MOV ES:[DI],BX
       ADD DI,2
       ADD SI,2
       INC AX
       JMP load8


LOAD7:

; Fermer le fichier    ║ INT 21h Fonction 3Eh
  MOV AH,3Eh
  MOV BX,Handle
  INT 21h

  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX

RET
ChargeShoot4Plan ENDP

; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE CHARGE COS SIN                                        ■
; ■                                                                 ■
; ■ Charge les tables de COS SIN                                    ■
; ■                                                                 ■
; ■ PARAMETRES  AUCUN                                               ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

ChargeCosSin PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI


; Ouverture du fichier ║ INT 21h Fonction 3Dh

  MOV AX,@DATA
  MOV DS,AX
  MOV DX,Offset(FileTable)
  MOV AH,3Dh
  MOV AL,0h
  INT 21h
  MOV Handle,AX       ; On a trouver le Handle


; Tranfert de la première partie des donnnées
; Lire un fichier      ║ INT 21h Fonction 3Fh


  MOV DX,Offset(Cos);
  MOV CX,512          ; 256 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h



; Transfert de la deuxieme partie des donnnés

  ; DEPLACE LE POINTEUR DE FICHIER      ║ INT 21h FONCTION 42h

    MOV AH,42h
    MOV AL,0      ; La distance se rapporte au debut du fichier
    MOV BX,Handle
    MOV CX,0      ; Mot fort   de la distance
    MOV DX,512    ; Mot faible de la distance
    INT 21h

  ; Lit la deuxieme partie des données  ║ INT 21h Fonction 3Fh

  MOV DX,Offset(SIN);
  MOV CX,512          ; 256 octets a lire
  MOV BX,Handle
  MOV AH,3Fh
  INT 21h

; Fermer le fichier    ║ INT 21h Fonction 3Eh
  MOV AH,3Eh
  MOV BX,Handle
  INT 21h


  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX

RET
ChargeCosSin ENDP


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE Dac2Black                                             ■
; ■                                                                 ■
; ■ Variation de palette vers dela DAC vers le noir                 ■
; ■                                                                 ■
; ■ PARAMETRES  AUCUN                                               ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■



Dac2Black PROC

  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI




;MOV SI,OFFSET(PALETTE)      ;
;MOV BX,OFFSET(PaletteDepart);
;MOV AX,0

;Dac2Black1: CMP SI,770      ; PaletteDepart=Palette
;            JA  Dac2Black2  ;
;            MOV CX,DS:[SI]  ;
;            MOV DS:[BX],CX  ;
;            ADD SI,2        ;
;            ADD BX,2        ;
;            JMP Dac2Black1  ;
;Dac2Black2:

MOV CX,0

Dac2BlackDebut: CMP CX,62
                JA  Dac2BlackFin

                MOV AX,0

                MOV SI,0;
                MOV BX,0

Dac2Black3: CMP  BX,256     ; Decremente chaque RVB si >1 puis envoi au port
            JA   Dac2Black4 ;

            MOV  DX,3C8h    ; Port 3C8h met n° DAC Dadant
            MOV  AX,BX      ;
            OUT  DX,AL      ;


            MOV  DX,3C9h    ; Port 3C8h met R puis V puis B incrementation
                            ; est gerer par le materiel


            MOV  AL,Palette[SI] ; R[BX] -> AH
            CMP  AL,1
            JB   D2B1
            DEC  AL
            MOV  Palette[SI],AL
      D2B1: OUT DX,AL
            INC SI

            MOV  AL,Palette[SI]  ; V[BX] -> AH
            CMP  AL,1
            JB   D2B2
            DEC  AL
            MOV  Palette[SI],AL
      D2B2: OUT DX,AL
            INC SI

            MOV  AL,Palette[SI]  ; B[BX] -> AH
            CMP  AL,1
            JB   D2B3
            DEC  AL
            MOV  Palette[SI],AL
      D2B3: OUT DX,AL
            INC SI

            INC BX          ; Incremente le compteur

            call attent

            JMP Dac2Black3  ;

Dac2Black4:


INC CX
JMP Dac2BlackDebut
Dac2BlackFin:



MOV SI,OFFSET(PALETTE)      ;
MOV BX,OFFSET(PaletteDepart);
MOV AX,0

Dac2Black5: CMP SI,770      ; Palette=PaletteDepart
            JA  Dac2Black6  ;
            MOV CX,DS:[BX]  ;
            MOV DS:[SI],CX  ;
            ADD SI,2        ;
            ADD BX,2        ;
            JMP Dac2Black5  ;
Dac2Black6:


  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX



RET
Dac2Black ENDP



; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE DacUp                                                 ■
; ■                                                                 ■
; ■ Variation de palette                                            ■
; ■                                                                 ■
; ■ PARAMETRES  AUCUN                                               ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX ES DI                     ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

DacUp PROC


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





; La palette charge devient la palette active

          MOV BX,@data
          MOV DS,BX
          MOV SI,Offset(Palette[0]); Offset de palette dans SI

          MOV BX,0       ; BX =compteur de 0 a 255

DacUp3: CMP BX,257
          JA DacUp4    ;

          MOV DX,3C8h    ; Port 3C8h met n° DAC Dadant
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


; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE Line                                                  ■
; ■                                                                 ■
; ■ Fait une droite avec l'algo de bressanam                        ■
; ■                                                                 ■
; ■ PARAMETRES  : Variables X1 Y1 X2 Y2 COULEUR                     ■
; ■                                                                 ■
; ■ REGISTRES ENPILE DEPILE : AX BX CX DX  ES DI                    ■
; ■                                                                 ■
; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■



LINE PROC NEAR


S1   EQU DI
S2   EQU CX



  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  PUSH ES
  PUSH DI




; X:=X1;
         MOV  AX,X1
         MOV  X ,AX

; Y:=Y1;
         MOV  AX,Y1
         MOV  Y ,AX


; DeltaX:=ABS (X2-X1)
; S1    :=SIGN(X2-X1)


         MOV  AX,X2         ;
         SUB  AX,X1         ; Ax:=X2-X1

         CMP  AX,LimNeg     ;
         JB   LINE1         ;

         NOT  AX            ; Puisque AX<0  ABS(AX):=-AX
         MOV  S1,-1         ;
         JMP  LINE2         ;

LINE1  : MOV  S1,1          ;

LINE2  : MOV  DeltaX,AX     ;



; DeltaY:=ABS (Y2-Y1)       ;
; S2    :=SIGN(Y2-Y1)       ;



         MOV  BX,Y2         ;
         SUB  BX,Y1         ; Ax:=Y2-Y1

         CMP  BX,LimNeg     ;
         JB   LINE3         ; DeltaY>0 -> JUMP LINE3:

         NOT  BX            ;
         MOV  S2,-1         ;
         JMP  LINE4         ;


LINE3  : MOV  S2,1          ;
LINE4  : MOV  DeltaY,BX     ;



; Si DeltaY>DeltaX          ;

         CMP  BX,AX         ;
         JB   LINE5         ; Si AX>BX DeltaX>DeltaY -> JUMP LINE5:

         XCHG AX,BX         ;
         MOV  InterChange,1 ;
         JMP  LINE6         ;

LINE5  : MOV  InterChange,0 ;

LINE6  : SHL  BX,1          ; BX:=2*DeltaY
         MOV  DX,AX         ;
         SHL  DX,1          ; DX:=2*DeltaX
         MOV  ERREUR,BX     ;
         SUB  ERREUR,AX     ; ERREUR:=2*DeltaY-DeltaX



         MOV  SI,1           ; I:=1   i compteur du For
         INC  AX            ; Inc(DeltaX) Because decroche un coup AV

         TEST InterChange,1 ;
         JZ   LINE7         ; Interchange:=1 ->JUMP LINE7




LINE8  : CMP  SI,AX         ; AX:=DeltaX ║ SI:=I
         JZ   LINE12        ; Si For Next Finit -> JUMP LINE9
         CALL PutPixel4Plan ;

LINE11 : CMP ERREUR,LimNeg  ;
         JA  LINE10         ;
         ADD Y,S2           ;
         SUB ERREUR,DX      ; Erreur:=Erreur-2*DeltaX
         JMP LINE11         ;

LINE10 : ADD X,S1           ;
         ADD ERREUR,BX;     ; Erreur:=Erreur-2*DeltaY
         INC SI             ;
         JMP LINE8          ;

LINE9  :


; Cas ou InterChange=1

LINE7  : CMP  SI,AX         ;
         JZ   LINE12        ; Si For Next Finit -> JUMP LINE9
         CALL PutPixel4Plan ;

LINE13 : CMP  ERREUR,LimNeg ;
         JA   LINE14        ;
         ADD  X,S1          ;
         SUB  ERREUR,DX     ; Erreur:=Erreur-2*DeltaX
         JMP  LINE13        ;

LINE14 : ADD  Y,S2          ;
         ADD  ERREUR,BX     ;

         INC  SI            ;
         JMP  LINE7         ;


LINE12 :

  POP DI
  POP ES
  POP DX
  POP CX
  POP BX
  POP AX



  RET
LINE ENDP




FinCode:

Call GraphMode4Plan



MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line
MOV Couleur,7
MOV X1,1
MOV Y1,1
MOV X2,100
MOV Y2,160
Call Line





;********************************************************************

   Mov ah, 4ch          ;fonction de désactivation de programme du DOS
   Int 21h              ;appel du DOS

   END
