unit FunctionsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.ButtonGroup, iniFiles,  Vcl.CheckLst, System.Math;

type
  TFunctionsObject = class(TObject)
    // Кастомный диалог
    function MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
      Caption: ARRAY OF string; dlgcaption: string; sound: Integer = 0): Integer;
    // Обрезка холста
    procedure CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
    function CutFloat(Number: Real; Digits: Integer): Real;
    function BooleanToInt(Bool: Boolean): Integer;
  end;

var
  Functions: TFunctionsObject;

implementation

uses MainUnit, ParamsUnit, DecompositionUnit, SettingsUnit, SigmasTransferUnit, SelectionUnit;

// Кастомный диалог
// MyMessageDlg('Hello World!', mtInformation, [mbYes, mbNo], ['Yessss','Noooo'], 'New MessageDlg Box'):
function TFunctionsObject.MyMessageDlg(CONST Msg: string; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
  Caption: ARRAY OF string; dlgcaption: string; sound: Integer = 0): Integer;
var
  aMsgdlg: TForm;
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  aMsgdlg := createMessageDialog(Msg, DlgTypt, button);
  aMsgdlg.Caption := dlgcaption;
  aMsgdlg.BiDiMode := bdLeftToRight;
  Captionindex := 0;
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[i] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(aMsgdlg.components[i]);
      if Captionindex <= High(Caption) then
        Dlgbutton.Caption := Caption[Captionindex];
      inc(Captionindex);
    end;
  end;
  MessageBeep(sound);
  Result := aMsgdlg.Showmodal;
end;

// Обрезка холста -------------------------------- ПРОЦЕДУРА
procedure TFunctionsObject.CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
begin
  OutBitMap.Width  := 0;
  OutBitMap.Height := 0;
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width  := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X, Y, SRCCOPY);
end;

// Оставляет у числа с плавающей точкой нужное количество знаков ================================ ФУНКЦИЯ
function TFunctionsObject.CutFloat(Number: Real; Digits: Integer): Real;
var
  i: Integer;
  st: Integer;
begin
  st := 1;
  For i := 1 to Digits do
     st := st * 10;
  Number := trunc(Number * st) / st;
  Result := Number;
end;

function TFunctionsObject.BooleanToInt(Bool: Boolean): Integer;
begin
  if Bool = False then
    Result := 0
  else
    Result := 1;
end;

end.
