Unit Gest_Com;

{$V-}
Interface
{--------------------------------------------------------------------------}
Procedure Receive;
Procedure Send;
{--------------------------------------------------------------------------}
Implementation

USES ycom,BigTab,Crc,Dos;

TYPE
  TypeFileName = STRING[13];


FUNCTION ComReceivePacket(max_retries:INTEGER;
                          VAR Taille:INTEGER;
                               NumPacket:INTEGER;
                          VAR Packet:TypeBigTab):Boolean;
(*Cette procedure est chargée de recevoir un packet avec un nombre *)
(*maximum d'essais de max_retries                                  *)
(*le paquet peut-être d'une taille de 128 ou 1024 octets           *)
VAR
   c:CHAR;
   retry:INTEGER;
   i    :INTEGER;
   crc,crc_hi,crc_calcule:WORD;

LABEL NEXT_LOOP,BAD_PACKET;
BEGIN
   retry:=0;
   WHILE (retry <> max_retries) DO BEGIN
     IF (NOT ComReceiveChar(100,C)) THEN BEGIN
       writeln('ERR - Pas de caractère de synchro');
       INC(retry);
       GOTO NEXT_LOOP;
     END;
     CASE c OF
       STX:
         Taille:=1024;
       SOH:
         Taille:=128;
       ELSE
         WRITELN('ERR - Mauvais caractére de synchro');
         GOTO BAD_PACKET;
     END;
     (*Reception du numéro de packet*)
     IF (NOT ComReceiveChar(20,C)) THEN BEGIN
       writeln('ERR - Réception du numéro de bloc');
       GOTO BAD_PACKET;
     END;
     IF (ORD(c) <> numpacket) Then Begin
       writeln('ERR - Mauvais numéro de bloc');
       GOTO BAD_PACKET;
     END;
     (*réception du complément du numéro de packet*)
     IF (NOT ComReceiveChar(20,C)) THEN BEGIN
       writeln('ERR - Réception du complément du numéro de bloc');
       GOTO BAD_PACKET;
     END;
     (*reception du numéro de packet*)
     IF (ORD(c) <> ($FF- numpacket)) Then Begin
       writeln('ERR - Mauvais complément du numéro de bloc');
       GOTO BAD_PACKET;
     END;
     (*Réception du paquet de données*)
     FOR i:=0 To Taille-1 DO BEGIN
       IF (NOT ComReceiveChar(20,Char(packet[i]))) Then BEGIN
       writeln('ERR - Réception de l''octet ',i);
       GOTO BAD_PACKET;
     END;
   END;
   IF (NOT ComReceiveChar (20,c)) THEN BEGIN
     writeln('ERR - Réception du CRC haut');
     GOTO BAD_PACKET;
   END;
   crc_hi:=ORD(c);
   crc_hi:=(crc_hi SHL 8);
   IF (NOT ComReceiveChar(20,C)) Then BEGIN
     writeln('ERR - Réception du CRC bas');
     GOTO BAD_PACKET;
   END;
   crc:=crc_hi OR ORD(c);
   crc_calcule:=calcCRC(taille,packet);
   IF (crc <> crc_calcule) THEN BEGIN
     writeln('ERR - Mauvais CRC');
     GOTO BAD_PACKET;
   END;
   ComReceivePacket:=ComSendChar(ACK);
   EXIT;
BAD_PACKET:
     IF (ComSendChar(NAK)) THEN BEGIN
       INC(Retry);
     END ELSE BEGIN
       writeln('ERR - Envoi du NAK');
       ComReceivePacket:=False;
       EXIT;
     END;
NEXT_LOOP:
    END;
    ComReceivePacket:=False;
END;


FUNCTION GetFileName(VAR packet:TypeBigTab;
                      taille:Integer;
                     VAR filename:TypeFileName;
                     VAR filesize:LONGINT):Boolean;
(*Extraction du paquet reçu des données
  concernant le fichier (nom et taille) *)
VAR
  i:Integer;
Begin
   i:=0;
   filename:='';
   WHILE ((packet[i] <> 0) AND (i<>taille)) DO
   BEGIN
         filename:=filename+chr(packet[i]);
         inc(i);
   END;
IF  (filename='') Then Begin
  GetFileName:=False;
  EXIT;
END;
Filesize:=0;
inc(i);
While (chr(packet[i]) IN ['0'..'9']) DO BEGIN
    filesize:=filesize*10+(packet[i]-ORD('0'));
    Inc(i);
End;
GetFileName:=True;
End;

Function ReceiveFile:Boolean;
(*Procedure de réception d'un fichier.On reçoit tout d'abord le paquet 0*)
(*qui contient les informations sur le fichier (nom et taille) puis on reçoit*)
(*les paquets de données*)
VAR
   retry,taille:INTEGER;
   hfile       :FILE;
   packet      :TypeBigTab;
   numpacket   :Byte;
   filename    :TypeFileName;
   c           :Char;
   filesize,sizerecv:longint;
   nbwritten   :word;

BEGIN
  retry:=0;
  While (retry<10) Do Begin
     ComPurgeInputBuffer;
     ComPurgeOutputBuffer;
     IF (ComSendChar('C')) Then Begin
        (*On essaie de recevoir le paquet 0 avec 1 seul retry*)
        (*car il faut envoyer un C entre chaque essai*)
        IF (ComReceivePacket (1,taille,0,packet)) THEN Retry:=10;
        (*Astuce pour sortir de la boucle*)
     End;
     Inc(Retry);
  End;
  If (Retry=10) THEN BEGIN
    ReceiveFile:=False;
    EXIT;
  END;
  IF (NOT GetFileName(packet,taille,filename,filesize)) THEN BEGIN
    ReceiveFile:=False;
    EXIT;
  END;
  ComSendChar('C');
  Sizerecv:=0;
  numpacket:=0;
  ASSIGN(hfile,filename);  REWRITE(hfile,1);
  WRITELN('Réception de ',filename,' (',filesize,')');
  WHILE (sizerecv<filesize) DO BEGIN
    Inc(numpacket);
    numpacket:=numpacket MOD 256;
    IF (NOT ComReceivePacket(10,Taille,numpacket,packet)) THEN BEGIN
        close(hfile);
        ReceiveFile:=False;
    EXIT;
  END;
  IF ((sizerecv+taille)>filesize) Then Begin
     writeln(filesize,' octets ont été reçus.');
     blockwrite(hfile,packet,filesize-sizerecv,nbwritten);
     close(hfile);
     IF (ComReceiveChar(100,c)) THEN BEGIN
     (* C'est normalement un EOT, pour ne pas compliquer la réception*)
     (*alors que le transfert s'est bien déroulé, on envoie un ACK    *)
     (*dans tous les cas*)
     ComsendChar(ACK);
     END;
     ReceiveFile:=True;
     EXIT;
     END ELSE BEGIN
     INC(sizerecv,taille);
     WRITE(sizerecv,'octets ont été reçus,',chr(13));
     blockwrite(hfile,packet,taille,nbwritten);
  End;
  End;
  ReceiveFile:=False;
  EXIT;
End;

Procedure Receive;
Var Erreur:Integer;
Begin
    writeln('YMODEM RECEIVE - (C) 1993 Henri Tonier / Réponse Micro',#10);
    InitTableCrc;
    NumPort:=0;
    IF (ParamCount=1) THEN BEGIN
       VAL(PARAMSTR(1),NumPort,erreur);
       IF (erreur=0) THEN DEC(NumPort);
    END;
    ComInitPort(ParityOdd,OneStopbit,Baud0300,Word8bits,0);
    While (ReceiveFile) DO
END;

Function ComSendPacket(taille:Integer;NumPacket:Byte;packet:TypeBigTab):Boolean;
Var
   i,retry:INTEGER;
   crc    :Word;
   response:CHAR;
   retcode :Boolean;
Begin
   retry:=0;
   WHILE (retry<10) DO BEGIN
     IF (taille =1024) THEN BEGIN
       IF (NOT ComSendChar (STX)) THEN BEGIN
         ComSendPacket:=False;
         EXIT;
       END;
     END ELSE BEGIN
       IF (NOT ComSendChar(SOH)) THEN BEGIN
         ComSendPacket:=False;
         EXIT;
       END;
     END;
     IF (NOT ComSendChar(CHR(numpacket))) THEN BEGIN
       ComSendPacket:=False;
       EXIT;
     END;
     IF (NOT (ComSendChar(CHR($FF -NumPacket)))) THEN BEGIN
       ComSendPacket:=False;
       EXIT;
     END;
     FOR i:=0 TO PRED(taille) DO
       IF (NOT ComSendChar (CHR(packet[i]))) THEN BEGIN
       ComSendPacket:=False;
       EXIT;
       END;
     Crc:=CalcCRC(Taille,Packet);
     IF (NOT ComSendChar(CHR(((Crc AND $FF00) SHR 8)))) THEN BEGIN
       ComSendPacket:=False;
       EXIT;
     END;
     IF (NOT ComSendChar (CHR(((crc AND $00FF))))) THEN BEGIN
       ComSendPacket:=False;
       EXIT;
     END;
     ComFlushOutputBuffer; (* On attend que tout soit transmis *)
     ComPurgeInputBuffer;
     IF (ComReceiveChar(100,response)) THEN BEGIN
        CASE response OF
          ACK: BEGIN
            ComSendPacket:=True;
            Exit;
               End;
          CAN: BEGIN
            ComSendPacket:=False;
            EXIT;
               End;
          End;
      End;
      Inc(retry);
     End;
     ComSendPacket:=False;
End;

Function InitFileTransfert (Var filename:TypeFileName;filelen:longint):Boolean;
Var data:TypeBigTab;
    response:Char;
    i:Integer;
    stemp:String[32];

Begin
  (*Quand filelen vaut 0, on envoie le paquet de fin de transfert*)
  For i:=0 To 1023 Do Data[i]:=0;
  i:=0;
  REPEAT
        Inc(i);
        Write('Attente de C (',i,')',Chr(13));
        ComReceiveChar(200,response);
  UNTIL (Response='C');
  Writeln('C reçu                  ');
  IF (filelen <> 0) Then Begin
     FOR I:=1 TO Length(filename) DO data[i-1]:=ORD(filename[i]);
     STR(filelen,stemp);
     FOR i:=1 TO Length(stemp) DO data[i+length(filename)]:=Ord(stemp[i]);
     END ELSE BEGIN
       WRITELN('Fin de transfert...      ');
     END;
     IF (NOT ComSendPacket(1024,0,data)) THEN BEGIN
       InitFileTransfert:=FALSE;
       EXIT;
     END;
     IF (filelen<>0) THEN BEGIN
       ComReceiveChar(200,Response);
       InitFileTransfert:=(response='C');
       (* Le recepteur envoie un C avant le premier paquet*)
     END ELSE BEGIN
        InitFileTransfert:=True;
        Exit;
     END;
END;


FUNCTION CloseFileTransfert:Boolean;
  (*Procedure de fin de transfert de fichier                  *)
  (*on envoie le caractére EOT                                *)
  (*en fait, si le correspondant répond mal ce n'est pas grave car*)
  (*le transfert est terminé et s'est bien passé                  *)
  (*C'est pour cela qu'on ne fait que trois tentatives*)

Var
    response:Char;
    retry   :Integer;
Begin
   retry:=0;
   WHILE (Retry<3) DO BEGIN
   INC(retry);
   ComSendChar(EOT);
   IF (ComReceiveChar(STDTIMEOUT,Response)) THEN BEGIN
     IF (Response=ACK) THEN BEGIN
        CloseFileTransfert:=True;
        Exit;
     End;
   End;
End;
CloseFileTransfert:=True;
(* ça n'a pas trés bien marché, mais quelle importance ?...*)
END;

Procedure SEND;
Var ifile,firstfile,i    :INTEGER;
    hfile                :FILE;
    ipacket,fin_recherche:INTEGER;
    Erreur               :Integer;
    nread                :WORD;
    data                 :TypeBigTab;
    dataSent             :LongInt;
    DirInfo              :SearchRec;
Label Fin_Transfert;
BEGIN
    Writeln('YMODEM SEND - (C) 1993 Henri Tonier / Réponse Micro',#10);
    NumPort:=0;
    VAL(ParamStr(1),NumPort,Erreur);
    IF (Erreur=0) THEN BEGIN
      DEC(NumPort);
      FirstFile:=2;
    END ELSE BEGIN
      NumPort:=0;
      firstfile:=1;
    END;
    ComInitPort(ParityOdd,OneStopbit,Baud0300,Word8bits,0);;
    ComPurgeInputBuffer;
    ComPurgeOutputBuffer;
    InitTableCrc;
    For ifile:=Firstfile To ParamCount DO BEGIN
    (* On utilise le couple findfirst/findnext qui est trés simple      *)
    (* d'emploi et qui permet de mettre des caractéres jokers dans les  *)
    (* noms de fichiers (Y*.EXE par exemple) *)
    FindFirst (ParamStr(iFile),Archive,DirInfo);
    While (DosError = 0) Do BEGIN
      ASSIGN(hfile,DirInfo.Name);
      RESET(hFile,1);
      IF (NOT InitFileTransfert(DirInfo.Name,DirInfo.Size)) Then GOTO FIN_TRANSFERT;
      WRITELN('Envoi de ',DirInfo.Name,' (',DirInfo.size,')');
      ipacket:=0; datasent:=0;
        REPEAT
         (* On remet notre bloc de données à 0,C'est plus propre *)
         For i:=0 TO 1023 Do Data[i]:=0;
         BlockRead(hfile,data,1024,nread);
         IF (nread<>0) THEN BEGIN
           INC(ipacket);
           IF (NOT ComSendPacket (1024,ipacket,data)) Then GOTO FIN_TRANSFERT;
           Inc(datasent,nread);
           Write(#13,datasent, 'octets ont été envoyés');
         END;
      UNTIL (nread <> 1024);
      WRITELN;
      IF (NOT CloseFileTransfert) Then Goto Fin_Transfert;
    End;
 End;
Fin_Transfert:
  InitFileTransfert(DirInfo.Name,0);
END;

End.









