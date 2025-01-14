unit AutoSelectionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TAutoSelectionForm = class(TForm)
    GroupBox2: TGroupBox;
    GridPanel3: TGridPanel;
    Label4: TLabel;
    MethodCB: TComboBox;
    Label1: TLabel;
    CriteriaCB: TComboBox;
    StartSelectionBtn: TButton;
    ProgressBar: TProgressBar;
    Label2: TLabel;
    minCellNumEdit: TEdit;
    procedure StartSelectionBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure FormProcessing;
    procedure FormReset;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AutoSelectionForm: TAutoSelectionForm;

implementation

uses
  MainUnit, FunctionsUnit, Math, StrUtils, DateUtils, SelectionUnit, ProcessingUnit, TablesUnit;

{$R *.dfm}

procedure TAutoSelectionForm.FormProcessing;
begin
  StartSelectionBtn.Visible := False;
  ProgressBar.Visible := True;
  ProgressBar.Max := (xTableDim-1)*(yTableDim-1);
  ProgressBar.Position := 0;
  CriteriaCB.Enabled := False;
  MethodCB.Enabled := False;
  minCellNumEdit.Enabled := False;
end;

procedure TAutoSelectionForm.FormReset;
begin
  StartSelectionBtn.Visible := True;
  ProgressBar.Visible := False;
  CriteriaCB.Enabled := True;
//  MethodCB.Enabled := True;
  minCellNumEdit.Enabled := True;
  AutoSelectionForm.Caption := 'Автоподбор';
  StartSelectionBtn.Visible := True;
end;

procedure TAutoSelectionForm.FormShow(Sender: TObject);
begin
  FormReset;
end;

procedure TAutoSelectionForm.StartSelectionBtnClick(Sender: TObject);
var
  bestRange: array[0..4] of Integer;
  best: Integer;
  x, y, i, j: Integer;
  bestFound: Boolean;
  Condition: Boolean;

  tStart, tStop, tSum, tAv, tLeft: TDateTime;
  iterNum: Integer;

  function calculateCellNum: Integer;
  var
    num: Integer;
  begin
    num := (i+1) - x;
    num := num * ((j+1) - y);
    Result := num;
  end;

  function calculateFunction: Integer;
  var
    i, j: Integer;
    num: Integer;
  begin
    num := 0;
    Selections.Changed(activeSelIndex);
    for i:=1 to yTableDim do
      for j:=1 to xTableDim do
      begin
        try
          case CriteriaCB.ItemIndex of
            0: Condition := (StrToFloat(MainForm.tableD.Cells[j, i]) >= 1) and (StrToFloat(MainForm.tableD.Cells[j, i]) < 1.5);
            1: Condition := (StrToFloat(MainForm.tableD.Cells[j, i]) >= 1.5) and (StrToFloat(MainForm.tableD.Cells[j, i]) < 2);
            2: Condition := (StrToFloat(MainForm.tableD.Cells[j, i]) >= 2) and (StrToFloat(MainForm.tableD.Cells[j, i]) < 3);
            3: Condition := (StrToFloat(MainForm.tableD.Cells[j, i]) >= 3);
          end;

          if Condition then
            if (StrToFloat(MainForm.tableR.Cells[j, i]) < 0)
              and (not IsNaN(StrToFloat(MainForm.tableR.Cells[j, i]))) and
              (not IsNaN(StrToFloat(MainForm.tableD.Cells[j, i]))) and
              (not IsInfinite(StrToFloat(MainForm.tableR.Cells[j, i]))) and
              (not IsInfinite(StrToFloat(MainForm.tableD.Cells[j, i])))
              then
                num := num + 1;
        except
          AutoSelectionForm.Close;
        end;
      end;
    Result := num;
  end;

begin
  bestFound := False;
  FormProcessing;
  MainForm.InfoLineUpdate('Начат процесс поиска матрицы определения');

  with SelectionsList[activeSelIndex] do
  begin
    DefMatrixStartX := 1;
    DefMatrixStartY := 1;
    DefMatrixEndX := 1;
    DefMatrixEndY := 1;
    Name := MainForm.selNameEdit.Text;
  end;

  MainForm.selAddBtn.Click;
  MainForm.openTableDBtn.Click;
  MainForm.selNameEdit.Text := 'Выборка №' + IntToStr(activeSelIndex+1) + '* ';
  AutoSelectionForm.Caption := 'Автоподбор (Расчет оставшегося времени)';
  bestRange[0] := 0;
  tAv := 0;

  for y:=1 to yTableDim-1 do
  with SelectionsList[activeSelIndex] do
  begin
    tSum := tAv;
    iterNum := 1;

    for x:=1 to xTableDim-1 do
    begin
      ProgressBar.Position := ProgressBar.Position+1;
      tStart := Now;

      for j:=y+1 to yTableDim do
        for i:=x+1 to xTableDim do
      begin
        DefMatrixStartX := x;
        DefMatrixStartY := y;
        DefMatrixEndX := i;
        DefMatrixEndY := j;

        if calculateCellNum >= StrToInt(minCellNumEdit.Text) then
        begin
          best := calculateFunction;
          if (best > bestRange[0]) then
          begin
            bestFound := True;
            bestRange[0] := best;
            bestRange[1] := DefMatrixStartX;
            bestRange[2] := DefMatrixStartY;
            bestRange[3] := DefMatrixEndX;
            bestRange[4] := DefMatrixEndY;
          end;
        end;

        Application.ProcessMessages;
      end;

      tStop := Now - tStart;
      tSum := tSum + tStop;
      tAv := tSum/iterNum;
      tLeft := (yTableDim-y-1)*xTableDim*tAv;
      Inc(iterNum);
      AutoSelectionForm.Caption := 'Автоподбор (Осталось примерно ' + TimeToStr(TimeOf(tLeft)) + ')';
    end;
    MessageBeep(MB_ICONASTERISK);
  end;

  if bestFound then
  with SelectionsList[activeSelIndex] do
  begin
    DefMatrixStartX := bestRange[1];
    DefMatrixStartY := bestRange[2];
    DefMatrixEndX := bestRange[3];
    DefMatrixEndY := bestRange[4];

    Selections.Changed(activeSelIndex);
    Functions.MyMessageDlg('Найден расчетный диапазон.'+#13#10+'Количество значений, удовлетворяющих'+#13#10+'условию '+
      CriteriaCB.Text+': '+IntToStr(best)+#13#10+'Сохранена выборка "'+SelectionsList[activeSelIndex].Name+'"',
      mtInformation, [mbOk], ['Ок'], 'Подбор завершен', MB_ICONWARNING)
  end
  else
  with SelectionsList[activeSelIndex] do
  begin
    Selections.DelActive;
    Tables.ClearDR;
    Selections.Changed(activeSelIndex);
    Functions.MyMessageDlg('Расчетный диапазон не найден.'+#13#10+'Значений, удовлетворяющих условию'+#13#10+
      CriteriaCB.Text+' не найдено. ', mtError, [mbOk], ['Ок'], 'Подбор завершен', MB_ICONWARNING)
  end;

  MainForm.InfoLineUpdate('Процесс поиска матрицы определения завершен');
  FormReset;
  AutoSelectionForm.Close;
end;

end.
