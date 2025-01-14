unit CreateUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TCreateForm = class(TForm)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    CreateXEdit: TEdit;
    CreateYEdit: TEdit;
    ButtonsPanel: TPanel;
    CreateButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure CreateButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CreateXEditKeyPress(Sender: TObject; var Key: Char);
    procedure CreateXEditChange(Sender: TObject);
    procedure createFile(xDim, yDim: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateForm: TCreateForm;
  i: Integer;

implementation

{$R *.dfm}

uses MainUnit, FunctionsUnit, FilesUnit, SelectionUnit, ProcessingUnit;

// Кнопка отмены ================================ ПРОЦЕДУРА
procedure TCreateForm.CancelButtonClick(Sender: TObject);
begin
   CreateForm.Close;
end;

// Кнопка создания ================================ ПРОЦЕДУРА
procedure TCreateForm.CreateButtonClick(Sender: TObject);
begin
  createFile(StrToInt(CreateXEdit.Text), StrToInt(CreateYEdit.Text))
end;
//
procedure TCreateForm.createFile(xDim, yDim: Integer);
var
  x, y, i, j, temp: Integer;
begin
  if isFileOpened then
    MainForm.closeFileBtn.Click;
  if (isFileOpened = True) and (isFileChanged = True) then
    if Functions.MyMessageDlg('Сохранить текущий файл перед созданием нового?',
      mtInformation, [mbYes, mbNo], ['Да','Нет'], 'Подтверждение', MB_ICONWARNING) = mrYes then
        Files.Save(True);
  for i := 0 to (((xDim*yDim)*2)+1) do
    MainForm.loadingBuffer.Lines.Add('');
  MainForm.loadingBuffer.Lines.Strings[0] := IntToStr(xDim);
  MainForm.loadingBuffer.Lines.Strings[1] := IntToStr(yDim);

  // Глобальные переменные количества рядов и колонн в таблицах
  xTableDim := StrToInt(MainForm.loadingBuffer.Lines.Strings[0]);
  yTableDim := StrToInt(MainForm.loadingBuffer.Lines.Strings[1]);

  MainForm.fileSaveDialog.FileName := '';

  Selections.Clear;
  isFileOpened := True;
  isFileNew := True;
  isFileChanged := False;
  // readjustCheck := False;
  MainForm.Caption:='Анализатор (Несохраненный файл)';
  MainForm.saveAsFileBtn.Enabled := True;
  MainForm.saveFileBtn.Enabled := True;
  MainForm.closeFileBtn.Enabled := True;
  MainForm.exportToTablesBtn.Enabled := True;
  if (isPythonInitialized = True) and (isFileOpened = True) then
    MainForm.exportToIsolinesBtn.Enabled := True
  else
    MainForm.exportToIsolinesBtn.Enabled := False;
  MainForm.tableA.ColCount := xTableDim+1;
  MainForm.tableA.RowCount := yTableDim+1;
  MainForm.tableB.ColCount := xTableDim+1;
  MainForm.tableB.RowCount := yTableDim+1;
  MainForm.tableD.ColCount := xTableDim+1;
  MainForm.tableD.RowCount := yTableDim+1;
  MainForm.tableR.ColCount := xTableDim+1;
  MainForm.tableR.RowCount := yTableDim+1;
  MainForm.tableAB.ColCount := xTableDim+1;
  MainForm.tableAB.RowCount := (yTableDim*2)+1;
  MainForm.tableDR.ColCount := xTableDim+1;
  MainForm.tableDR.RowCount := (yTableDim*2)+1;

  for i:=0 to (MainForm.tableA.ColCount * MainForm.tableA.RowCount) do
  begin
    MainForm.tableA.Cols[i].Clear;
    MainForm.tableA.Rows[i].Clear;
    MainForm.tableB.Cols[i].Clear;
    MainForm.tableB.Rows[i].Clear;
    MainForm.tableD.Cols[i].Clear;
    MainForm.tableD.Rows[i].Clear;
    MainForm.tableR.Cols[i].Clear;
    MainForm.tableR.Rows[i].Clear;;
  end;

  temp := yTableDim;
  for y:=0 to yTableDim do
  begin
    for x:=0 to xTableDim  do
    begin
      MainForm.tableA.Cells[x+1,0] := IntToStr(x+1);
      MainForm.tableA.Cells[0,y+1] := IntToStr(temp);
      MainForm.tableB.Cells[x+1,0] := IntToStr(x+1);
      MainForm.tableB.Cells[0,y+1] := IntToStr(temp);
      MainForm.tableD.Cells[x+1,0] := IntToStr(x+1);
      MainForm.tableD.Cells[0,y+1] := IntToStr(temp);
      MainForm.tableR.Cells[x+1,0] := IntToStr(x+1);
      MainForm.tableR.Cells[0,y+1] := IntToStr(temp);
      MainForm.tableA.Cells[x+1,y+1] := '0';
      MainForm.tableB.Cells[x+1,y+1] := '0';
      MainForm.tableD.Cells[x+1,y+1] := '0';
      MainForm.tableR.Cells[x+1,y+1] := '0';
    end;
    temp := temp - 1;
  end;

  for x:=0 to xTableDim  do
    MainForm.tableDR.Cells[x+1,0] := IntToStr(x+1);
  temp := yTableDim+1;
  for y:=1 to (yTableDim*2) do
  begin
    if (y mod 2) <> 0 then
    begin
      MainForm.tableDR.Cells[0,y] := 'D';
      temp := temp - 1;
    end
    else
    begin
      MainForm.tableDR.Cells[0,y] := 'R';
    end;
    MainForm.tableDR.Cells[0,y] := IntToStr(temp) + MainForm.tableDR.Cells[0,y];
  end;

  for x:=0 to xTableDim  do
    MainForm.tableAB.Cells[x+1,0] := IntToStr(x+1);
  temp := yTableDim+1;
  for y:=1 to (yTableDim*2) do
  begin
    if (y mod 2) <> 0 then
    begin
      MainForm.tableAB.Cells[0,y] := 'A';
      temp := temp - 1;
    end
    else
    begin
      MainForm.tableAB.Cells[0,y] := 'B';
    end;
    MainForm.tableAB.Cells[0,y] := IntToStr(temp) + MainForm.tableAB.Cells[0,y];
  end;

  for y:=0 to (yTableDim*2) do
    for x:=0 to xTableDim  do
    begin
      MainForm.tableDR.Cells[x+1,y+1] := '0';
    end;

  MainForm.toolsPnl.Visible := True;
  MainForm.toolsPnl.Enabled := True;
  MainForm.openTableABtn.Enabled := False;
  MainForm.openTableBBtn.Enabled := True;
  MainForm.openTableDBtn.Enabled := True;
  MainForm.openTableRBtn.Enabled := True;
  MainForm.openDecompositionFormBtn.Enabled := True;
  MainForm.openCompositionFormBtn.Enabled := True;
  MainForm.openTableABtn.Click;
  MainForm.tableA.Refresh;
  CreateForm.Close;
  MainForm.sigmaAEdit.Text := '?';
  MainForm.sigmaBEdit.Text := '?';
  MainForm.meanAEdit.Text := '?';
  MainForm.meanBEdit.Text := '?';
  Processing.Calculation(activeSelIndex);
  MainForm.InfoLineUpdate('Создан новый файл');
  Screen.Cursor := crDefault;
  MainForm.startPanel.Visible := False;
end;

// Разрешенные символы ================================ ПРОЦЕДУРА
procedure TCreateForm.CreateXEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', #13]) then
  begin
    Key := #0;
  end
end;

// Открытие формы ================================ ПРОЦЕДУРА
procedure TCreateForm.FormShow(Sender: TObject);
begin
  CreateXEdit.Text := '32';
  CreateYEdit.Text := '37';
end;

// Кнопка "Создать" заблокирована при пустом значении и нуле ================================ ПРОЦЕДУРА
procedure TCreateForm.CreateXEditChange(Sender: TObject);
begin
  if ((CreateXEdit.Text = '') or (StrToInt(CreateXEdit.Text) = 0)) or ((CreateYEdit.Text = '') or (StrToInt(CreateYEdit.Text) = 0))
   then (CreateButton.Enabled := False)
    else (CreateButton.Enabled := True);
end;

end.
