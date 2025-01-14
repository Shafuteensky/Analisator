unit FilesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls, System.IOUtils,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.ButtonGroup, iniFiles,  Vcl.CheckLst, System.Math;

type
  TFiles = class(TObject)
  // ���������� �����
  procedure SaveIni(FileName: string; StringGrid1: TStringGrid; StringGrid2: TStringGrid; UIupdate: Boolean);
  procedure Save(Fast: Boolean);
  // �������� �����
  procedure Load();

  function GetFileName(): string;
  function CutFileExtension(fileName: string): string;
  end;


var
  Files: TFiles;
  LoadedFileName: string;

implementation

uses
  MainUnit, FunctionsUnit, ParamsUnit, DecompositionUnit, SelectionUnit, TablesUnit, ProcessingUnit;

// ���������� �����
procedure TFiles.SaveIni(FileName: string; StringGrid1: TStringGrid; StringGrid2: TStringGrid; UIupdate: Boolean);
var
  tableList, Sel: TStringList;
  ini: TIniFile;
  x, y, i, j: Integer;
  Indexes: array of integer;

  // �������� ������� �������, �� ��������� �� ����� ������������
  procedure PrepSel();
  var i: Integer;
  begin
//    SetLength(Indexes, 0);
    for i := 0 to Length(SelectionsList)-1 do
    with SelectionsList[i] do
    begin
      if (not ((DefMatrixStartX < decompRange[0]) or (DefMatrixStartY < decompRange[1]) or
        (DefMatrixEndX > decompRange[2]) or (DefMatrixEndY > decompRange[3]) or
        (CalcAreaStartX < decompRange[0]) or (CalcAreaStartY < decompRange[1]) or
        (CalcAreaEndX > decompRange[2]) or (CalcAreaEndY > decompRange[3]))) or
        ((IsFixed = True) and not ((CalcAreaStartX < decompRange[0]) or (CalcAreaStartY < decompRange[1]) or
        (CalcAreaEndX > decompRange[2]) or (CalcAreaEndY > decompRange[3]))) then
      begin
        SetLength(Indexes, Length(Indexes)+1);
        Indexes[Length(Indexes)-1] := i;
      end;
    end;
  end;

begin
  with MainForm do
  begin
    Screen.Cursor := crHourGlass;
    isFileNew := False;
    //
    if FileExists(FileName) then
      DeleteFile(FileName);
    // ------------------------------------
    ini := TIniFile.Create(FileName);

    for i := 0 to Length(SelectionsList)-1 do
      Processing.ComputeSigmas(i);
    with ini do
    begin
      WriteInteger('Information', 'Version', ProgramVersion);
      WriteString('Information', 'Info', '');
      WriteInteger('Information', 'SizeX', StringGrid1.ColCount-1);
      WriteInteger('Information', 'SizeY', StringGrid1.RowCount-1);
    end;

    // ����������� � ������ ��� �������� � ini
    tableList := TStringList.Create;
    tableList.StrictDelimiter := True;
    tableList.Delimiter := ';';
    for y := 1 to StringGrid1.RowCount-1 do
    begin
      tableList.Clear;
      for x := 1 to StringGrid1.ColCount-1 do
        tableList.Add(StringGrid1.Cells[x, y]);
      ini.WriteString('TableA', IntToStr(y), QuotedStr(tableList.DelimitedText));

      tableList.Clear;
      for x := 1 to StringGrid1.ColCount-1 do
        tableList.Add(StringGrid2.Cells[x, y]);
      ini.WriteString('TableB', IntToStr(y), QuotedStr(tableList.DelimitedText));
    end;

    Sel := TStringList.Create;
    Sel.StrictDelimiter := True;
    Sel.Delimiter := ';';
    Sel.QuoteChar := #0;
    if StringGrid1 = MainForm.tableA then
    begin
      for x := 0 to Length(SelectionsList)-1 do
      with SelectionsList[x] do
      begin
        ini.WriteInteger('Information', 'SelNum', Length(SelectionsList));
        ini.WriteString('Selection'+IntToStr(x+1), 'Name', Name);

        Sel.Clear;
        Sel.Add(IntToStr(DefMatrixStartX));
        Sel.Add(IntToStr(DefMatrixStartY));
        Sel.Add(IntToStr(DefMatrixEndX));
        Sel.Add(IntToStr(DefMatrixEndY));
        ini.WriteString('Selection'+IntToStr(x+1), 'DefMatrix', Sel.DelimitedText);

        Sel.Clear;
        Sel.Add(IntToStr(CalcAreaStartX));
        Sel.Add(IntToStr(CalcAreaStartY));
        Sel.Add(IntToStr(CalcAreaEndX));
        Sel.Add(IntToStr(CalcAreaEndY));
        ini.WriteString('Selection'+IntToStr(x+1), 'CalcArea', Sel.DelimitedText);

        ini.WriteString('Selection'+IntToStr(x+1), 'IsFixed', IntToStr(IfThen(IsFixed, 1,0)));

        Sel.Clear;
        Sel.Add(FloatToStr(SigmaA));
        Sel.Add(FloatToStr(SigmaB));
        ini.WriteString('Selection'+IntToStr(x+1), 'Sigmas', Sel.DelimitedText);

        Sel.Clear;
        Sel.Add(FloatToStr(AverageA));
        Sel.Add(FloatToStr(AverageB));
        ini.WriteString('Selection'+IntToStr(x+1), 'Averages', Sel.DelimitedText);
      end;
    end
    // ��� ������������
    else
    begin
      PrepSel();
      ini.WriteInteger('Information', 'SelNum', Length(Indexes));

      for x := 0 to Length(Indexes)-1 do
      with SelectionsList[Indexes[x]] do
      begin
        ini.WriteString('Selection'+IntToStr(x+1), 'Name', Name);

        Sel.Clear;
        Sel.Add(IntToStr(DefMatrixStartX-decompRange[0]+1));
        Sel.Add(IntToStr(DefMatrixStartY-decompRange[1]+1));
        Sel.Add(IntToStr(DefMatrixEndX-decompRange[0]+1));
        Sel.Add(IntToStr(DefMatrixEndY-decompRange[1]+1));
        ini.WriteString('Selection'+IntToStr(x+1), 'DefMatrix', Sel.DelimitedText);

        Sel.Clear;
        Sel.Add(IntToStr(CalcAreaStartX-decompRange[0]+1));
        Sel.Add(IntToStr(CalcAreaStartY-decompRange[1]+1));
        Sel.Add(IntToStr(CalcAreaEndX-decompRange[0]+1));
        Sel.Add(IntToStr(CalcAreaEndY-decompRange[1]+1));
        ini.WriteString('Selection'+IntToStr(x+1), 'CalcArea', Sel.DelimitedText);

        ini.WriteString('Selection'+IntToStr(x+1), 'IsFixed', IntToStr(IfThen(IsFixed, 1,0)));

        Sel.Clear;
        Sel.Add(FloatToStr(SigmaA));
        Sel.Add(FloatToStr(SigmaB));
        ini.WriteString('Selection'+IntToStr(x+1), 'Sigmas', Sel.DelimitedText);

        Sel.Clear;
        Sel.Add(FloatToStr(AverageA));
        Sel.Add(FloatToStr(AverageB));
        ini.WriteString('Selection'+IntToStr(x+1), 'Averages', Sel.DelimitedText);
      end;
    end;

    ini.Free;
    tableList.Free;
    Sel.Free;

    if UIupdate then
    begin
      MainForm.Caption := '���������� (' + FileName + ')';
      mainForm.InfoLineUpdate('���� �������� ��� "' + fileOpenDialog.FileName + '"')
    end;
    Screen.Cursor := crDefault;
  end;
end;
// ---
procedure TFiles.Save(Fast: Boolean);
begin
  with MainForm do
  begin
    if Fast then
    begin
      // ���� ���� �����, �� ��������� ���
      if isFileNew = True then
      begin
        if fileSaveDialog.Execute then
          SaveIni(fileSaveDialog.FileName, tableA, tableB, True)
      end
      // ����� ��������� ������
      else
        SaveIni(fileOpenDialog.FileName, tableA, tableB, True);
    end
    else
    begin
      if fileSaveDialog.Execute then
        SaveIni(fileSaveDialog.FileName, tableA, tableB, True);
    end;
    fileOpenDialog.FileName := fileSaveDialog.FileName;
    LoadedFileName := fileSaveDialog.FileName;;
    isFileChanged := False;
  end;
end;

// �������� ����� ================================ ���������
procedure TFiles.Load;
var
  x, y, temp, i: Integer; SelLoad, SelError: Boolean;
  tableList, Selection: TStringList;
  ini: TIniFile;

  // �������� ����� (������ ������) ================================ ���������
  procedure LoadOld;
  var
    x, y, temp, i: Integer;
    selCount: integer;
  begin
    // ----------------------------------------
    // ���� ����������:
    // ������ ������ (������) - ��������� ��������:
    // (0) - ���������� ����� � �������� (x)
    // (1) - ���������� ������ � �������� (y)
    // (2, x*y+1) - ������� �
    // (x*y+2, x*y*2+1) - ������� B
    // (x*y*2+2) - ���������� �������
    // (x*y*2+3, x*y*2+7) - ������ �������
    // (x*y*2+8, x*y*2+12) - ������ �������
    // (x*y*2+13, x*y*2+17) - ������ �������
    // (x*y*2+18, x*y*2+22) - ��������� �������
    // ----------------------------------------
    with MainForm do
    begin
      Functions.MyMessageDlg('������ ���� ������ ������ ���������.'+#13#10+'��� ���������� ���� ����� ��������.',
        mtInformation, [mbOk], ['��'], '�����������', MB_ICONWARNING);
      // �������� ����� �� ����� � ����� (memo)
      loadingBuffer.Lines.LoadFromFile(fileOpenDialog.FileName);
      // ���������� ���������� ���������� ����� � ������ � ��������
      xTableDim := StrToInt(loadingBuffer.Lines.Strings[0]);
      yTableDim := StrToInt(loadingBuffer.Lines.Strings[1]);
      // ������� ���������� ����� � ������ �������� (+1 ��� ������������� �������� - ���������)
      tableA.ColCount := xTableDim+1;
      tableA.RowCount := yTableDim+1;
      tableB.ColCount := xTableDim+1;
      tableB.RowCount := yTableDim+1;
      tableD.ColCount := xTableDim+1;
      tableD.RowCount := yTableDim+1;
      tableR.ColCount := xTableDim+1;
      tableR.RowCount := yTableDim+1;
      // �� �� �����, ��� ����������� ������
      tableAB.ColCount := xTableDim+1;
      tableAB.RowCount := (yTableDim*2)+1;
      tableDR.ColCount := xTableDim+1;
      tableDR.RowCount := (yTableDim*2)+1;
      // ���������� ����������� ������ ������������� ���������� � ������� �� Memo
      temp := yTableDim;
      for y := 0 to yTableDim do
      begin
        for x := 0 to xTableDim do
        begin
          tableA.Cells[x+1,0] := IntToStr(x+1);
          tableA.Cells[0,y+1] := IntToStr(temp);
          tableA.Cells[x+1,y+1] := loadingBuffer.Lines.Strings[y*(xTableDim)+x+2];
          tableB.Cells[x+1,0] := IntToStr(x+1);
          tableB.Cells[0,y+1] := IntToStr(temp);
          tableB.Cells[x+1,y+1] := loadingBuffer.Lines.Strings[(y+yTableDim)*(xTableDim)+x+2];
          tableD.Cells[x+1,0] := IntToStr(x+1);
          tableD.Cells[0,y+1] := IntToStr(temp);
          tableR.Cells[x+1,0] := IntToStr(x+1);
          tableR.Cells[0,y+1] := IntToStr(temp);
        end;
        temp := temp - 1;
      end;
      // �� �� �����, ��� ����������� ������
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
      // �������� ������ � ��������
        // ���� ������ � �������� ����, �� ���������
      if ((loadingBuffer.Lines.Strings[((xTableDim * yTableDim) * 2) + 2]) <> '0') then
      begin
        selCount := StrToInt(loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2]);
        temp := 1;


        for i := 1 to selCount do
        begin
          SetLength(SelectionsList, Length(SelectionsList)+1);
          SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
        end;

//        SetLength(SelectionsList, selCount);
//        SelectionsList[selCount] := TSelection.Create;

//        SetLength(SelectionsList, StrToInt(loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2]));
        // ���� ������ ������� ����� ��������, �� ���������
        if Length(SelectionsList) > 0 then
        begin
          for x := 0 to (Length(SelectionsList) - 1) do
          begin
            // ���� �������� ���������� ������� �� ������, �� ���������
            if (loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2+1] <> '') then
              SelectionsList[x].DefMatrixStartX := selCount+1
            else // ����� ���������� ����
              SelectionsList[x].DefMatrixStartX := 0;

            if (loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2+2] <> '') then
              SelectionsList[x].DefMatrixStartY := selCount+2
            else SelectionsList[x].DefMatrixStartY := 0;

            if (loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2+3] <> '') then
              SelectionsList[x].DefMatrixEndX := selCount+3
            else SelectionsList[x].DefMatrixEndX := 0;

            if (loadingBuffer.Lines.Strings[((xTableDim * yTableDim)*2)+2+4] <> '') then
              SelectionsList[x].DefMatrixEndY := selCount+4
            else SelectionsList[x].DefMatrixEndY := 0;

            SelectionsList[x].Name := '������� �' + IntToStr(x+1);
          end;
          // ������� �������� ������� �� ������ ���������
          for x := 0 to (Length(SelectionsList) - 1) do
          begin
            SelectionsList[x].CalcAreaStartX := 1;
            SelectionsList[x].CalcAreaStartY := 1;
            SelectionsList[x].CalcAreaEndX := xTableDim;
            SelectionsList[x].CalcAreaEndY := yTableDim;

            SelectionsList[x].IsFixed := False;
            SelectionsList[x].SigmaA := 0;
            SelectionsList[x].SigmaB := 0;
            SelectionsList[x].AverageA := 0;
            SelectionsList[x].AverageB := 0;
          end;

          activeSelIndex := 0;
          Selections.Changed(activeSelIndex);
        end;
      end
      else
      begin
        temp := yTableDim;
        for y:=0 to yTableDim do
        begin
          for x:=0 to xTableDim do
          begin
            MainForm.tableD.Cells[x+1,0] := IntToStr(x+1);
            MainForm.tableD.Cells[0,y+1] := IntToStr(temp);
            MainForm.tableR.Cells[x+1,0] := IntToStr(x+1);
            MainForm.tableR.Cells[0,y+1] := IntToStr(temp);
            MainForm.tableD.Cells[x+1,y+1] := '0';
            MainForm.tableR.Cells[x+1,y+1] := '0';
          end;
          temp := temp - 1;
        end;
        for y:=0 to (yTableDim*2) do
          for x:=0 to xTableDim  do
          begin
            MainForm.tableDR.Cells[x+1,y+1] := '0';
          end;
      end;
    end;
  end;

  procedure Load2340;
  var
    x, y, i: Integer;
  begin
    // ���������� ���������� ���������� ����� � ������ � ��������
    xTableDim := ini.ReadInteger('Table', 'SizeX', 0);
    yTableDim := ini.ReadInteger('Table', 'SizeY', 0);

    // ������� ���������� ����� � ������ �������� (+1 ��� ������������� �������� - ���������)
    Tables.DrawCoords;

    // �������� ������
    for y := 1 to yTableDim do
    begin
      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('Table', 'A'+IntToStr(y), '');
      with MainForm do
      for x := 1 to xTableDim do
        tableA.Cells[x, y] := tableList[x-1];

      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('Table', 'B'+IntToStr(y), '');
      with MainForm do
      for x := 1 to xTableDim do
        tableB.Cells[x, y] := tableList[x-1];
    end;

    // �������� �������
      // ���� ������ � �������� ����, �� ���������
    SelLoad := False;
    if ini.ReadInteger('Selection', 'SelNum', 0) > 0 then
    begin;
      for i := 1 to ini.ReadInteger('Selection', 'SelNum', 0) do
      begin
        SetLength(SelectionsList, Length(SelectionsList)+1);
        SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
      end;

      for x := 0 to ini.ReadInteger('Selection', 'SelNum', 0)-1 do
      begin
        Selection.Clear;
        Selection.CommaText := AnsiString(ini.ReadString('Selection', 'S'+IntToStr(x), ''));

        SelectionsList[x].DefMatrixStartX := StrToInt(Selection[0]);
        SelectionsList[x].DefMatrixStartY := StrToInt(Selection[1]);
        SelectionsList[x].DefMatrixEndX := StrToInt(Selection[2]);
        SelectionsList[x].DefMatrixEndY := StrToInt(Selection[3]);

        SelectionsList[x].CalcAreaStartX := StrToInt(Selection[4]);
        SelectionsList[x].CalcAreaStartY := StrToInt(Selection[5]);
        SelectionsList[x].CalcAreaEndX := StrToInt(Selection[6]);
        SelectionsList[x].CalcAreaEndY := StrToInt(Selection[7]);

//        SelectionsList[x].Name := Selection[8];
//        SelectionsList[x].IsFixed := StrToBool(Selection[9]);
//        SelectionsList[x].SigmaA := StrToFloat(Selection[10]);
//        SelectionsList[x].SigmaB := StrToFloat(Selection[11]);
//        SelectionsList[x].AverageA := StrToFloat(Selection[12]);
//        SelectionsList[x].AverageB := StrToFloat(Selection[13]);
      end;

      SelLoad := True;
      activeSelIndex := 0;
      Selections.Changed(activeSelIndex);
    end
    else
    begin
      temp := yTableDim;
      for y:=0 to yTableDim do
      begin
        for x:=0 to xTableDim do
        begin
          MainForm.tableD.Cells[x+1,0] := IntToStr(x+1);
          MainForm.tableD.Cells[0,y+1] := IntToStr(temp);
          MainForm.tableR.Cells[x+1,0] := IntToStr(x+1);
          MainForm.tableR.Cells[0,y+1] := IntToStr(temp);
          MainForm.tableD.Cells[x+1,y+1] := '0';
          MainForm.tableR.Cells[x+1,y+1] := '0';
        end;
        temp := temp - 1;
      end;
      for y:=0 to (yTableDim*2) do
        for x:=0 to xTableDim  do
        begin
          MainForm.tableDR.Cells[x+1,y+1] := '0';
        end;
    end;
    tableList.Free;
    Selection.Free;
  end;

  procedure LoadActual;
  var
    x, y, i: Integer;
  begin
    // ���������� ���������� ���������� ����� � ������ � ��������
    xTableDim := ini.ReadInteger('Information', 'SizeX', 0);
    yTableDim := ini.ReadInteger('Information', 'SizeY', 0);

    Selection.StrictDelimiter := True;
    Selection.Delimiter := ';';
    tableList.StrictDelimiter := True;
    tableList.Delimiter := ';';

    // ������� ���������� ����� � ������ �������� (+1 ��� ������������� �������� - ���������)
    Tables.DrawCoords;

    // �������� ������
    for y := 1 to yTableDim do
    begin
      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('TableA', IntToStr(y), '');
      with MainForm do
      for x := 1 to xTableDim do
        tableA.Cells[x, y] := tableList[x-1];

      tableList.Clear;
      tableList.DelimitedText := ini.ReadString('TableB', IntToStr(y), '');
      with MainForm do
      for x := 1 to xTableDim do
        tableB.Cells[x, y] := tableList[x-1];
    end;

    // �������� �������
      // ���� ������ � �������� ����, �� ���������
    SelLoad := False;
    if ini.ReadInteger('Information', 'SelNum', 0) > 0 then
    begin;
      for i := 1 to ini.ReadInteger('Information', 'SelNum', 0) do
      begin
        SetLength(SelectionsList, Length(SelectionsList)+1);
        SelectionsList[Length(SelectionsList)-1] := TSelection.Create;
      end;

      for x := 0 to ini.ReadInteger('Information', 'SelNum', 0)-1 do
      begin
        SelectionsList[x].Name := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Name', ''));

        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'DefMatrix', ''));
        SelectionsList[x].DefMatrixStartX := StrToInt(Selection[0]);
        SelectionsList[x].DefMatrixStartY := StrToInt(Selection[1]);
        SelectionsList[x].DefMatrixEndX := StrToInt(Selection[2]);
        SelectionsList[x].DefMatrixEndY := StrToInt(Selection[3]);

        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'CalcArea', ''));
        SelectionsList[x].CalcAreaStartX := StrToInt(Selection[0]);
        SelectionsList[x].CalcAreaStartY := StrToInt(Selection[1]);
        SelectionsList[x].CalcAreaEndX := StrToInt(Selection[2]);
        SelectionsList[x].CalcAreaEndY := StrToInt(Selection[3]);

        SelectionsList[x].IsFixed := StrToBool(ini.ReadString('Selection'+IntToStr(x+1), 'IsFixed', ''));

        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Sigmas', ''));
        SelectionsList[x].SigmaA := StrToFloat(Selection[0]);
        SelectionsList[x].SigmaB := StrToFloat(Selection[1]);

        Selection.Clear;
        Selection.DelimitedText := AnsiString(ini.ReadString('Selection'+IntToStr(x+1), 'Averages', ''));
        SelectionsList[x].AverageA := StrToFloat(Selection[0]);
        SelectionsList[x].AverageB := StrToFloat(Selection[1]);
      end;

      SelLoad := True;
      activeSelIndex := 0;
      Selections.Changed(activeSelIndex);
    end
    else
    begin
      temp := yTableDim;
      for y:=0 to yTableDim do
      begin
        for x:=0 to xTableDim do
        begin
          MainForm.tableD.Cells[x+1,0] := IntToStr(x+1);
          MainForm.tableD.Cells[0,y+1] := IntToStr(temp);
          MainForm.tableR.Cells[x+1,0] := IntToStr(x+1);
          MainForm.tableR.Cells[0,y+1] := IntToStr(temp);
          MainForm.tableD.Cells[x+1,y+1] := '0';
          MainForm.tableR.Cells[x+1,y+1] := '0';
        end;
        temp := temp - 1;
      end;
      for y:=0 to (yTableDim*2) do
        for x:=0 to xTableDim  do
        begin
          MainForm.tableDR.Cells[x+1,y+1] := '0';
        end;
    end;
    tableList.Free;
    Selection.Free;
  end;

begin
  with MainForm do
  begin
    Screen.Cursor := crHourGlass;
    closeFileBtn.Click;
    LoadedFileName := fileOpenDialog.FileName;
    fileSaveDialog.FileName := fileOpenDialog.FileName;

    // ������
    tableList := TStringList.Create;
    Selection := TStringList.Create;
    ini := TIniFile.Create(fileOpenDialog.FileName);

    // ��������������� ���������� / ��������� / �������
    isFileOpened := True;
    isFileNew := False;
    saveAsFileBtn.Enabled := True;
    saveFileBtn.Enabled := True;
    exportToTablesBtn.Enabled := True;
    exportToIsolinesBtn.Enabled := True;
    closeFileBtn.Enabled := True;
    openDecompositionFormBtn.Enabled := True;
    openCompositionFormBtn.Enabled := True;

    // ������ �� ini-�����
    // ���� ������ ���������
    try
      if ini.ReadInteger('Information', 'Version', 0) < 2340 then
        LoadOld
      else if ini.ReadInteger('Information', 'Version', 0) = 2340 then
        Load2340
      else
        LoadActual;
    except
      Screen.Cursor := crDefault;
      Functions.MyMessageDlg('�� ������� ������� ����.'+#13#10+'��������, ���� ���������.',
        mtError, [mbOk], ['��'], '������', MB_ICONERROR);
      exit;
    end;

    // ���� ���������� ������������ ���������� �������
    if Length(SelectionsList) = MaxSel then
      selPnlLabel.Caption := '������� (���������� ������������ ����������)'
    else
      selPnlLabel.Caption := '�������';

    // ��������������� ���������� / ��������� / �������
    tableA.Refresh;
    tableB.Refresh;
    tableD.Refresh;
    tableR.Refresh;
    isFileChanged := False;
    toolsPnl.Visible := True;
    toolsPnl.Enabled := True;
    openTableABtn.Enabled := False;
    openTableBBtn.Enabled := True;
    openTableDBtn.Enabled := True;
    openTableRBtn.Enabled := True;
    openTableABtn.Click;
    isSelSwitched := True;

    // ��������� �������
    Processing.Calculation(activeSelIndex);
    //
    if (SelLoad = False) then
    begin
      selDeleteBtn.Enabled := False;
      InfoLineUpdate('������ ������������ ����',
        ' (������ � �������� �����������: ��� ������������ �������� ���������� ������� �������)');
    end
    else if (SelLoad = True) and (SelError = False) then
    begin
      selDeleteBtn.Enabled := True;
      InfoLineUpdate('������ ������������ ����, ������� ���������, ���������� �������', '');
    end
    else if (SelLoad = True) and (SelError = True) then
    begin
      InfoLineUpdate('������ ������������ ����',
        ' (������ � �������� �����������: ��� ������������ �������� ���������� ������� �������)');
    end;
    Tables.ABTransfer('to AB');

    if not isPythonInitialized then
      MainForm.exportToIsolinesBtn.Enabled := False;

    MainForm.Caption := '���������� (' + fileOpenDialog.FileName + ')';
    startPanel.Visible := False;
    Screen.Cursor := crDefault;
  end;
end;

// �������� ���� � .jpg �� SaveDialogName -------------------------------- �������
function TFiles.GetFileName(): String;
var
  fullFileName: String;
  x, cut1, cut2: Integer;
begin
//  Result := TPath.GetFileNameWithoutExtension(LoadedFileName);
  fullFileName := MainForm.Caption;
  for x := 1 to Length(MainForm.Caption) do
  begin
    if fullFileName[x] = '\' then cut1 := x;
    if fullFileName[x] = '.' then cut2 := x;
  end;
  cut2 := cut2 - cut1 - 1;
  Result := Copy(fullFileName, cut1+1, cut2);
end;

function TFiles.CutFileExtension(fileName: string): String;
var
  path, name: string;
begin
  path := TPath.GetDirectoryName(fileName);
  name := TPath.GetFileNameWithoutExtension(fileName);
  Result := path + '\' + name;
end;

end.
