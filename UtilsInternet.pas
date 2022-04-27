unit UtilsInternet;

interface

Uses Winapi.Windows, System.SysUtils, Vcl.Forms, WinInet, URLMon, ShellApi;

// Verifica si hay conexión disponible a Internet
function IsConnectedToInternet: Boolean;
function DescargarArchivo( sURL, sArchivoLocal: String ): boolean;
function DownloadToFile(URL, FileName: String): Boolean;
function DownloadToText(const pagina: string): UTF8String;
function GetStrUntilChar(Texto:String; i:Integer; Ch:Char): String;

implementation

{******************************************************************************}
function IsConnectedToInternet: Boolean;
var
dwConnectionTypes: DWORD;
begin
dwConnectionTypes :=
INTERNET_CONNECTION_MODEM +
INTERNET_CONNECTION_LAN +
INTERNET_CONNECTION_PROXY;
Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;

{******************************************************************************}
function DescargarArchivo( sURL, sArchivoLocal: String ): boolean;
const BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  LongitudBuffer: DWORD;
  F: File;
  sMiPrograma: String;
begin
  sMiPrograma := ExtractFileName( Application.ExeName );
  hSession := InternetOpen( PChar( sMiPrograma ), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0 );

  try
    hURL := InternetOpenURL( hSession, PChar( sURL ), nil, 0, 0, 0 );

    try
      AssignFile( F, sArchivoLocal );
      Rewrite( F, 1 );

      repeat
        InternetReadFile( hURL, @Buffer, SizeOf( Buffer ), LongitudBuffer );
        BlockWrite( F, Buffer, LongitudBuffer );
      until LongitudBuffer = 0;

      CloseFile( F );
      Result := True;
    finally
      InternetCloseHandle( hURL );
    end
  finally
    InternetCloseHandle( hSession );
  end
end;

{******************************************************************************}
function DownloadToFile(URL, FileName: String): Boolean;
var  lpszFile:      Array [0..MAX_PATH] of Char;
begin
  // Download to cache by getting newest version
  if (URLDownloadToCacheFile(nil, PChar(URL), @lpszFile, MAX_PATH, BINDF_GETNEWESTVERSION, nil) = S_OK) then
     // Copy to desired file name
     result:=CopyFile(@lpszFile, PChar(FileName), False)
  else
     // Failed
     result:=False;
end;

{******************************************************************************}
function DownloadToText(const pagina: string): UTF8String;

// Credits : Based on http://www.scalabium.com/faq/dct0080.htm
// Thanks to www.scalabium.com

var
  nave1: HINTERNET;
  nave2: HINTERNET;
  tou: DWORD;
  codez: UTF8String;
  codee: array [0 .. 1023] of byte;
  finalfinal: string;

begin

if pagina<>'' then

  begin

    try

      begin

        finalfinal := '';
        Result := '';

        nave1 := InternetOpen
          ('Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0',
          INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

        nave2 := InternetOpenUrl(nave1, PChar(pagina), nil, 0,
          INTERNET_FLAG_RELOAD, 0);

        repeat

          begin
          InternetReadFile(nave2, @codee, SizeOf(codee), tou);
          SetString(codez, PAnsiChar(@codee[0]), tou);
          finalfinal := finalfinal + codez;
          end;

        until tou = 0;

        InternetCloseHandle(nave2);
        InternetCloseHandle(nave1);

        Result := finalfinal;
      end;

    except

    end;

  end
else Result := '';

end;

{******************************************************************************}
function GetStrUntilChar(Texto:String; i:Integer; Ch:Char): String;
var j:Integer;
    S:String;
    Chr:Char;
begin
S:=''; j:=0;

  Repeat
    Chr:=Texto[i+j];
    if Chr<>Ch then S:=S+Chr;
    inc(j);
  Until (Chr=Ch) or (j>length(Texto));

GetStrUntilChar:=S;
end;

{*******************************************************************************}
end.
