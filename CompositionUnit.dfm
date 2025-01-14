object CompositionForm: TCompositionForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1084#1087#1086#1079#1080#1094#1080#1103
  ClientHeight = 169
  ClientWidth = 272
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
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 268
    Height = 49
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1060#1072#1081#1083
    Constraints.MaxHeight = 49
    Constraints.MaxWidth = 268
    Constraints.MinHeight = 33
    Constraints.MinWidth = 213
    TabOrder = 0
    object NameEdit: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 16
      Width = 188
      Height = 24
      Margins.Top = 0
      Align = alLeft
      Color = clBtnFace
      Constraints.MaxHeight = 24
      Constraints.MinHeight = 24
      ReadOnly = True
      TabOrder = 0
      ExplicitTop = 14
    end
    object SearchButton: TButton
      AlignWithMargins = True
      Left = 199
      Top = 16
      Width = 64
      Height = 24
      Margins.Top = 0
      Align = alClient
      Caption = #1054#1073#1079#1086#1088
      Constraints.MaxHeight = 28
      Constraints.MinHeight = 24
      TabOrder = 1
      OnClick = SearchButtonClick
      ExplicitTop = 14
      ExplicitHeight = 28
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 53
    Width = 268
    Height = 67
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '
    Constraints.MinWidth = 213
    TabOrder = 1
    object SelInsCB: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 19
      Width = 258
      Height = 17
      Hint = #1042#1099#1073#1086#1088#1082#1080' '#1080#1079' '#1092#1072#1081#1083#1072' '#1082#1086#1084#1087#1086#1079#1080#1094#1080#1080' '#1073#1091#1076#1091#1090' '#1074#1089#1090#1072#1074#1083#1077#1085#1099'.'
      Align = alTop
      Caption = #1042#1099#1073#1086#1088#1082#1080' '#1089' '#1092#1072#1081#1083#1072' '#1082#1086#1084#1087#1086#1079#1080#1094#1080#1080
      Checked = True
      Constraints.MaxHeight = 17
      Constraints.MinHeight = 17
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
      OnClick = SelInsCBClick
      ExplicitTop = 14
    end
    object SelOnlyCB: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 42
      Width = 258
      Height = 17
      Hint = #1058#1072#1073#1083#1080#1094#1099' '#1085#1077' '#1073#1091#1076#1091#1090' '#1082#1086#1084#1087#1086#1079#1080#1088#1086#1074#1072#1085#1099'.'
      Align = alTop
      Caption = #1058#1086#1083#1100#1082#1086' '#1074#1099#1073#1086#1088#1082#1080
      Constraints.MaxHeight = 17
      Constraints.MinHeight = 17
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ExplicitTop = 34
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 122
    Width = 268
    Height = 45
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085
    TabOrder = 2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 28
      Top = 18
      Width = 6
      Height = 14
      Hint = #1053#1072#1095#1072#1083#1086' '#1088#1072#1089#1089#1095#1077#1090#1085#1086#1075#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Align = alLeft
      Alignment = taCenter
      Caption = 'x'
      Layout = tlCenter
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 60
      Top = 18
      Width = 11
      Height = 14
      Margins.Left = 0
      Margins.Top = 2
      Align = alLeft
      Alignment = taCenter
      Caption = #8212
      Layout = tlCenter
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 97
      Top = 18
      Width = 6
      Height = 14
      Hint = #1050#1086#1085#1077#1094' '#1088#1072#1089#1089#1095#1077#1090#1085#1086#1075#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
      Margins.Left = 0
      Margins.Top = 2
      Margins.Bottom = 5
      Align = alLeft
      Alignment = taCenter
      Caption = 'x'
      Layout = tlCenter
    end
    object compFirstXEdit: TEdit
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
    object compFirstYEdit: TEdit
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
    object compLastXEdit: TEdit
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
    object compLastYEdit: TEdit
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
    object InsertButton: TButton
      AlignWithMargins = True
      Left = 132
      Top = 16
      Width = 131
      Height = 24
      Margins.Top = 0
      Align = alClient
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Enabled = False
      TabOrder = 4
      OnClick = InsertButtonClick
      ExplicitLeft = 128
      ExplicitTop = 14
      ExplicitWidth = 135
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1055#1088#1086#1075#1088#1072#1084#1084#1085#1099#1081' '#1092#1072#1081#1083'|*.anls'
    Left = 139
    Top = 16
  end
end
