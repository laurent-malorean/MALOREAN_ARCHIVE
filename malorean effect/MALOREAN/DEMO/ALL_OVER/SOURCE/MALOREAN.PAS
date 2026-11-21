program exe;
{$m 2000,0,0}
uses dos;
var a,b,c:char;

FUNCTION FichierExiste(NomFichier: STRING)
                                 : BOOLEAN;
{ Fonction bool‚enne qui renvoie Vrai si le fichier existe,
  et Faux si ce n'est pas le cas. Fermeture du fichier
  s'il existe. }
VAR
  f: FILE;
BEGIN
  {$I-}
  Assign(f, NomFichier);
  Reset(f);
  Close(f); { Inop‚rant si IOResult <> 0 }
  {$I+}
  FichierExiste := (IOResult = 0) and
   (NomFichier <> '');
END;  { Fin de FichierExiste }

begin
if fichierexiste('MALODATA.001') then begin
if fichierexiste('MALODATA.002') then begin
if fichierexiste('MALODATA.003') then begin
if fichierexiste('MALOREA1.EXE') then begin
if fichierexiste('MALOREA2.EXE') then begin
if fichierexiste('MALOREA3.EXE') then begin
a:='þ';
b:='ü';
c:='ú';
swapvectors;
exec('MALOREA1.EXE ',+a);
exec('MALOREA2.EXE ',+b);
exec('MALOREA3.EXE ',+c);
swapvectors;
end else begin
writeln('!!! MALOREA3.EXE absent þ MALOREA3.EXE not found !!!');
end;
end else begin
writeln('!!! MALOREA2.EXE absent þ MALOREA2.EXE not found !!!');
end;
end else begin
writeln('!!! MALOREA1.EXE absent þ MALOREA1.EXE not found !!!');
end;
end else begin
writeln('!!! MALODATA.003 absent þ MALODATA.003 not found !!!');
end;
end else begin
writeln('!!! MALODATA.002 absent þ MALODATA.002 not found !!!');
end;
end else begin
writeln('!!! MALODATA.001 absent þ MALODATA.001 not found !!!');
end;
end
.