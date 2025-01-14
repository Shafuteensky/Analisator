unit IsolinesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, Math,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, U3Dpolys, ShellApi,
  PythonVersions, PythonEngine, Vcl.PythonGUIInputOutput, System.IOUtils,
  System.ImageList, Vcl.ImgList, Vcl.CheckLst, iniFiles;

type
  TIsolinesForm = class(TForm)
    GroupBox7: TGroupBox;
    GroupBox1: TGroupBox;
    SaveButton: TButton;
    ProgressBar: TProgressBar;
    ReviseMemo: TMemo;
    PyLibMemo: TMemo;
    GroupBox6: TGroupBox;
    ProgressLabel: TLabel;
    A4RadioButton: TRadioButton;
    A2RadioButton: TRadioButton;
    A4mRadioButton: TRadioButton;
    GroupBox5: TGroupBox;
    GridPanel2: TGridPanel;
    ModeReviseRB: TRadioButton;
    ModeСorrelRB: TRadioButton;
    SelectionCLB: TCheckListBox;
    ExtraSettingsPanel: TPanel;
    CanvasSettingsBox: TGroupBox;
    GridPanel7: TGridPanel;
    GridCheck: TCheckBox;
    CheckGridCB: TCheckBox;
    CoordsCB: TCheckBox;
    DotsCheckCB: TCheckBox;
    SignBox: TGroupBox;
    GridPanel1: TGridPanel;
    IsHatchCB: TCheckBox;
    IsColorMapCB: TCheckBox;
    InfoSettingsBox: TGroupBox;
    SignatureEdit: TEdit;
    ScaleEdit: TEdit;
    TypeEdit: TEdit;
    ApplicationEdit: TEdit;
    PrintLegendCB: TCheckBox;
    PrintInfoCB: TCheckBox;
    PrintTitleCB: TCheckBox;
    GroupBox2: TGroupBox;
    GridPanel3: TGridPanel;
    Label1: TLabel;
    LineWidthsLabel: TLabel;
    LineWidthsCB: TComboBox;
    FontSizeLabel: TLabel;
    FontSizeCB: TComboBox;
    InterpLvlEdit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    InterpOrderCB: TComboBox;
    DPIEdit: TEdit;
    ShowExtraSettingsBtn: TButton;
    GridPanel4: TGridPanel;
    UseFileNameButton: TButton;
    ClearSignatureButton: TButton;
    PythonModule: TPythonModule;
    PythonEngine: TPythonEngine;
    procedure RebuildPython();
    procedure FormShow(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure DoIsolines(askForSavePath: Boolean = True);
    procedure UseFileNameButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PreviewPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Fill1RBClick(Sender: TObject);
    procedure Fill2RBClick(Sender: TObject);
    procedure Fill3RBClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearSignatureButtonClick(Sender: TObject);
    procedure ModeReviseRBClick(Sender: TObject);
    procedure ModeСorrelRBClick(Sender: TObject);
    // Выбор выборки из списка
    procedure SelectionCLBClick(Sender: TObject);
    procedure SelectionCLBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrintTitleCBClick(Sender: TObject);
    procedure IsHatchCBClick(Sender: TObject);
    procedure IsColorMapCBClick(Sender: TObject);
    procedure ShowExtraSettingsBtnClick(Sender: TObject);
    procedure InterpLvlEditChange(Sender: TObject);
    procedure InterpOrderCBChange(Sender: TObject);
    procedure LineWidthsCBChange(Sender: TObject);
    procedure FontSizeCBChange(Sender: TObject);
    procedure DPIEditChange(Sender: TObject);
    procedure PythonEngineBeforeLoad(Sender: TObject);
  private
    { Private declarations }
    FImage: TPicture;
  public
    { Public declarations }
    Map:Tentity;
    Collider:Tentity;
  end;

var
  ColliderLvl: Double;
  IsolinesForm: TIsolinesForm;
  Rect: TRect;
  H: extended;
  x, y: Integer;
  // Массив координат усредненных точек
  PointsArray: array of array of array of Double;
  // Массив для отметки использования
  CheckArray: array of array of Boolean;
  // Координаты подходящей ячейки массива
  FitCellPosX: Integer;
  FitCellPosY: Integer;
  // Разница для вычисления наиболее подходящей чейки
  CellDiff: Double;
  MinCellDiff: Double;
  // Количество выбранных выборок
  SelectedSelNum: Integer;

  drawingNow: Boolean;

  MinPMD: Double;
  PMD: Double;
  FitPointPosX: Integer;
  FitPointPosY: Integer;
  // Разница шага
  Step: Double;
  // Координаты подходящих точек
  Points: array of TPoint;
  PythonEngine : TPythonEngine;
  PythonModule : TPythonModule;

  YBorderIndent: Integer;

const
  // Масштаб ячеек
  CanvasScale = 100; //%
  // Кратность увеличения по двум
  Multiplicity = 6;

implementation

{$R *.dfm}

uses MainUnit, ExportToTablesUnit, SettingsUnit, FunctionsUnit, VarPyth, SelectionUnit, ProcessingUnit, FilesUnit, TablesUnit;

//

// Активация формы =================================================== ПРОЦЕДУРА
procedure TIsolinesForm.FormActivate(Sender: TObject);
begin
  Selections.UIListFill(SelectionCLB);

  A4RadioButton.Checked := True;
  GridCheck.Checked := True;

  ProgressLabel.Parent := ProgressBar;
  ProgressLabel.Left := 5;
  ProgressLabel.Top := 5;
  ProgressLabel.Transparent := True;

  SignatureEdit.Clear;
  SignatureEdit.Text := Files.GetFileName();

  ShowExtraSettingsBtn.Visible := True;
  ExtraSettingsPanel.Visible := False;
  IsolinesForm.Height := IsolinesForm.Height - ExtraSettingsPanel.Height + 6;
end;

procedure TIsolinesForm.ShowExtraSettingsBtnClick(Sender: TObject);
begin
  ShowExtraSettingsBtn.Visible := False;
  ExtraSettingsPanel.Visible := True;
  IsolinesForm.Height := IsolinesForm.Height + ExtraSettingsPanel.Height;
end;

// Закрытие формы ==================================================== ПРОЦЕДУРА
procedure TIsolinesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  try
////    Scene.free; // очищаем сцену
//  except
//  end;
end;

// Создание формы
procedure TIsolinesForm.FormCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  RebuildPython();
  if not isPythonInitialized then
    Functions.MyMessageDlg('Python не найден!'+#13#10+'Модуль "Изолинии" будет недоступен.',
      mtWarning, [mbYes], ['ОК'], 'Ошибка обработчика', MB_ICONERROR);

  ini := TIniFile.Create(ExtractFileDir(ParamStr(0))+setCfg);
  with ini do
  begin
    InterpLvlEdit.Text := ReadString('IsolinesSettings', 'InterpLvl', '10');
    InterpOrderCB.ItemIndex := ReadInteger('IsolinesSettings', 'InterpOrder', 3);
    LineWidthsCB.ItemIndex := ReadInteger('IsolinesSettings', 'LineWidths', 2);
    FontSizeCB.ItemIndex := ReadInteger('IsolinesSettings', 'FontSize', 3);
    DPIEdit.Text := ReadString('IsolinesSettings', 'DPI', '250');
    Free;
  end;
end;
//
procedure TIsolinesForm.RebuildPython();
begin
  if FileExists(AppPath+'python\python39.dll') then
  try
    FreeAndNil(PythonEngine);
    PythonEngine.Free;
    PythonEngine := TPythonEngine.Create(nil);
    PythonEngine.AutoFinalize := False;
    PythonEngine.AutoLoad := False;
    PythonEngine.UseLastKnownVersion := False;
    PythonEngine.RegVersion := '3.9';
    PythonEngine.APIVersion := 1013;
    PythonEngine.DllName := 'python39.dll';
    PythonEngine.DllPath := AppPath+'python\';
    PythonModule := TPythonModule.Create(Self);
    PythonModule.ModuleName := 'PythonModule';
    PythonModule.Engine := PythonEngine;
    PythonEngine.LoadDll;
    PythonModule.Initialize;
    MaskFPUExceptions(True); // Святая функция
    isPythonInitialized := True;
  except
    isPythonInitialized := False;
    MainForm.exportToIsolinesBtn.Enabled := False;
  end;
end;
//
procedure TIsolinesForm.PythonEngineBeforeLoad(Sender: TObject);
begin
    PythonEngine.SetPythonHome(AppPath+'python\')
end;

// Показ формы ======================================================= ПРОЦЕДУРА
procedure TIsolinesForm.FormShow(Sender: TObject);
var x, y: Integer;
begin
  drawingNow := False;
end;

// Управление мышкой сценой ========================================== ПРОЦЕДУРА
procedure TIsolinesForm.PreviewPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//  Mouse.move(x,y,shift); // обнавляем объект - дальфин в новых координатах
//  Mouse2.move(x,y,shift);
//  Scene.Redraw;
end;

// Обрезка карты битов =============================================== ПРОЦЕДУРА
procedure CropBitmap(InBitmap, OutBitMap : TBitmap; X, Y, W, H :Integer);
begin
  OutBitMap.Width  := 0;
  OutBitMap.Height := 0;
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width  := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X, Y, SRCCOPY);
end;

// Выбор заливки ===================================================== ПРОЦЕДУРА
procedure TIsolinesForm.Fill1RBClick(Sender: TObject);
begin
  Map.wireframe:=2;
  Collider.wireframe:=2;
//  Scene.Redraw;
end;
procedure TIsolinesForm.Fill2RBClick(Sender: TObject);
begin
  Map.wireframe:=1;
  Collider.wireframe:=1;
//  Scene.Redraw;
end;
procedure TIsolinesForm.Fill3RBClick(Sender: TObject);
begin
  Map.wireframe:=0;
  Collider.wireframe:=0;
//  Scene.Redraw;
end;

// Присвоение сигнатуры ============================================== ПРОЦЕДУРА
procedure TIsolinesForm.UseFileNameButtonClick(Sender: TObject);
begin
  SignatureEdit.Text := Files.GetFileName();
end;

procedure TIsolinesForm.ClearSignatureButtonClick(Sender: TObject);
begin
  SignatureEdit.Text := '';
end;


// Кнопка "Сохранить" ================================================ ПРОЦЕДУРА
procedure TIsolinesForm.SaveButtonClick(Sender: TObject);
begin
  DoIsolines();
end;
//
procedure TIsolinesForm.DoIsolines(askForSavePath: Boolean = True);
var
  Jpg: TJPEGImage;
  IsolinesBitmap, A2Bitmap, BitmapPiece: TBitMap;
  i, j, x, y, k, n, temp: Integer;
  // Поправка: доп. ячейки на соседние А4 (для обрезки и склеивания после распечатки)
  cellAdj: Double;
  // Поправка размерности холста
  wdhA2Adj, wdhA4Adj, hgtA2Adj, hgtA4Adj: Double;
  // Цвета
  color1, color2, color3, color4, color5, color6: TColor;
  // Прорисовка фона и очистка канвы
  procedure SetBitmap();
  begin
    IsolinesBitmap := TBitmap.Create;
    IsolinesBitmap.SetSize(Round(((xTableDim+5)*CanvasScale)+YShift), Round(sqrt(2)*(((xTableDim+5)*CanvasScale)+YShift)));
    IsolinesBitmap.Canvas.Pen.Color := clWhite;
    IsolinesBitmap.Canvas.Rectangle(0, 0, Round(2100*x), Round((sqrt(2)*(2100))*y));
  end;

  // Прорисовка сетки
  procedure PaintGrid();
    var y, x: Integer;
  begin
    if GridCheck.Checked then
    begin
      // Цвет
      if SettingsForm.lightGrid.Checked = True then
        IsolinesBitmap.Canvas.Pen.Color := $ebebeb; // $b3b3b3 d9d9d9;
      if SettingsForm.darkGrid.Checked = True then
        IsolinesBitmap.Canvas.Pen.Color := $b3b3b3;
      // Вертикальные линии
      IsolinesBitmap.Canvas.Pen.Width := 2;
      for x:=1 to xTableDim+1 do
      begin
        IsolinesBitmap.Canvas.MoveTo(((x)*CanvasScale), CanvasScale+YBorderIndent);
        IsolinesBitmap.Canvas.LineTo(((x)*CanvasScale), ((yTableDim+1)*CanvasScale+YBorderIndent));
      end;
      // Горизонтальные линии
      for y:=1 to yTableDim+1 do
      begin
        IsolinesBitmap.Canvas.MoveTo(CanvasScale, ((y)*CanvasScale)+YBorderIndent);
        IsolinesBitmap.Canvas.LineTo(((xTableDim+1)*CanvasScale), ((y)*CanvasScale)+YBorderIndent);
      end;
    end;
  end;

  // Указатели координат (серые поля) и рамки (сетка)
  procedure PaintBorder();
  var
    y, x: Integer;
    procedure printborder(mlp1: Integer; mlp2: Integer);
    var
      y, x: Integer;
    begin
      // Вертикальные жирные
      IsolinesBitmap.Canvas.MoveTo(CanvasScale*mlp1, CanvasScale+YBorderIndent);
      IsolinesBitmap.Canvas.LineTo(CanvasScale*mlp1, Round(CanvasScale*(yTableDim+1.5))+YBorderIndent);
        // Ребра
      for x := 2 to xTableDim+1 do
      begin
        IsolinesBitmap.Canvas.MoveTo(CanvasScale*x, CanvasScale*(yTableDim+mlp2)+YBorderIndent);
        IsolinesBitmap.Canvas.LineTo(CanvasScale*x, Round(CanvasScale*(yTableDim+1.5))+YBorderIndent);
      end;
      // Горизонтальные жирные
      IsolinesBitmap.Canvas.MoveTo(35, CanvasScale*(yTableDim+mlp2)+YBorderIndent);
      IsolinesBitmap.Canvas.LineTo(CanvasScale*(xTableDim+1), CanvasScale*(yTableDim+mlp2)+YBorderIndent);
        // Ребра
      for y := 1 to yTableDim+1 do
      begin
        IsolinesBitmap.Canvas.MoveTo(35, CanvasScale*y+YBorderIndent);
        IsolinesBitmap.Canvas.LineTo(CanvasScale*mlp1, CanvasScale*y+YBorderIndent);
      end;
    end;
  begin
    IsolinesBitmap.Canvas.Font.Size := 14;
    IsolinesBitmap.Canvas.Font.Name := 'Segoe UI';
    // Указатели координат (серые поля)
    IsolinesBitmap.Canvas.Brush.Style := bsSolid;
    IsolinesBitmap.Canvas.Brush.Color := $F2F2F2;
    IsolinesBitmap.Canvas.Pen.Color := $F2F2F2;
    // Вертикальная
    IsolinesBitmap.Canvas.Rectangle(35, CanvasScale+YBorderIndent, CanvasScale, CanvasScale*(yTableDim+1)+YBorderIndent);
    // Горизонтальная
    IsolinesBitmap.Canvas.Rectangle(35, CanvasScale*(yTableDim+1)+YBorderIndent, CanvasScale*(xTableDim+1),
      Round(CanvasScale*(yTableDim+1.5))+YBorderIndent);

    // Рамки (сетка)
    IsolinesBitmap.Canvas.Pen.Color := $303030;
    IsolinesBitmap.Canvas.Pen.Width := 5;
    IsolinesBitmap.Canvas.Pen.Style := psSolid;
    printborder(1, 1);
      // Сетка сверки
    if CheckGridCB.Checked then
      printborder(2, 0);
  end;

  // Указатели координат (цифры)
  procedure PaintCoord();
    var y, x: Integer;
  begin
    IsolinesBitmap.Canvas.Font.Name := 'Segoe UI';
    IsolinesBitmap.Canvas.Brush.Style := Vcl.Graphics.bsClear;
    IsolinesBitmap.Canvas.Font.Color := $000000;
    IsolinesBitmap.Canvas.Font.Size := 18;
    SetBkMode(IsolinesBitmap.Canvas.Handle, Transparent);
//      IsolinesBitmap.Canvas.TextOut(60, 60, '0');
    // по X
    // Сверху
//    for x:=1 to xTableDim do
//    begin
//      if x<10 then
//        IsolinesBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/7),
//          Round((CanvasScale/10)*6)+YBorderIndent, IntToStr(x));
//      if x>=10 then
//        IsolinesBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/5),
//          Round((CanvasScale/10)*6)+YBorderIndent, IntToStr(x));
//    end;
    // Снизу
    for x:=1 to xTableDim do
    begin
    if x<10 then
      IsolinesBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/9)+4,
        (CanvasScale*(yTableDim+1))+Round(CanvasScale/16)+YBorderIndent, IntToStr(x));
    if x>=10 then
      IsolinesBitmap.Canvas.TextOut((CanvasScale*(x+1))-Round(CanvasScale/2)-Round(CanvasScale/7),
        (CanvasScale*(yTableDim+1))+Round(CanvasScale/16)+YBorderIndent, IntToStr(x));
    end;
    // по Y
    for y:=1 to yTableDim do
    begin
      if (yTableDim-y+1)<10 then
      begin
        IsolinesBitmap.Canvas.Font.Color := clBlack;
        IsolinesBitmap.Canvas.TextOut(Round((CanvasScale/10)*6),
          (CanvasScale*(y+1))-CanvasScale+Round(CanvasScale/16)+25+YBorderIndent,
          IntToStr(yTableDim-y+1));
      end;
      if (yTableDim-y+1)>=10 then
      begin
        IsolinesBitmap.Canvas.Font.Color := clBlack;
        IsolinesBitmap.Canvas.TextOut(Round((CanvasScale/10)*5),
          (CanvasScale*(y+1))-CanvasScale+Round(CanvasScale/16)+25+YBorderIndent,
          IntToStr(yTableDim-y+1));
      end;
    end;
  end;

  // Прорисовка точек
  procedure PaintDots();
  var
    y, x: Integer;
    tableCell: string;
    procedure TextPrint(color: integer; tableCell: string; alignY: Integer);
    begin
      with IsolinesBitmap.Canvas do
      begin
        Font.Color := color;
        if StrToFloat(tableCell) >= 0 then
          Font.Style := []
        else
          Font.Style := [fsItalic];
        TextOut(
          x*CanvasScale+Round(CanvasScale/2)-2*Round((MainForm.tableD.Canvas.TextWidth(tableCell))/2)+2,
          (CanvasScale*(y+1))-alignY+Round(CanvasScale/28)+YBorderIndent, tableCell);
      end;
    end;
  begin
  // Прорисовка точек координат на сетке
    with IsolinesBitmap.Canvas do
    begin
      for x:=1 to xTableDim do
      for y:=1 to yTableDim do
      begin
        // Точки
        Pen.Color := clBlack;
        Pen.Width := 9;
        SetBkMode(Handle, Transparent);
        MoveTo(x*CanvasScale+Round(CanvasScale/2),
          y*CanvasScale+Round(CanvasScale/2)+YBorderIndent);  // 50 - половина CanvasScale
        LineTo(x*CanvasScale+Round(CanvasScale/2),
          y*CanvasScale+Round(CanvasScale/2)+YBorderIndent);
        // Вес точек
        Font.Size := 18;
        SetBkMode(Handle, Transparent);
        TextPrint($00686868, MainForm.tableD.Cells[x, y], CanvasScale);
        TextPrint($002222FF, MainForm.tableR.Cells[x, y], Round(CanvasScale/2));
      end;
      Font.Style := []
    end;
  end;

  // Поправка изображения (растягивание/сжатие) ------------ ВЛОЖЕННАЯ ПРОЦЕДУРА
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
  begin
    if (SettingsForm.wdhA4CheckBox.Checked = True) then wdhA4Adj := StrToFloat(SettingsForm.wdhA4Edit.Text)
    else wdhA4Adj := 1;
    if (SettingsForm.hgtA4CheckBox.Checked = True) then hgtA4Adj := StrToFloat(SettingsForm.hgtA4Edit.Text)
    else hgtA4Adj := 1;
    oldHeight := Bitmap.Height;
    R.Left := 0; R.Top := 0; R.Right := Round(Bitmap.Width * wdhA4Adj); R.Bottom := Round(Bitmap.Height * hgtA4Adj);
    Bitmap.Canvas.StretchDraw(R, Bitmap);
    Bitmap.SetSize(Bitmap.Width, oldHeight);
  end;

  procedure OpenFolder();
  begin
    ShellExecute(Handle, 'open', PChar(Extractfilepath(MainForm.exportSaveDialog.FileName)), nil, nil, SW_SHOWNORMAL);
  end;

  // Сохранение изображения -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
  procedure savePic(name: String);
  var
    pieceNum: Integer;
    procedure saveBitmapPiece(x1, y1, x2, y2: Integer);
    begin
      CropBitmap(IsolinesBitmap, BitmapPiece, x1 , y1, x2, y2);
      fixA4(BitmapPiece);
      Jpg.Assign(BitmapPiece);
      if (xTableDim > 20) or (yTableDim > 29) then
        Jpg.SaveToFile(name + ' №'+IntToStr(pieceNum)+'.jpg')
      else
        Jpg.SaveToFile(name + '.jpg');
    end;
  begin
    Jpg := TJPEGImage.Create;
    name := Files.CutFileExtension(name);
    // Разрезанное немасштабированное (A4)
    if (A4RadioButton.Checked = True) then
    begin
      pieceNum := 1;
      if (SettingsForm.hgtA4CheckBox.Checked = True) then hgtA4Adj := StrToFloat(SettingsForm.hgtA4Edit.Text)
      else hgtA4Adj := 1;
      cellAdj := (2970 * hgtA4Adj * 2)/29.7;
      BitmapPiece := TBitmap.Create;
      saveBitmapPiece(0, 0, Round(2100), Round(sqrt(2)*(2100)));
      if xTableDim > 20 then
      begin
        pieceNum := pieceNum+1;
        saveBitmapPiece(Round((2100)-cellAdj), 0, Round(2100), Round(sqrt(2)*(2100)));
      end;
      if yTableDim > 29 then
      begin
        pieceNum := pieceNum+1;
        saveBitmapPiece(0, Round((sqrt(2)*(2100))-cellAdj), Round(2100), Round(sqrt(2)*(2100)));
      end;
      if (xTableDim > 20) and (yTableDim > 29) then
      begin
        pieceNum := pieceNum+1;
        saveBitmapPiece(Round((2100)-cellAdj), Round((sqrt(2)*(2100))-cellAdj), Round(2100), Round(sqrt(2)*(2100)));
      end;
      BitmapPiece.Free;
    end;
    // Цельное масштабированное (A4)
    if (A4mRadioButton.Checked = True) then
    begin
      Jpg.Assign(IsolinesBitmap);
      Jpg.SaveToFile(name + '.jpg');
    end;
    // A2
    if (A2RadioButton.Checked = True) then
    begin
      A2Bitmap := TBitmap.Create;
      CropBitmap(IsolinesBitmap, A2Bitmap, 0,0, Round(4200), Round(sqrt(2)*(4200)));
      fixA2(A2Bitmap);
      Jpg.Assign(A2Bitmap);
      Jpg.SaveToFile(name + '.jpg');
    end;
    MainForm.InfoLineUpdate('Изображения успешно созданы');
    Jpg.Free;
    OpenFolder();
  end;

  procedure printTitle;
  var
    Signature: String;
  begin
    IsolinesBitmap.Canvas.Font.Color := clBlack;
    IsolinesBitmap.Canvas.Font.Size := 20;
    if PrintTitleCB.Checked then
    begin
      YBorderIndent := round(CanvasScale*2.2);
      IsolinesBitmap.Canvas.TextOut(round(((xTableDim+1)*CanvasScale)-IsolinesBitmap.Canvas.TextWidth(ApplicationEdit.Text)),
        round(CanvasScale*0.3), ApplicationEdit.Text);
      IsolinesBitmap.Canvas.Font.Size := 30;
      if SignatureEdit.Text = '' then
      begin
        Signature := '__________________';
        IsolinesBitmap.Canvas.TextOut(round(((xTableDim+1)*CanvasScale)/2-IsolinesBitmap.Canvas.TextWidth(Signature)/2),
          CanvasScale, Signature)
      end
      else
      begin
        Signature := SignatureEdit.Text;
        IsolinesBitmap.Canvas.Font.Style := [fsBold];
        IsolinesBitmap.Canvas.TextOut(round(((xTableDim+1)*CanvasScale)/2-IsolinesBitmap.Canvas.TextWidth(Signature)/2),
          CanvasScale, Signature);
        IsolinesBitmap.Canvas.Font.Style := [];
      end;
      IsolinesBitmap.Canvas.Font.Size := 20;
      IsolinesBitmap.Canvas.TextOut(round(((xTableDim+1)*CanvasScale)/2-IsolinesBitmap.Canvas.TextWidth(TypeEdit.Text)/2),
        round(CanvasScale*1.7), TypeEdit.Text);
      IsolinesBitmap.Canvas.TextOut(round(((xTableDim+1)*CanvasScale)/2-IsolinesBitmap.Canvas.TextWidth(ScaleEdit.Text)/2),
        round(CanvasScale*2.2), ScaleEdit.Text);
      IsolinesBitmap.Canvas.Font.Size := round(IsolinesBitmap.Canvas.Font.Size/2);
    end
    else
      YBorderIndent := 0;
  end;

  // Доп. информация под сеткой
  procedure printInfo();
  const
    interlineIndent = 40;
  var
    isoinfo, selectionString: string;
    i, j: Integer;
    YIndent: Integer;
    Signature: String;
  begin
    // Информация
    if PrintInfoCB.Checked then
    begin
      IsolinesBitmap.Canvas.Font.Color := clBlack;
      // Изолинии
      if ModeReviseRB.Checked then
      begin
        isoinfo := 'D - черный контур, R - красный контур';
        YIndent := 2;
        IsolinesBitmap.Canvas.TextOut(CanvasScale, round((yTableDim+1.2)*CanvasScale+(interlineIndent)+YBorderIndent), isoinfo);
      end
      else if ModeСorrelRB.Checked then
      begin
        if PrintLegendCB.Checked then
          YIndent := 8
        else
          YIndent := 1
      end;
      // Выборки, сигмы и средние
      if SelectedSelNum = 1 then
      begin
        selectionString := Selections.GetRangesStr(activeSelIndex) + '; ' + Processing.GetSigmasStr(activeSelIndex);
        IsolinesBitmap.Canvas.TextOut(CanvasScale, round((yTableDim+1.2)*CanvasScale+(interlineIndent*YIndent)+YBorderIndent),
          'Таблица DR;  ' + 'Выборка: '+selectionString);
      end
      else if SelectedSelNum > 1 then
      begin
        j := YIndent;
        IsolinesBitmap.Canvas.TextOut(CanvasScale, round((yTableDim+1.2)*CanvasScale+(interlineIndent*YIndent)+YBorderIndent),
          'Таблица DR;  ' + 'Выборки: ');
        for i := 0 to SelectionCLB.Items.Count-1 do
          if SelectionCLB.Checked[i] then
          begin
            Inc(j);
            selectionString := Selections.GetRangesStr(i) + '; ' + Processing.GetSigmasStr(i);
            IsolinesBitmap.Canvas.TextOut(CanvasScale+20, round((yTableDim+1.2)*CanvasScale+(interlineIndent*j)+YBorderIndent), selectionString);
          end;
      end;
    end;
  end;

  // Создаем в питоне карты изолиний -------------------------------- ВЛОЖЕННАЯ ПРОЦЕДУРА
  procedure PyMarshingSquares();
  var
    // Параметры для обработчика Python
    GridArray: Variant;
    y,x,i,j: Integer;
    // Выборка
    selection: Integer;
    scriptError: Boolean;
    procedure DoScript(script: TStrings);
    begin
      try
        PythonEngine.ExecStrings(script);
      except
        if not scriptError then
        begin
          Functions.MyMessageDlg('Ошибка скрипта обработчика.',
            mtError, [mbYes], ['ОК'], 'Ошибка', MB_ICONWARNING);
          scriptError := True;
        end;
      end;
    end;
  begin
    // Раздельный режим (по одной выборке)
    if SelectedSelNum = 1 then
    begin
      for i := 0 to SelectionCLB.Items.Count - 1 do
        if SelectionCLB.Checked[i] then
        begin
          Selections.Changed(i);
          break
        end;
    end
    // Совместный режим (по поочередному совмещению нескольких выборок)
    else if SelectedSelNum > 1 then
    begin
      for i := 0 to SelectionCLB.Items.Count - 1 do
        if SelectionCLB.Checked[i] then
          Selections.Changed(i, True);
    end;
    // Массив по выбранной таблице
    GridArray := VarArrayCreate([0, yTableDim*xTableDim], varDouble);
    RebuildPython();
    DoScript(PyLibMemo.Lines);
    PythonModule.SetVarFromVariant('linewidths', StrToFloat(LineWidthsCB.Text));
    PythonModule.SetVarFromVariant('fontsize', StrToInt(FontSizeCB.Text));
    PythonModule.SetVarFromVariant('CanvasScale', CanvasScale);
    PythonModule.SetVarFromVariant('order', StrToInt(InterpOrderCB.Text));
    PythonModule.SetVarFromVariant('xCol', xTableDim);
    PythonModule.SetVarFromVariant('yCol', yTableDim);
    PythonModule.SetVarFromVariant('InterpLvl', StrToInt(InterpLvlEdit.Text));
    PythonModule.SetVarFromVariant('Dpi', StrToInt(DPIEdit.Text));
    PythonModule.SetVarFromVariant('IsHatch', IshatchCB.Checked);
    PythonModule.SetVarFromVariant('IsColorMap', IsColorMapCB.Checked);

    // Режим сверки
    if ModeReviseRB.Checked then
    begin
      // D
      j:=0;
      for y:=0 to yTableDim-1 do
      begin
        for x:=0 to xTableDim-1 do
        begin
          GridArray[j] := MainForm.tableD.Cells[x+1, yTableDim-y];  // по оси ординат в обратном порядке (специфика сетки)
          j:=j+1;
        end;
      end;
      PythonModule.SetVarFromVariant('GridArray', GridArray);
      PythonModule.SetVarFromVariant('IsoMode', 'D');
      DoScript(ReviseMemo.Lines);
      FImage := TPicture.Create;
      FImage.LoadFromFile('temp.png');
      IsolinesBitmap.Canvas.Draw(CanvasScale, CanvasScale+YBorderIndent, FImage.Graphic);
      FImage.Free;
      // R
      j:=0;
      for y:=0 to yTableDim-1 do
      begin
        for x:=0 to xTableDim-1 do
        begin
          GridArray[j] := MainForm.tableR.Cells[x+1, yTableDim-y];
          j:=j+1;
        end;
      end;
      PythonModule.SetVarFromVariant('GridArray', GridArray);
      PythonModule.SetVarFromVariant('IsoMode', 'R');
      DoScript(ReviseMemo.Lines);
      FImage := TPicture.Create;
      FImage.LoadFromFile('temp.png');
      IsolinesBitmap.Canvas.Draw(CanvasScale, CanvasScale+YBorderIndent, FImage.Graphic);
      FImage.Free;
    end;

    // Режим корреляции
    if ModeСorrelRB.Checked then
    begin
      j:=0;
      for y:=0 to yTableDim-1 do
      begin
        for x:=0 to xTableDim-1 do
        begin
          GridArray[j] := MainForm.tableD.Cells[x+1, yTableDim-y];
          j:=j+1;
        end;
      end;
      PythonModule.SetVarFromVariant('GridArray', GridArray);
      j:=0;
      for y:=0 to yTableDim-1 do
      begin
        for x:=0 to xTableDim-1 do
        begin
          GridArray[j] := MainForm.tableR.Cells[x+1,yTableDim-y];
          j:=j+1;
        end;
      end;
      PythonModule.SetVarFromVariant('GridArray2', GridArray);
      PythonModule.SetVarFromVariant('IsoMode', 'C');
      DoScript(ReviseMemo.Lines);
      FImage := TPicture.Create;
      FImage.LoadFromFile('temp.png');
      IsolinesBitmap.Canvas.Draw(CanvasScale, CanvasScale+YBorderIndent, FImage.Graphic);
      FImage.Free;
    end;
    DeleteFile('temp.png');
    PythonModule.Finalize;
  end;

  procedure UpdateProcess(text: String);
  begin
    ProgressLabel.Caption := text;
    Application.ProcessMessages;
    ProgressBar.StepIt;
  end;

  procedure PrintLegend();
  begin
    FImage := TPicture.Create;
    if isHatchCB.Checked then
    begin
      FImage.LoadFromFile('legendRED.png');
      IsolinesBitmap.Canvas.Draw(CanvasScale-15, round((yTableDim+2.0)*CanvasScale+YBorderIndent), FImage.Graphic);
      DeleteFile('legendRED.png');
    end;
    FImage.LoadFromFile('legend.png');
    IsolinesBitmap.Canvas.Draw(CanvasScale-15, round((yTableDim+2.0)*CanvasScale+YBorderIndent), FImage.Graphic);
    DeleteFile('legend.png');

    IsolinesBitmap.Canvas.Font.Color := clBlack;
    IsolinesBitmap.Canvas.Font.Size := 20;
    IsolinesBitmap.Canvas.TextOut(CanvasScale, round((yTableDim+1.6)*CanvasScale+YBorderIndent), 'Условные обозначения');
    FImage.Free;
  end;

// ТЕЛО ФУНКЦИИ ====================== Кнопка "Сохранить" ======================= ТЕЛО ФУНКЦИИ
begin
  if SelectedSelNum > 1 then
    if not Selections.IsIntersect(SelectionCLB) then exit;
  if (InterpLvlEdit.Text = '') or (StrToInt(InterpLvlEdit.Text) = 0) then
  begin
    Functions.MyMessageDlg('Установите уровень интерполяции выше нуля.',
      mtWarning, [mbYes], ['ОК'], 'Ошибка обработчика', MB_ICONERROR);
    exit;
  end;

  for i := 0 to SelectionCLB.Items.Count - 1 do
  if SelectionCLB.Checked[i] then
  begin
    activeSelIndex := i;
    break
  end;

  SaveButton.Visible := False;
  ProgressBar.Visible := True;
  ProgressBar.Position := 0;
  ProgressLabel.Visible := True;

  try
    // Прорисовка фона и очистка холста
    UpdateProcess('Подготовка холста...');
    SetBitmap();
    printTitle;
    // Прорисовка сетки
    PaintGrid();
    // Прорисовка изолиний
    UpdateProcess('Построение карты изолиний...');
    try
      PyMarshingSquares();
    except
      Functions.MyMessageDlg('Недостаточно памяти!'+#13#10+
        #13#10+'Для решения проблемы попробуйте следующие действия:'+
        #13#10+'• перезапустите программу и повторите попытку'+
        #13#10+'• уменьшите уровень интерполяции'+#13#10+'• уменьшите качество (DPI)'+
        #13#10+'• декомпозируйте файл и выполните построение'+
        #13#10+'  изолиний на меньшем участке.',
        mtWarning, [mbYes], ['ОК'], 'Ошибка выделения памяти', MB_ICONERROR);
        exit;
    end;
    // Указатели координат (серые поля) и рамки (сетка)
    UpdateProcess('Отрисовка элементов холста...');
    if CoordsCB.Checked then
    begin
      PaintBorder();
      // Указатели координат (цифры)
      PaintCoord();
    end;
    // Прорисовка точек
    if (DotsCheckCB.Checked) then PaintDots();
    if PrintLegendCB.Checked and ModeСorrelRB.Checked then PrintLegend();
    // Доп. информация под сеткой
    printinfo();

    // Сохранить файл
    UpdateProcess('Сохранение файла...');
    try
      if askForSavePath then
      begin
        MessageBeep(MB_ICONASTERISK);
        MainForm.exportSaveDialog.FileName := TPath.GetFileNameWithoutExtension(LoadedFileName) + '.jpg';
        if MainForm.exportSaveDialog.Execute then savePic(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)
          + ' ('+SelectionsList[activeSelIndex].Name+')' + '.jpg');
      end
      else
      begin
        savePic(Files.CutFileExtension(MainForm.exportSaveDialog.FileName)
          + ' ('+SelectionsList[activeSelIndex].Name+')' + '.jpg');
      end;
    except
      Functions.MyMessageDlg('Не удалось сохранить файл!'+#13#10+
        #13#10+'Попробуйте сохранить без изменения имени.',
        mtError, [mbYes], ['ОК'], 'Ошибка сохранения', MB_ICONWARNING);
    end;

    IsolinesBitmap.SetSize(0, 0);
  finally
    Selections.Changed(activeSelIndex);
    ProgressBar.Visible := False;
    SaveButton.Visible := True;
    ProgressLabel.Visible := False;
  end;
end;

// Активация выборки в списке
procedure TIsolinesForm.SelectionCLBClick(Sender: TObject);
var
  i: Integer;
begin
  SelectedSelNum := 0;
  for i := 0 to SelectionCLB.Items.Count - 1 do
    if SelectionCLB.Checked[i] then
      Inc(SelectedSelNum);

  if Selections.IsActiveInUIList(SelectionCLB) then
    SaveButton.Enabled := True
  else
    SaveButton.Enabled := False;
end;

// Изменение режима
procedure TIsolinesForm.ModeReviseRBClick(Sender: TObject);
begin
  if ModeReviseRB.Checked then DotsCheckCB.Enabled := True
  else DotsCheckCB.Enabled := False;

  InterpLvlEdit.Text := '10';
  DotsCheckCB.Checked := True;
  CheckGridCB.Checked := True;

  FontSizeLabel.Enabled := True;
  FontSizeCB.Enabled := True;

  PrintLegendCB.Enabled := False;
  IsHatchCB.Enabled := False;
  IsColorMapCB.Enabled := False;
end;
//
procedure TIsolinesForm.ModeСorrelRBClick(Sender: TObject);
begin
  InterpLvlEdit.Text := '40';
  DotsCheckCB.Checked := False;
  CheckGridCB.Checked := False;

  FontSizeLabel.Enabled := False;
  FontSizeCB.Enabled := False;

  PrintLegendCB.Enabled := True;
  IsHatchCB.Enabled := True;
  IsColorMapCB.Enabled := True;
end;

// Переключение выборки для просмотра
procedure TIsolinesForm.SelectionCLBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  prevIndex: Integer;
begin
  try
    prevIndex := activeSelIndex;
    activeSelIndex := SelectionCLB.ItemIndex;
    Selections.Changed(activeSelIndex);
    MainForm.InfoLineUpdate('Произведен рассчет по выборке "' + SelectionsList[activeSelIndex].Name + '"',
      '', clMenuHighlight);
  except
    activeSelIndex := prevIndex;
//    ShowMessage('Error');
  end;
end;

procedure TIsolinesForm.PrintTitleCBClick(Sender: TObject);
begin
  ApplicationEdit.Enabled := PrintTitleCB.Checked;
  SignatureEdit.Enabled := PrintTitleCB.Checked;
  TypeEdit.Enabled := PrintTitleCB.Checked;
  ScaleEdit.Enabled := PrintTitleCB.Checked;
  UseFileNameButton.Enabled := PrintTitleCB.Checked;
  ClearSignatureButton.Enabled := PrintTitleCB.Checked;
end;

procedure TIsolinesForm.InterpLvlEditChange(Sender: TObject);
begin
  SettingsForm.SaveSetting('IsolinesSettings', 'InterpLvl', InterpLvlEdit.Text);
end;

procedure TIsolinesForm.InterpOrderCBChange(Sender: TObject);
begin
  SettingsForm.SaveSetting('IsolinesSettings', 'InterpOrder', InterpOrderCB.ItemIndex);
end;

procedure TIsolinesForm.LineWidthsCBChange(Sender: TObject);
begin
  SettingsForm.SaveSetting('IsolinesSettings', 'LineWidths', LineWidthsCB.ItemIndex);
end;

procedure TIsolinesForm.FontSizeCBChange(Sender: TObject);
begin
  SettingsForm.SaveSetting('IsolinesSettings', 'FontSize', FontSizeCB.ItemIndex);
end;

procedure TIsolinesForm.DPIEditChange(Sender: TObject);
begin
  SettingsForm.SaveSetting('IsolinesSettings', 'DPI', DPIEdit.Text);
end;

procedure TIsolinesForm.IsColorMapCBClick(Sender: TObject);
begin
  if (IsHatchCB.Checked = False) and (IsColorMapCB.Checked = False) then IsHatchCB.Checked := True;
end;

procedure TIsolinesForm.IsHatchCBClick(Sender: TObject);
begin
  if (IsHatchCB.Checked = False) and (IsColorMapCB.Checked = False) then IsColorMapCB.Checked := True;
end;

end.

