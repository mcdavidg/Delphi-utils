unit UtilsStrings;

interface

uses Classes, SysUtils;

// Elimina los caracteres que pueda haber al inicio o final de una cadena
function Strip(L:string; Separador:char):String;

// Pone solo la primer letra en mayuscula, el resto en minusculas
function Capitalize(L:String):String;

// Separa en subcadenas divididas por un separador
// StripEspacios si debe quitar espacios de inicio o final
procedure SplitByChar(L:string; Separador:char; var Lista:TStringList;
  StripEspacios:Boolean);

// Concatenar unidos por un separador
function JoinByChar(Lista:TStringList; c:char):String;

// Completa o Recorta una cadena para cumplir con una longitud
function FixLength(L:String; LengthToFix:Integer; c:char):String;

// Ordenar de manera inversa un TStringList
// Usar de esta manera: TS.CustomSort(@CompareDesc);
function CompareDesc(TS: TStrings; const i1, i2: Integer): Integer;

// Regresa la cadena entre la posicion de la variable "i" y
// el proximo caracter indicado por "Ch". La variable "i" termina
// adoptando el valor de la posicion del caracter "Ch"
function GetStrUntilCh(Text:String; var i:Integer; Ch:Char):String;

implementation

{******************************************************************************}
function Strip(L:string; Separador:char):String;
var ch:char;
    Sa, S:String;
    i:Integer;
    found:Boolean;
begin
Sa:='';
found:=false;
for i:=1 to Length(L) do
  begin
  if (Not Found) and (L[i]<>Separador) then found:=true;
  if found then Sa:=Sa+L[i];
  end;

S:='';
found:=false;
for i:=length(Sa) downto 1 do
  begin
  if (Not Found) and (Sa[i]<>Separador) then found:=true;
  if found then S:=Sa[i]+S;
  end;

strip:=S;
end;

{******************************************************************************}
function Capitalize(L:String):String;
var S:String;
begin
S:='';
if Length(L)>0 then S:=Uppercase(L[1]);
if Length(L)>1 then S:=S+Lowercase(Copy(L,2,Length(L)-1));
capitalize:=S;
end;

{******************************************************************************}
procedure SplitByChar(L:string; Separador:char; var Lista:TStringList;
  StripEspacios:Boolean);
Var S:String;
    i:Integer;
begin
Lista.Clear;
S:='';
for i:=1 to Length(L) do
  begin
  if L[i]<>Separador then
    begin
    S:=S+L[i];
    end
  else
    begin
    if StripEspacios then S:=strip(S,' ');
    Lista.Add(S);
    S:='';
    end;
  end;

if StripEspacios then S:=strip(S,' ');
Lista.Add(S);

end;

{******************************************************************************}
function JoinByChar(Lista:TStringList; c:char):String;
var L:String;
    i:Integer;
Begin
L:='';
for i:=0 to Lista.Count-1 do
  begin
  L:=L+Lista[i];
  if i<Lista.Count-1 then L:=L+c;
  end;

JoinByChar:=L;
end;

{******************************************************************************}
function FixLength(L:String; LengthToFix:Integer; c:char):String;
var S:String;
    i:Integer;
begin
     if Length(L)<LengthToFix then
  begin
  S:=L;
  for i:=0 to LengthToFix-Length(L) do S:=S+c;
  end
else if Length(L)>LengthToFix then
  begin
  S:=Copy(L,1,LengthToFix);
  end
else
  begin
  S:=L;
  end;

FixLength:=S;
end;

{******************************************************************************}
function CompareDesc(TS: TStrings; const i1, i2: Integer): Integer;
begin
  Result:= CompareText(TS[i2], TS[i1]);
end;

{******************************************************************************}
function GetStrUntilCh(Text:String; var i:Integer; Ch:Char):String;
var S:String;
begin
S:='';
  Repeat
  if Text[i]<>Ch then S:=S+Text[i];
  Inc(i);
  Until (Text[i]=Ch) or (i>=Length(Text)-1);
GetStrUntilCh:=S;
end;

{******************************************************************************}
end.
