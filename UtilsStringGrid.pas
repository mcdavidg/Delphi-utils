unit UtilsStringGrid;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ComCtrls,
  Vcl.Menus,

  UtilsStrings;

// Carga un StringList en un StringGrid
procedure SListToSGrid(SList:TStringList; var SGrid:TStringGrid; Separador:Char);

// Carga un STringGrid en un StringList
procedure SGridToSList(SGrid:TStringGrid; var SList:TStringList; Separador:Char);

// Ordena Ascendente los datos en un StringList por columna NumCol
// (Las columnas se numeran desde el cero)
procedure SortAscSListByCol(var SList:tstringList; NumCol:Integer; Separador:Char);

// Ordena Descendente los datos en un StringList por columna NumCol
// (Las columnas se numeran desde el cero)
procedure SortDesSListByCol(var SList:tstringList; NumCol:Integer; Separador:Char);


implementation

{******************************************************************************}
procedure SListToSGrid(SList:TStringList; var SGrid:TStringGrid; Separador:Char);
var i, j, x, y: Integer;
    DRow: TStringList;
    S:String;
begin
y:=SList.Count;
DRow:=TStringList.Create;
SplitByChar(SList[0],Separador,DRow);
x:=DRow.Count;

SGrid.ColCount:=x;
SGrid.RowCount:=y;

for j:=0 to y-1 do
  begin
  SplitByChar(SList[j],Separador,DRow);
  for i:=0 to x-1 do
    begin
    S:=DRow[i];
    SGrid.Cells[i,j]:=S;
    end;
  end;

DRow.Free;
end;

{******************************************************************************}
procedure SGridToSList(SGrid:TStringGrid; var SList:TStringList; Separador:Char);
var i,j,x,y:Integer;
    S,L:String;
    DRow:TStringList;
begin
SList.Clear;

x:=SGrid.ColCount;
y:=SGrid.RowCount;
for j:=0 to y-1 do
  begin
  S:='';
  for i:=0 to x-1 do
    begin
    S:=S+SGrid.Cells[i,j];
    if i<x-1 then S:=S+Separador;
    end;
  SList.Add(S);
  end;

end;

{******************************************************************************}
procedure SortAscSListByCol(var SList:tstringList; NumCol:Integer; Separador:Char);
var DRow, TSTemp:TStringList;
    i,j:Integer;
    S, Header:String;
begin
TSTemp:=TStringList.Create;
DRow:=TStringList.Create;

Header:=SList[0];
SList.Delete(0);

for i:=0 to SList.Count-1 do
  begin
  SplitByChar(SList[i],Separador,DRow);
  S:=DRow[NumCol]+Separador+Slist[i];
  TSTemp.Add(S);
  end;

TSTemp.Sort;

SList.Clear;
for i:=0 to TSTemp.Count-1 do
  begin
  SplitByChar(TSTemp[i],Separador,DRow);
  S:='';
  for j:=1 to DRow.Count-1 do
    begin
    S:=S+DRow[j];
    if j<DRow.Count-1 then S:=S+Separador;
    end;
  SList.Add(S);
  end;

SList.Insert(0,Header);

DRow.Free;
TSTemp.Free;
end;

{******************************************************************************}
procedure SortDesSListByCol(var SList:tstringList; NumCol:Integer; Separador:Char);
var DRow, TSTemp:TStringList;
    i,j:Integer;
    S, Header:String;
begin
TSTemp:=TStringList.Create;
DRow:=TStringList.Create;

Header:=SList[0];
SList.Delete(0);

for i:=0 to SList.Count-1 do
  begin
  SplitByChar(SList[i],Separador,DRow);
  S:=DRow[NumCol]+Separador+Slist[i];
  TSTemp.Add(S);
  end;

TSTemp.CustomSort(@CompareDesc);

SList.Clear;
for i:=0 to TSTemp.Count-1 do
  begin
  SplitByChar(TSTemp[i],Separador,DRow);
  S:='';
  for j:=1 to DRow.Count-1 do
    begin
    S:=S+DRow[j];
    if j<DRow.Count-1 then S:=S+Separador;
    end;
  SList.Add(S);
  end;

SList.Insert(0,Header);

DRow.Free;
TSTemp.Free;
end;

{******************************************************************************}
end.
