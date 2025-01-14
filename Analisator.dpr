program Analisator;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  MainUnit in 'MainUnit.pas' {MainForm},
  CreateUnit in 'CreateUnit.pas' {CreateForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm},
  InformationUnit in 'InformationUnit.pas' {InformationForm},
  ExportToTablesUnit in 'ExportToTablesUnit.pas' {ExportToTablesForm},
  IsolinesUnit in 'IsolinesUnit.pas' {IsolinesForm},
  FunctionsUnit in 'FunctionsUnit.pas',
  ParamsUnit in 'ParamsUnit.pas',
  PreviewUnit in 'PreviewUnit.pas' {Form1},
  CompositionUnit in 'CompositionUnit.pas' {CompositionForm},
  DecompositionUnit in 'DecompositionUnit.pas' {DecompositionForm},
  DrawUnit in 'DrawUnit.pas' {Form2},
  SigmasTransferUnit in 'SigmasTransferUnit.pas' {SigmasTransferForm},
  AutoSelectionUnit in 'AutoSelectionUnit.pas' {AutoSelectionForm},
  SelectionUnit in 'SelectionUnit.pas',
  FilesUnit in 'FilesUnit.pas',
  TablesUnit in 'TablesUnit.pas',
  ProcessingUnit in 'ProcessingUnit.pas';

{$R *.res}
{$REFERENCEINFO ON}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCreateForm, CreateForm);
  Application.CreateForm(TInformationForm, InformationForm);
  Application.CreateForm(TExportToTablesForm, ExportToTablesForm);
  Application.CreateForm(TIsolinesForm, IsolinesForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TCompositionForm, CompositionForm);
  Application.CreateForm(TDecompositionForm, DecompositionForm);
  Application.CreateForm(TSigmasTransferForm, SigmasTransferForm);
  Application.CreateForm(TAutoSelectionForm, AutoSelectionForm);
  Application.Run;
end.
