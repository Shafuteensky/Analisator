unit SettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Registry, shlobj, iniFiles;

type
  TSettingsForm = class(TForm)
    GroupBox1: TGroupBox;
    DRCheckBox: TCheckBox;
    XYCheckBox: TCheckBox;
    sCheckBox: TCheckBox;
    GroupBox5: TGroupBox;
    ToolTopButton: TRadioButton;
    ToolBottomButton: TRadioButton;
    selCheckBox: TCheckBox;
    ABCheckBox: TCheckBox;
    GroupBox2: TGroupBox;
    ResetButton: TLabel;
    GroupBox3: TGroupBox;
    wdhA4CheckBox: TCheckBox;
    wdhA4Edit: TEdit;
    GroupBox4: TGroupBox;
    wdhA2CheckBox: TCheckBox;
    wdhA2Edit: TEdit;
    hgtA2CheckBox: TCheckBox;
    hgtA2Edit: TEdit;
    hgtA4CheckBox: TCheckBox;
    hgtA4Edit: TEdit;
    GroupBox6: TGroupBox;
    wdhExcelCheckBox: TCheckBox;
    hgtExcelCheckBox: TCheckBox;
    hgtExcelEdit: TEdit;
    wdhExcelEdit: TEdit;
    AssociationButton: TLabel;
    lightGrid: TRadioButton;
    darkGrid: TRadioButton;
    GroupBox7: TGroupBox;
    GridPaintCB: TCheckBox;
    GridCoordCB: TCheckBox;
    procedure DRCheckBoxClick(Sender: TObject);
    procedure XYCheckBoxClick(Sender: TObject);
    procedure sCheckBoxClick(Sender: TObject);
    procedure ToolTopButtonClick(Sender: TObject);
    procedure ToolBottomButtonClick(Sender: TObject);
    procedure selCheckBoxClick(Sender: TObject);
    procedure ABCheckBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveSettings;
    procedure wdhA2EditKeyPress(Sender: TObject; var Key: Char);
    procedure ResetButtonClick(Sender: TObject);
    procedure ResetButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wdhA4EditKeyPress(Sender: TObject; var Key: Char);
    procedure hgtA2EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure hgtA4EditKeyPress(Sender: TObject; var Key: Char);
    procedure settingsReset();
    procedure SettingsLoad();
    procedure SetAssociation();
    procedure DelAssociation();
    procedure wdhExcelEditKeyPress(Sender: TObject; var Key: Char);
    procedure hgtExcelEditKeyPress(Sender: TObject; var Key: Char);
    procedure AssociationButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AssociationButtonClick(Sender: TObject);
    procedure ResetButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AssociationButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridPaintCBClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SaveSetting(group, name, text: string); overload;
    procedure SaveSetting(group, name: string; index: integer); overload;
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;
  wdhA2, wdhA4, wdhExcel, hgtA2, hgtA4, hgtExcel: String;
  Reg: TRegistry;
const
  cwA2 = '0,975';
  chA2 = '1,0063';
  cwA4 = '1,0303';
  chA4 = '1,0347'; //'1,002';
  cwExcel = '1';
  chExcel = '1';
  setCfg = '\settings.cfg';
  ExtensionName = 'anls';
  ApplicationName = 'Analisator';

implementation

{$R *.dfm}

uses MainUnit, ExportToTablesUnit, FunctionsUnit, ParamsUnit, TablesUnit,
  IsolinesUnit;

// Создание формы ================================ ПРОЦЕДУРА
procedure TSettingsForm.FormCreate(Sender: TObject);
var
  text : TextFile;
  i: integer;
begin
  SettingsLoad();
  // Проверка ассоциации файлов
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;
  if Reg.KeyExists('.' + ExtensionName) = False then AssociationButton.Caption := 'Установить ассоциацию файлов'
  else AssociationButton.Caption := 'Удалить ассоциацию файлов';
end;

// Загрузка настроек в программу ================================ ПРОЦЕДУРА
procedure TSettingsForm.SettingsLoad();
var
  ini: TIniFile;
begin
  if not FileExists(ExtractFileDir(ParamStr(0))+setCfg) then
  begin
    ShowMessage('Файл настроек не найден. Будут загружены стандартные настройки.');
    settingsReset();
  end;

  ini := TIniFile.Create(ExtractFileDir(ParamStr(0))+setCfg);
  with ini do
  begin
    ToolTopButton.Checked := ReadBool('ToolPanelSettings', 'ToolTopButton', True);
    ABCheckBox.Checked := ReadBool('ToolPanelSettings', 'ABCheckBox', False);
    DRCheckBox.Checked := ReadBool('ToolPanelSettings', 'DRCheckBox', False);
    XYCheckBox.Checked := ReadBool('ToolPanelSettings', 'XYCheckBox', True);
    selCheckBox.Checked := ReadBool('ToolPanelSettings', 'selCheckBox', True);
    sCheckBox.Checked := ReadBool('ToolPanelSettings', 'sCheckBox', True);

    GridPaintCB.Checked := ReadBool('TableGridSettings', 'GridPaintCB', True);
    GridCoordCB.Checked := ReadBool('TableGridSettings', 'GridCoordCB', True);

    darkGrid.Checked := ReadBool('ExportSettings', 'darkGrid', True);
    wdhA4CheckBox.Checked := ReadBool('ExportSettings', 'wdhA4CheckBox', True);
    hgtA4CheckBox.Checked := ReadBool('ExportSettings', 'hgtA4CheckBox', True);
    wdhA2CheckBox.Checked := ReadBool('ExportSettings', 'wdhA2CheckBox', True);
    hgtA2CheckBox.Checked := ReadBool('ExportSettings', 'hgtA2CheckBox', True);
    wdhExcelCheckBox.Checked := ReadBool('ExportSettings', 'wdhExcelCheckBox', False);
    hgtExcelCheckBox.Checked := ReadBool('ExportSettings', 'hgtExcelCheckBox', False);
    wdhA4Edit.Text := ReadString('ExportSettings', 'wdhA4Edit', cwA4);
    hgtA4Edit.Text := ReadString('ExportSettings', 'hgtA4Edit', chA4);
    wdhA2Edit.Text := ReadString('ExportSettings', 'wdhA2Edit', cwA2);
    hgtA2Edit.Text := ReadString('ExportSettings', 'hgtA2Edit', chA2);
    wdhExcelEdit.Text := ReadString('ExportSettings', 'wdhExcelEdit', cwExcel);
    hgtExcelEdit.Text := ReadString('ExportSettings', 'hgtExcelEdit', chExcel);

    Free;
  end;
end;

// Сохранение настроек ================================ ПРОЦЕДУРА
procedure TSettingsForm.SaveSettings;
var
  FS : TFileStream;
  ini: TIniFile;
  Filename: string;
begin
  try
    Filename := ExtractFileDir(ParamStr(0))+setCfg;
    if not FileExists(Filename) then
    begin
      FS := TFileStream.Create(Filename, fmCreate);
      FreeAndNil(FS);
    end;

    ini := TIniFile.Create(Filename);
    with ini do
    begin
      WriteBool('ToolPanelSettings', 'ToolTopButton', ToolTopButton.Checked);
      WriteBool('ToolPanelSettings', 'ABCheckBox', ABCheckBox.Checked);
      WriteBool('ToolPanelSettings', 'DRCheckBox', DRCheckBox.Checked);
      WriteBool('ToolPanelSettings', 'XYCheckBox', XYCheckBox.Checked);
      WriteBool('ToolPanelSettings', 'selCheckBox', selCheckBox.Checked);
      WriteBool('ToolPanelSettings', 'sCheckBox', sCheckBox.Checked);

      WriteBool('TableGridSettings', 'GridPaintCB', GridPaintCB.Checked);
      WriteBool('TableGridSettings', 'GridCoordCB', GridCoordCB.Checked);

      WriteBool('ExportSettings', 'darkGrid', darkGrid.Checked);
      WriteBool('ExportSettings', 'wdhA4CheckBox', wdhA4CheckBox.Checked);
      WriteString('ExportSettings', 'wdhA4Edit', wdhA4Edit.Text);
      WriteBool('ExportSettings', 'hgtA4CheckBox', hgtA4CheckBox.Checked);
      WriteString('ExportSettings', 'hgtA4Edit', hgtA4Edit.Text);
      WriteBool('ExportSettings', 'wdhA2CheckBox', wdhA2CheckBox.Checked);
      WriteString('ExportSettings', 'wdhA2Edit', wdhA2Edit.Text);
      WriteBool('ExportSettings', 'hgtA2CheckBox', hgtA2CheckBox.Checked);
      WriteString('ExportSettings', 'hgtA2Edit', hgtA2Edit.Text);
      WriteBool('ExportSettings', 'wdhExcelCheckBox', wdhExcelCheckBox.Checked);
      WriteString('ExportSettings', 'wdhExcelEdit', wdhExcelEdit.Text);
      WriteBool('ExportSettings', 'hgtExcelCheckBox', hgtExcelCheckBox.Checked);
      WriteString('ExportSettings', 'hgtExcelEdit', hgtExcelEdit.Text);
      Free;
    end;
    MainForm.InfoLineUpdate('Настройки изменены');
  except
  end;
end;
//
procedure TSettingsForm.SaveSetting(group, name, text: string);
var
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFileDir(ParamStr(0))+setCfg);
    ini.WriteString(group, name, text);
    ini.Free;
  except
  end;
end;
//
procedure TSettingsForm.SaveSetting(group, name: string; index: integer);
var
  ini: TIniFile;
begin
  try
    ini := TIniFile.Create(ExtractFileDir(ParamStr(0))+setCfg);
    ini.WriteInteger(group, name, index);
    ini.Free;
  except
  end;
end;

// Расположение сверху ================================ ПРОЦЕДУРА
procedure TSettingsForm.ToolTopButtonClick(Sender: TObject);
begin
  if ToolTopButton.Checked = True then
    MainForm.toolsPnl.Align := alTop;
end;

// Расположение снизу ================================ ПРОЦЕДУРА
procedure TSettingsForm.ToolBottomButtonClick(Sender: TObject);
begin
  if ToolBottomButton.Checked = True then
    MainForm.toolsPnl.Align := alBottom;
end;

// Показывать A и B вместе ================================ ПРОЦЕДУРА
procedure TSettingsForm.ABCheckBoxClick(Sender: TObject);
begin
  if ABCheckBox.Checked = True then
  begin
    Tables.ABTransfer('to AB');
    MainForm.openTableABtn.Caption := 'AB';
    MainForm.openTableABtn.Width := 70;
    MainForm.openTableBBtn.Visible := False;
    MainForm.openTableABtn.Click;
  end
  else
  begin
    Tables.ABTransfer('to A and B');
    MainForm.openTableABtn.Caption := 'A';
    MainForm.openTableABtn.Width := 25;
    MainForm.openTableBBtn.Visible := True;
    MainForm.openTableABtn.Click;
  end;
end;

// Показывать D и R вместе ================================ ПРОЦЕДУРА
procedure TSettingsForm.DRCheckBoxClick(Sender: TObject);
begin
  if DRCheckBox.Checked = True then
  begin
    MainForm.openTableDBtn.Caption := 'DR';
    MainForm.openTableDBtn.Width := 70;
    MainForm.openTableDBtn.Margins.Right := 9;
    MainForm.openTableRBtn.Visible := False;
    MainForm.openTableDBtn.Click;
  end
  else
  begin
    MainForm.openTableDBtn.Caption := 'D';
    MainForm.openTableDBtn.Width := 30;
    MainForm.openTableDBtn.Margins.Right := 2;
    MainForm.openTableDBtn.Visible := False;
    MainForm.openTableRBtn.Visible := True;
    MainForm.openTableDBtn.Visible := True;
    MainForm.openTableDBtn.Click;
  end;
end;

// Показывать текущие координаты ================================ ПРОЦЕДУРА
procedure TSettingsForm.XYCheckBoxClick(Sender: TObject);
begin
  MainForm.coordsPnl.Visible := XYCheckBox.Checked;
end;

// Показывать панель выборки ================================ ПРОЦЕДУРА
procedure TSettingsForm.selCheckBoxClick(Sender: TObject);
begin
  MainForm.selPnl.Visible := selCheckBox.Checked;
end;

// Показывать сигмы и средние значения ================================ ПРОЦЕДУРА
procedure TSettingsForm.sCheckBoxClick(Sender: TObject);
begin
  MainForm.sigmasPnl.Visible := sCheckBox.Checked;
end;

// Окраска сетки таблиц
procedure TSettingsForm.GridPaintCBClick(Sender: TObject);
begin
  Tables.Repaint;
end;

// Только цифры и точка в полях ввода ================================ ПРОЦЕДУРА
procedure EditKeyPress(Edit: TEdit; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', ',']) then
    Key := #0;
  if (Key in [',']) and (Edit.SelStart <> 1) then
    Key := #0;
end;
  //
procedure TSettingsForm.wdhA2EditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(wdhA2Edit, Key);
end;
  //
procedure TSettingsForm.wdhA4EditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(wdhA4Edit, Key);
end;
  //
procedure TSettingsForm.hgtA2EditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(hgtA2Edit, Key);
end;
  //
procedure TSettingsForm.hgtA4EditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(hgtA4Edit, Key);
end;
  //
procedure TSettingsForm.wdhExcelEditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(wdhExcelEdit, Key);
end;
  //
procedure TSettingsForm.hgtExcelEditKeyPress(Sender: TObject; var Key: Char);
begin
  EditKeyPress(hgtExcelEdit, Key);
end;

// Убрать галочку поправки, если поле пустое ================================ ПРОЦЕДУРА
procedure TSettingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (wdhA2Edit.Text = '') then
    wdhA2Edit.Text := cwA2;
  if (wdhA4Edit.Text = '') then
    wdhA4Edit.Text := cwA4;
  if (wdhExcelEdit.Text = '') then
    wdhExcelEdit.Text := cwExcel;
  if (hgtA2Edit.Text = '') then
    hgtA2Edit.Text := chA2;
  if (hgtA4Edit.Text = '') then
    hgtA4Edit.Text := chA4;
  if (hgtExcelEdit.Text = '') then
    hgtExcelEdit.Text := chExcel;
  SaveSettings;
end;

// Установка ассоциации файлов  ================================ ПРОЦЕДУРА
procedure TSettingsForm.SetAssociation();
var
  R: TRegistry;
begin
  try
    R := TRegistry.Create;
    R.RootKey := HKEY_CLASSES_ROOT;
    R.OpenKey('.anls\OpenWithProgids\', true);
    R.WriteString('Analisator.anls', '');
    R.OpenKey('\Analisator.anls\DefaultIcon\', true);
    R.WriteString('', Application.ExeName+',0');
    R.OpenKey('\Analisator.anls\Shell\Open\', true);
    R.WriteString('', 'Открыть в Анализаторе');
    R.OpenKey('command\', true);
    R.WriteString('', '"'+Application.ExeName+'" "%1"');
  finally
    R.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

// Удаление ассоциации файлов  ================================ ПРОЦЕДУРА
procedure TSettingsForm.DelAssociation();
var
  R: TRegistry;
begin
  try
    R:=TRegistry.Create;
    R.RootKey := HKEY_CLASSES_ROOT;
    R.DeleteKey('.anls');
    R.DeleteKey('Analisator.anls');
  finally
    R.Free;
  end;
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

// Установка/удаление ассоциации файлов  ================================ ПРОЦЕДУРА
procedure TSettingsForm.AssociationButtonClick(Sender: TObject);
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;
  if Reg.KeyExists('.' + ExtensionName) = False then
  begin
    SetAssociation();
    AssociationButton.Caption := 'Удалить ассоциацию файлов';
  end
  else
  begin
    DelAssociation();
    AssociationButton.Caption := 'Установить ассоциацию файлов';
  end;
end;

// Сброс настроек ================================ ПРОЦЕДУРА
procedure TSettingsForm.settingsReset();
begin
    ToolTopButton.Checked :=  True;
    ABCheckBox.Checked := False;
    DRCheckBox.Checked := False;
    XYCheckBox.Checked := True;
    selCheckBox.Checked := True;
    sCheckBox.Checked := True;

    GridPaintCB.Checked := True;
    GridCoordCB.Checked := True;

    darkGrid.Checked := True;
    wdhA4CheckBox.Checked := False;
    wdhA4Edit.Text := '1'; // cwA4;
    hgtA4CheckBox.Checked := False;
    hgtA4Edit.Text := '1'; // chA4;
    wdhA2CheckBox.Checked := False;
    wdhA2Edit.Text := '1'; // cwA2;
    hgtA2CheckBox.Checked := False;
    hgtA2Edit.Text := '1'; // chA2;
    wdhExcelCheckBox.Checked := False;
    wdhExcelEdit.Text := cwExcel;
    hgtExcelCheckBox.Checked := False;
    hgtExcelEdit.Text := chExcel;
end;
  // ================================ ПРОЦЕДУРА
procedure TSettingsForm.ResetButtonClick(Sender: TObject);
begin
  if Functions.MyMessageDlg('Вы действительно хотите сбросить настройки?',
    mtInformation, [mbYes, mbNo], ['Да','Нет'], 'Подтверждение', MB_ICONWARNING) = mrYes then
    settingsReset();
end;

// Визуализация кнопки-текста ================================ ПРОЦЕДУРА
procedure TSettingsForm.ResetButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ResetButton.Font.Color := clGrayText;
  ResetButton.Font.Style := ResetButton.Font.Style + [TFontStyle.fsItalic];
end;
procedure TSettingsForm.ResetButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ResetButton.Font.Color := clWindowText;
  ResetButton.Font.Style := ResetButton.Font.Style - [TFontStyle.fsItalic];
end;
  //
procedure TSettingsForm.AssociationButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AssociationButton.Font.Color := clGrayText;
  AssociationButton.Font.Style := AssociationButton.Font.Style + [TFontStyle.fsItalic];
end;
procedure TSettingsForm.AssociationButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AssociationButton.Font.Color := clWindowText;
  AssociationButton.Font.Style := AssociationButton.Font.Style - [TFontStyle.fsItalic];
end;

end.
