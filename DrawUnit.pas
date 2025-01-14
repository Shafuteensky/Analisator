unit DrawUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PythonVersions, PythonEngine, Vcl.PythonGUIInputOutput, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg;

type
  TForm2 = class(TForm)
    MemoInit: TMemo;
    MemoOutput: TMemo;
    redrawMemo: TMemo;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure VariantToBMP(aValue: OleVariant; var aBmp: TBitmap);
    procedure VariantToStream(const v: olevariant; Stream: TMemoryStream);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DrawForm: TForm2;

implementation

uses
  IsolinesUnit, MainUnit;

{$R *.dfm}

procedure TForm2.VariantToStream (const v : olevariant;
                                  Stream : TMemoryStream);
var
  p : pointer;
begin
  Stream.Position := 0;
  Stream.Size := VarArrayHighBound (v, 1) - VarArrayLowBound(v,  1) + 1;
  p := VarArrayLock (v);
  Stream.Write (p^, Stream.Size);
  VarArrayUnlock (v);
  Stream.Position := 0;
end;

procedure TForm2.VariantToBMP(aValue : OleVariant;var aBmp:TBitmap);
var
   Stream : TMemoryStream;
begin
try
  Stream := TMemoryStream.Create;

  VariantToStream (aValue,Stream);
  aBmp.LoadfromStream(Stream);

finally
//   Variant.Clear(aValue);
   Stream.free;
end;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
//  IsolinesForm.PythonModule.SetVarFromVariant('xTableDim', xTableDim);
//  IsolinesForm.PythonModule.SetVarFromVariant('yTableDim', yTableDim);
//  IsolinesForm.PythonEngine.ExecStrings(MemoInit.Lines);
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  imgX, imgY: Double;
  im: OleVariant;
  FImage: TPicture;
  kek: String;
  procedure reassignImage;
  begin
    FImage := TPicture.Create;
    FImage.LoadFromFile('drawing.png');
    Image1.Picture.Assign(FImage);
    FImage.Free;
  end;

begin
//  if Button = mbLeft then
//  begin
//    imgX := (X/Image1.Width)*100;
//    imgY := 100-(Y/Image1.Height)*100;
//    MemoOutput.Lines.Add(FloatToStr(imgX) + ' ' + FloatToStr(imgY));
//    IsolinesForm.PythonModule.SetVarFromVariant('imgX', imgX*0.01*xTableDim);
//    IsolinesForm.PythonModule.SetVarFromVariant('imgY', imgY*0.01*yTableDim);
//    IsolinesForm.PythonEngine.ExecString(
//      'points = np.append(points, [[PythonModule.imgX, PythonModule.imgY]], axis=0)');
//    IsolinesForm.PythonEngine.ExecStrings(redrawMemo.Lines);
//    reassignImage;
//  end
//  else if Button = mbRight then
//  begin
//    IsolinesForm.PythonEngine.ExecString('if len(points) > 0: points = np.delete(points, len(points)-1, axis=0)');
//    IsolinesForm.PythonEngine.ExecStrings(redrawMemo.Lines);
//    reassignImage;
//  end;
end;

end.

