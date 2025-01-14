unit ExportToTablesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Math, U3Dpolys,
  Vcl.CheckLst;

type
  TExportToTablesForm = class(TForm)
    GroupBox3: TGroupBox;
    SignatureEdit: TEdit;
    GroupBox4: TGroupBox;
    PictureRadioButton: TRadioButton;
    ExcelRadioButton: TRadioButton;
    PicVarPanel: TPanel;
    A4RadioButton: TRadioButton;
    A4mRadioButton: TRadioButton;
    PrevievImageE: TImage;
    PrevievImage1: TImage;
    PrevievImage4: TImage;
    Panel1: TPanel;
    ClearSignatureButton: TButton;
    UseFileNameButton: TButton;
    A2RadioButton: TRadioButton;
    PrevievImage1А2: TImage;
    ImportButton: TButton;
    GroupBox5: TGroupBox;
    ColorCheckBox: TCheckBox;
    ColorScheme2: TRadioButton;
    ColorScheme3: TRadioButton;
    ColorScheme1: TRadioButton;
    ImportProgressBar: TProgressBar;
    GroupBox8: TGroupBox;
    GridPanel1: TGridPanel;
    TabABCheckBox: TCheckBox;
    TabDRCheckBox: TCheckBox;
    SelectionGB: TGroupBox;
    SelectionCLB: TCheckListBox;
    ModeGB: TGroupBox;
    ModeGP: TGridPanel;
    ModeSeparateRB: TRadioButton;
    ModeJointRB: TRadioButton;
    GroupBox1: TGroupBox;
    procedure ImportButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DataFill(StringGrid: TStringGrid);
    procedure TabDRCheckBoxClick(Sender: TObject);
    procedure ImportButtonCheck;
    procedure ImportFormCheck;
    procedure PictureRadioButtonClick(Sender: TObject);
    procedure ExcelRadioButtonClick(Sender: TObject);
    procedure ClearSignatureButtonClick(Sender: TObject);
    procedure UseFileNameButtonClick(Sender: TObject);
    procedure ColorCheckBoxClick(Sender: TObject);
    // Выбор выборки из списка
    procedure SelectionCLBClick(Sender: TObject);
    procedure SelectionCLBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rx, ry, rz: word;
  ExcelApp: OleVariant;
  ExportToTablesForm: TExportToTablesForm;
  xls, wb, Range, ColumnRange, RowRange: OLEVariant;
  arrData: Variant;
  RowCount, ColCount: Integer;
  // Сдвиг по Y (изображение)
  const YShift = 65-36;
  const CanvasScale = 100;

implementation

{$R *.dfm}

uses  OleAuto, MainUnit, SettingsUnit, FunctionsUnit, SelectionUnit, ProcessingUnit, FilesUnit, TablesUnit;

// =======================================================

// Обрезка ================================ ПРОЦЕДУРА
procedure CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
begin
  OutBitMap.Width  := 0;
  OutBitMap.Height := 0;
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width  := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X, Y, SRCCOPY);
end;

// Использовать название файла в подписи ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.UseFileNameButtonClick(Sender: TObject);
begin
  SignatureEdit.Text := Files.GetFileName();
end;

// Заполнение массива ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.DataFill(StringGrid: TStringGrid);
var
  k, n, i, j: Integer;
  wdhExcelAdj, hgtExcelAdj: Double;
begin
  k := 2;
  n := 1;
  for i := 1 to RowCount do
  begin
    for j := 1 to ColCount do
    begin
      if k mod 3 = 0 then
      begin
        if j <> 1 then
          arrData[i, j] := '•'
      end
      else
      begin
        arrData[i, j] := StringGrid.Cells[j-1, n];
      end;
    if i = RowCount then
      arrData[i, j] := StringGrid.Cells[j-1, 0];
    end;
    k := k + 1;
      if k mod 3 <> 0 then
        n := n + 1;
  end;
  // Размерность ячеек
    // Ширина
  if (SettingsForm.wdhExcelCheckBox.Checked = True) then wdhExcelAdj := StrToFloat(SettingsForm.wdhExcelEdit.Text)
  else wdhExcelAdj := 1;
  if (SettingsForm.hgtExcelCheckBox.Checked = True) then hgtExcelAdj := StrToFloat(SettingsForm.hgtExcelEdit.Text)
  else hgtExcelAdj := 1;                                                                          // Блядь, сколько можно рАсХоДиТьСя
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].ColumnWidth := 24.37 * wdhExcelAdj;
    //24.89; // 24.11; // 4.22 п / 1 см;   (с учетом масштабирования в 20% из-за умножения на 5: иначе 1см ровно не выйдет)
  for i := 2 to RowCount do
  begin
    if i mod 3 = 0 then
    begin
    // Высота (точка)
      xls.Range[wb.WorkSheets[1].Cells[i-1, 1], wb.WorkSheets[1].Cells[i-1, ColCount]].RowHeight := 27.61 * hgtExcelAdj;
        //28.2; //117; // 5.6 п / 0.12 см;
    end
    else
    begin
    // Высота (поле значения)
      xls.Range[wb.WorkSheets[1].Cells[i-1, 1], wb.WorkSheets[1].Cells[i-1, ColCount]].RowHeight := 56.6 * hgtExcelAdj;
        //62.3; // 11.7 п / 0.44 см;
    end;
  end;
  // Диапазон, который будет заполнен информацией
  for i := 1 to RowCount do
    Range := wb.WorkSheets[1].Range[wb.WorkSheets[1].Cells[1,+ 1], wb.WorkSheets[1].Cells[RowCount, ColCount]];
  // Параметры отображения
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount + 6, ColCount]].Font.Size := 45;
    // xls.WorkSheets[1].Rows[RowCount].Font.Size := 11;
  // Визуал
    // Серая сетка
      // Вертикальные
  if SettingsForm.lightGrid.Checked = True then
    xls.Range[wb.WorkSheets[1].Cells[1, 3], wb.WorkSheets[1].Cells[RowCount - 4, ColCount]].Borders[11].Color := $D9D9D9;
  if SettingsForm.lightGrid.Checked = True then
    xls.Range[wb.WorkSheets[1].Cells[1, 3], wb.WorkSheets[1].Cells[RowCount - 4, ColCount]].Borders[11].Color := $a8a8a8;
      // Горизонтальные
  for i := 1 to RowCount - 4 do
    if i mod 3 = 0 then
    begin
      //xls.Range[wb.WorkSheets[1].Cells[i, 3], wb.WorkSheets[1].Cells[i, ColCount]].Borders[9].LineStyle := 1;
    if SettingsForm.lightGrid.Checked = True then
      xls.Range[wb.WorkSheets[1].Cells[i, 3], wb.WorkSheets[1].Cells[i, ColCount]].Borders[9].Color := $D9D9D9;
    if SettingsForm.darkGrid.Checked = True then
      xls.Range[wb.WorkSheets[1].Cells[i, 3], wb.WorkSheets[1].Cells[i, ColCount]].Borders[9].Color := $a8a8a8;
    end;
    // 1, 2 ряды, разделитель квадратов координаты
  for i := 1 to RowCount do
    if i mod 3 = 0 then
    begin
      xls.Range[wb.WorkSheets[1].Cells[i, 1], wb.WorkSheets[1].Cells[i, 2]].Borders[9].LineStyle := 1; // 1;
      xls.Range[wb.WorkSheets[1].Cells[i, 1], wb.WorkSheets[1].Cells[i, 2]].Borders[9].Weight := 4;
    end;
    // 1 | 2 | 3
  for i := 2 to ColCount do
  begin
    xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, i], wb.WorkSheets[1].Cells[RowCount, i]].Borders[7].LineStyle := 1; // 1;
    xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, i], wb.WorkSheets[1].Cells[RowCount, i]].Borders[7].Weight := 4;
  end;
    // Вертикальный разделитель координат
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, 1]].Borders[10].LineStyle := 1;
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, 1]].Borders[10].Weight := 4;
    // Вертикальный разделитель первого Y
  xls.Range[wb.WorkSheets[1].Cells[1, 2], wb.WorkSheets[1].Cells[RowCount, 2]].Borders[10].LineStyle := 1; // 1;
  xls.Range[wb.WorkSheets[1].Cells[1, 2], wb.WorkSheets[1].Cells[RowCount, 2]].Borders[10].Weight := 4;
    // Горизонтальный разделитель координат
  xls.Range[wb.WorkSheets[1].Cells[RowCount, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].Borders[8].LineStyle := 1;
  xls.Range[wb.WorkSheets[1].Cells[RowCount, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].Borders[8].Weight := 4;
    // Горизонтальный разделитель последнего X
  xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, 1], wb.WorkSheets[1].Cells[RowCount - 3, ColCount]].Borders[8].LineStyle := 1; // 1;
  xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, 1], wb.WorkSheets[1].Cells[RowCount - 3, ColCount]].Borders[8].Weight := 4;
    // Крышки
  xls.WorkSheets[1].Cells[1, 2].Borders[8].LineStyle := 1;
  xls.WorkSheets[1].Cells[1, 2].Borders[8].Weight := 4;
  xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, ColCount], wb.WorkSheets[1].Cells[RowCount - 1, ColCount]].Borders[10].LineStyle := 1;
  xls.Range[wb.WorkSheets[1].Cells[RowCount - 3, ColCount], wb.WorkSheets[1].Cells[RowCount - 1, ColCount]].Borders[10].Weight := 4;
    // Выравнивание
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].HorizontalAlignment := 3;
  xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].VerticalAlignment := 2;
    // Серые линии
    if SettingsForm.lightGrid.Checked = True then
    begin
      xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, 1]].Interior.Color := $F2F2F2;
      xls.Range[wb.WorkSheets[1].Cells[RowCount, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].Interior.Color := $F2F2F2;
    end;
    if SettingsForm.darkGrid.Checked = True then
    begin
      xls.Range[wb.WorkSheets[1].Cells[1, 1], wb.WorkSheets[1].Cells[RowCount, 1]].Interior.Color := $D9D9D9;
      xls.Range[wb.WorkSheets[1].Cells[RowCount, 1], wb.WorkSheets[1].Cells[RowCount, ColCount]].Interior.Color := $D9D9D9;
    end;
    // R красного цвета
  for i := 2 to RowCount do
  begin
    if i mod 3 = 0 then
    begin
      xls.WorkSheets[1].Rows[i].Font.Color := clRed;
    end
  end;
  // Подробности
  if SignatureEdit.Text = '' then
  begin
    wb.WorkSheets[1].Cells[RowCount + 2, 1] := '__________________________________';
  end
  else
  begin
    wb.WorkSheets[1].Cells[RowCount + 2, 1] := SignatureEdit.Text;
  end;
  if StringGrid = MainForm.tableDR then
  begin
    wb.WorkSheets[1].Cells[RowCount + 4, 1] := 'Таблица DR;  ' + 'Выборка "' + MainForm.selNameEdit.Text + '";  Диапазон выборки: ' +
      MainForm.selFirstQXEdit.Text + 'X:' + MainForm.selFirstQYEdit.Text + 'Y' + '—' + MainForm.selLastQXEdit.Text +
      'X:' + MainForm.selLastQYEdit.Text + 'Y';
    wb.WorkSheets[1].Cells[RowCount + 6, 1] := 'δa=' + MainForm.sigmaAEdit.Text + ';  δb=' +
      MainForm.sigmaBEdit.Text + ';  СРa=' + MainForm.meanAEdit.Text + ';  СРb=' + MainForm.meanBEdit.Text;
  end
  else if StringGrid = MainForm.tableAB then
  begin
    wb.WorkSheets[1].Cells[RowCount + 4, 1] := 'Таблица AB';
  end;
  // Объеденяем ячейки
  xls.Range[wb.WorkSheets[1].Cells[RowCount + 2, 1], wb.WorkSheets[1].Cells[RowCount + 2, 33]].MergeCells := True;
  xls.Range[wb.WorkSheets[1].Cells[RowCount + 4, 1], wb.WorkSheets[1].Cells[RowCount + 4, 33]].MergeCells := True;
  xls.Range[wb.WorkSheets[1].Cells[RowCount + 6, 1], wb.WorkSheets[1].Cells[RowCount + 6, 33]].MergeCells := True;
  // Масштаб 20% (от 5 см берем 1 - идиотская специфика Excel)
  xls.WorkSheets[1].PageSetup.Zoom := 20;
  xls.WorkSheets[1].PageSetup.BottomMargin := 15;
  xls.WorkSheets[1].PageSetup.TopMargin := 20;
  xls.WorkSheets[1].PageSetup.LeftMargin := 15;
  xls.WorkSheets[1].PageSetup.RightMargin := 15;
  // Копируем данные
  Range.Value := arrData;
end;

// Активация формы ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.FormActivate(Sender: TObject);
begin
  Selections.UIListFill(SelectionCLB);

  ModeSeparateRB.Checked := True;
  ExcelRadioButton.Checked := False;
  PictureRadioButton.Checked := True;
  A4RadioButton.Checked := True;
  A4mRadioButton.Checked := False;
  A2RadioButton.Checked := False;
  TabABCheckBox.Checked := False;
  TabDRCheckBox.Checked := False;
  ColorCheckBox.Checked := False;

  SignatureEdit.Clear;
  if MainForm.Caption = 'Анализатор (Несохраненный файл)' then
    UseFileNameButton.Enabled := False
  else
    UseFileNameButton.Enabled := True;
end;

// Кнопка меню: Импортировать ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.ImportButtonClick(Sender: TObject);
const
  width = 300;
  height = 300;
  d = 10;
  indent = 60;
var
  selectionString: String;
  pass: Boolean;
  today : TDateTime;
  ImportBitmap, A2Bitmap, BitmapPiece: TBitMap;
  Jpg: TJPEGImage;
  i, j, x, y, a, b, c, k, n, temp: Integer;
  Pix: array of array of byte;
  // Поправка: доп. ячейки на соседние А4 (для обрезки и склеивания после распечатки)
  cellAdj: Double;
  // Поправка размерности холста
  wdhA2Adj, wdhA4Adj, hgtA2Adj, hgtA4Adj: Double;

  // Поправка изображения (растягивание/сжатие) -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
    // A2
  procedure fixA2(Bitmap: TBitmap);
  var
    R: TRect;
    oldHeight: Integer;
  begin
    if (SettingsForm.wdhA2CheckBox.Checked = True) then wdhA2Adj := StrToFloat(SettingsForm.wdhA2Edit.Text)
    else wdhA2Adj := 1;
    if (SettingsForm.hgtA2CheckBox.Checked = True) then hgtA2Adj := StrToFloat(SettingsForm.hgtA2Edit.Text)
    else hgtA2Adj := 1;
    oldHeight := Bitmap.Height;
    R.Left := 0; R.Top := 0; R.Right := Round(Bitmap.Width * wdhA2Adj); R.Bottom := Round(Bitmap.Height * hgtA2Adj);
    Bitmap.Canvas.StretchDraw(R, Bitmap);
    Bitmap.SetSize(Bitmap.Width, oldHeight);
  end;
    // A4
  procedure fixA4(Bitmap: TBitmap);
  var
    R: TRect;
    oldHeight: Integer;
//    SupBitmap: TBitmap;
  begin
//    SupBitmap := TBitmap.Create;
    if (SettingsForm.wdhA4CheckBox.Checked = True) then wdhA4Adj := StrToFloat(SettingsForm.wdhA4Edit.Text)
    else wdhA4Adj := 1;
    if (SettingsForm.hgtA4CheckBox.Checked = True) then hgtA4Adj := StrToFloat(SettingsForm.hgtA4Edit.Text)
    else hgtA4Adj := 1;
    oldHeight := Bitmap.Height;
    R.Left := 0; R.Top := 0; R.Right := Round(Bitmap.Width * wdhA4Adj); R.Bottom := Round(Bitmap.Height * hgtA4Adj);
    Bitmap.Canvas.StretchDraw(R, Bitmap);
    Bitmap.SetSize(Bitmap.Width, oldHeight);

  end;

  // Подготовка печатного вида -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
  procedure prepPic(StringGrid1, StringGrid2: TStringGrid);
  var
    x, y, a, b: Integer;
    i, j, k, GradScale: Integer;
    Color: TColor;
    GradientArray: array[0..299, 0..299] of Double;
    GradientArray2: array[0..299, 0..299] of Double;
    f: Textfile;
    // Количество активированных выборок
    selSel: Integer;

    // Указатели координат по У
    procedure coordprint(text1, text2: string);
    var y: Integer;
      procedure multipl(multi: Double);
      begin
        ImportBitmap.Canvas.Font.Color := clBlack;
        ImportBitmap.Canvas.TextOut(Round((CanvasScale/10)*multi), (CanvasScale*(y+1))-CanvasScale+Round(CanvasScale/10)-YShift,
          IntToStr(yTableDim-y+1)+text1);
        ImportBitmap.Canvas.Font.Color := clRed;
        ImportBitmap.Canvas.TextOut(Round((CanvasScale/10)*multi), (CanvasScale*(y+1))-Round(CanvasScale/2)+Round(CanvasScale/10)-YShift,
          IntToStr(yTableDim-y+1)+text2);
      end;
    begin
      for y:=1 to yTableDim do
      begin
        if (yTableDim-y+1)<10 then
          multipl(6)
        else if (yTableDim-y+1)>=10 then
          multipl(4.5);
      end;
    end;

  // ТЕЛО -------------------
  begin
    ImportBitmap := TBitmap.Create;
    // Размер битмапы
      // A4 (масшт.)
    if (A4mRadioButton.Checked = True) then
    begin
      selSel := 0;
      for i := 0 to SelectionCLB.Items.Count-1 do
        if SelectionCLB.Checked[i] then
          Inc(selSel, 1);
      if xTableDim < 7 then temp := 7 else temp := xTableDim;
      ImportBitmap.SetSize(Round(((temp+1)*CanvasScale)+35), Round(((yTableDim+2)*CanvasScale)+60+(indent*selSel)));
    end;
      // A4
    if (A4RadioButton.Checked = True) or (A2RadioButton.Checked = True) then
    begin
      if xTableDim > 20 then x := 2
      else if xTableDim <= 20 then x := 1;
      if yTableDim > 29 then y := 2
      else if yTableDim <= 20 then y := 1;
      ImportBitmap.SetSize(Round(2100*x), Round((sqrt(2)*(2100))*y));
    end;
    // Очистка канвы
    ImportBitmap.Canvas.Pen.Color := clWhite;
    ImportBitmap.Canvas.Rectangle(0, 0, Round(2100*x), Round((sqrt(2)*(2100))*y));

    // Цветовое обозначение высот
    if ColorCheckBox.Checked = True then
    begin
      ImportButton.Enabled := False;
      ImportProgressBar.Visible := True;
      ImportProgressBar.Max := yTableDim*xTableDim;
      ExportToTablesForm.Enabled := False;
      Try
//      for a:=1 to xCol do
//        for b:=1 to yCol do
          begin
            for x:=1 to xTableDim do
              for y:=1 to yTableDim do
              begin
                ImportBitmap.Canvas.Brush.Style := bsSolid;
                if ColorScheme1.Checked = True then
                begin
                  if StrToFloat(StringGrid1.Cells[x, y]) >= 2 then
                  begin
                    Color := RGB(255, Round(255/(StrToFloat(StringGrid1.Cells[x, y])/2)), 0);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 2) then
                  begin
                    Color := RGB(Round(255*(Frac(StrToFloat(StringGrid1.Cells[x, y])/0.5)))-255, 255, 0);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1) and (StrToFloat(StringGrid1.Cells[x, y]) < 1.5) then
                  begin
                    Color := RGB(0, 255, 255-Round(255*(Frac(StrToFloat(StringGrid1.Cells[x, y])/0.5))));
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 1) then
                  begin
                    Color := RGB(0, Round(255*(Frac(StrToFloat(StringGrid1.Cells[x, y])/0.5)))-255, 255);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0) and (StrToFloat(StringGrid1.Cells[x, y]) < 0.5) then
                  begin
                    Color := RGB(255-Round(255*(Frac(StrToFloat(StringGrid1.Cells[x, y]))/0.5)), 0, 255);
                  end
                  else if StrToFloat(StringGrid1.Cells[x, y]) < 0 then
                  begin
                    Color := RGB(255, 0, 255);
                  end;
                end
                else if ColorScheme2.Checked = True then
                begin
                  if StrToFloat(StringGrid1.Cells[x, y]) >= 2 then
                  begin
                    Color := rgb(255,56,56);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 2) then
                  begin
                    Color := rgb(255,159,26);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1) and (StrToFloat(StringGrid1.Cells[x, y]) < 1.5) then
                  begin
                    Color := rgb(255,242,0);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 1) then
                  begin
                    Color := rgb(50,255,126);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0) and (StrToFloat(StringGrid1.Cells[x, y]) < 0.5) then
                  begin
                    Color := rgb(24,220,255);
                  end
                  else if StrToFloat(StringGrid1.Cells[x, y]) < 0 then
                  begin
                    Color := rgb(125,95,255);
                  end;
                end
                else if ColorScheme3.Checked = True then
                begin
                if StrToFloat(StringGrid1.Cells[x, y]) >= 2 then
                  begin
                    Color := rgb(89, 89, 89);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 2) then
                  begin
                    Color := rgb(115, 115, 115);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 1) and (StrToFloat(StringGrid1.Cells[x, y]) < 1.5) then
                  begin
                    Color := rgb(153, 153, 153);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0.5) and (StrToFloat(StringGrid1.Cells[x, y]) < 1) then
                  begin
                    Color := rgb(179, 179, 179);
                  end
                  else if (StrToFloat(StringGrid1.Cells[x, y]) >= 0) and (StrToFloat(StringGrid1.Cells[x, y]) < 0.5) then
                  begin
                    Color := rgb(204, 204, 204);
                  end
                  else if StrToFloat(StringGrid1.Cells[x, y]) < 0 then
                  begin
                    Color := rgb(242, 242, 242);
                  end;
                end;
                ImportBitmap.Canvas.Brush.Color := Color;
                ImportBitmap.Canvas.Rectangle(Round(x*CanvasScale), Round((y*CanvasScale)-YShift),
                  Round((x+1)*CanvasScale), Round(((y+1)*CanvasScale)-YShift));
//                ImportBitmap.Canvas.Pixels[(a*CanvasScale)+x, (b*CanvasScale)+y-YShift] := Color;
              end;
              ImportProgressBar.Position := ImportProgressBar.Position+1;
              Application.ProcessMessages;
          end;
      Finally
      ImportButton.Enabled := True;
      ImportProgressBar.Visible := False;
      ImportProgressBar.Position := ImportProgressBar.Max;
      ExportToTablesForm.Enabled := True;
      End;
    end;

    // Прорисовка сетки
      // Цвет
    if SettingsForm.lightGrid.Checked = True then
      ImportBitmap.Canvas.Pen.Color := $ebebeb; // $b3b3b3 d9d9d9;
    if SettingsForm.darkGrid.Checked = True then
      ImportBitmap.Canvas.Pen.Color := $b3b3b3;
    ImportBitmap.Canvas.Pen.Width := 2;
      // Вертикальные линии
    for x:=1 to xTableDim+1 do
    begin
      ImportBitmap.Canvas.MoveTo(((x)*CanvasScale), CanvasScale-YShift);
      ImportBitmap.Canvas.LineTo(((x)*CanvasScale), ((yTableDim+1)*CanvasScale-YShift));
    end;
      // Горизонтальные линии
    for y:=1 to yTableDim do
    begin
      ImportBitmap.Canvas.MoveTo(CanvasScale, ((y)*CanvasScale-YShift));
      ImportBitmap.Canvas.LineTo(((xTableDim+1)*CanvasScale), ((y)*CanvasScale-YShift));
    end;
    // Указатели координат (серые поля)
    ImportBitmap.Canvas.Brush.Style := bsSolid;
    if A2RadioButton.Checked = True then
    begin
      if SettingsForm.lightGrid.Checked = True then
      begin
        ImportBitmap.Canvas.Brush.Color := $F2F2F2;
        ImportBitmap.Canvas.Pen.Color := $F2F2F2;
      end;
      if SettingsForm.darkGrid.Checked = True then
      begin
        ImportBitmap.Canvas.Brush.Color := $D9D9D9;
        ImportBitmap.Canvas.Pen.Color := $D9D9D9;
      end;
    end
    else
    begin
      if SettingsForm.lightGrid.Checked = True then
      begin
        ImportBitmap.Canvas.Brush.Color := $F2F2F2;
        ImportBitmap.Canvas.Pen.Color := $F2F2F2;
      end;
      if SettingsForm.darkGrid.Checked = True then
      begin
        ImportBitmap.Canvas.Brush.Color := $D9D9D9;
        ImportBitmap.Canvas.Pen.Color := $D9D9D9;
      end;
    end;
      // Вертикальная
    ImportBitmap.Canvas.Rectangle(35, CanvasScale-YShift, CanvasScale, CanvasScale*(yTableDim+1)-YShift);
      // Горизонтальная
    ImportBitmap.Canvas.Rectangle(35, CanvasScale*(yTableDim+1)-YShift, CanvasScale*(xTableDim+1), Round(CanvasScale*(yTableDim+1.5)-YShift));

    // Рамки (сетка)
    ImportBitmap.Canvas.Pen.Color := $303030;
    ImportBitmap.Canvas.Pen.Width := 5;
    ImportBitmap.Canvas.Pen.Style := psSolid;
      // Вертикальные жирные
    ImportBitmap.Canvas.MoveTo(CanvasScale, CanvasScale-YShift);
    ImportBitmap.Canvas.LineTo(CanvasScale, Round(CanvasScale*(yTableDim+1.5)-YShift));
    ImportBitmap.Canvas.MoveTo(CanvasScale*2, CanvasScale-YShift);
    ImportBitmap.Canvas.LineTo(CanvasScale*2, Round(CanvasScale*(yTableDim+1.5)-YShift));
        // Ребра
    for x := 3 to xTableDim+1 do
    begin
      ImportBitmap.Canvas.MoveTo(CanvasScale*x, CanvasScale*(yTableDim)-YShift);
      ImportBitmap.Canvas.LineTo(CanvasScale*x, Round(CanvasScale*(yTableDim+1.5)-YShift));
    end;
      // Горизонтальные жирные
    ImportBitmap.Canvas.MoveTo(35, CanvasScale*(yTableDim+1)-YShift);
    ImportBitmap.Canvas.LineTo(CanvasScale*(xTableDim+1), CanvasScale*(yTableDim+1)-YShift);
    ImportBitmap.Canvas.MoveTo(35, CanvasScale*(yTableDim)-YShift);
    ImportBitmap.Canvas.LineTo(CanvasScale*(xTableDim+1), CanvasScale*(yTableDim)-YShift);
        // Ребра
    for y := 1 to yTableDim+1 do
    begin
      ImportBitmap.Canvas.MoveTo(35, CanvasScale*y-YShift);
      ImportBitmap.Canvas.LineTo(CanvasScale*2, CanvasScale*y-YShift);
    end;
    // Указатели координат (цифры)
    ImportBitmap.Canvas.Brush.Style := bsClear;
    ImportBitmap.Canvas.Font.Color := $000000;
    ImportBitmap.Canvas.Font.Size := 15;
    SetBkMode(ImportBitmap.Canvas.Handle, Transparent);
    // Снизу
    for x:=1 to xTableDim do
    begin
      if x<10 then
        ImportBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/9)+4,
          (CanvasScale*(yTableDim+1))+Round(CanvasScale/10)-YShift, IntToStr(x));
      if x>=10 then
        ImportBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/7),
          (CanvasScale*(yTableDim+1))+Round(CanvasScale/10)-YShift, IntToStr(x));
    end;
    // по Y
    if TabABCheckBox.Checked = True then
      coordprint('A', 'B')
    else if TabDRCheckBox.Checked = True then
      coordprint('D', 'R');

    // Прорисовка точек координат на сетке
    for x:=1 to xTableDim do
      for y:=1 to yTableDim do
      begin
        // Точки
        ImportBitmap.Canvas.Pen.Color := clBlack;
        ImportBitmap.Canvas.Pen.Width := 9;
        SetBkMode(ImportBitmap.Canvas.Handle, Transparent);
        ImportBitmap.Canvas.MoveTo(x*CanvasScale+Round(CanvasScale/2), y*CanvasScale+Round(CanvasScale/2)-YShift);  // 50 - половина CanvasScale
        ImportBitmap.Canvas.LineTo(x*CanvasScale+Round(CanvasScale/2), y*CanvasScale+Round(CanvasScale/2)-YShift);
        // Вес точек
        MainForm.tableAB.Refresh;
        ImportBitmap.Canvas.Font.Size := 15;
        SetBkMode(ImportBitmap.Canvas.Handle, Transparent);
        ImportBitmap.Canvas.Font.Color := clBlack;
        ImportBitmap.Canvas.TextOut(x*CanvasScale+Round(CanvasScale/2)-
          2*Round((StringGrid1.Canvas.TextWidth(StringGrid1.Cells[x, y]))/2)+2,
          (CanvasScale*(y+1))-CanvasScale+Round(CanvasScale/10)-YShift, StringGrid1.Cells[x, y]);
        ImportBitmap.Canvas.Font.Color := clRed;
        ImportBitmap.Canvas.TextOut(x*CanvasScale+Round(CanvasScale/2)-
          2*Round((StringGrid2.Canvas.TextWidth(StringGrid2.Cells[x, y]))/2)+2,
          (CanvasScale*(y+1))-Round(CanvasScale/2)+Round(CanvasScale/10)-YShift, StringGrid2.Cells[x, y]);
      end;

    // Доп. информация под сеткой
    // Подпись
    ImportBitmap.Canvas.Font.Color := clBlack;
    if SignatureEdit.Text = '' then
    begin
      ImportBitmap.Canvas.TextOut(35, (yTableDim+1)*CanvasScale+indent, '__________________________________');
    end
    else
    begin
       ImportBitmap.Canvas.TextOut(35, (yTableDim+1)*CanvasScale+indent, SignatureEdit.Text);
    end;

    // Информация
    // АB
    if StringGrid1 = MainForm.tableA then
    begin
      ImportBitmap.Canvas.TextOut(35, (yTableDim+1)*CanvasScale+(indent*2), 'Таблица AB');
    end;
    // DR
    if StringGrid1 = MainForm.tableD then
    begin
      if ModeSeparateRB.Checked then
      begin
        selectionString := Selections.GetRangesStr(activeSelIndex) + '; ' + Processing.GetSigmasStr(activeSelIndex);
        ImportBitmap.Canvas.TextOut(35, (yTableDim+1)*CanvasScale+(indent*2), 'Таблица DR;  ' + 'Выборка: '+selectionString);
      end
      else if ModeJointRB.Checked then
      begin
        j := 2;
        ImportBitmap.Canvas.TextOut(35, (yTableDim+1)*CanvasScale+(indent*2), 'Таблица DR;  ' + 'Выборки: ');
        for i := 0 to SelectionCLB.Items.Count-1 do
          if SelectionCLB.Checked[i] then
          begin
            Inc(j);
            selectionString := Selections.GetRangesStr(i) + '; ' + Processing.GetSigmasStr(i);
            ImportBitmap.Canvas.TextOut(55, (yTableDim+1)*CanvasScale+(indent*j), selectionString);
          end;
      end;
    end;
  end;

    // Сохранение разрезанного на А4 -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
    procedure SavePicture();
    var j: Integer;
    R: TRect;
    oldHeight: Integer;
    begin
      j := 1;
      if (SettingsForm.hgtA4CheckBox.Checked = True) then hgtA4Adj := StrToFloat(SettingsForm.hgtA4Edit.Text)
      else hgtA4Adj := 1;
      cellAdj := (2970 * hgtA4Adj * 2)/29.7;
      BitmapPiece := TBitmap.Create;
      CropBitmap(ImportBitmap, BitmapPiece, 0,0, Round(2100), Round(sqrt(2)*(2100)));
      fixA4(BitmapPiece);
      Jpg.Assign(BitmapPiece);
      Jpg.SaveToFile(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)+'_#'+IntToStr(j)+'.jpg');
      if xTableDim > 20 then
      begin
        j := j+1;
        CropBitmap(ImportBitmap, BitmapPiece, Round((2100)-cellAdj), 0, Round(2100), Round(sqrt(2)*(2100)));
        fixA4(BitmapPiece);
        Jpg.Assign(BitmapPiece);
        Jpg.SaveToFile(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)+'_#'+IntToStr(j)+'.jpg');
      end;
      if yTableDim > 29 then
      begin
        j := j+1;
        CropBitmap(ImportBitmap, BitmapPiece, 0, Round((sqrt(2)*(2100))-cellAdj), Round(2100),
          Round(sqrt(2)*(2100)));
        fixA4(BitmapPiece);
        Jpg.Assign(BitmapPiece);
        Jpg.SaveToFile(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)+'_#'+IntToStr(j)+'.jpg');
      end;
      if (xTableDim > 20) and (yTableDim > 29) then
      begin
        j := j+1;
        CropBitmap(ImportBitmap, BitmapPiece, Round((2100)-cellAdj), Round((sqrt(2)*(2100))-cellAdj),
          Round(2100), Round(sqrt(2)*(2100)));
        fixA4(BitmapPiece);
        Jpg.Assign(BitmapPiece);
        Jpg.SaveToFile(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)+'_#'+IntToStr(j)+'.jpg');
      end;
    end;

  // Сохранение изображения -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
  procedure savePic(table: String);
  begin
    Jpg := TJPEGImage.Create;
    // Разрезанное немасштабированное (A4)
    if (A4RadioButton.Checked = True) then
    begin
      MainForm.exportSaveDialog.FileName := Files.GetFileName()+'_'+table+'_A4_'+DateToStr(Now)+'.jpg';
      if MainForm.exportSaveDialog.Execute then
      begin
        SavePicture();
        MainForm.InfoLineUpdate('Изображения успешно созданы');
        Jpg.Free;
        ExportToTablesForm.Close;
      end;
    end;
    // Цельное масштабированное (A4)
    if (A4mRadioButton.Checked = True) then
    begin
      MainForm.exportSaveDialog.FileName := Files.GetFileName()+'_'+table+'_A4M_'+DateToStr(Now)+'.jpg';
      if MainForm.exportSaveDialog.Execute then
      begin
        Jpg.Assign(ImportBitmap);
        Jpg.SaveToFile(MainForm.exportSaveDialog.FileName);
        MainForm.InfoLineUpdate('Изображения успешно созданы');
        Jpg.Free;
      end;
    end;
    // A2
    if (A2RadioButton.Checked = True) then
    begin
      A2Bitmap := TBitmap.Create;
      CropBitmap(ImportBitmap, A2Bitmap, 0,0, Round(4200), Round(sqrt(2)*(4200)));
      fixA2(A2Bitmap);
      MainForm.exportSaveDialog.FileName := Files.GetFileName()+'_'+table+'_A2_'+DateToStr(Now)+'.jpg';
      if MainForm.exportSaveDialog.Execute then
      begin
        Jpg.Assign(A2Bitmap);
        Jpg.SaveToFile(MainForm.exportSaveDialog.FileName);
        MainForm.InfoLineUpdate('Изображения успешно созданы');
        A2Bitmap.Free;
        Jpg.Free;
      end;
    end;
  end;

// ТЕЛО ФУНКЦИИ ================================================================
begin
  if ModeJointRB.Checked then
  begin
    if Selections.IsIntersect(SelectionCLB) then
      pass := True
    else
      pass := False;
  end
  else
    pass := True;

  if pass then
  begin
    today := Time;
    // Выбор: Таблицы Excel
    if ExcelRadioButton.Checked = True then
    begin
      // Задание расширения для экстракторов
      MainForm.exportSaveDialog.FileName := Files.GetFileName();
      MainForm.exportSaveDialog.Filter := 'Файл Excel|*.xlsx';
      MainForm.exportSaveDialog.DefaultExt := 'xlsx';
      MainForm.exportSaveDialog.FilterIndex := 1;

      RowCount := MainForm.tableDR.RowCount + ((MainForm.tableDR.RowCount - 1) div 2);
      ColCount := MainForm.tableDR.ColCount;
      arrData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);

      try
        xls := CreateOLEObject('Excel.Application');
      except
        on E: Exception do
        begin
          ShowMessage('Файл не может быть импортирован:' + sLineBreak + 'На компьютере отсутствует Excel подходящей версии.');
          Exit;
        end;
      end;
      // Создание книги
      wb := xls.Workbooks.Add;
      ColumnRange := wb.WorkSheets[1].Columns;
      RowRange := wb.WorkSheets[1].Rows;

      temp := 1;
      if TabABCheckBox.Checked = True then
      begin
        Tables.ABTransfer('to AB');
        if temp > 1 then
        begin
          wb.Sheets.Add;
        end;
        xls.Workbooks[1].ActiveSheet.Name := 'AB';
        DataFill(MainForm.tableAB);
        Inc(temp, 1);
      end;
      // Выборан DR
      if TabDRCheckBox.Checked = True then
      begin
        // Раздельный режим
        if ModeSeparateRB.Checked then
        begin
          for i := 0 to SelectionCLB.Items.Count - 1 do
            if SelectionCLB.Checked[i] then
            begin
              if temp > 1 then
                wb.Sheets.Add;
              Selections.Changed(i);
              xls.Workbooks[1].ActiveSheet.Name := 'DR'+IntToStr(i)+', '+SelectionsList[i].Name;
              DataFill(MainForm.tableDR);
              Inc(temp, 1);
            end;
        end
        // Совместный режим
        else
        begin
          if temp > 1 then
            wb.Sheets.Add;

          for i := 0 to SelectionCLB.Items.Count - 1 do
            if SelectionCLB.Checked[i] then
            begin
              Selections.Changed(i, True);
            end;

          xls.Workbooks[1].ActiveSheet.Name := 'DR';
          DataFill(MainForm.tableDR);
          Inc(temp, 1);
        end;
      end;

      // Сохранить таблицу
      if MainForm.exportSaveDialog.Execute then
      begin
        Screen.Cursor := crHourGlass;
        MainForm.GridToMemo;
        xls.WorkBooks[1].SaveAs(MainForm.exportSaveDialog.FileName);
        MainForm.InfoLineUpdate('Таблицы Excel успешно созданы');
        xls.ActiveWorkbook.Close;
        xls.Application.Quit;
      end;
      Screen.Cursor := crDefault;
      ExportToTablesForm.Close;
    end

    // Выбор: Изображение ----------------------------
    else
    begin
      // Задание расширения для экстракторов
      MainForm.exportSaveDialog.FileName := Files.GetFileName();
      MainForm.exportSaveDialog.Filter := 'JPEG|*.jpg;*.jpeg;*.jpe;*.jfif';
      MainForm.exportSaveDialog.DefaultExt := 'jpg';
      MainForm.exportSaveDialog.FilterIndex := 1;

      if PictureRadioButton.Checked = True then
      begin
        begin
          // Выбран AB
          if TabABCheckBox.Checked = True then
          begin
            prepPic(MainForm.tableA, MainForm.tableB);
            savePic('AB');
          end;

          // Выборан DR
          if TabDRCheckBox.Checked = True then
          begin
            // Раздельный режим
            if ModeSeparateRB.Checked then
            begin
              for i := 0 to SelectionCLB.Items.Count - 1 do
                if SelectionCLB.Checked[i] then
                begin
                  Selections.Changed(i);
                  prepPic(MainForm.tableD, MainForm.tableR);
                  savePic('DR'+IntToStr(i));
                end;
            end
            // Совместный режим
            else
            begin
              for i := 0 to SelectionCLB.Items.Count - 1 do
                if SelectionCLB.Checked[i] then
                  Selections.Changed(i, True);
              prepPic(MainForm.tableD, MainForm.tableR);
              savePic('DR'+IntToStr(i));
            end;
          end;
        end;
      end;
    end;
    Selections.Changed(activeSelIndex);
  end;
end;

// Кнопка "Таблица Excel" ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.ExcelRadioButtonClick(Sender: TObject);
begin
  ImportFormCheck;
end;
// Кнопка "Изображения" ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.PictureRadioButtonClick(Sender: TObject);
begin
  ImportFormCheck;
end;

// ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.ImportFormCheck;
begin
  if PictureRadioButton.Checked = True then
  begin
    ColorCheckBox.Enabled := True;

    A4mRadioButton.Enabled := True;
    A4RadioButton.Enabled := True;
    A2RadioButton.Enabled := True;

    // Масштабировать на А4
    if A4mRadioButton.Checked = True then
    begin
      PrevievImage1.Visible := True;
      PrevievImage4.Visible := False;
      PrevievImage1А2.Visible := False;
      PrevievImageE.Visible := False;
    end;
    // Разрезать A2 на несколько А4
    if A4RadioButton.Checked = True then
    begin
      PrevievImage1.Visible := False;
      PrevievImage4.Visible := True;
      PrevievImage1А2.Visible := False;
      PrevievImageE.Visible := False;
    end;
    // A2
    if A2RadioButton.Checked = True then
    begin
      PrevievImage1.Visible := False;
      PrevievImage4.Visible := False;
      PrevievImage1А2.Visible := True;
      PrevievImageE.Visible := False;
    end;
  end
  //
  else
  begin
    ColorCheckBox.Checked := False;
    ColorCheckBox.Enabled := False;

    A4mRadioButton.Enabled := False;
    A4RadioButton.Enabled := False;
    A2RadioButton.Enabled := False;

    PrevievImage1.Visible := False;
    PrevievImage4.Visible := False;
    PrevievImage1А2.Visible := False;
    PrevievImageE.Visible := True;
  end;
end;

// Галочки ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.ImportButtonCheck;
begin
  if Selections.IsActiveInUIList(SelectionCLB) or TabABCheckBox.Checked then
    ImportButton.Enabled := True
  else
    ImportButton.Enabled := False;
end;

// AB, DR ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.TabDRCheckBoxClick(Sender: TObject);
begin
  if TabDRCheckBox.Checked = False then
    SelectionCLB.CheckAll(cbUnchecked, true, false);

  ImportButtonCheck;
end;

//
procedure TExportToTablesForm.ColorCheckBoxClick(Sender: TObject);
begin
  if ColorCheckBox.Checked = True then
  begin
    ColorScheme1.Enabled := True;
    ColorScheme2.Enabled := True;
    ColorScheme3.Enabled := True;
  end
  else
  begin
    ColorScheme1.Enabled := False;
    ColorScheme2.Enabled := False;
    ColorScheme3.Enabled := False;
  end;
end;

// Очистить поле подписи ================================ ПРОЦЕДУРА
procedure TExportToTablesForm.ClearSignatureButtonClick(Sender: TObject);
begin
  SignatureEdit.Clear;
end;

// Выбор выборки из списка
procedure TExportToTablesForm.SelectionCLBClick(Sender: TObject);
begin
  if Selections.IsActiveInUIList(SelectionCLB) then
    TabDRCheckBox.Checked := True
  else
    TabDRCheckBox.Checked := False;
  ImportButtonCheck;
end;

// Переключение выборки для просмотра
procedure TExportToTablesForm.SelectionCLBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  activeSelIndex := SelectionCLB.ItemIndex;
  Selections.Changed(activeSelIndex);
  MainForm.InfoLineUpdate('Произведен рассчет по выборке "' + SelectionsList[activeSelIndex].Name + '"',
    '', clMenuHighlight);
end;

end.
