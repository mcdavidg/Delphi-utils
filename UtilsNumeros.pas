unit UtilsNumeros;

interface

Uses SysUtils, DateUtils, Classes;

// Toma un REAL y lo convierte a STRING
function RealToStr(R:Real):String;

// Toma un REAL y lo convierte a STRING para Moneda
function MonedaToStr(R:Real):String;

// Toma un STR y lo convierte a REAL
function StrToReal(S:String):Real;

// Toma un STR y lo convierte a INTEGER
function StrToEntero(S:String):Integer;

implementation

{******************************************************************************}
function RealToStr(R:Real):String;
begin
     if R=0000 then RealToStr:='0.0'
else if Abs(R)<0001 then RealToStr:=FormatFloat('#,##0.000',R)
else if Abs(R)<0010 then RealToStr:=FormatFloat('#,##0.00',R)
else if Abs(R)<0100 then RealToStr:=FormatFloat('#,##0.0',R)
                    else RealToStr:=FormatFloat('#,##0',R)
end;

{******************************************************************************}
function MonedaToStr(R:Real):String;
begin
MonedaToStr:=FormatFloat('#,##0.00',R)
end;

{******************************************************************************}
function StrToReal(S:String):Real;
Var Ch:Char;
    L:String;
    R:Real;
begin
if (S='-') or (S=' ') or (S='') then
  begin
  R:=0;
  end
else
  begin
  Ch:=' ';
  if S[Length(S)] in ['a'..'z','A'..'Z'] then
    begin
    Ch:=S[Length(S)];
    L:=Copy(S,1,Length(S)-1);
    end
  Else L:=S;

  R:=StrToFloat(StringReplace(L,',','',[rfReplaceAll]));

    Case Ch of
      'K' : R:=R*1000;
      'M' : R:=R*1000000;
    End;
  end;

StrToReal:=R;
end;

{******************************************************************************}
function StrToEntero(S:String):Integer;
Var Ch:Char;
    L:String;
    R:Real;
begin
if (S='-') or (S=' ') or (S='') then
  begin
  R:=0;
  end
else
  begin
  Ch:=' ';
  if S[Length(S)] in ['a'..'z','A'..'Z'] then
    begin
    Ch:=UpCase(S[Length(S)]);
    L:=Copy(S,1,Length(S)-1);
    end
  Else L:=S;

  R:=StrToFloat(StringReplace(L,',','',[rfReplaceAll]));

    Case Ch of
      'K' : R:=R*1000;
      'M' : R:=R*1000000;
    End;
  end;

StrToEntero:=Round(R);
end;

{******************************************************************************}
end.
