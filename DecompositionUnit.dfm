object DecompositionForm: TDecompositionForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1077#1082#1086#1084#1087#1086#1079#1080#1094#1080#1103
  ClientHeight = 371
  ClientWidth = 224
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object SaveButton: TButton
    AlignWithMargins = True
    Left = 2
    Top = 345
    Width = 220
    Height = 24
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Constraints.MaxHeight = 24
    Constraints.MaxWidth = 220
    Constraints.MinHeight = 24
    Constraints.MinWidth = 174
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = SaveButtonClick
    ExplicitTop = 341
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 220
    Height = 45
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 28
      Top = 18
      Width = 6
      Height = 22
      Hint = #1053#1072#1095#1072#1083#1086' '#1088#1072#1089#1089#1095#1077#1090#1085#1086#1075#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Align = alLeft
      Alignment = taCenter
      Caption = 'x'
      Layout = tlCenter
      ExplicitTop = 16
      ExplicitHeight = 14
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 60
      Top = 18
      Width = 11
      Height = 22
      Margins.Left = 0
      Margins.Top = 2
      Align = alLeft
      Alignment = taCenter
      Caption = #8212
      Layout = tlCenter
      ExplicitHeight = 14
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 97
      Top = 18
      Width = 6
      Height = 20
      Hint = #1050#1086#1085#1077#1094' '#1088#1072#1089#1089#1095#1077#1090#1085#1086#1075#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Caption = 'x'
      Layout = tlCenter
      ExplicitHeight = 14
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 129
      Top = 18
      Width = 5
      Height = 22
      Margins.Left = 0
      Margins.Top = 2
      Align = alLeft
      Alignment = taCenter
      Caption = '|'
      Layout = tlCenter
      ExplicitHeight = 14
    end
    object decompFirstXEdit: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 20
      Height = 20
      Hint = 'X '#1085#1072#1095#1072#1083#1072' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Color = clBtnFace
      Ctl3D = True
      NumbersOnly = True
      ParentCtl3D = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      TextHint = 'X'
      ExplicitHeight = 22
    end
    object decompFirstYEdit: TEdit
      AlignWithMargins = True
      Left = 37
      Top = 18
      Width = 20
      Height = 20
      Hint = 'Y '#1085#1072#1095#1072#1083#1072' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Color = clBtnFace
      Ctl3D = True
      NumbersOnly = True
      ParentCtl3D = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      TextHint = 'Y'
      ExplicitHeight = 22
    end
    object decompLastXEdit: TEdit
      AlignWithMargins = True
      Left = 74
      Top = 18
      Width = 20
      Height = 20
      Hint = 'X '#1082#1086#1085#1094#1072' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Color = clBtnFace
      Ctl3D = True
      NumbersOnly = True
      ParentCtl3D = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 2
      TextHint = 'X'
      ExplicitHeight = 22
    end
    object decompLastYEdit: TEdit
      AlignWithMargins = True
      Left = 106
      Top = 18
      Width = 20
      Height = 20
      Hint = 'Y '#1082#1086#1085#1094#1072' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Color = clBtnFace
      Ctl3D = True
      NumbersOnly = True
      ParentCtl3D = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
      TextHint = 'Y'
      ExplicitHeight = 22
    end
    object QuarterButton: TButton
      AlignWithMargins = True
      Left = 140
      Top = 16
      Width = 75
      Height = 24
      Margins.Top = 0
      Align = alRight
      Caption = #1063#1077#1090#1074#1077#1088#1090#1100' '#8595
      TabOrder = 4
      OnClick = QuarterButtonClick
      ExplicitTop = 14
    end
  end
  object GroupBox9: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 273
    Width = 220
    Height = 70
    Hint = #1055#1086#1076#1087#1080#1089#1100' '#1073#1091#1076#1077#1090' '#1074#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1076' '#1082#1072#1088#1090#1086#1081
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alTop
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object SignatureEdit: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 17
      Width = 210
      Height = 21
      Hint = #1055#1088#1080#1084#1077#1088': '#1053#1072#1073#1086#1088' '#1090#1072#1073#1083#1080#1094' '#8470'13'
      Margins.Top = 1
      Align = alTop
      AutoSize = False
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitTop = 15
    end
    object ClearSignatureButton: TButton
      AlignWithMargins = True
      Left = 190
      Top = 41
      Width = 25
      Height = 24
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100
      Margins.Top = 0
      Align = alRight
      Caption = '<'
      TabOrder = 1
      OnClick = ClearSignatureButtonClick
      ExplicitTop = 39
    end
    object UseFileNameButton: TButton
      AlignWithMargins = True
      Left = 5
      Top = 41
      Width = 180
      Height = 24
      Margins.Top = 0
      Align = alLeft
      Caption = #1048#1089#1087'. '#1085#1072#1079#1074#1072#1085#1080#1077' '#1086#1088#1080#1075'. '#1092#1072#1081#1083#1072
      TabOrder = 2
      OnClick = UseFileNameButtonClick
      ExplicitTop = 39
    end
  end
  object QuarterGB: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 51
    Width = 220
    Height = 220
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    TabOrder = 3
    Visible = False
    ExplicitTop = 49
    object Quarter3: TButton
      Left = 7
      Top = 6
      Width = 100
      Height = 100
      TabOrder = 0
      OnClick = Quarter1Click
    end
    object Quarter4: TButton
      Left = 111
      Top = 6
      Width = 100
      Height = 100
      TabOrder = 1
      OnClick = Quarter1Click
    end
    object Quarter1: TButton
      Left = 7
      Top = 111
      Width = 100
      Height = 100
      TabOrder = 2
      OnClick = Quarter1Click
    end
    object Quarter2: TButton
      Left = 111
      Top = 111
      Width = 100
      Height = 100
      TabOrder = 3
      OnClick = Quarter1Click
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'anls'
    Filter = #1055#1088#1086#1075#1088#1072#1084#1084#1085#1099#1081' '#1092#1072#1081#1083'|*.anls'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 20
    Top = 48
  end
end
