object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '
  ClientHeight = 645
  ClientWidth = 184
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ResetButton: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 629
    Width = 178
    Height = 13
    Align = alBottom
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = ResetButtonClick
    OnMouseDown = ResetButtonMouseDown
    OnMouseUp = ResetButtonMouseUp
    ExplicitWidth = 104
  end
  object AssociationButton: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 610
    Width = 178
    Height = 13
    Align = alBottom
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1072#1089#1089#1086#1094#1080#1072#1094#1080#1102' '#1092#1072#1081#1083#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = AssociationButtonClick
    OnMouseDown = AssociationButtonMouseDown
    OnMouseUp = AssociationButtonMouseUp
    ExplicitWidth = 165
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 178
    Height = 214
    Align = alTop
    Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
    Constraints.MaxHeight = 214
    Constraints.MinHeight = 214
    TabOrder = 0
    object DRCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 109
      Width = 168
      Height = 17
      Align = alTop
      Caption = 'D '#1080' R '#1074#1084#1077#1089#1090#1077
      TabOrder = 0
      WordWrap = True
      OnClick = DRCheckBoxClick
    end
    object XYCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 132
      Width = 168
      Height = 20
      Align = alTop
      Caption = #1058#1077#1082#1091#1097#1080#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1099
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = XYCheckBoxClick
    end
    object sCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 184
      Width = 168
      Height = 20
      Align = alTop
      Caption = #1057#1080#1075#1084#1099' '#1080' '#1089#1088#1077#1076#1085#1080#1077' '
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = sCheckBoxClick
    end
    object selCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 158
      Width = 168
      Height = 20
      Align = alTop
      Caption = #1055#1072#1085#1077#1083#1100' '#1074#1099#1073#1086#1088#1082#1080
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = selCheckBoxClick
    end
    object ABCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 84
      Width = 168
      Height = 19
      Margins.Top = 1
      Align = alTop
      Caption = 'A '#1080' B '#1074#1084#1077#1089#1090#1077' '
      TabOrder = 5
      WordWrap = True
      OnClick = ABCheckBoxClick
    end
    object GroupBox5: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 168
      Height = 62
      Align = alTop
      Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '
      Constraints.MaxHeight = 62
      Constraints.MinHeight = 62
      TabOrder = 3
      object ToolTopButton: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 158
        Height = 17
        Margins.Bottom = 0
        Align = alTop
        Caption = #1057#1074#1077#1088#1093#1091
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = ToolTopButtonClick
      end
      object ToolBottomButton: TRadioButton
        AlignWithMargins = True
        Left = 5
        Top = 38
        Width = 158
        Height = 17
        Align = alTop
        Caption = #1057#1085#1080#1079#1091
        TabOrder = 1
        OnClick = ToolBottomButtonClick
      end
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 301
    Width = 178
    Height = 306
    Align = alTop
    Caption = #1069#1082#1089#1087#1086#1088#1090
    TabOrder = 1
    object GroupBox3: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 64
      Width = 168
      Height = 73
      ParentCustomHint = False
      Align = alTop
      Caption = 'A4'
      TabOrder = 0
      object wdhA4CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 16
        Width = 158
        Height = 20
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        Margins.Top = 1
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (X)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object wdhA4Edit: TEdit
        Left = 100
        Top = 15
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnKeyPress = wdhA4EditKeyPress
      end
      object hgtA4CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 42
        Width = 158
        Height = 17
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (Y)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object hgtA4Edit: TEdit
        Left = 100
        Top = 42
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnKeyPress = hgtA4EditKeyPress
      end
    end
    object GroupBox4: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 143
      Width = 168
      Height = 73
      Align = alTop
      Caption = 'A2'
      Constraints.MaxHeight = 73
      Constraints.MinHeight = 73
      TabOrder = 1
      object wdhA2CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 16
        Width = 158
        Height = 20
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        Margins.Top = 1
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (X)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object wdhA2Edit: TEdit
        Left = 100
        Top = 15
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnKeyPress = wdhA2EditKeyPress
      end
      object hgtA2CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 42
        Width = 158
        Height = 17
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (Y)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object hgtA2Edit: TEdit
        Left = 100
        Top = 42
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnKeyPress = hgtA2EditKeyPress
      end
    end
    object GroupBox6: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 222
      Width = 168
      Height = 73
      Align = alTop
      Caption = 'Excel'
      Constraints.MaxHeight = 73
      Constraints.MinHeight = 73
      TabOrder = 2
      object wdhExcelCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 16
        Width = 158
        Height = 20
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        Margins.Top = 1
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (X)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object hgtExcelCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 42
        Width = 158
        Height = 17
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        Align = alTop
        Caption = #1055#1086#1087#1088#1072#1074#1082#1072' (Y)'
        Constraints.MaxWidth = 158
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object hgtExcelEdit: TEdit
        Left = 100
        Top = 42
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1074#1099#1089#1086#1090#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnKeyPress = hgtExcelEditKeyPress
      end
      object wdhExcelEdit: TEdit
        Left = 100
        Top = 15
        Width = 61
        Height = 21
        Hint = #1055#1086#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnKeyPress = wdhExcelEditKeyPress
      end
    end
    object lightGrid: TRadioButton
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 168
      Height = 17
      Align = alTop
      Caption = #1057#1074#1077#1090#1083#1072#1103' '#1089#1077#1090#1082#1072
      TabOrder = 3
    end
    object darkGrid: TRadioButton
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 168
      Height = 17
      Align = alTop
      Caption = #1058#1077#1084#1085#1072#1103' '#1089#1077#1090#1082#1072
      Checked = True
      TabOrder = 4
      TabStop = True
    end
  end
  object GroupBox7: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 223
    Width = 178
    Height = 72
    Align = alTop
    Caption = #1057#1077#1090#1082#1072' '#1090#1072#1073#1083#1080#1094
    TabOrder = 2
    object GridPaintCB: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 168
      Height = 20
      Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1088#1072#1089#1095#1077#1090#1085#1099#1093' '#1076#1080#1072#1087#1072#1079#1086#1085#1072' '#1080' '#1087#1083#1086#1097#1072#1076#1080' '#1085#1072' '#1089#1077#1090#1082#1077' '#1094#1074#1077#1090#1072#1084#1080
      Align = alTop
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1076#1072#1087#1072#1079#1086#1085#1086#1074' '
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
      OnClick = GridPaintCBClick
    end
    object GridCoordCB: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 44
      Width = 168
      Height = 20
      Hint = #1055#1086#1076#1089#1089#1074#1077#1095#1080#1074#1072#1090#1100' '#1086#1089#1080' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1103#1095#1077#1081#1082#1080
      Align = alTop
      Caption = #1055#1086#1076#1089#1074#1077#1090#1082#1072' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 1
      OnClick = GridPaintCBClick
    end
  end
end
