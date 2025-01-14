unit TablesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTables = class(TObject)
    // Переключение между таблицами
    procedure Activate(A, B, AB, D, R, DR: Boolean);
    // Перерисовка ячеек таблиц
    procedure Repaint();
    // Заполнение координат сеток
    procedure DrawCoords();
    // Переключение таблиц во время операций отметки
    procedure SwitchToA;
    procedure SwitchToAB;
    // Очистка таблиц DR
    procedure ClearDR;
    // Не пуста ли таблица (не только ли нули)
    function IsNotOnlyZerosData(table: TStringGrid): Boolean;
    // Перенос таблиц AB
    procedure ABTransfer(Variant: String);
  end;

var
  Tables: TTables;

implementation

uses
  MainUnit, FunctionsUnit, SettingsUnit, SelectionUnit;

// Переключение между таблицами -------------------------------- ПРОЦЕДУРА
procedure TTables.Activate(A, B, AB, D, R, DR: Boolean);
begin
  with MainForm do
  begin
    tableA.Enabled := A;
    tableA.Visible := A;
    tableB.Enabled := B;
    tableB.Visible := B;
    tableAB.Enabled := AB;
    tableAB.Visible := AB;
    tableD.Enabled := D;
    tableD.Visible := D;
    tableR.Enabled := R;
    tableR.Visible := R;
    tableDR.Enabled := DR;
    tableDR.Visible := DR;
    openTableABtn.Enabled := not (A or AB);
    openTableBBtn.Enabled := not B;
    openTableDBtn.Enabled := not (D or DR);
    openTableRBtn.Enabled := not R;
  end;
end;

// Перерисовка ячеек таблиц -------------------------------- ПРОЦЕДУРА
procedure TTables.Repaint();
begin
  if Length(SelectionsList) > 0 then
    SelectionsList[activeSelIndex].CoordFix; // Правка координат диапазона
  with MainForm do
  begin
    if tableA.Visible then
      tableA.Repaint
    else if tableB.Visible then
      tableB.Repaint
    else if tableD.Visible then
      tableD.Repaint
    else if tableR.Visible then
      tableR.Repaint
    else if tableAB.Visible then
      tableAB.Repaint
    else if tableDR.Visible then
      tableDR.Repaint;
  end;
end;


// Заполнение координат сеток
procedure TTables.DrawCoords();
var
  x, y, temp: Integer;
begin
  with mainForm do
  begin
    // Задание количества рядов и колоон таблицам (+1 для фиксированных значений - координат)
    tableA.ColCount := xTableDim+1;
    tableA.RowCount := yTableDim+1;
    tableB.ColCount := xTableDim+1;
    tableB.RowCount := yTableDim+1;
    tableD.ColCount := xTableDim+1;
    tableD.RowCount := yTableDim+1;
    tableR.ColCount := xTableDim+1;
    tableR.RowCount := yTableDim+1;
    // То же самое, для расширенных таблиц
    tableAB.ColCount := xTableDim+1;
    tableAB.RowCount := (yTableDim*2)+1;
    tableDR.ColCount := xTableDim+1;
    tableDR.RowCount := (yTableDim*2)+1;
    // Заполнение стандартных таблиц координатными значениями
    temp := yTableDim;
    for y:=0 to yTableDim do
    begin
      for x:=0 to xTableDim do
      begin
        tableA.Cells[x+1,0] := IntToStr(x+1);
        tableA.Cells[0,y+1] := IntToStr(temp);
        tableB.Cells[x+1,0] := IntToStr(x+1);
        tableB.Cells[0,y+1] := IntToStr(temp);
        tableD.Cells[x+1,0] := IntToStr(x+1);
        tableD.Cells[0,y+1] := IntToStr(temp);
        tableR.Cells[x+1,0] := IntToStr(x+1);
        tableR.Cells[0,y+1] := IntToStr(temp);
      end;
      temp := temp - 1;
    end;
    // То же самое, для расширенных аблиц
    for y:=0 to xTableDim  do
      tableDR.Cells[y+1,0] := IntToStr(y+1);
    temp := yTableDim+1;
    for y:=1 to (yTableDim*2) do
    begin
      if (y mod 2) <> 0 then
      begin
        tableDR.Cells[0,y] := 'D';
        temp := temp - 1;
      end
      else
      begin
        tableDR.Cells[0,y] := 'R';
      end;
      tableDR.Cells[0,y] := IntToStr(temp) + tableDR.Cells[0,y];
    end;
    for x:=0 to xTableDim  do
      tableAB.Cells[x+1,0] := IntToStr(x+1);
    temp := yTableDim+1;
    for y:=1 to (yTableDim*2) do
    begin
      if (y mod 2) <> 0 then
      begin
        tableAB.Cells[0,y] := 'A';
        temp := temp - 1;
      end
      else
      begin
        tableAB.Cells[0,y] := 'B';
      end;
      tableAB.Cells[0,y] := IntToStr(temp) + tableAB.Cells[0,y];
    end;
  end;
end;

// Переключение таблиц во время операций отметки
procedure TTables.SwitchToA;
begin
  with MainForm do
  begin
    if SettingsForm.ABCheckBox.Checked = True then
    begin
      openTableABtn.Caption := 'A';
      openTableABtn.Click;
      openTableABtn.Caption := 'AB';
    end
    else if (not openTableDBtn.Enabled) or (not openTableRBtn.Enabled) then
    begin
      openTableABtn.Click;
    end;
    openTableDBtn.Enabled := False;
    openTableRBtn.Enabled := False;
  end;
end;
// ===
procedure TTables.SwitchToAB;
begin
  with MainForm do
  begin
    if SettingsForm.ABCheckBox.Checked = True then
    begin
      openTableABtn.Click;
      openTableABtn.Visible := True;
      openTableBBtn.Visible := False;
    end;
    openTableDBtn.Enabled := True;
    openTableRBtn.Enabled := True;
  end;
end;

// Очистка таблиц DR
procedure TTables.ClearDR;
var
  x, y: Integer;
begin
  for x:=0 to xTableDim do
    for y:=0 to yTableDim do
    begin
      MainForm.tableD.Cells[x+1,y+1] := '0';
      MainForm.tableR.Cells[x+1,y+1] := '0';
    end;
  for x:=0 to (xTableDim*2) do
    for y:=0 to yTableDim do

      MainForm.tableDR.Cells[x+1,y+1] := '0';
end;

// Не пуста ли таблица (не только ли нули)
function TTables.IsNotOnlyZerosData(table: TStringGrid): Boolean;
var
  i, j: Integer;
begin
  result := False;
  for j := 1 to yTableDim do
    for i := 1 to xTableDim  do
    begin
      if (table.Cells[i, j] <> '0') then
        result := True;
    end;
end;

// Перенос таблиц AB ================================ ПРОЦЕДУРА
procedure TTables.ABTransfer(Variant: String);
var
  x, y, temp: Integer;
begin
  Screen.Cursor := crHourGlass;
  temp := 1;
  // Из А и В в АВ
  if Variant = 'to AB' then
  begin
    for y:=1 to yTableDim*2 do
    begin
      for x:=1 to xTableDim  do
      begin
        if (y mod 2) <> 0 then
        begin
          temp := (y div 2) + 1;
          MainForm.tableAB.Cells[x,y] := MainForm.tableA.Cells[x, temp];
        end
        else
          MainForm.tableAB.Cells[x,y] := MainForm.tableB.Cells[x, temp];
      end;
      if (y mod 2) = 0 then
        temp := temp + 1;
    end;
  end;
  // Из АВ в А и В
  if Variant = 'to A and B' then
  begin
    for y:=1 to yTableDim*2 do
    begin
      for x:=1 to xTableDim  do
      begin
        if (y mod 2) <> 0 then
        begin
          MainForm.tableA.Cells[x, temp] := MainForm.tableAB.Cells[x, y];
        end
        else
        begin
          MainForm.tableB.Cells[x, temp] := MainForm.tableAB.Cells[x, y];
        end;
      end;
      if (y mod 2) = 0 then
        temp := temp + 1;
    end;
  end;
  Screen.Cursor := crDefault;
end;

end.
