unit ParamsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.ButtonGroup;

type
  TParamsUnit = class(TForm)
  end;

  // =============================================
var
  Params: TParamsUnit;

const
  // Версия
  ProgramVersion: Integer = 2450;
  // Максимальное количество выборок
  MaxSel: Integer = 99;


  // =============================================

implementation

uses CreateUnit, DGLUT, FunctionsUnit, ExportToTablesUnit, InformationUnit,
  IsolinesUnit, MainUnit, SettingsUnit;


end.
