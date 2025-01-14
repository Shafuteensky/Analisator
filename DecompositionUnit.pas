unit DecompositionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TDecompositionForm = class(TForm)
    SaveButton: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    decompFirstXEdit: TEdit;
    decompFirstYEdit: TEdit;
    Label2: TLabel;
    decompLastXEdit: TEdit;
    Label4: TLabel;
    decompLastYEdit: TEdit;
    GroupBox9: TGroupBox;
    SignatureEdit: TEdit;
    ClearSignatureButton: TButton;
    UseFileNameButton: TButton;
    QuarterButton: TButton;
    Label3: TLabel;
    QuarterGB: TGroupBox;
    Quarter3: TButton;
    Quarter4: TButton;
    Quarter1: TButton;
    Quarter2: TButton;
    SaveDialog: TSaveDialog;
    procedure QuarterButtonClick(Sender: TObject);
    procedure UseFileNameButtonClick(Sender: TObject);
    procedure ClearSignatureButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Quarter1Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    // Правка координат диапазона декомпозиции
    procedure OneDCoordFix();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DecompositionForm: TDecompositionForm;
  decompRange: array of integer;

implementation

{$R *.dfm}

uses FunctionsUnit, MainUnit, FilesUnit, TablesUnit;

// Открытие формы
procedure TDecompositionForm.FormShow(Sender: TObject);
begin
  SaveButton.Enabled := False;
  with MainForm do
  begin
    selPnl.Enabled := False;
    selPnlLabel.Enabled := False;
    openTableDBtn.Enabled := False;
    openTableRBtn.Enabled := False;
  end;
  if isSelEditing then
    MainForm.selDeleteBtn.Click;
  SetLength(decompRange, 0);
  SetLength(decompRange, 4);

  Tables.SwitchToA;
  MainForm.toolBar.Enabled := False;
  decompFirstXEdit.Text := '';
  decompFirstYEdit.Text := '';
  decompLastXEdit.Text := '';
  decompLastYEdit.Text := '';
  MainForm.InfoLineUpdate('Запущен модуль декомпозиции',
    ' (Выберите ячейки начала/конца диапазона декомпозиции в таблице левой кнопкой мыши либо через меню "Четверть")');
end;

// Закрытие формы
procedure TDecompositionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Tables.SwitchToAB;
  with MainForm do
  begin
    selPnl.Enabled := True;
    selPnlLabel.Enabled := True;
    openTableDBtn.Enabled := True;
    openTableRBtn.Enabled := True;
  end;
  SetLength(decompRange, 0);
  MainForm.toolBar.Enabled := True;
end;

//==============================================================================

// Четверть
procedure TDecompositionForm.QuarterButtonClick(Sender: TObject);
begin
  QuarterGB.Visible := not QuarterGB.Visible;
  if QuarterGB.Visible then
    QuarterButton.Caption := 'Четверть ↑'
  else
    QuarterButton.Caption := 'Четверть ↓';
  DecompositionForm.AutoSize := False;
  DecompositionForm.AutoSize := True;
end;

procedure TDecompositionForm.Quarter1Click(Sender: TObject);
  procedure setRange(x1, y1, x2, y2: Double);
  begin
    decompRange[0] := Trunc(x1);
    decompRange[1] := Trunc(y1);
    decompRange[2] := Trunc(x2);
    decompRange[3] := Trunc(y2);

    DecompositionForm.decompFirstXEdit.Text := FloatToStr(Trunc(x1));
    DecompositionForm.decompFirstYEdit.Text := FloatToStr(yTableDim - Trunc(y1)+1);
    DecompositionForm.decompLastXEdit.Text := FloatToStr(Trunc(x2));
    DecompositionForm.decompLastYEdit.Text := FloatToStr(yTableDim - Trunc(y2)+1);
  end;
//
begin
  with (Sender as TButton) do
  begin
    if Sender = Quarter1 then
      setRange(1, (yTableDim/2)+1, xTableDim/2, yTableDim)
    else if Sender = Quarter2 then
      setRange((xTableDim/2)+1, (yTableDim/2)+1, xTableDim, yTableDim)
    else if Sender = Quarter3 then
      setRange(1, 1, xTableDim/2, yTableDim/2)
    else if Sender = Quarter4 then
      setRange((xTableDim/2)+1, 1, xTableDim, yTableDim/2);
  end;
  if (decompRange[0] >= 1) and (decompRange[2] >= 1) then
    DecompositionForm.SaveButton.Enabled := True;
  Tables.Repaint();
end;

//------------------------------------------------------------------------------

// Использовать имя файла
procedure TDecompositionForm.UseFileNameButtonClick(Sender: TObject);
begin
  SignatureEdit.Text := Files.GetFileName();
end;

// Очистить имя
procedure TDecompositionForm.ClearSignatureButtonClick(Sender: TObject);
begin
  SignatureEdit.Clear;
end;

// Сохранить
procedure TDecompositionForm.SaveButtonClick(Sender: TObject);
var
  DecompSGA, DecompSGB: TStringGrid;
  i, j, x ,y: integer;
begin
  OneDCoordFix();
  DecompSGA := TStringGrid.Create(Self);
  DecompSGB := TStringGrid.Create(Self);

  DecompSGA.ColCount := (decompRange[2]-decompRange[0])+2;
  DecompSGA.RowCount := (decompRange[3]-decompRange[1])+2;
  DecompSGB.ColCount := DecompSGA.ColCount;
  DecompSGB.RowCount := DecompSGA.RowCount;

  i := 1;
  j := 1;

  for x := decompRange[0] to decompRange[2] do
  begin
    for y := decompRange[1] to decompRange[3] do
    begin
      DecompSGA.Cells[i, j] := MainForm.tableA.Cells[x, y];
      DecompSGB.Cells[i, j] := MainForm.tableB.Cells[x, y];
      Inc(j);
    end;
    j := 1;
    Inc(i);
  end;

  if Length(SignatureEdit.Text) > 0 then
    SaveDialog.FileName := SignatureEdit.Text;
  if SaveDialog.Execute then
    Files.SaveIni(SaveDialog.FileName, DecompSGA, DecompSGB, False);
  MainForm.InfoLineUpdate('Файл декомпозирован как "'+DecompositionForm.SaveDialog.FileName+'"');
end;

// Правка координат диапазона декомпозиции-------------------------------- ПРОЦЕДУРА
procedure TDecompositionForm.OneDCoordFix();
begin
  if Length(decompRange) > 0 then
    if (((decompRange[0]+decompRange[1]) > 0) and
     ((decompRange[2]+decompRange[3]) > 0)) then
    begin
      if decompRange[0] > decompRange[2] then
      begin
        decompRange[0] := decompRange[0] + decompRange[2];
        decompRange[2] := decompRange[0] - decompRange[2];
        decompRange[0] := decompRange[0] - decompRange[2];
      end;
      if decompRange[1] > decompRange[3] then
      begin
        decompRange[1] := decompRange[1] + decompRange[3];
        decompRange[3] := decompRange[1] - decompRange[3];
        decompRange[1] := decompRange[1] - decompRange[3];
      end;
    end;
end;

end.
