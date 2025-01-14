unit SelectionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, iniFiles,  Vcl.CheckLst, System.Math, System.Types, FMX.Utils;

type
  TDoubleArray = array of Double;
  TSelection = class
    DefMatrixStartX, DefMatrixStartY, DefMatrixEndX, DefMatrixEndY: Integer;
    CalcAreaStartX, CalcAreaStartY, CalcAreaEndX, CalcAreaEndY: Integer;
    Name: string;
    IsFixed: Boolean;
    SigmaA, SigmaB, AverageA, AverageB: Double;

    constructor Create;
    procedure SetDefMatrixStart(DefMatrixStartX, DefMatrixStartY: Integer);
    procedure SetDefMatrixEnd(DefMatrixEndX, DefMatrixEndY: Integer);
    procedure SetCalcAreaStart(CalcAreaStartX, CalcAreaStartY: Integer);
    procedure SetCalcAreaEnd(CalcAreaEndX, CalcAreaEndY: Integer);
    procedure SetName(Name: String);
    procedure SetFixed(IsFixed: Boolean);
    procedure CopyFrom(Selection: TSelection);
    procedure CoordFix();
  end;

  TSelections = class
    // Удалить активную выборку
    procedure DelActive;
    // Заполнение UI списка выборок
    procedure UIListFill(SelList: TCheckListBox);
    // Проверка на пересечение выбранных выборок
    function IsIntersect(SelList: TCheckListBox): Boolean;
    // Выбран ли хоть один элемент
    function IsActiveInUIList(CheckList: TCheckListBox): Boolean;
    // Получить строку с диапазонами выборки
    function GetRangesStr(Index: Integer): String;
    // Очистка массива выборки
    procedure Clear;
    // Переключение активной выборки
    procedure Changed(SelIndex: Integer; Joint: Boolean=False);
    // Проверка на наличие выборки
    procedure IsPresent();
    function IsExists: Boolean;
    // Элементы меню выборок по-умолчанию
    procedure SetVisuals(PrevB, NextB, NewB, DeleteB, fixedSigmasB, Reset: Boolean);
    // Установить количество выборок
    procedure SetNumber(Number: Integer);
    procedure Add;
  end;

var
  Selections: TSelections;

implementation

uses
  MainUnit, FunctionsUnit, ParamsUnit, SigmasTransferUnit, TablesUnit, ProcessingUnit;

constructor TSelection.Create;
begin
  DefMatrixStartX := 0;
  DefMatrixStartY := 0;
  DefMatrixEndX := 0;
  DefMatrixEndY := 0;

  CalcAreaStartX := 0;
  CalcAreaStartY := 0;
  CalcAreaEndX := 0;
  CalcAreaEndY := 0;

  Name := 'Новая выборка';
  IsFixed := False;

  SigmaA := 0;
  SigmaB := 0;
  AverageA := 0;
  AverageB := 0;
end;

procedure TSelection.SetDefMatrixStart(DefMatrixStartX, DefMatrixStartY: Integer);
begin
  self.DefMatrixStartX := DefMatrixStartX;
  self.DefMatrixStartY := DefMatrixStartY;
end;

procedure TSelection.SetDefMatrixEnd(DefMatrixEndX, DefMatrixEndY: Integer);
begin
  self.DefMatrixEndX := DefMatrixEndX;
  self.DefMatrixEndY := DefMatrixEndY;
end;

procedure TSelection.SetCalcAreaStart(CalcAreaStartX, CalcAreaStartY: Integer);
begin
  self.CalcAreaStartX := CalcAreaStartX;
  self.CalcAreaStartY := CalcAreaStartY;
end;

procedure TSelection.SetCalcAreaEnd(CalcAreaEndX, CalcAreaEndY: Integer);
begin
  self.CalcAreaEndX := CalcAreaEndX;
  self.CalcAreaEndY := CalcAreaEndY;
end;

procedure TSelection.SetName(Name: String);
begin
  self.Name := Name;
end;

procedure TSelection.SetFixed(IsFixed: Boolean);
begin
  self.IsFixed := IsFixed;
end;

procedure TSelection.CopyFrom(Selection: TSelection);
begin
  DefMatrixStartX := Selection.DefMatrixStartX;
  DefMatrixStartY := Selection.DefMatrixStartY;
  DefMatrixEndX := Selection.DefMatrixEndX;
  DefMatrixEndY := Selection.DefMatrixEndY;

  CalcAreaStartX := Selection.CalcAreaStartX;
  CalcAreaStartY := Selection.CalcAreaStartY;
  CalcAreaEndX := Selection.CalcAreaEndX;
  CalcAreaEndY := Selection.CalcAreaEndY;

  Name := Selection.Name;
  IsFixed := Selection.IsFixed;

  SigmaA := Selection.SigmaA;
  SigmaB := Selection.SigmaB;
  AverageA := Selection.AverageA;
  AverageB := Selection.AverageB;
end;

procedure TSelection.CoordFix;
begin
  if Length(SelectionsList) > 0 then
  begin
    if (((DefMatrixStartX + DefMatrixStartY) > 0) and
     ((DefMatrixEndX + DefMatrixEndY) > 0)) then
    begin
      if DefMatrixStartX > DefMatrixEndX then
      begin
        DefMatrixStartX := DefMatrixStartX + DefMatrixEndX;
        DefMatrixEndX := DefMatrixStartX - DefMatrixEndX;
        DefMatrixStartX := DefMatrixStartX - DefMatrixEndX;
      end;
      if DefMatrixStartY > DefMatrixEndY then
      begin
        DefMatrixStartY := DefMatrixStartY + DefMatrixEndY;
        DefMatrixEndY := DefMatrixStartY - DefMatrixEndY;
        DefMatrixStartY := DefMatrixStartY - DefMatrixEndY;
      end;
    end;
    if (((CalcAreaStartX + CalcAreaStartY) > 0) and
     ((CalcAreaEndX + CalcAreaEndY) > 0)) then
    begin
    if CalcAreaStartX > CalcAreaEndX then
      begin
        CalcAreaStartX := CalcAreaStartX + CalcAreaEndX;
        CalcAreaEndX := CalcAreaStartX - CalcAreaEndX;
        CalcAreaStartX := CalcAreaStartX - CalcAreaEndX;
      end;
      if CalcAreaStartY > CalcAreaEndY then
      begin
        CalcAreaStartY := CalcAreaStartY + CalcAreaEndY;
        CalcAreaEndY := CalcAreaStartY - CalcAreaEndY;
        CalcAreaStartY := CalcAreaStartY - CalcAreaEndY;
      end;
    end;
  end;
end;

// ================================================================

// Удалить активную выборку
procedure TSelections.DelActive;
var
  i, j: Integer;
begin
  isFileChanged := True;
  // Если не первая и не последняя
  if ((Length(SelectionsList) > (activeSelIndex+1)) and (activeSelIndex <> 0)) then
  begin
    for i := activeSelIndex to (Length(SelectionsList) - 2) do
      SelectionsList[i].CopyFrom(SelectionsList[i+1]);
    SetLength(SelectionsList, Length(SelectionsList)-1);
  end
  // Если первая и не последняя
  else if ((Length(SelectionsList) > (activeSelIndex+1)) and (activeSelIndex = 0)) then
  begin
    for i := activeSelIndex to (Length(SelectionsList) - 2) do
      SelectionsList[i].CopyFrom(SelectionsList[i+1]);
    SetLength(SelectionsList, Length(SelectionsList)-1);
  end
  // Если не первая и последняя
  else if ((Length(SelectionsList) = (activeSelIndex+1)) and (activeSelIndex <> 0)) then
  begin
    SetLength(SelectionsList, Length(SelectionsList)-1);
    Dec(activeSelIndex);
  end
  // Если первая и последняя
  else if ((Length(SelectionsList) = (activeSelIndex+1)) and (activeSelIndex = 0)) then
  begin
    SetLength(SelectionsList, 0);
  end;
  if Length(SelectionsList) = 0 then
  begin
    MainForm.selDeleteBtn.Enabled := False;
  end;
  MainForm.selAddBtn.Enabled := True;
  // Если количество выборок меньше максимального
  if Length(SelectionsList) < MaxSel then
  begin
    MainForm.selPnlLabel.Caption := 'Выборки';
  end;
  MainForm.InfoLineUpdate('Выборка удалена');
end;

// Заполнение UI списка выборок
procedure TSelections.UIListFill(SelList: TCheckListBox);
var
  i: Integer;
begin
  SelList.Clear;
  for i := 0 to Length(SelectionsList)-1 do
  begin
    SelList.Items.Add(GetRangesStr(i));
  end;
end;

// Проверка на пересечение выбранных выборок
function TSelections.IsIntersect(SelList: TCheckListBox): Boolean;
var
  i, j: Integer;
  intersection: Boolean;
  rect1, rect2: TRect;
begin
  intersection := False;
  for i := 0 to SelList.Items.Count - 1 do
    if SelList.Checked[i] then
      for j := 0 to SelList.Items.Count - 1 do
        if j <> i then
          if SelList.Checked[j] then
          begin
            rect1 := Rect(SelectionsList[i].CalcAreaStartX, SelectionsList[i].CalcAreaStartY,
              SelectionsList[i].CalcAreaEndX, SelectionsList[i].CalcAreaEndY);
            rect2 := Rect(SelectionsList[j].CalcAreaStartX, SelectionsList[j].CalcAreaStartY,
              SelectionsList[j].CalcAreaEndX, SelectionsList[j].CalcAreaEndY);
            if IntersectRect(rect1, rect2)  then
              intersection := True;
          end;
  if intersection then
  begin
    if Functions.MyMessageDlg('Площади некоторых выборок пересекаются.'+sLineBreak+'Продолжить несмотря на это?'
      +sLineBreak+sLineBreak+'В случае продолжения таблицы будут расчитаны по'+sLineBreak+
      'порядку расположения выборок (сверху вниз).',
      mtWarning, [mbYes, mbNo], ['Да','Нет'], 'Пересечение', MB_ICONWARNING) = mrYes then
      Result := True
    else
      Result := False;
  end
  else
    Result := True;
end;

// Выбран ли хоть один элемент
function TSelections.IsActiveInUIList(CheckList: TCheckListBox): Boolean;
var
  i: Integer;
  AnyChecked: Boolean;
begin
  AnyChecked := False;
  for i := 0 to CheckList.Items.Count - 1 do
    if CheckList.Checked[i] then
      AnyChecked := True;
  Result := AnyChecked;
end;

// Получить строку с диапазонами выборки
function TSelections.GetRangesStr(Index: Integer): String;
begin
  if not SelectionsList[Index].IsFixed then
    Result := SelectionsList[Index].Name+' (Q['+IntToStr(SelectionsList[Index].DefMatrixStartX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].DefMatrixStartY)+'-'+IntToStr(SelectionsList[Index].DefMatrixEndX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].DefMatrixEndY)+'], S['+IntToStr(SelectionsList[Index].CalcAreaStartX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].CalcAreaStartY)+'-'+IntToStr(SelectionsList[Index].CalcAreaEndX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].CalcAreaEndY)+'])'
  else
    Result := SelectionsList[Index].Name+', Фикс. δμ S['+IntToStr(SelectionsList[Index].CalcAreaStartX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].CalcAreaStartY)+'-'+IntToStr(SelectionsList[Index].CalcAreaEndX)+':'+IntToStr(yTableDim+1 -
      SelectionsList[Index].CalcAreaEndY)+'])'
end;

// Очистка массива выборки ================================ ПРОЦЕДУРА
procedure TSelections.Clear;
begin
  SetLength(SelectionsList, 0);
  Selections.SetVisuals(False, False, True, False, False, True);
end;

// Переключение активной выборки ================================ ПРОЦЕДУРА
procedure TSelections.Changed(SelIndex: Integer; Joint: Boolean=False);
begin
  isSelSwitched := True;
  if (Length(SelectionsList) = 0) then
  begin
    Selections.SetVisuals(False, False, True, False, False, True);
  end
  else if isSelEditing then
  begin
    // Если диапазон выборки существует
    if ((not SelectionsList[activeSelIndex].IsFixed) and
     ((SelectionsList[activeSelIndex].DefMatrixStartX+SelectionsList[activeSelIndex].DefMatrixStartY) > 0)
     and ((SelectionsList[activeSelIndex].DefMatrixEndX+SelectionsList[activeSelIndex].DefMatrixEndY) > 0))
     // или установлены фиксированные значения
     or ((SelectionsList[activeSelIndex].IsFixed) and (Length(MainForm.sigmaAEdit.Text) <> 0) and
     (Length(MainForm.sigmaBEdit.Text) <> 0) and
     (Length(MainForm.meanAEdit.Text) <> 0) and (Length(MainForm.meanBEdit.Text) <> 0)) then
      Selections.SetVisuals(False, False, True, True, True, False)
    else
      Selections.SetVisuals(False, False, False, True, True, False);
  end
  else
  begin
    SelectionsList[activeSelIndex].CoordFix;
    MainForm.selDeleteBtn.Enabled := True;
    // Если не первый и не последний
    if (((activeSelIndex < Length(SelectionsList)-1) and (activeSelIndex > 0))) then
    begin
      Selections.SetVisuals(True, True, True, True, False, False);
    end
    // Если первый и не последний
    else if (((activeSelIndex < Length(SelectionsList)-1) and (activeSelIndex = 0))) then
    begin
      Selections.SetVisuals(False, True, True, True, False, False);
    end
    // Если не первый и последний
    else if (((activeSelIndex = Length(SelectionsList)-1) and (activeSelIndex > 0))) then
    begin
      Selections.SetVisuals(True, False, True, True, False, False);
    end
    // Если первый и последний
    else if (((activeSelIndex = Length(SelectionsList)-1) and (activeSelIndex = 0))) then
    begin
      Selections.SetVisuals(False, False, True, True, False, False);
    end;

    if SelectionsList[activeSelIndex].IsFixed then
    begin
      MainForm.selFirstQXEdit.Text := 'F';
      MainForm.selFirstQYEdit.Text := 'F';
      MainForm.selLastQXEdit.Text := 'F';
      MainForm.selLastQYEdit.Text := 'F';
    end
    else
    begin
      MainForm.selFirstQXEdit.Text := IntToStr(SelectionsList[activeSelIndex].DefMatrixStartX);
      MainForm.selFirstQYEdit.Text := IntToStr(MainForm.tableA.RowCount - SelectionsList[activeSelIndex].DefMatrixStartY);
      MainForm.selLastQXEdit.Text := IntToStr(SelectionsList[activeSelIndex].DefMatrixEndX);
      MainForm.selLastQYEdit.Text := IntToStr(MainForm.tableA.RowCount - SelectionsList[activeSelIndex].DefMatrixEndY);
    end;

    MainForm.selFirstSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaStartX);
    MainForm.selFirstSYEdit.Text := IntToStr(MainForm.tableA.RowCount - SelectionsList[activeSelIndex].CalcAreaStartY);
    MainForm.selLastSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaEndX);
    MainForm.selLastSYEdit.Text := IntToStr(MainForm.tableA.RowCount - SelectionsList[activeSelIndex].CalcAreaEndY);

    MainForm.fixedSigmasCB.Checked := SelectionsList[activeSelIndex].IsFixed;
    MainForm.selNameEdit.Text := SelectionsList[activeSelIndex].Name;

    if Joint then
      Processing.Calculation(SelIndex)
    else
    begin
      Tables.ClearDR;
      Processing.Calculation(SelIndex);
    end;
  end;

  Tables.Repaint;
end;

// Проверка на наличие выборки -------------------------------- ПРОЦЕДУРА
procedure TSelections.IsPresent();
begin
  // Выборка есть
  if (Length(SelectionsList) > 0) and (Length(SelectionsList) < MaxSel) then
    MainForm.selDeleteBtn.Enabled := True
  // Выборки нет
  else
    MainForm.selDeleteBtn.Enabled := False;
end;

function TSelections.IsExists: Boolean;
begin
  if Length(SelectionsList) > 0 then Result := True
  else Result := False;
end;

// Элементы меню выборок по-умолчанию
procedure TSelections.SetVisuals(PrevB, NextB, NewB, DeleteB, fixedSigmasB, Reset: Boolean);
begin
  with MainForm do
  begin
    selPrevBtn.Enabled := PrevB;
    selNextBtn.Enabled := NextB;
    selAddBtn.Enabled := NewB;
    selDeleteBtn.Enabled := DeleteB;
    fixedSigmasCB.Enabled := fixedSigmasB;

    if Reset then
    begin
      selFirstQXEdit.Text := 'X';
      selFirstQYEdit.Text := 'Y';
      selLastQXEdit.Text := 'X';
      selLastQYEdit.Text := 'Y';
      selFirstSXEdit.Text := 'X';
      selFirstSYEdit.Text := 'Y';
      selLastSXEdit.Text := 'X';
      selLastSYEdit.Text := 'Y';
      sigmaAEdit.Text := '?';
      sigmaBEdit.Text := '?';
      meanAEdit.Text := '?';
      meanBEdit.Text := '?';
      selNameEdit.Text := '';
      fixedSigmasCB.Checked := False;
    end;

    if (Length(SelectionsList) > 0) and not IsSelEditing then
      DoReviseBtn.Enabled := True
    else
      DoReviseBtn.Enabled := False;
    if IsSelEditing then
      Do5RevisesBtn.Enabled := False
    else
      Do5RevisesBtn.Enabled := True;

  end;
end;

// Установить количество выборок
procedure TSelections.SetNumber(Number: Integer);
var
  i: Integer;
begin
  if (Number = 0) or (Number < Length(SelectionsList)) then
    SetLength(SelectionsList, Number)
  else if Number > Length(SelectionsList) then
    for i := Length(SelectionsList) to Number do
    begin
      SetLength(SelectionsList, Length(SelectionsList)+1);
      SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
    end;
end;

procedure TSelections.Add;
begin
  SetLength(SelectionsList, Length(SelectionsList)+1);
  SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
end;

end.
