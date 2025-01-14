unit SigmasTransferUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.IniFiles,
  Vcl.CheckLst;

type
  TSigmasTransferForm = class(TForm)
    OkBtn: TButton;
    CancelBtn: TButton;
    GroupBox7: TGroupBox;
    SelList: TCheckListBox;
    procedure FormActivate(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure SelListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SigmasTransferForm: TSigmasTransferForm;
  ini: TIniFile;

implementation

uses
  MainUnit, FunctionsUnit, SelectionUnit;

{$R *.dfm}

procedure TSigmasTransferForm.FormActivate(Sender: TObject);
var
  i: Integer;

  function GetSelRangeStr(Index: Integer): string;
  var
    Selection: TStringList;
  begin
    Selection := TStringList.Create;
    Selection.StrictDelimiter := True;
    Selection.Delimiter := ';';

    Selection.Clear;
    Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(Index+1), 'Sigmas', ''));
    Result := (ini.ReadString('Selection'+IntToStr(Index+1), 'Name', ''))
      + ' (δa='+Selection[0]+', δb='+Selection[1];

    Selection.Clear;
    Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(Index+1), 'Averages', ''));
    Result := Result + ', μa='+Selection[0]+', μb='+Selection[1]+')';
  end;

begin
  ini := TIniFile.Create(MainForm.fileOpenDialog.FileName);
  SelList.Items.Clear;
  for i := 0 to StrToInt(ini.ReadString('Information', 'SelNum', '0'))-1 do
  begin
    SelList.Items.Add(GetSelRangeStr(i));
  end;
end;

procedure TSigmasTransferForm.OkBtnClick(Sender: TObject);
var
  Selection: TStringList;

  function GetChosenIndex: Integer;
  var
    i: Integer;
  begin
    for i := 0 to SelList.Items.Count - 1 do
      if SelList.Checked[i] then
      begin
        Result := i;
        break
      end;
  end;

begin
  with MainForm do
  begin
    Selection := TStringList.Create;
    Selection.StrictDelimiter := True;
    Selection.Delimiter := ';';

    Selection.Clear;
    Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(GetChosenIndex+1), 'Sigmas', ''));
    sigmaAEdit.Text := Selection[0];
    sigmaBEdit.Text := Selection[1];

    Selection.Clear;
    Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(GetChosenIndex+1), 'Averages', ''));
    meanAEdit.Text := Selection[0];
    meanBEdit.Text := Selection[1];

    selNameEdit.Text := ini.ReadString('Selection'+IntToStr(GetChosenIndex+1), 'Name', '')
  end;
  SigmasTransferForm.Close;
end;

procedure TSigmasTransferForm.SelListClick(Sender: TObject);

  function GetChosenIndex: Integer;
  var
    i: Integer;
  begin
    for i := 0 to SelList.Items.Count - 1 do
      if SelList.Checked[i] then
      begin
        Result := i;
        break
      end;
  end;
begin
  if Selections.IsActiveInUIList(SelList) then
    OkBtn.Enabled := True
  else
    OkBtn.Enabled := False;
  try
    SelList.Hint := SelList.Items[GetChosenIndex];
  except
    SelList.Hint := '';
  end;
end;

procedure TSigmasTransferForm.SelListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  for i := 0 to SelList.Items.Count-1 do
    SelList.Checked[i] := False;
end;

procedure TSigmasTransferForm.CancelBtnClick(Sender: TObject);
begin
  SigmasTransferForm.Close;
end;

end.
