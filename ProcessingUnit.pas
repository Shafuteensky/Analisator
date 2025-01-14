unit ProcessingUnit;

interface

uses
   Winapi.Windows, Vcl.Forms, System.SysUtils, iniFiles, System.Classes, Vcl.Dialogs, Vcl.Graphics;

type
  TDoubleArray = array of Double;
  TProcessing = class(TForm)
    procedure Calculation(SelIndex: Integer);
    // Расчет сигм
    procedure ComputeSigmas(Index: Integer);
    // Получить значения сигм и средих выборки
    function GetSigmas(Index: Integer): TDoubleArray;
    // Получить строку с сигмами и средими выборки
    function GetSigmasStr(Index: Integer): String;
    // Загрузить значения сигм и средних из стороннего файла
    procedure LoadSigmasFromFile(FileName: string);
    // Поля сигм и средних на редактирование или нет
    procedure SetVisuals(isEditing: Boolean);
  end;

var
  Processing: TProcessing;

implementation

uses
  SelectionUnit, MainUnit, Math, SigmasTransferUnit, FunctionsUnit, Vcl.Controls, TablesUnit;

// Обработка данных ================================ ПРОЦЕДУРА
procedure TProcessing.Calculation(SelIndex: Integer);
var
  i, j, temp: Integer;
  aMean, bMean, aSigma, bSigma: Double;
  isTableAEmpty, isTableBEmpty: Boolean;

// ТЕЛО --------------------------------
begin
  Screen.Cursor := crHourGlass;

  isTableAEmpty := True;
  isTableBEmpty := True;

  for i := 1 to yTableDim do
    for j := 1 to xTableDim  do
    begin
      if (MainForm.tableA.Cells[j, i] <> '0') then
        isTableAEmpty := False;
      if (MainForm.tableB.Cells[j, i] <> '0') then
        isTableBEmpty := False;
    end;

  if (isSelSwitched = True) and (Length(SelectionsList) <> 0) then
  begin
    SelectionsList[activeSelIndex].CoordFix;
    if ((isTableAEmpty = False) and (isTableBEmpty = False)) then
    begin
      Processing.ComputeSigmas(SelIndex);

      aSigma := SelectionsList[SelIndex].SigmaA;
      bSigma := SelectionsList[SelIndex].SigmaB;
      aMean := SelectionsList[SelIndex].AverageA;
      bMean := SelectionsList[SelIndex].AverageB;

      MainForm.sigmaAEdit.Text := FloatToStrF(aSigma, ffFixed, 5, 4);
      MainForm.sigmaBEdit.Text := FloatToStrF(bSigma, ffFixed, 5, 4);
      MainForm.meanAEdit.Text := FloatToStrF(aMean, ffFixed, 5, 4);
      MainForm.meanBEdit.Text := FloatToStrF(bMean, ffFixed, 5, 4);

      MainForm.sigmaBEdit.Hint := 'Сигма (B) = ' + MainForm.sigmaBEdit.Text;
      MainForm.meanBEdit.Hint := 'Среднее значение (B) = ' + MainForm.meanBEdit.Text;

      // Расчет и заполнение D и R *******************************************
      for i := SelectionsList[SelIndex].CalcAreaStartY to SelectionsList[SelIndex].CalcAreaEndY do
        for j := SelectionsList[SelIndex].CalcAreaStartX to SelectionsList[SelIndex].CalcAreaEndX do
        begin
         MainForm.tableD.Cells[j, i] := FloatToStrF((((StrToFloat(MainForm.tableA.Cells[j,i]) - aMean) / aSigma) -
            ((StrToFloat(MainForm.tableB.Cells[j,i]) - bMean) / bSigma)), ffFixed, 3, 2);
          MainForm.tableR.Cells[j, i] := FloatToStrF((((StrToFloat(MainForm.tableA.Cells[j,i]) - aMean) / aSigma) *
            ((StrToFloat(MainForm.tableB.Cells[j,i]) - bMean) / bSigma)), ffFixed, 3, 2);
        end;

      // Совмещение D и R в DR
      temp := 1;
      for i:=1 to yTableDim*2 do
      begin
        for j:=1 to xTableDim  do
        begin
          if (i mod 2) <> 0 then
          begin
            temp := (i div 2) + 1;
            MainForm.tableDR.Cells[j,i] := MainForm.tableD.Cells[j, temp];
          end
          else
          begin
            MainForm.tableDR.Cells[j,i] := MainForm.tableR.Cells[j, temp];
          end;
        end;
      end;
    end;
    isSelSwitched := False;
  end
  else
    Tables.ClearDR;

  if (((isTableAEmpty = True) or (isTableBEmpty = True)) and (Length(SelectionsList) = 0)) then
    MainForm.InfoLineUpdate('Рассчет не произведен: недостаточно данных; нет расчетного диапазона',
      ' (Заполните таблицы A и/или B; Для произведения рассчета необходимо создать выборку)', clRed)
  else if (((isTableAEmpty = False) and (isTableBEmpty = False)) and (Length(SelectionsList) = 0)) then
    MainForm.InfoLineUpdate('Рассчет не произведен: нет расчетного диапазона',
      ' (Для произведения рассчета необходимо создать выборку)', clRed)
  else if ((isTableAEmpty = True) or (isTableBEmpty = True)) then
    MainForm.InfoLineUpdate('Рассчет не произведен: недостаточно данных', ' (Заполните таблицы A и/или B)', clRed)
  else
    MainForm.InfoLineUpdate('Произведен рассчет');

  Screen.Cursor := crDefault;
end;

// Расчет сигм
procedure TProcessing.ComputeSigmas(Index: Integer);
var
  Sigmas: TDoubleArray;
begin
  // Расчет средних значений
  if not SelectionsList[Index].IsFixed then
  begin
    Sigmas := GetSigmas(Index);
    SelectionsList[Index].SigmaA := roundTo(Sigmas[0], -4);
    SelectionsList[Index].SigmaB := roundTo(Sigmas[1], -4);
    SelectionsList[Index].AverageA := roundTo(Sigmas[2], -4);
    SelectionsList[Index].AverageB := roundTo(Sigmas[3], -4);
  end;
end;

// Получить значения сигм и средих выборки
function TProcessing.GetSigmas(Index: Integer): TDoubleArray;
var
 temp, aAverage, bAverage, tempA, tempB, aSigma, bSigma: Double;
 x, y, n: Integer;
begin
  with MainForm do
  begin
    if not SelectionsList[Index].IsFixed then
    begin
      // Расчет средних значений
      n := ((SelectionsList[Index].DefMatrixEndX - SelectionsList[Index].DefMatrixStartX) + 1) *
        ((SelectionsList[Index].DefMatrixEndY - SelectionsList[Index].DefMatrixStartY) + 1);
      temp := 0;
      aAverage := 0;
      bAverage := 0;
      for x := SelectionsList[Index].DefMatrixStartX to SelectionsList[Index].DefMatrixEndX do
        for y := SelectionsList[Index].DefMatrixStartY to SelectionsList[Index].DefMatrixEndY  do
        begin
          tempA := StrToFloat(tableA.Cells[x, y]);
          tempB := StrToFloat(tableB.Cells[x, y]);
          aAverage := aAverage + tempA;
          bAverage := bAverage + tempB;
        end;
      aAverage := aAverage / n;
      bAverage := bAverage / n;

      // Расчет сигм
      temp := 0;
      tempA := 0;
      for x := SelectionsList[Index].DefMatrixStartX to SelectionsList[Index].DefMatrixEndX do
        for y := SelectionsList[Index].DefMatrixStartY to SelectionsList[Index].DefMatrixEndY  do
        begin
          tempA := StrToFloat(tableA.Cells[x, y]);
          temp := temp + (sqr(tempA - aAverage));
        end;
      aSigma := sqrt(temp/n);
      temp := 0;
      tempB := 0;
      for x := SelectionsList[Index].DefMatrixStartX to SelectionsList[Index].DefMatrixEndX do
        for y := SelectionsList[Index].DefMatrixStartY to SelectionsList[Index].DefMatrixEndY  do
        begin
          tempB := StrToFloat(tableB.Cells[x, y]);
          temp := temp + (sqr(tempB - bAverage));
        end;
      bSigma := sqrt(temp/n);
    end
    else
    begin
      aSigma := SelectionsList[Index].SigmaA;
      bSigma := SelectionsList[Index].SigmaB;
      aAverage := SelectionsList[Index].AverageA;
      bAverage := SelectionsList[Index].AverageB;
    end;
  end;
  Result := [roundTo(aSigma, -4), roundTo(bSigma, -4), roundTo(aAverage, -4),
    roundTo(bAverage, -4)]
end;

// Получить строку с сигмами и средими выборки
function TProcessing.GetSigmasStr(Index: Integer): String;
var
  Arr: TDoubleArray;
begin
  Arr := GetSigmas(Index);
  Result := 'δa='+FloatToStrF(Arr[0], ffFixed, 5, 4)+'; δb='+FloatToStrF(Arr[1], ffFixed, 5, 4)+
    '; μа='+FloatToStrF(Arr[2], ffFixed, 5, 4)+'; μb='+FloatToStrF(Arr[3], ffFixed, 5, 4);
end;

// Загрузить значения сигм и средних из стороннего файла
procedure TProcessing.LoadSigmasFromFile(FileName: string);
var
  i: integer;
  ini: TIniFile;
  Selection: TStringList;
begin
  ini := TIniFile.Create(FileName);
  if StrToInt(ini.ReadString('Information', 'SelNum', '0')) > 0 then
  begin
    Selection := TStringList.Create;
    Selection.StrictDelimiter := True;
    Selection.Delimiter := ';';
    if StrToInt(ini.ReadString('Information', 'SelNum', '0')) = 1 then
    begin
      with MainForm do
      begin
        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection1', 'Sigmas', ''));
        sigmaAEdit.Text := (Selection[0]);
        sigmaBEdit.Text := (Selection[1]);

        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection1', 'Averages', ''));
        meanAEdit.Text := (Selection[0]);
        meanBEdit.Text := (Selection[1]);
      end;
    end
    else
    begin
      SigmasTransferForm.ShowModal;
    end;
  end
  else
    Functions.MyMessageDlg('В выбранном файле отсутствуют выборки!',
      mtError, [mbYes], ['ОК'], 'Ошибка загрузки значений', MB_ICONERROR);
end;

// Поля сигм и средних на редактирование или нет
procedure TProcessing.SetVisuals(isEditing: Boolean);
begin
  with MainForm do
  begin
    sigmaAEdit.ReadOnly := not isEditing;
    sigmaBEdit.ReadOnly := not isEditing;
    meanAEdit.ReadOnly := not isEditing;
    meanBEdit.ReadOnly := not isEditing;

    if isEditing then
    begin
      sigmaAEdit.Color := clWhite;
      sigmaBEdit.Color := clWhite;
      meanAEdit.Color := clWhite;
      meanBEdit.Color := clWhite;

      sigmaAEdit.Text := '';
      sigmaBEdit.Text := '';
      meanAEdit.Text := '';
      meanBEdit.Text := '';
    end
    else
    begin
      sigmaAEdit.Color := clBtnFace;
      sigmaBEdit.Color := clBtnFace;
      meanAEdit.Color := clBtnFace;
      meanBEdit.Color := clBtnFace;

      sigmaAEdit.Text := '?';
      sigmaBEdit.Text := '?';
      meanAEdit.Text := '?';
      meanBEdit.Text := '?';
    end;
  end;
end;

end.
