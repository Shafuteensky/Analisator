unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.ButtonGroup, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, iniFiles, Vcl.CheckLst, SelectionUnit;

type
  TMainForm = class(TForm)
    loadingBuffer: TMemo;
    // Основные панели
    menuPnl: TPanel;
    toolsPnl: TScrollBox;
    toolsPnlBevel: TBevel;
    tableA: TStringGrid;
    tableB: TStringGrid;
    tableD: TStringGrid;
    tableR: TStringGrid;
    tableAB: TStringGrid;
    tableDR: TStringGrid;
    // Стартовая панель
    startPanel: TPanel;
    appIconlarge: TImage;
    // Диалоговые окна
    fileSaveDialog: TSaveDialog;
    fileOpenDialog: TOpenDialog;
    exportSaveDialog: TSaveDialog;
    // Меню
    toolBar: TToolBar;
    menu: TMainMenu;
    menuFileBtn: TMenuItem;
    createFileBtn: TMenuItem;
    openFileBtn: TMenuItem;
    saveFileBtn: TMenuItem;
    saveAsFileBtn: TMenuItem;
    closeFileBtn: TMenuItem;
    menuExportBtn: TMenuItem;
    exportToTablesBtn: TMenuItem;
    exportToIsolinesBtn: TMenuItem;
    menuAggregationBtn: TMenuItem;
    openCompositionFormBtn: TMenuItem;
    openDecompositionFormBtn: TMenuItem;
    menuOptionsBtn: TMenuItem;
    openSettingsFormBtn: TMenuItem;
    openInfoFormBtn: TMenuItem;
    menuOptionsSeparator: TMenuItem;
    exitApplicationBtn: TMenuItem;
    // Выборки (всплывающее меню)
    selectionPopupMenu: TPopupMenu;
    setFirstSelectionQBtn: TMenuItem;
    setLastSelectionQBtn: TMenuItem;
    selectionPopupMenuSeparator: TMenuItem;
    setFirstSelectionSBtn: TMenuItem;
    setLastSelectionSBtn: TMenuItem;
    setFullSelectionSBtn: TMenuItem;
    // Агрегация (всплывающее меню)
    decompPopupMenu: TPopupMenu;
    setFirstDecompBtn: TMenuItem;
    setLastDecompBtn: TMenuItem;
    compPopupMenu: TPopupMenu;
    insertCompBtn: TMenuItem;
    // Таблицы
    tableBtnsPnl: TPanel;
    activeTableLabel: TLabel;
    openTableABtn: TButton;
    openTableBBtn: TButton;
    openTableDBtn: TButton;
    openTableRBtn: TButton;
    tableBtnsPnlBevel2: TBevel;
    tableBtnsPnlBevel1: TBevel;
    tableBtnsPnlBevel3: TBevel;
    tableBtnsPnlLabel: TLabel;
    // Координаты
    coordsPnl: TPanel;
    xCoordEdit: TEdit;
    yCoordEdit: TEdit;
    coordsPnlBevel: TBevel;
    coordsPnlLabel1: TLabel;
    coordsPnlLabel2: TLabel;
    coordsPnlLabel: TLabel;
    // Выборки
    selPnl: TPanel;
    selQPnl: TPanel;
    selFirstQXEdit: TEdit;
    selFirstQYEdit: TEdit;
    selLastQXEdit: TEdit;
    selLastQYEdit: TEdit;
    selSPnl: TPanel;
    selFirstSXEdit: TEdit;
    selFirstSYEdit: TEdit;
    selLastSXEdit: TEdit;
    selLastSYEdit: TEdit;
    selSwitchPnl: TPanel;
    selPrevBtn: TButton;
    selNameEdit: TEdit;
    selNextBtn: TButton;
    selControlPnl: TPanel;
    selAddBtn: TButton;
    selDeleteBtn: TButton;
    selPnlBevel4: TBevel;
    selPnlBevel2: TBevel;
    selPnlBevel3: TBevel;
    selQPnlLabel1: TLabel;
    selQPnlLabel2: TLabel;
    selQPnlLabel3: TLabel;
    selQPnlLabel4: TLabel;
    selSPnlLabel1: TLabel;
    selSPnlLabel2: TLabel;
    selSPnlLabel3: TLabel;
    selSPnlLabel4: TLabel;
    selPnlBevel1: TBevel;
    selPnlLabel: TLabel;
    // Сигмы
    sigmasPnl: TPanel;
    sigmaAPanel: TPanel;
    sigmaAEdit: TEdit;
    sigmaBPanel: TPanel;
    sigmaBEdit: TEdit;
    sigmaALabel: TLabel;
    sigmaBLabel: TLabel;
    sigmasPnlBevel: TBevel;
    sigmasPnlLabel: TLabel;
    // Панель уведомлений
    notificationPnl: TPanel;
    TestEdit: TEdit;
    notificationText: TLabel;
    helpLabel: TLabel;
    menuImportBtn: TMenuItem;
    importFromExcelAB12Btn: TMenuItem;
    importOpenDialog: TOpenDialog;
    menuDrawBtn: TMenuItem;
    meanAPnl: TPanel;
    meanPnlALabel: TLabel;
    meanAEdit: TEdit;
    meanBPnl: TPanel;
    meanPnlBLabel: TLabel;
    meanBEdit: TEdit;
    Bevel1: TBevel;
    FixedSigmasCB: TCheckBox;
    Bevel2: TBevel;
    N1: TMenuItem;
    AutoSelectionBtn: TMenuItem;
    Panel1: TPanel;
    Label2: TLabel;
    Bevel3: TBevel;
    Do5RevisesBtn: TButton;
    DoReviseBtn: TButton;
    Panel2: TPanel;
    Button5: TButton;
    Button4: TButton;

    // Файл
    procedure createFileBtnClick(Sender: TObject);
    procedure openFileBtnClick(Sender: TObject);
    procedure saveFileBtnClick(Sender: TObject);
    procedure saveAsFileBtnClick(Sender: TObject);
    procedure closeFileBtnClick(Sender: TObject);
    // Экспорт
    procedure exportToTablesBtnClick(Sender: TObject);
    procedure exportToIsolinesBtnClick(Sender: TObject);
    // Опции
    procedure openSettingsFormBtnClick(Sender: TObject);
    procedure openInfoFormBtnClick(Sender: TObject);
    procedure exitApplicationBtnClick(Sender: TObject);
    // Таблицы
    procedure openTableABtnClick(Sender: TObject);
    procedure openTableBBtnClick(Sender: TObject);
    procedure openTableDBtnClick(Sender: TObject);
    procedure openTableRBtnClick(Sender: TObject);
    // Выборки
    procedure selPrevBtnClick(Sender: TObject);
    procedure selNextBtnClick(Sender: TObject);
    procedure selAddBtnClick(Sender: TObject);
    procedure selDeleteBtnClick(Sender: TObject);
    procedure tableAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure selNameEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure selNameEditKeyPress(Sender: TObject; var Key: Char);
    // Выборки (всплывающее меню)
    procedure setFirstSelectionQBtnClick(Sender: TObject);
    procedure setLastSelectionQBtnClick(Sender: TObject);
    procedure setFirstSelectionSBtnClick(Sender: TObject);
    procedure setLastSelectionSBtnClick(Sender: TObject);
    procedure setFullSelectionSBtnClick(Sender: TObject);
    // Таблицы
    procedure StringGridClick(StringGrid: TStringGrid);
    procedure tableAClick(Sender: TObject);
    procedure tableBClick(Sender: TObject);
    procedure tableDClick(Sender: TObject);
    procedure tableRClick(Sender: TObject);
    procedure tableABClick(Sender: TObject);
    procedure tableDRClick(Sender: TObject);
    procedure tableASelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableBSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableRSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableDSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableABSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableDRSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure tableASetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure tableBSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGridKeyPress(StringGrid: TStringGrid; var Key: Char);
    procedure tableAKeyPress(Sender: TObject; var Key: Char);
    procedure tableADrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure tableAMouseEnter(Sender: TObject);
    procedure tableAMouseLeave(Sender: TObject);
    // Композиция и декомпозиция (всплывающее меню)
    procedure openDecompositionFormBtnClick(Sender: TObject);
    procedure setFirstDecompBtnClick(Sender: TObject);
    procedure openCompositionFormBtnClick(Sender: TObject);
    procedure insertCompBtnClick(Sender: TObject);
    // Форма
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    // Обработка
    procedure InfoLineUpdate(TextCaption: string; LabelCaption: string=''; FontColor: Integer=clWindowText);
    procedure GridToMemo;
    procedure MemoEmpty;
    procedure importFromExcelAB12BtnClick(Sender: TObject);
    procedure menuDrawBtnClick(Sender: TObject);
    procedure FixedSigmasCBClick(Sender: TObject);
    procedure sigmaAEditChange(Sender: TObject);
    procedure sigmaAEditKeyPress(Sender: TObject; var Key: Char);
    procedure sigmasPnlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure menuAutoSelectionBtnClick(Sender: TObject);
    procedure AutoSelectionBtnClick(Sender: TObject);
    procedure DoReviseBtnClick(Sender: TObject);
    procedure tableDRDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure Do5RevisesBtnClick(Sender: TObject);
    // Устаревшие -------------------------------------------------------------
    // procedure aTransferButtonClick(Sender: TObject);
    // procedure bTransferButtonClick(Sender: TObject);
    // procedure qEditXChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  isMouseOnTable: Boolean;
  isFileOpened: Boolean;
  isFileNew: Boolean;
  isPythonInitialized: Boolean;
  isFileChanged: Boolean;
  isSelSwitched: Boolean;
  xTableDim: Integer;
  yTableDim: Integer;
  SelectionsList: array of TSelection;
  isSelEditing: Boolean;
  activeSelIndex: Integer;
  ExcelApp: OleVariant;
  AppPath: string;

implementation

{$R *.dfm}

uses CreateUnit, SettingsUnit, InformationUnit, OleAuto, Math, ExportToTablesUnit,
  IsolinesUnit, FunctionsUnit, ParamsUnit, DecompositionUnit, CompositionUnit, DrawUnit, SigmasTransferUnit,
  AutoSelectionUnit, FilesUnit, TablesUnit, ProcessingUnit;

// Очистка буфера (memo) ================================ ПРОЦЕДУРА
procedure TmainForm.MemoEmpty;
var i: Integer;
begin
  for i:=0 to loadingBuffer.Lines.Count - 1 do
    loadingBuffer.Lines.Delete(i);
  loadingBuffer.Lines.Clear;
end;

// Строка уведомлений ================================ ПРОЦЕДУРА
procedure TmainForm.InfoLineUpdate(TextCaption: string; LabelCaption: string=''; FontColor: Integer=clWindowText);
begin
  notificationText.Font.Color := FontColor;
  notificationText.Caption := TextCaption;
  helpLabel.Caption := LabelCaption;
end;

//procedure TMainForm.WarningLine(Variant: String);
//begin
//  if Variant = 'TableOpened' then LineUpdate('Открыта таблица ' + activeTableLabel.Caption, '')
//  else if Variant = 'OpenNoSelection' then LineUpdate('Открыт существующий файл', ' (Данные о выборках отсутствуют: для произведения рассчета необходимо создать выборку)')
//  else if Variant = 'OpenSelection' then LineUpdate('Открыт существующий файл, выборки загружены, произведен рассчет', '')
//  else if Variant = 'New' then LineUpdate('Создан новый файл')
//  else if Variant = 'Close' then LineUpdate('Файл закрыт')
//  else if Variant = 'Save' then
//  else if Variant = 'Calculation' then LineUpdate('Произведен рассчет')
//  else if Variant = 'CalculationErrorNoData' then LineUpdate('Рассчет не произведен: недостаточно данных', ' (Заполните таблицы A и/или B)', clRed)
//  else if Variant = 'CalculationErrorNoSelection' then LineUpdate('Рассчет не произведен: нет расчетного диапазона', ' (Для произведения рассчета необходимо создать выборку)', clRed)
//  else if Variant = 'CalculationError' then LineUpdate('Рассчет не произведен: недостаточно данных; нет расчетного диапазона', ' (Заполните таблицы A и/или B; Для произведения рассчета необходимо создать выборку)', clRed)
//  else if Variant = 'SettingsChanged' then LineUpdate('Настройки изменены')
//  else if Variant = 'GridTextChanged' then LineUpdate('Изменено значение ячейки, произведен расчет')
//  else if Variant = 'SelectionCreated' then LineUpdate('Новая выборка сохранена, произведен расчет')
//  else if Variant = 'SelectionNotCreated' then LineUpdate('Выборка не сохранена')
//  else if Variant = 'SelectionDeleted' then LineUpdate('Выборка удалена')
//  else if Variant = 'SelectionCreating' then LineUpdate('Выборка в процессе создания', ' (Выберите ячейку в таблице левой кнопкой мыши, затем определите ее как начало/конец правой кнопкой и подтвердите нажатием по кнопке с галочкой)', clMenuHighlight)
//  else if Variant = 'SelectionSwitched' then LineUpdate('Произведен рассчет по выборке "' + SelectionsList[activeSelIndex].Name + '"', '', clMenuHighlight)
//  else if Variant = 'FirstSelSelected' then LineUpdate('Заданы координаты начала диапазона выборки', '', clMenuHighlight)
//  else if Variant = 'LastSelSelected' then LineUpdate('Заданы координаты конца диапазона выборки', '', clMenuHighlight)
//  else if Variant = 'FirstSelSSelected' then LineUpdate('Заданы координаты начала площади выборки', '', clMenuHighlight)
//  else if Variant = 'LastSelSSelected' then LineUpdate('Заданы координаты конца площади выборки', '', clMenuHighlight)
//  else if Variant = 'ExcelImport' then
//  else if Variant = 'PictureImport' then
//  else if Variant = 'IsolinesImport' then LineUpdate('Карта изолиний успешно создана')
//  else if Variant = 'DecompositionStarted' then LineUpdate('Запущен модуль декомпозиции', ' (Выберите ячейки начала/конца диапазона декомпозиции в таблице левой кнопкой мыши либо через меню "Четверть")')
//  else if Variant = 'DecompositionSaved' then LineUpdate('Файл декомпозирован как "'+DecompositionForm.SaveDialog.FileName+'"')
//  else if Variant = 'CompositionStarted' then LineUpdate('Запущен модуль композиции', ' (Выберите файл, затем правой кнопкой мыши по таблице выберите координату композиции)')
//  else if Variant = 'СompositionDone' then LineUpdate('Произведена композиция файла "'+CompositionForm.OpenDialog1.FileName+'"')
//  else if Variant = 'FileImported' then LineUpdate('Произведен импорт файла "'+importOpenDialog.FileName+'"');
//end;

// Перевод всех данных в буфер (memo) ================================ ПРОЦЕДУРА
procedure TMainForm.GridToMemo;
var
  x: Integer; y: Integer;
begin
  Screen.Cursor := crHourGlass;
  loadingBuffer.Lines.Clear;
  // (0) - количество рядов в таблицах (x)
  loadingBuffer.Lines.Add(IntToStr(tableA.ColCount-1));
  // (1) - количество колонн в таблицах (y)
  loadingBuffer.Lines.Add(IntToStr(tableA.RowCount-1));
  // (2, x*y+1) - таблица А
  for x := 1 to StrToInt(loadingBuffer.Lines.Strings[1]) do
    for y := 1 to StrToInt(loadingBuffer.Lines.Strings[0])  do
    begin
      loadingBuffer.Lines.Add(tableA.Cells[y,x]);
    end;
  // (x*y+2, x*y*2+1) - таблица B
  for x := 1 to StrToInt(loadingBuffer.Lines.Strings[1]) do
    for y := 1 to StrToInt(loadingBuffer.Lines.Strings[0]) do
    begin
      loadingBuffer.Lines.Add(tableB.Cells[y,x]);
    end;
  // После А и В количество элементов в массиве выборки (по x)
  // (x*y*2+2) - количество выборок
  loadingBuffer.Lines.Add(IntToStr(Length(SelectionsList)));
  // Поочередно значения по y
  // (x*y*2+3, x*y*2+7) - первая выборка
  // (x*y*2+8, x*y*2+12) - вторая выборка
  // (x*y*2+13, x*y*2+17) - третья выборка
  // (x*y*2+18, x*y*2+22) - четвертая выборка
  if (Length(SelectionsList) > 0) then
  begin
    for x := 0 to (Length(SelectionsList) - 1) do
    begin
      loadingBuffer.Lines.Add(IntToStr(SelectionsList[x].DefMatrixStartX));
      loadingBuffer.Lines.Add(IntToStr(SelectionsList[x].DefMatrixStartY));
      loadingBuffer.Lines.Add(IntToStr(SelectionsList[x].DefMatrixEndX));
      loadingBuffer.Lines.Add(IntToStr(SelectionsList[x].DefMatrixEndY));
    end;
  end;
  //
  Screen.Cursor := crDefault;
end;

// -----------------------------------------------------------------------------

// Создание формы (Запуск программы) ================================ ПРОЦЕДУРА
procedure TMainForm.FormCreate(Sender: TObject);
begin
  AppPath := IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
  Selections.Clear;
  isFileOpened := False;
  isFileNew := False;
  isFileChanged := False;
  isSelSwitched := True;
  toolsPnl.Enabled := False;
  InfoLineUpdate('Программа запущена');

  // Загрузка через ассоциацию
  if FileExists(ParamStr(1)) then
  begin
    fileSaveDialog.FileName := '';
    fileOpenDialog.FileName := ParamStr(1);
    Files.Load;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  toolsPnl.AutoSize := True;
  toolsPnl.AutoSize := False;
end;

// Кнопка меню: Создание нового файла ================================ ПРОЦЕДУРА
procedure TMainForm.createFileBtnClick(Sender: TObject);
begin
  CreateForm.ShowModal;
end;

// Кнопка меню: Открыть ================================ ПРОЦЕДУРА
procedure TMainForm.openFileBtnClick(Sender: TObject);
begin
  fileSaveDialog.FileName := '';
  fileOpenDialog.FileName := '';
  if fileOpenDialog.Execute then
    Files.Load;
end;

// Кнопка меню: Быстрое сохранение файла ================================ ПРОЦЕДУРА
procedure TMainForm.saveFileBtnClick(Sender: TObject);
begin
  Files.Save(True);
end;

// Кнопка меню: "Сохранить как" ================================ ПРОЦЕДУРА
procedure TMainForm.saveAsFileBtnClick(Sender: TObject);
begin
  Files.Save(False);
end;

// Кнопка меню: Закрытие файла ================================ ПРОЦЕДУРА
procedure TMainForm.closeFileBtnClick(Sender: TObject);
var
  x, y: Integer;
begin
  if isFileChanged = True then
  begin
    if Functions.MyMessageDlg('Сохранить текущий файл перед закрытием?',
      mtInformation, [mbYes, mbNo], ['Да','Нет'], 'Подтверждение', MB_ICONWARNING) = mrYes then
        Files.Save(True);
  end;
  LoadedFileName := '';

  // Вспомогательные переменные / интерфейс / функции
  if isSelEditing = True then
    selDeleteBtn.Click;
  selPnlLabel.Caption := 'Выборки';
  MemoEmpty;
  Selections.Clear;
  isFileOpened := False;
  isFileNew := False;
  isFileChanged := False;

  saveAsFileBtn.Enabled := False;
  saveFileBtn.Enabled := False;
  closeFileBtn.Enabled := False;
  exportToTablesBtn.Enabled := False;
  exportToIsolinesBtn.Enabled := False;
  openDecompositionFormBtn.Enabled := False;
  openCompositionFormBtn.Enabled := False;

  MainForm.Caption := 'Анализатор';
  toolsPnl.Enabled := False;
  toolsPnl.Visible := False;
  tableA.Visible := False;
  tableB.Visible := False;
  tableD.Visible := False;
  tableR.Visible := False;
  tableAB.Visible := False;
  tableDR.Visible := False;
  startPanel.Visible := True;
  InfoLineUpdate('Файл закрыт');
  Screen.Cursor := crDefault;
end;

// Кнопка меню: Экпорт
  // Таблицы  ================================ ПРОЦЕДУРА
procedure TMainForm.exportToTablesBtnClick(Sender: TObject);
var
  ExcelApp: OleVariant;
begin
//  Calculation(activeSelIndex);
  ExportToTablesForm.ShowModal;
end;
  // Изолинии ================================ ПРОЦЕДУРА
procedure TMainForm.exportToIsolinesBtnClick(Sender: TObject);
begin
  IsolinesForm.Free;
  IsolinesForm := TIsolinesForm.Create(Self);
  IsolinesForm.ShowModal;
end;

// Кнопка меню: Импорт
procedure TMainForm.importFromExcelAB12BtnClick(Sender: TObject);
var
  xExcelDim, yExcelDim: Integer;
  WorkSheet: OLEVariant;

  function isExcelInitialised: Boolean;
  begin
    try
      ExcelApp := CreateOLEObject('Excel.Application');
      result := True;
    except
      on E: Exception do
      begin
        ShowMessage('Файл не может быть импортирован:' + sLineBreak + 'На компьютере отсутствует Excel подходящей версии.');
        result := False;
      end;
    end;
  end;

  procedure getDims();
  var
    i, j, k, n: Integer;
    templateRowHeight: Integer; // В шаблоне AB12 каждый ряд разделен на 3 строки по 12 (12+12+10)
  begin
    j := -1;
    for templateRowHeight := 2 to 4 do
    begin
      j := j+7;
      for i := 2 to 13 do
      begin
        if WorkSheet.Cells.Item[j, i].Text <> '' then
          xExcelDim := xExcelDim+1
        else
          break;
      end;
    end;

    k := -15;
    for j := 2 to 38 do
    begin
      k := k+21;
      if WorkSheet.Cells.Item[k, 2].Text <> '' then
        yExcelDim := yExcelDim+1
      else
        break;
    end;
  end;

  function prepareFile: Boolean;
  begin
    result := True;
    if isFileOpened then
    begin
      if Functions.MyMessageDlg('В какой файл будет произведен импорт?',
        mtCustom, [mbYes, mbNo], ['Новый', 'Активный'], 'Выбор', MB_ICONWARNING) = mrYes then
      begin
        if Functions.MyMessageDlg('Для продолжения необходимо закрыть активный файл.',
          mtInformation, [mbYes, mbNo], ['Закрыть', 'Отмена'], 'Подтверждение', MB_ICONWARNING) = mrYes then
        begin
          closeFileBtn.Click;
          CreateForm.createFile(xExcelDim, yExcelDim);
        end
        else
          result := False;
      end
      else
      begin
        if (xTableDim <> xExcelDim) or (yTableDim <> yExcelDim) then
          Functions.MyMessageDlg('Размерности импортируемого файла и активного различаются!'+#13#10+
            'Расположение данных может быть неверным, или некоторые'+#13#10+
            'данные могут быть утерянны.', mtWarning, [mbOk], ['OK'], 'Несовпадение размерностей', MB_ICONWARNING)
      end;
    end
    else
    begin
      CreateForm.createFile(xExcelDim, yExcelDim);
    end;
  end;

  procedure fillGridFromExcel;
  var
    table: ^TStringGrid;
    isTableHaveData: Boolean;

    procedure fillData;
    var
      i, j, x, y, k, n: Integer;
    begin
      MainForm.Enabled := False;
      Screen.Cursor := crHourGlass;
      for j := 0 to yExcelDim-1 do
      begin
        i := 1;
        for n := 1 to 3 do
        begin
          y := y+7;
          for x := 2 to 13 do
          begin
            if WorkSheet.Cells.Item[y, x].Text <> '' then
              table.Cells[i, yExcelDim-j] := WorkSheet.Cells.Item[y, x].Text;
            i := i+1;
          end;
        end;
      end;
      isFileChanged := True;
      MainForm.Enabled := True;
      Screen.Cursor := crDefault;
    end;

  begin
    try
      if Functions.MyMessageDlg('Выберите таблицу для импорта.',
        mtCustom, [mbYes, mbNo], ['A','B'], 'Выбор таблицы', MB_ICONWARNING) = mrYes then
      begin
        isTableHaveData := Tables.IsNotOnlyZerosData(tableA);
        table := @tableA
      end
      else
      begin
        isTableHaveData := Tables.IsNotOnlyZerosData(tableB);
        table := @tableB;
      end;

      if isTableHaveData then
      begin
        if Functions.MyMessageDlg('В выбранной таблице содержатся данные.'+#13#10+'При импорте они будут изменены.'
          +#13#10+'Все равно продолжить?', mtWarning, [mbYes, mbNo], ['Да','Отмена'], 'Предупреждение',
          MB_ICONWARNING) = mrYes then
        begin
          fillData;
        end
      end
      else
        fillData;
    finally
      ExcelApp.Workbooks.close;
    end;
  end;

begin
  if isExcelInitialised and importOpenDialog.Execute then
  begin
    ExcelApp.Workbooks.Open(importOpenDialog.FileName);
    WorkSheet := ExcelApp.ActiveWorkbook.ActiveSheet;
    getDims;
    if prepareFile then
    begin
      fillGridFromExcel;
      InfoLineUpdate('Произведен импорт файла "'+importOpenDialog.FileName+'"');
    end;
  end;
end;

// Кнопка меню: Редактор
procedure TMainForm.menuDrawBtnClick(Sender: TObject);
begin
  Application.CreateForm(TForm2, DrawForm);
  DrawForm.Show;
end;

procedure TMainForm.menuAutoSelectionBtnClick(Sender: TObject);
begin
  AutoSelectionForm.ShowModal;
end;

// Кнопка меню: Агрегация
  // Декомпозиция ================================ ПРОЦЕДУРА
procedure TMainForm.openDecompositionFormBtnClick(Sender: TObject);
begin
  setFirstDecompBtn.Checked := False;
  setLastDecompBtn.Checked := False;
  DecompositionForm.Show;
end;
  // Композиция ================================ ПРОЦЕДУРА
procedure TMainForm.openCompositionFormBtnClick(Sender: TObject);
begin
  CompositionForm.Show;
end;
// -----------------------------------------------------------------------------

// Всплывающее меню: диапазон выборки ================================ ПРОЦЕДУРА
procedure TMainForm.setFirstSelectionQBtnClick(Sender: TObject);
var
  table: ^TStringGrid;
begin
  if tableA.Visible then
    table := @tableA
  else if tableB.Visible then
    table := @tableB;

  SelectionsList[activeSelIndex].SetDefMatrixStart(table.Col, table.Row);
  
  selFirstQXEdit.Text := IntToStr(SelectionsList[activeSelIndex].DefMatrixStartX);
  selFirstQYEdit.Text := IntToStr(yTableDim+1 - SelectionsList[activeSelIndex].DefMatrixStartY);
  setFirstSelectionQBtn.Checked := True;
  InfoLineUpdate('Заданы координаты начала матрицы определения выборки', '', clMenuHighlight);
  Selections.Changed(activeSelIndex);
end;
//
procedure TMainForm.setLastSelectionQBtnClick(Sender: TObject);
var
  table: ^TStringGrid;
begin
  if tableA.Visible then
    table := @tableA
  else if tableB.Visible then
    table := @tableB;

  SelectionsList[activeSelIndex].SetDefMatrixEnd(table.Col, table.Row);
  
  selLastQXEdit.Text := IntToStr(SelectionsList[activeSelIndex].DefMatrixEndX);
  selLastQYEdit.Text := IntToStr(yTableDim+1 - SelectionsList[activeSelIndex].DefMatrixEndY);
  setLastSelectionQBtn.Checked := True;
  InfoLineUpdate('Заданы координаты конца матрицы определения выборки', '', clMenuHighlight);
  Selections.Changed(activeSelIndex);
end;

// Всплывающее меню: площадь выборки ================================ ПРОЦЕДУРА
procedure TMainForm.setFirstSelectionSBtnClick(Sender: TObject);
var
  table: ^TStringGrid;
begin
  if tableA.Visible then
    table := @tableA
  else if tableB.Visible then
    table := @tableB;

  SelectionsList[activeSelIndex].SetCalcAreaStart(table.Col, table.Row);

  selFirstSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaStartX);
  selFirstSYEdit.Text := IntToStr(yTableDim+1 - SelectionsList[activeSelIndex].CalcAreaStartY);
  setFirstSelectionSBtn.Checked := True;
  InfoLineUpdate('Заданы координаты начала области расчета выборки', '', clMenuHighlight);
  Selections.Changed(activeSelIndex);
  if (SelectionsList[activeSelIndex].CalcAreaStartX > 0) and (SelectionsList[activeSelIndex].CalcAreaStartY > 0) and
    (SelectionsList[activeSelIndex].CalcAreaEndX > 0) and (SelectionsList[activeSelIndex].CalcAreaEndY > 0) then
    AutoSelectionBtn.Enabled := True;
end;
//
procedure TMainForm.setLastSelectionSBtnClick(Sender: TObject);
var
  table: ^TStringGrid;
begin
  if tableA.Visible then
    table := @tableA
  else if tableB.Visible then
    table := @tableB;

  SelectionsList[activeSelIndex].SetCalcAreaEnd(table.Col, table.Row);

  selLastSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaEndX);
  selLastSYEdit.Text := IntToStr(yTableDim+1 - SelectionsList[activeSelIndex].CalcAreaEndY);
  setLastSelectionSBtn.Checked := True;
  InfoLineUpdate('Заданы координаты конца области расчета выборки', '', clMenuHighlight);
  Selections.Changed(activeSelIndex);
  if (SelectionsList[activeSelIndex].CalcAreaStartX > 0) and (SelectionsList[activeSelIndex].CalcAreaStartY > 0) and
    (SelectionsList[activeSelIndex].CalcAreaEndX > 0) and (SelectionsList[activeSelIndex].CalcAreaEndY > 0) then
    AutoSelectionBtn.Enabled := True;
end;
//
procedure TMainForm.setFullSelectionSBtnClick(Sender: TObject);
begin
  SelectionsList[activeSelIndex].CalcAreaStartX := 1;
  SelectionsList[activeSelIndex].CalcAreaStartY := 1;
  SelectionsList[activeSelIndex].CalcAreaEndX := xTableDim;
  SelectionsList[activeSelIndex].CalcAreaEndY := yTableDim;
  selFirstSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaStartX);
  selFirstSYEdit.Text := IntToStr(tableA.RowCount - SelectionsList[activeSelIndex].CalcAreaStartY);
  selLastSXEdit.Text := IntToStr(SelectionsList[activeSelIndex].CalcAreaEndX);
  selLastSYEdit.Text := IntToStr(tableA.RowCount - SelectionsList[activeSelIndex].CalcAreaEndY);
  setFullSelectionSBtn.Checked := True;
  setFirstSelectionSBtn.Checked := True;
  setLastSelectionSBtn.Checked := True;
  InfoLineUpdate('Заданы координаты области расчета выборки', '', clMenuHighlight);
  Selections.Changed(activeSelIndex);
  AutoSelectionBtn.Enabled := True;
end;

// Всплывающее меню: поиск диапазона ================================ ПРОЦЕДУРА
procedure TMainForm.AutoSelectionBtnClick(Sender: TObject);
begin
  AutoSelectionForm.ShowModal;
end;

// Кнопка меню: Предыдущая выборка ================================ ПРОЦЕДУРА
procedure TMainForm.selPrevBtnClick(Sender: TObject);
begin
  Dec(activeSelIndex);
  Selections.Changed(activeSelIndex);
  InfoLineUpdate('Произведен рассчет по выборке "' + SelectionsList[activeSelIndex].Name + '"', '', clMenuHighlight);
end;

// Кнопка меню: Следующая выборка ================================ ПРОЦЕДУРА
procedure TMainForm.selNextBtnClick(Sender: TObject);
begin
  Inc(activeSelIndex);
  Selections.Changed(activeSelIndex);
  InfoLineUpdate('Произведен рассчет по выборке "' + SelectionsList[activeSelIndex].Name + '"', '', clMenuHighlight);
end;

// Изменение подписи
procedure TMainForm.selNameEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Length(SelectionsList) > 0 then
  begin
    SelectionsList[activeSelIndex].Name := selNameEdit.Text;
    isFileChanged := True;
  end;
end;
//
procedure TMainForm.selNameEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Length(SelectionsList) = 0 then
    Key := #0
end;

// Кнопка меню: Новая выборка ================================ ПРОЦЕДУРА
procedure TMainForm.selAddBtnClick(Sender: TObject);
begin
  // Подтвердить
  if isSelEditing then
  begin
    toolBar.Enabled := True;
    isFileChanged := True;
    selControlPnl.Visible := True;
    menuFileBtn.Enabled := True;
    openSettingsFormBtn.Enabled := True;

    if (((SelectionsList[activeSelIndex].CalcAreaStartX + SelectionsList[activeSelIndex].CalcAreaStartY) = 0) and
     ((SelectionsList[activeSelIndex].CalcAreaEndX + SelectionsList[activeSelIndex].CalcAreaEndY) = 0)) then
    begin
      setFullSelectionSBtn.Click;
    end;
    if Length(selNameEdit.Text) = 0 then
      selNameEdit.Text := 'Выборка №' + IntToStr(activeSelIndex+1);
    SelectionsList[activeSelIndex].Name := selNameEdit.Text;

    // Если достугнуто максимальное количество выборок
    if Length(SelectionsList) = MaxSel then
    begin
      selAddBtn.Enabled := False;
      selPnlLabel.Caption := 'Выборки (достигнуто максимальное количество)';
    end;

    SelectionsList[activeSelIndex].IsFixed := fixedSigmasCB.Checked;
    if SelectionsList[activeSelIndex].IsFixed then
    begin
      SelectionsList[activeSelIndex].DefMatrixStartX := 0;
      SelectionsList[activeSelIndex].DefMatrixStartY := 0;
      SelectionsList[activeSelIndex].DefMatrixEndX := 0;
      SelectionsList[activeSelIndex].DefMatrixEndY := 0;

      SelectionsList[activeSelIndex].SigmaA := StrToFloat(sigmaAEdit.Text);
      SelectionsList[activeSelIndex].SigmaB := StrToFloat(sigmaBEdit.Text);
      SelectionsList[activeSelIndex].AverageA := StrToFloat(meanAEdit.Text);
      SelectionsList[activeSelIndex].AverageB := StrToFloat(meanBEdit.Text);
    end;

    Processing.SetVisuals(False);
    Tables.SwitchToAB;
    isSelEditing := False;
    selDeleteBtn.Enabled := True;
    selControlPnl.Color := selPnl.Color;
    selControlPnl.BevelKind := bkNone;
    selAddBtn.Caption := '➕';
    selDeleteBtn.Caption := '➖';
    InfoLineUpdate('Новая выборка сохранена, произведен расчет');
  end
  // Новая выборка
  else
  begin
    toolBar.Enabled := False;
    Selections.SetVisuals(False, False, False, True, True, True);

    Selections.Add;

    activeSelIndex := Length(SelectionsList)-1;
    selNameEdit.Text := '';

    Tables.SwitchToA;
    isSelEditing := True;
    menuFileBtn.Enabled := False;
    openSettingsFormBtn.Enabled := False;
    InfoLineUpdate('Выборка в процессе создания',
      ' (Выберите ячейку в таблице левой кнопкой мыши, затем определите ее как начало/конец правой кнопкой и ' +
      'подтвердите нажатием по кнопке с галочкой)', clMenuHighlight);

    selAddBtn.Enabled := False;
    selDeleteBtn.Enabled := True;
    selControlPnl.Color := clHighlight;
    selControlPnl.BevelKind := bkFlat;
    selAddBtn.Caption := '✔';
    selDeleteBtn.Caption := '❌';

    MainForm.setFirstSelectionQBtn.Checked := False;
    MainForm.setLastSelectionQBtn.Checked := False;
    MainForm.setFullSelectionSBtn.Checked := False;
    MainForm.setFirstSelectionSBtn.Checked := False;
    MainForm.setLastSelectionSBtn.Checked := False;

    AutoSelectionBtn.Enabled := False;
  end;
//  Tables.Repaint;
  Selections.Changed(activeSelIndex);
end;

// Кнопка меню: Удалить текущую выборку ================================ ПРОЦЕДУРА
procedure TMainForm.selDeleteBtnClick(Sender: TObject);
begin
  // Отменить
  if isSelEditing then
  begin
    isSelEditing := False;
    Selections.DelActive;
    selControlPnl.Visible := True;
    menuFileBtn.Enabled := True;
    openSettingsFormBtn.Enabled := True;

    Processing.SetVisuals(False);
    Tables.SwitchToAB;
    selAddBtn.Enabled := True;
    selControlPnl.Color := selPnl.Color;
    selControlPnl.BevelKind := bkNone;
    selAddBtn.Caption := '➕';
    selDeleteBtn.Caption := '➖';
    InfoLineUpdate('Выборка не сохранена');
    toolBar.Enabled := True;
  end
  // Удалить текущую выборку
  else
  begin
    if Functions.MyMessageDlg('Удалить выборку "'+SelectionsList[activeSelIndex].Name+'"?',
      mtInformation, [mbYes, mbNo], ['Да','Нет'], 'Подтверждение', MB_ICONWARNING) = mrYes then
    begin
      Selections.DelActive;
    end;
  end;
  Tables.ClearDR;
  Selections.Changed(activeSelIndex);
  Tables.Repaint;
end;

// -----------------------------------------------------------------------------

// Сверка по текущей выборке ================================ ПРОЦЕДУРА
procedure TMainForm.DoReviseBtnClick(Sender: TObject);
var
  FileChanged: Boolean;
begin
  if isFileChanged then FileChanged := True else FileChanged := False;
  Screen.Cursor := crHourGlass;
  MainForm.Enabled := False;
  Application.ProcessMessages;

  IsolinesForm.SignatureEdit.Text := Files.GetFileName();
  IsolinesForm.ModeReviseRB.Checked := True;
  IsolinesForm.A4RadioButton.Checked := True;

  SelectedSelNum := 1;
  Selections.Changed(activeSelIndex);
  Selections.UIListFill(IsolinesForm.SelectionCLB);
  IsolinesForm.SelectionCLB.Checked[activeSelIndex] := True;
  IsolinesForm.DoIsolines();

  if FileChanged then isFileChanged := True else isFileChanged := False;
  MainForm.Enabled := True;
  Screen.Cursor := crDefault;
end;

// Сверка по пяти областям ================================ ПРОЦЕДУРА
procedure TMainForm.Do5RevisesBtnClick(Sender: TObject);
var
  FileChanged: Boolean;
  procedure DoRevise(DefMatrixStartX, DefMatrixStartY, DefMatrixEndX, DefMatrixEndY: integer; SelName: string; askForSavePath: Boolean = True);
  begin
    Selections.Add;
    activeSelIndex := Length(SelectionsList)-1;
    Selections.UIListFill(IsolinesForm.SelectionCLB);

    selNameEdit.Text := SelName;
    SelectionsList[activeSelIndex].Name := selNameEdit.Text;
    SelectionsList[activeSelIndex].IsFixed := False;

    SelectionsList[activeSelIndex].SetDefMatrixStart(DefMatrixStartX, DefMatrixStartY);
    SelectionsList[activeSelIndex].SetDefMatrixEnd(DefMatrixEndX, DefMatrixEndY);
    setFullSelectionSBtn.Click;

    Selections.Changed(activeSelIndex);
    IsolinesForm.SelectionCLB.Checked[activeSelIndex] := True;
    IsolinesForm.DoIsolines(askForSavePath);
    Selections.DelActive;
  end;
begin
  if isFileChanged then FileChanged := True else FileChanged := False;
  Screen.Cursor := crHourGlass;
  MainForm.Enabled := False;
  Application.ProcessMessages;

  IsolinesForm.SignatureEdit.Text := Files.GetFileName();
  IsolinesForm.ModeReviseRB.Checked := True;
  IsolinesForm.A4RadioButton.Checked := True;
  SelectedSelNum := 1;

  DoRevise(1, 1, xTableDim, yTableDim - Trunc(yTableDim/2), '№1 Верхняя половина');
  DoRevise(1, yTableDim - Trunc(yTableDim/2)+1, xTableDim, yTableDim, '№2 Нижняя половина', False);
  DoRevise(1, 1, xTableDim - Trunc(xTableDim/2), yTableDim, '№3 Левая половина', False);
  DoRevise(xTableDim - Trunc(xTableDim/2)+1, 1, xTableDim, yTableDim, '№4 Правая половина', False);
  DoRevise(1, 1, xTableDim, yTableDim, '№5 Полное поле', False);

  if FileChanged then isFileChanged := True else isFileChanged := False;
  Selections.Changed(activeSelIndex);
  MainForm.Enabled := True;
  Screen.Cursor := crDefault;
end;

// -----------------------------------------------------------------------------

// Кнопка меню: Выход ================================ ПРОЦЕДУРА
procedure TMainForm.exitApplicationBtnClick(Sender: TObject);
begin
  if Functions.MyMessageDlg('Завершить работу?',
    mtCustom, [mbYes, mbNo], ['Выход','Отмена'], 'Подтверждение', MB_ICONWARNING) = mrYes then
  begin
    closeFileBtn.Click;
    Application.Terminate();
  end
  else Application.Run;
end;
// Принудительный выход через крестик ================================ ПРОЦЕДУРА
procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  exitApplicationBtn.Click;
end;

// Кнопка меню: Настройки ================================ ПРОЦЕДУРА
procedure TMainForm.openSettingsFormBtnClick(Sender: TObject);
begin
  SettingsForm.ShowModal;
end;

// Кнопка меню: Справка ================================ ПРОЦЕДУРА
procedure TMainForm.openInfoFormBtnClick(Sender: TObject);
begin
  InformationForm.Show;
end;

// Разрешенные для ввода в таблицы А и В символы ================================ ПРОЦЕДУРА
procedure TMainForm.StringGridKeyPress(StringGrid: TStringGrid; var Key: Char);
begin
  // Разрешенные к нажатию
  if not (Key in [#8, '0'..'9', ',', '.', #13, #39]) then
    Key := #0
  // При нажатии на '.' или ',' ставить запятую (при нулевой ячейке)
  else if ((Key = ',') or (Key = '.')) and (StringGrid.Cells[StringGrid.Col,StringGrid.Row] = '0') then
    Key := ','
  // Если ячейка пуста (но не ноль), то ничего не нажимать
  else if ((Key = ',') or (Key = '.')) and ((StringGrid.Cells[StringGrid.Col,StringGrid.Row] = '') or
    (StringGrid.Cells[StringGrid.Col,StringGrid.Row] = '-')) then
    Key := #0
  else if (Key = '0') and (StringGrid.Cells[StringGrid.Col,StringGrid.Row] = '0') then
    Key := ','
  // Если запятая уже есть, то не нажимать
  else if ((Key = ',') or (Key = '.')) and ((Pos(',', StringGrid.Cells[StringGrid.Col,StringGrid.Row]) <> 0) or
    (Pos('.', StringGrid.Cells[StringGrid.Col,StringGrid.Row]) <> 0)) then
    Key := #0
  // При нажатии на Enter переносить на следующую ячейку/ряд
  else if (Key = #13) then
  begin
    // Вставить запятую после первого символа
    if not (Pos(',', StringGrid.Cells[StringGrid.Col,StringGrid.Row]) <> 0) then
    begin
      if Length(StringGrid.Cells[StringGrid.Col,StringGrid.Row]) > 1 then
      begin
        StringGrid.Cells[StringGrid.Col,StringGrid.Row] := StringGrid.Cells[StringGrid.Col,StringGrid.Row].Chars[0] + ',' +
        StringGrid.Cells[StringGrid.Col,StringGrid.Row].Chars[1] +  StringGrid.Cells[StringGrid.Col,StringGrid.Row].Chars[2] +
         StringGrid.Cells[StringGrid.Col,StringGrid.Row].Chars[3];
      end;
    end;
    //
    if StringGrid.Cells[StringGrid.Col,StringGrid.Row] <> '' then
      StringGrid.Cells[StringGrid.Col,StringGrid.Row] := FloatToStr(StrToFloat(StringGrid.Cells[StringGrid.Col,StringGrid.Row]));
    if (StringGrid.Col = xTableDim) and (StringGrid.Row <> 1) then
    begin
      StringGrid.Row := StringGrid.Row - 1;
      StringGrid.Col := 1;
    end
    else if (StringGrid.Col = xTableDim) and (StringGrid.Row = 1) then
      Key := #0
    else
      StringGrid.Col := StringGrid.Col + 1;
  end;

  if (Key = '0') and (StringGrid.Cells[StringGrid.Col,StringGrid.Row] = '') then
    Key := ',';
  // Замена точки на запятую
  if (Key = '.') then
    Key := ',';
  // Нажатие на стрелочки
  if Key = #39 then
  begin
    if (StringGrid.Col = xTableDim) and (StringGrid.Row <> yTableDim) then
    begin
      StringGrid.Row := StringGrid.Row + 1;
      StringGrid.Col := 1;
    end
    else if (StringGrid.Col = xTableDim) and (StringGrid.Row = yTableDim) then
    begin
      StringGrid.Row := 1;
      StringGrid.Col := 1;
    end
    else
    StringGrid.Col := StringGrid.Col + 1;
  end;
end;
// ================================ ПРОЦЕДУРА
procedure TMainForm.tableAKeyPress(Sender: TObject; var Key: Char);
begin
  StringGridKeyPress((Sender as TStringGrid), Key);
end;
// Отвод мыши ================================ ПРОЦЕДУРА
procedure TMainForm.tableAMouseLeave(Sender: TObject);
begin
  isMouseOnTable := False;
  with (Sender as TStringGrid) do Repaint;
end;
//
procedure TMainForm.tableAMouseEnter(Sender: TObject);
begin
  isMouseOnTable := True;
  with (Sender as TStringGrid) do Repaint;
end;

// Нажатие на ячейку - вывод координат
  // A, B, D, R ================================ ПРОЦЕДУРА
procedure TMainForm.StringGridClick(StringGrid: TStringGrid);
begin
  xCoordEdit.Text := IntToStr(StringGrid.Col);
  yCoordEdit.Text := (StringGrid.Cells[0,StringGrid.Row]);
  StringGrid.Repaint;
end;
  // А ================================ ПРОЦЕДУРА
procedure TMainForm.tableAClick(Sender: TObject);
begin
  StringGridClick(tableA);
end;
  // В ================================ ПРОЦЕДУРА
procedure TMainForm.tableBClick(Sender: TObject);
begin
  StringGridClick(tableB);
end;
  // D ================================ ПРОЦЕДУРА
procedure TMainForm.tableDSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  StringGridClick(tableD);
end;
procedure TMainForm.tableDClick(Sender: TObject);
begin
  StringGridClick(tableD);
end;
  // R ================================ ПРОЦЕДУРА
procedure TMainForm.tableRSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  StringGridClick(tableR);
end;
procedure TMainForm.tableRClick(Sender: TObject);
begin
  StringGridClick(tableR);
end;
  // DR ================================ ПРОЦЕДУРА
procedure TMainForm.tableDRClick(Sender: TObject);
begin
  xCoordEdit.Text := IntToStr(tableDR.Col);
  yCoordEdit.Text := (tableDR.Cells[0,tableDR.Row]);
end;

// ================================ ПРОЦЕДУРА
procedure TMainForm.tableDRSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  xCoordEdit.Text := IntToStr(tableDR.Col);
  yCoordEdit.Text := (tableDR.Cells[0,tableDR.Row]);
end;
  // АВ ================================ ПРОЦЕДУРА
procedure TMainForm.tableABClick(Sender: TObject);
begin
  xCoordEdit.Text := IntToStr(tableAB.Col);
  yCoordEdit.Text := (tableAB.Cells[0,tableAB.Row]);
end;
  // ================================ ПРОЦЕДУРА
procedure TMainForm.tableABSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  xCoordEdit.Text := IntToStr(tableAB.Col);
  yCoordEdit.Text := (tableAB.Cells[0,tableAB.Row]);
end;

// Всплывающее меню выборки при поднятии правой кнопки мыши
procedure TMainForm.tableAMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point: TPoint;
begin
  with (Sender as TstringGrid) do
  begin
    Point := GetClientOrigin;
    if isSelEditing then
      if Button = mbRight then
        selectionPopupMenu.Popup(X+Point.X+Left, Y+Point.Y+Top);
    if DecompositionForm.Visible then
      if Button = mbRight then
        decompPopupMenu.Popup(X+Point.X+Left, Y+Point.Y+Top);
    if CompositionForm.Visible then
      if Button = mbRight then
        if Length(CompositionForm.OpenDialog1.FileName) <> 0 then
          compPopupMenu.Popup(X+Point.X+Left, Y+Point.Y+Top);
  end;

  with CompositionForm do
    if Visible and (OpenDialog1.FileName <> '') then
    begin
      SetCompCoord();
      Tables.Repaint;
    end;
end;

// Изменено значение ячейки
  // А ================================ ПРОЦЕДУРА
procedure TMainForm.tableASetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  isFileChanged := True;
  isSelSwitched := True;
  tableA.Refresh;
  tableB.Refresh;
  try
    Processing.Calculation(activeSelIndex);
//    selectionChanged(False, activeSelIndex);
    InfoLineUpdate('Изменено значение ячейки, произведен расчет');
  except
  end;
end;
  // А, заполнить нулем, если ячейка пуста ================================ ПРОЦЕДУРА
procedure TMainForm.tableASelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if tableA.Cells[tableA.Col,tableA.Row] = '' then
  begin
    tableA.Cells[tableA.Col,tableA.Row] := '0';
  end;
end;
  // В ================================ ПРОЦЕДУРА
procedure TMainForm.tableBSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  isFileChanged := True;
  isSelSwitched := True;
  tableB.Refresh;
    InfoLineUpdate('Изменено значение ячейки, произведен расчет');
end;
  // В, заполнить нулем, если ячейка пуста ================================ ПРОЦЕДУРА
procedure TMainForm.tableBSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if tableB.Cells[tableB.Col,tableB.Row] = '' then
  begin
    tableB.Cells[tableB.Col,tableB.Row] := '0';
  end;
end;

// Отрисовка ячеек ================================ ПРОЦЕДУРА
procedure TMainForm.tableADrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
  begin
    // Первые колонная и ряд неизменны
    if (ACol = 0) or (ARow = 0) then
      Canvas.Brush.Color := clBtnFace
    // Активная ячейка
    else if (ACol = Col) and (Arow = Row) then
      Canvas.Brush.Style := bsSolid
    else
    begin
//      if not selEdit then
      begin
        // Подсветка частей декомпозиции
        if DecompositionForm.Visible then
        begin
          if (ACol >= decompRange[0]) and (ACol <= decompRange[2]) and
          (ARow >= decompRange[1]) and (ARow <= decompRange[3]) then
            Canvas.Brush.Color := rgb(174, 214, 241);
        end
        // Подсветка диапазона композиции
        else if CompositionForm.Visible then
        begin
          if (ACol >= compCoord[0]) and (ACol <= compCoord[2]) and
          (ARow >= compCoord[1]) and (ARow <= compCoord[3]) then
          begin
            if (compCoord[1] < 1) or (compCoord[2] > xTableDim) then
              Canvas.Brush.Color := rgb(245, 183, 177)
            else
              Canvas.Brush.Color := rgb(171, 235, 198);
          end;
        end
        // Если активен параметр настройки (подсветка выборки)
        else if SettingsForm.GridPaintCB.Checked and not isMouseOnTable then
        begin
          if Length(SelectionsList) > 0 then
          with SelectionsList[activeSelIndex] do
          begin
            // Площадь
            if (ACol >= CalcAreaStartX) and (ACol <= CalcAreaEndX) and
            (ARow >= CalcAreaStartY) and (ARow <= CalcAreaEndY) then
              Canvas.Brush.Color := rgb(212, 239, 223);
            // Диапазон
            // При фиксированных сигмах и средних не подсвечивать
            if not IsFixed then
            begin
              if (ACol >= DefMatrixStartX) and (ACol <= DefMatrixEndX) and
              (ARow >= DefMatrixStartY) and (ARow <= DefMatrixEndY) then
              begin
                // Пересечение с площадью
                if (ACol >= CalcAreaStartX) and (ACol <= CalcAreaEndX) and
                (ARow >= CalcAreaStartY) and (ARow <= CalcAreaEndY) then
                  Canvas.Brush.Color := rgb(214, 234, 248)
                //
                else
                  Canvas.Brush.Color := rgb(232, 218, 239)
              end;
            end;
          end;
        end;
      end;
      // Подсветка координат
      if SettingsForm.GridCoordCB.Checked and isMouseOnTable then
        if (ACol = Col) or (ARow = Row) then
          Canvas.Brush.Color := Canvas.Brush.Color - rgb(10, 10, 10);
      Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 5, cells[acol, arow]);
      Canvas.FrameRect(Rect);
    end;
  end;
end;

procedure TMainForm.tableDRDrawCell(Sender: TObject; ACol, ARow: Integer;
Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid) do
  begin
    if (ARow mod 2 = 0) then
      Canvas.Font.Color := $002222FF;
    Canvas.TextRect(Rect, Rect.Left+6, Rect.Top, cells[acol, arow]);
    Canvas.FrameRect(Rect);
  end;
end;

// -----------------------------------------------------------------------------

// Кнопка "A" ================================ ПРОЦЕДУРА
procedure TMainForm.openTableABtnClick(Sender: TObject);
begin
  if openTableABtn.Caption = 'A' then
  begin
    StringGridClick(tableA);
    Screen.Cursor := crHourGlass;
    activeTableLabel.Caption := 'A';
    Tables.Activate(True, False, False, False, False, False);
    selAddBtn.Enabled := True;
    if isSelEditing then
    begin
      openTableDBtn.Enabled := False;
      openTableRBtn.Enabled := False;
    end;
    if Length(SelectionsList) = MaxSel then
      selAddBtn.Enabled := False;
    tableA.Refresh;
    ActiveControl := tableA;
    // WarningLine('TableOpened');
    Screen.Cursor := crDefault;
  end
  // AB
  else
  begin
    xCoordEdit.Text := IntToStr(tableAB.Col);
    yCoordEdit.Text := (tableAB.Cells[0,tableAB.Row]);
    Screen.Cursor := crHourGlass;
    activeTableLabel.Caption := 'AB';
    Tables.Activate(False, False, True, False, False, False);
    selAddBtn.Enabled := True;
    Selections.IsPresent;
    isSelSwitched := False;
    tableAB.Refresh;
    ActiveControl := tableAB;
    // WarningLine('TableOpened');
    Screen.Cursor := crDefault;
  end;
end;

// Кнопка "B" ================================ ПРОЦЕДУРА
procedure TMainForm.openTableBBtnClick(Sender: TObject);
begin
  StringGridClick(tableB);
  Screen.Cursor := crHourGlass;
  activeTableLabel.Caption := 'B';
  Tables.Activate(False, True, False, False, False, False);
  selAddBtn.Enabled := True;
  selDeleteBtn.Enabled := True;
  if isSelEditing or CompositionForm.Visible or DecompositionForm.Visible then
  begin
    openTableDBtn.Enabled := False;
    openTableRBtn.Enabled := False;
  end;
  if Length(SelectionsList) = MaxSel then
    selAddBtn.Enabled := False;
  tableB.Refresh;
  ActiveControl := tableB;
  // WarningLine('TableOpened');
  Screen.Cursor := crDefault;
end;

// Кнопка "D" ================================ ПРОЦЕДУРА
procedure TMainForm.openTableDBtnClick(Sender: TObject);
begin
  if openTableDBtn.Caption = 'D' then
  begin
    StringGridClick(tableD);
    Screen.Cursor := crHourGlass;
    activeTableLabel.Caption := 'D';
    Tables.Activate(False, False, False, True, False, False);
    selAddBtn.Enabled := False;
    selDeleteBtn.Enabled := False;
    Processing.Calculation(activeSelIndex);
    isSelSwitched := False;
    tableD.Refresh;
    ActiveControl := tableD;
    // WarningLine('TableOpened');
    Screen.Cursor := crDefault;
  end
  // DR
  else
  begin
    xCoordEdit.Text := IntToStr(tableDR.Col);
    yCoordEdit.Text := (tableDR.Cells[0,tableDR.Row]);
    Screen.Cursor := crHourGlass;
    activeTableLabel.Caption := 'DR';
    Tables.Activate(False, False, False, False, False, True);
    selAddBtn.Enabled := False;
    selDeleteBtn.Enabled := False;
    Processing.Calculation(activeSelIndex);
    isSelSwitched := False;
    tableDR.Refresh;
    ActiveControl := tableDR;
    // WarningLine('TableOpened');
    Screen.Cursor := crDefault;
  end;
  Selections.Changed(activeSelIndex);
end;

// Кнопка "R" ================================ ПРОЦЕДУРА
procedure TMainForm.openTableRBtnClick(Sender: TObject);
begin
  StringGridClick(tableR);
  Screen.Cursor := crHourGlass;
  activeTableLabel.Caption := 'R';
  Tables.Activate(False, False, False, False, True, False);
  selAddBtn.Enabled := False;
  selDeleteBtn.Enabled := False;
  Processing.Calculation(activeSelIndex);
  isSelSwitched := False;
  tableR.Refresh;
  ActiveControl := tableR;
  // WarningLine('TableOpened');
  Screen.Cursor := crDefault;
  Selections.Changed(activeSelIndex);
end;

// Всплывающее меню: Декомпозиция ------------------------------
procedure TMainForm.setFirstDecompBtnClick(Sender: TObject);
var
  table: ^TstringGrid;
  dr1, dr2, dr3, dr4: Integer;
begin
  if Sender = setFirstDecompBtn then
  begin
    dr1 := 0;
    dr2 := 1;
    dr3 := 2;
    dr4 := 3;
  end
  else
  begin
    dr1 := 2;
    dr2 := 3;
    dr3 := 0;
    dr4 := 1;
  end;

  if tableA.Visible then
    table := @tableA
  else if tableB.Visible then
    table := @tableB;

  decompRange[dr1] := table.Col;
  decompRange[dr2] := table.Row;

  if (decompRange[dr3] <> 0) and (decompRange[dr4] <> 0) then
    DecompositionForm.OneDCoordFix();

  if Sender = setFirstDecompBtn then
  begin
    DecompositionForm.decompFirstXEdit.Text := IntToStr(table.Col);
    DecompositionForm.decompFirstYEdit.Text := IntToStr(yTableDim+1 - table.Row);
    setFirstDecompBtn.Checked := True;
  end
  else
  begin
    DecompositionForm.decompLastXEdit.Text := IntToStr(table.Col);
    DecompositionForm.decompLastYEdit.Text := IntToStr(yTableDim+1 - table.Row);
    setLastDecompBtn.Checked := True;
  end;
  if (decompRange[0] >= 1) and (decompRange[2] >= 1) then
    DecompositionForm.SaveButton.Enabled := True;
  Tables.Repaint();
end;

// Всплывающее меню: Композиция ------------------------------
procedure TMainForm.insertCompBtnClick(Sender: TObject);
begin
  CompositionForm.InsertButton.Click;
end;

// Фиксированные значения сигм и средних
procedure TMainForm.FixedSigmasCBClick(Sender: TObject);
begin
  if isSelEditing then
  begin
    if FixedSigmasCB.Checked then
      Processing.SetVisuals(True)
    else
      Processing.SetVisuals(False);
    selectionsList[activeSelIndex].IsFixed := FixedSigmasCB.Checked;
    Selections.Changed(activeSelIndex);
  end;
end;

procedure TMainForm.sigmaAEditChange(Sender: TObject);
begin
  if isSelEditing and FixedSigmasCB.Checked then
    Selections.Changed(activeSelIndex);
end;

procedure TMainForm.sigmaAEditKeyPress(Sender: TObject; var Key: Char);
begin
  if isSelEditing then
    with (Sender as TEdit) do
    begin
      // Разрешенные к нажатию
      if not (Key in [#8, '0'..'9', ',', '.', #13, #39]) then
        Key := #0
      // При нажатии на '.' или ',' ставить запятую (при нулевой ячейке)
      else if ((Key = ',') or (Key = '.')) and (Text = '0') then
        Key := ','
      // Если ячейка пуста (но не ноль), то ничего не нажимать
      else if ((Key = ',') or (Key = '.')) and ((Text = '') or (Text = '-')) then
        Key := #0
      else if (Key = '0') and (Text = '0') then
        Key := ','
      // Если запятая уже есть, то не нажимать
      else if ((Key = ',') or (Key = '.')) and ((Pos(',', Text) <> 0) or
        (Pos('.', Text) <> 0)) then
        Key := #0;

      if (Key = '0') and (Text = '') then
        Key := ',';
      // Замена точки на запятую
      if (Key = '.') then
        Key := ',';
      if Key = #13 then
      begin
        if Sender = sigmaAEdit then
          ActiveControl := sigmaBEdit;
        if Sender = sigmaBEdit then
          ActiveControl := meanAEdit;
        if Sender = meanAEdit then
          ActiveControl := meanBEdit;
        if ((Sender = meanBEdit) and (Length(sigmaAEdit.Text) <> 0) and (Length(sigmaBEdit.Text) <> 0) and
         (Length(meanAEdit.Text) <> 0) and (Length(meanBEdit.Text) <> 0)) then
          selAddBtn.Click;
      end;
    end;
end;

procedure TMainForm.sigmasPnlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if isSelEditing and FixedSigmasCB.Checked and (Button = mbRight) then
    if fileOpenDialog.Execute then
      Processing.LoadSigmasFromFile(fileOpenDialog.FileName);
end;

end.
