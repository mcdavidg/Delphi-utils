unit UtilsFechas;

interface

Uses SysUtils, DateUtils;

// Toma un numero de mes y regresa el nombre
function IntToMonth(N:Integer):String;

// Toma un numero de mes y regresa el nombre corto
function IntToMonthShort(N:Integer):String;

// Toma una cadena con el numero del mes y regresa el nombre
function IntStrToMonth(S:String):String;

// Toma una cadena con el numero de mes y regresa el nombre corto
function IntStrToMonthShort(S:String):String;

// Toma valor DATE y lo convierte a cadena con formato "dd/mes/yyyy"
function DateToShortStr(D:TDate):String;

// Toma Mes en Ingles (3 caracteres) y los convierte a numeros de 2 digitos
function IngMonthToNum(S:String):String;

// Regresa la Fecha en formato YYYYMMDD
function DateYYYYMMDD(Fecha:TDateTime): String;

// Regresa la Fecha en formato YYYY-MM-DD
function DateYYYY_MM_DD(Fecha:TDateTime): String;

// Toma una cadena YYYY-MM-DD y lo regresa como fecha
function YYYY_MM_DDtoDate(S:String):TDateTime;

implementation

{******************************************************************************}
function IntToMonth(N:Integer):String;
Begin
case N of
  01 : IntToMonth:='Enero';
  02 : IntToMonth:='Febrero';
  03 : IntToMonth:='Marzo';
  04 : IntToMonth:='Abril';
  05 : IntToMonth:='Mayo';
  06 : IntToMonth:='Junio';
  07 : IntToMonth:='Julio';
  08 : IntToMonth:='Agosto';
  09 : IntToMonth:='Septiembre';
  10 : IntToMonth:='Octubre';
  11 : IntToMonth:='Noviembre';
  12 : IntToMonth:='Diciembre';
  Else IntToMonth:='--';
end

End;

{******************************************************************************}
function IntToMonthShort(N:Integer):String;
Begin
case N of
  01 : IntToMonthShort:='Ene';
  02 : IntToMonthShort:='Feb';
  03 : IntToMonthShort:='Mar';
  04 : IntToMonthShort:='Abr';
  05 : IntToMonthShort:='May';
  06 : IntToMonthShort:='Jun';
  07 : IntToMonthShort:='Jul';
  08 : IntToMonthShort:='Ago';
  09 : IntToMonthShort:='Sep';
  10 : IntToMonthShort:='Oct';
  11 : IntToMonthShort:='Nov';
  12 : IntToMonthShort:='Dic';
  Else IntToMonthShort:='--';
end

End;

{******************************************************************************}
function IntStrToMonth(S:String):String;
Begin
     if (S='01') or (S='1') then IntStrToMonth:='Enero'
Else if (S='02') or (S='2') then IntStrToMonth:='Febrero'
Else if (S='03') or (S='3') then IntStrToMonth:='Marzo'
Else if (S='04') or (S='4') then IntStrToMonth:='Abril'
Else if (S='05') or (S='5') then IntStrToMonth:='Mayo'
Else if (S='06') or (S='6') then IntStrToMonth:='Junio'
Else if (S='07') or (S='7') then IntStrToMonth:='Julio'
Else if (S='08') or (S='8') then IntStrToMonth:='Agosto'
Else if (S='09') or (S='9') then IntStrToMonth:='Septiembre'
Else if (S='10') then IntStrToMonth:='Octubre'
Else if (S='11') then IntStrToMonth:='Noviembre'
Else if (S='12') then IntStrToMonth:='Diciembre'
Else IntStrToMonth:='--';
End;

{******************************************************************************}
function IntStrToMonthShort(S:String):String;
Begin
     if (S='01') or (S='1') then IntStrToMonthShort:='Ene'
Else if (S='02') or (S='2') then IntStrToMonthShort:='Feb'
Else if (S='03') or (S='3') then IntStrToMonthShort:='Mar'
Else if (S='04') or (S='4') then IntStrToMonthShort:='Abr'
Else if (S='05') or (S='5') then IntStrToMonthShort:='May'
Else if (S='06') or (S='6') then IntStrToMonthShort:='Jun'
Else if (S='07') or (S='7') then IntStrToMonthShort:='Jul'
Else if (S='08') or (S='8') then IntStrToMonthShort:='Ago'
Else if (S='09') or (S='9') then IntStrToMonthShort:='Sep'
Else if (S='10') then IntStrToMonthShort:='Oct'
Else if (S='11') then IntStrToMonthShort:='Nov'
Else if (S='12') then IntStrToMonthShort:='Dic'
Else IntStrToMonthShort:='--';
End;

{******************************************************************************}
function DateToShortStr(D:TDate):String;
Var dd, mm, yyyy: Integer;
begin
dd:=DayOf(D);
mm:=MonthOf(D);
yyyy:=YearOf(D);
DateToShortStr:=Format('%.2d',[dd])+'/'+IntToMonthShort(mm)+'/'+IntToStr(yyyy);
end;

{******************************************************************************}
Function IngMonthToNum(S:String):String;
Var R:String;
begin
R:='00';
if lowercase(S)='jan' then R:='01';
if lowercase(S)='feb' then R:='02';
if lowercase(S)='mar' then R:='03';
if lowercase(S)='apr' then R:='04';
if lowercase(S)='may' then R:='05';
if lowercase(S)='jun' then R:='06';
if lowercase(S)='jul' then R:='07';
if lowercase(S)='aug' then R:='08';
if lowercase(S)='sep' then R:='09';
if lowercase(S)='oct' then R:='10';
if lowercase(S)='nov' then R:='11';
if lowercase(S)='dec' then R:='12';

IngMonthToNum:=R;
end;

{******************************************************************************}
function DateYYYYMMDD(Fecha:TDateTime): String;
Var S:String;
begin
S:=IntToStr( YearOf(Fecha) );
S:=S+Format('%.2d',[ MonthOf(Fecha) ]);
S:=S+Format('%.2d',[ DayOfTheMonth(Fecha) ]);
DateYYYYMMDD:=S;
end;

{******************************************************************************}
function DateYYYY_MM_DD(Fecha:TDateTime): String;
Var S:String;
begin
S:=IntToStr( YearOf(Fecha) );
S:=S+'-'+Format('%.2d',[ MonthOf(Fecha) ]);
S:=S+'-'+Format('%.2d',[ DayOfTheMonth(Fecha) ]);
DateYYYY_MM_DD:=S;
end;

{******************************************************************************}
function YYYY_MM_DDtoDate(S:String):TDateTime;
begin
YYYY_MM_DDtoDate:=EncodeDate(StrToInt(Copy(S,1,4)),
StrToInt(Copy(S,6,2)),StrToInt(Copy(S,9,2)));
end;

{******************************************************************************}

end.
