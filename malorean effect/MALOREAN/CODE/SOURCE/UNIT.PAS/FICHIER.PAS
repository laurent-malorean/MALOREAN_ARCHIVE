UNIT FICHIER;

INTERFACE

USES POINTEUR,VARIABLE,DOS;

CONST FILE_1PL = 000 ;
      FILE_4PL = 001 ;
      FILE_MOD = 002 ;
      FILE_STM = 003 ;
      FILE_STX = 004 ;
      FILE_MOT = 005 ;
      FILE_PAL = 006 ;

TYPE FILE_FILE      = RECORD
                      OFSET_FICHIER  : WORD    ;
                      TYPE_FICHIER   : BYTE    ;
                      NAME           : STRING8 ;
                      END;

     FILE_DIRECTORY = RECORD
                      NOMBRE : BYTE ;
                      OFSET  : ARRAY [1..40] OF FILE_FILE;
                      END;
     FILE_DISTANCE  = RECORD
                      POID_FORT   : WORD;
                      POID_FAIBLE : WORD;
                      END;


TYPE OBJET_FICHIER = OBJECT
                     Handle           : WORD;
                     Ofset_FAIBLE     : WORD;
                     OFSET_FORT       : WORD;
                     PROCEDURE OUVRE (NOM : STRING);
                     PROCEDURE LIT   (



                     END;


IMPLEMENTATION

PROCEDURE OBJET_FICHIER.OUVRE (NOM : STRING);
VAR FICHIER_NOM_SEG  : WORD;
VAR FICHIER_NOM_OFS  : WORD;

BEGIN; FICHIER_NOM_SEG := SEG (NOM);
       FICHIER_NOM_OFS := OFS (NOM);
       {il faut fournir ds:dx}
       REG.DS:=FICHIER_NOM_SEG;
       REG.DX:=FICHIER_NOM_OFS;
       {Ouverture du fichier ║ INT 21h Fonction 3Dh }
       REG.AH:=$3D;
       REG.AL:=$0;
       INTR($21,registers(REG));
       HANDLE:=REG.AX;     ;   { On a trouver le Handle}

END;





BEGIN;
END.




; ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
; ■                                                                 ■
; ■ PROCEDURE CHARGE SHOOT 4 PLAN                                   ■
; ■                                                                 ■
; ■ Charge un FDICHIER ET L4AFECTE A LA PAGE N°                      ■
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
