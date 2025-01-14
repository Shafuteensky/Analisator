unit CompositionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, iniFiles, Vcl.Grids;

type
  TCompositionForm = class(TForm)
    GroupBox1: TGroupBox;
    NameEdit: TEdit;
    SearchButton: TButton;
    GroupBox2: TGroupBox;
    SelInsCB: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    compFirstXEdit: TEdit;
    compFirstYEdit: TEdit;
    compLastXEdit: TEdit;
    compLastYEdit: TEdit;
    OpenDialog1: TOpenDialog;
    SelOnlyCB: TCheckBox;
    InsertButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchButtonClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure SelInsCBClick(Sender: TObject);
    procedure SetCompCoord();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompositionForm: TCompositionForm;
  compCoord: array of integer;
  compxCol, compyCol: Integer;
  ini: TIniFile;

implementation

{$R *.dfm}

uses MainUnit, FunctionsUnit, SelectionUnit, TablesUnit, ParamsUnit;

// Открытие формы
procedure TCompositionForm.FormShow(Sender: TObject);
begin
  InsertButton.Enabled := False;
  with MainForm do
  begin
    selPnl.Enabled := False;
    selPnlLabel.Enabled := False;
    openTableDBtn.Enabled := False;
    openTableRBtn.Enabled := False;
  end;
  if isSelEditing then
    MainForm.selDeleteBtn.Click;
  SetLength(compCoord, 0);
  SetLength(compCoord, 4);

  Tables.SwitchToA;
  MainForm.toolBar.Enabled := False;
  OpenDialog1.FileName := '';
  NameEdit.Text := '';
  compFirstXEdit.Text := '';
  compFirstYEdit.Text := '';
  compLastXEdit.Text := '';
  compLastYEdit.Text := '';
  MainForm.InfoLineUpdate('Запущен модуль композиции',
    '(Выберите файл, затем правой кнопкой мыши по таблице выберите координату композиции)');
end;

// Закрытие формы
procedure TCompositionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Tables.SwitchToAB;
  with MainForm do
  begin
    selPnl.Enabled := True;
    selPnlLabel.Enabled := True;
    openTableDBtn.Enabled := True;
    openTableRBtn.Enabled := True;
  end;
  SetLength(compCoord, 0);
  MainForm.toolBar.Enabled := True;
end;

//==============================================================================

// Выбор файла
procedure TCompositionForm.SearchButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ini := TIniFile.Create(OpenDialog1.FileName);
    if ini.ReadInteger('Information', 'Version', 0) < ProgramVersion then
    begin
      Functions.MyMessageDlg('Выбранный файл устарел.'+sLineBreak+'Для его использования в модуле композиции'
      +sLineBreak+'откройте файл и заново сохраните.',
      mtError, [mbYes], ['Ок'], 'Несоответствие версий файла', MB_ICONERROR)
    end
    else
    begin
      compxCol := ini.ReadInteger('Information', 'SizeX', 0);
      compyCol := ini.ReadInteger('Information', 'SizeY', 0);

      NameEdit.Text := ExtractFileName(OpenDialog1.FileName);
      SetLength(compCoord, 0);
      SetLength(compCoord, 4);
      compFirstXEdit.Text := '';
      compFirstYEdit.Text := '';
      compLastXEdit.Text := '';
      compLastYEdit.Text := '';

      InsertButton.Enabled := False;
      Tables.Repaint();
    end;
  end;
end;

// Вставка
procedure TCompositionForm.InsertButtonClick(Sender: TObject);
var
  x, y, i: Integer;
  tableList, Selection: TStringList;
begin
  // Чтение из ini-файла
  tableList := TStringList.Create;
  tableList.StrictDelimiter := True;
  tableList.Delimiter := ';';
  with MainForm do
  begin
    // Вставка таблиц
    if not SelOnlyCB.Checked then
    for y := 1 to compyCol do
    begin
      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('TableA', IntToStr(y), '');
      for x := 1 to compxCol do
        if (y+compCoord[1]-1) > 0 then
          tableA.Cells[x+compCoord[0]-1, y+compCoord[1]-1] := tableList[x-1];

      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('TableB', IntToStr(y), '');
      for x := 1 to compxCol do
        if (y+compCoord[1]-1) > 0 then
          tableB.Cells[x+compCoord[0]-1, y+compCoord[1]-1] := tableList[x-1];
    end;

    // Вставка выборок
    if SelInsCB.Checked then
    begin
      Selection := TStringList.Create;
      Selection.StrictDelimiter := True;
      Selection.Delimiter := ';';
      for x := 0 to ini.ReadInteger('Information', 'SelNum', 0)-1 do
      begin
        SetLength(SelectionsList, Length(SelectionsList) + 1);
        SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
        with SelectionsList[Length(SelectionsList)-1] do
        begin
          Name := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Name', ''));

          Selection.Clear;
          Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'DefMatrix', ''));
          DefMatrixStartX := StrToInt(Selection[0])+compCoord[0]-1;
          DefMatrixStartY := StrToInt(Selection[1])+compCoord[1]-1;
          DefMatrixEndX := StrToInt(Selection[2])+compCoord[0]-1;
          DefMatrixEndY := StrToInt(Selection[3])+compCoord[1]-1;

          Selection.Clear;
          Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'CalcArea', ''));
          CalcAreaStartX := StrToInt(Selection[0])+compCoord[0]-1;
          CalcAreaStartY := StrToInt(Selection[1])+compCoord[1]-1;
          CalcAreaEndX := StrToInt(Selection[2])+compCoord[0]-1;
          CalcAreaEndY := StrToInt(Selection[3])+compCoord[1]-1;

          IsFixed := StrToBool(ini.ReadString('Selection'+IntToStr(x+1), 'IsFixed', ''));

          Selection.Clear;
          Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Sigmas', ''));
          SigmaA := StrToFloat(Selection[0]);
          SigmaB := StrToFloat(Selection[1]);

          Selection.Clear;
          Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Averages', ''));
          AverageA := StrToFloat(Selection[0]);
          AverageB := StrToFloat(Selection[1]);
        end;

        activeSelIndex := Length(SelectionsList)-1;
        Selections.Changed(activeSelIndex);
      end
    end;
  end;

  SetLength(compCoord, 0);
  SetLength(compCoord, 4);
  isFileChanged := True;
  MainForm.InfoLineUpdate('Произведена композиция файла "'+CompositionForm.OpenDialog1.FileName+'"');
end;

// Установка координат композиции
procedure TCompositionForm.SetCompCoord();
var
  StringGrid: ^TstringGrid;
  dr1, dr2, dr3, dr4: Integer;
begin
  begin
    dr1 := 2;
    dr2 := 3;
    dr3 := 0;
    dr4 := 1;
  end;

  with MainForm do
  begin
    if tableA.Visible then
      StringGrid := @tableA
    else if tableB.Visible then
      StringGrid := @tableB;
  end;

  compCoord[0] := StringGrid.Col;
  compCoord[1] := StringGrid.Row-compyCol+1;
  compCoord[2] := StringGrid.Col+compxCol-1;
  compCoord[3] := StringGrid.Row;

  compFirstXEdit.Text := IntToStr(StringGrid.Col);
  compFirstYEdit.Text := IntToStr(yTableDim-StringGrid.Row+1);
  compLastXEdit.Text := IntToStr(StringGrid.Col+compxCol-1);
  compLastYEdit.Text := IntToStr(yTableDim-(StringGrid.Row-compyCol));

  if (compCoord[0] <> 0) and not ((compCoord[1] < 1) or (compCoord[2] > xTableDim)) then
  begin
    InsertButton.Enabled := True;
    MainForm.insertCompBtn.Enabled := True;
  end
  else
  begin
    InsertButton.Enabled := False;
    MainForm.insertCompBtn.Enabled := False;
  end;
end;

//==============================================================================

procedure TCompositionForm.SelInsCBClick(Sender: TObject);
begin
  SelOnlyCB.Enabled := SelInsCB.Checked;
  SelOnlyCB.Checked := False;
end;

end.
