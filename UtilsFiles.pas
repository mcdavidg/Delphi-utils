unit UtilsFiles;

interface

Uses SysUtils, Classes;

// Regresa archivos de un directorio
procedure FindFiles(StartDir, FileMask: string; var FilesList: TStringList);

// Borar todos los archivos definidor por una mascara
// Ejemplo: DeleteFiles(GetCurrentDir+'\Archivo*.*');
procedure DeleteFiles(DirAndMask:string);

implementation

{******************************************************************************}
procedure FindFiles(StartDir, FileMask: string; var FilesList: TStringList);
const
  MASK_ALL_FILES = '*.*';
  CHAR_POINT = '.';
var
  SR: TSearchRec;
  DirList: TStringList;
  IsFound: Boolean;
  i: integer;
begin

FilesList.Clear;

if (StartDir[length(StartDir)] <> '\') then
  begin
  StartDir := StartDir + '\';
  end;

// Crear la lista de ficheos en el dir. StartDir (no directorios!)
IsFound := FindFirst(StartDir + FileMask,
                faAnyFile - faDirectory, SR) = 0;

// MIentras encuentre
while IsFound do
  begin
  FilesList.Add(StartDir + SR.Name);
  IsFound := FindNext(SR) = 0;
  end;

FindClose(SR);

end;

//******************************************************************************
procedure DeleteFiles(DirAndMask:string);
Var Dir:String;
    RBusqueda:TSearchRec; //Está definida en la unidad SysUtils
Begin
Dir:=ExtractFilePath(DirAndMask);
If FindFirst(DirAndMask,faanyfile, RBusqueda)=0 Then
  Begin
  DeleteFile(PChar(Dir+RBusqueda.Name)); //Borro el primero si existe

  //Busco todos los del mismo patrón y los borro
  While FindNext(RBusqueda)=0 Do
    Begin
    DeleteFile(PChar(Dir+RBusqueda.Name));
    End;

  //Ambas funciones devuelven 0 si la búsqueda tiene éxito
  End;
End;

//******************************************************************************
end.
