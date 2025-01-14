object SigmasTransferForm: TSigmasTransferForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' '#1042#1089#1090#1072#1074#1082#1072' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1089#1080#1075#1084' '#1080' '#1089#1088#1077#1076#1085#1080#1093
  ClientHeight = 119
  ClientWidth = 296
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object OkBtn: TButton
    AlignWithMargins = True
    Left = 5
    Top = 93
    Width = 141
    Height = 24
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    Caption = #1054#1082
    Constraints.MaxHeight = 89
    Constraints.MinHeight = 20
    Enabled = False
    TabOrder = 0
    OnClick = OkBtnClick
    ExplicitTop = 72
    ExplicitHeight = 21
  end
  object CancelBtn: TButton
    AlignWithMargins = True
    Left = 150
    Top = 93
    Width = 141
    Height = 24
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 2
    Align = alRight
    Caption = #1054#1090#1084#1077#1085#1072
    Constraints.MaxHeight = 89
    Constraints.MinHeight = 20
    TabOrder = 1
    OnClick = CancelBtnClick
    ExplicitTop = 72
    ExplicitHeight = 21
  end
  object GroupBox7: TGroupBox
    AlignWithMargins = True
    Left = 5
    Top = 2
    Width = 286
    Height = 89
    Margins.Left = 5
    Margins.Top = 2
    Margins.Right = 5
    Margins.Bottom = 2
    Align = alTop
    Caption = #1042#1099#1073#1086#1088#1082#1080
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    object SelList: TCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 17
      Width = 276
      Height = 67
      Margins.Top = 0
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Items.Strings = (
        #1042#1099#1073#1086#1088#1082#1072' '#8470'1 (15:0-23:15, 0:32-32-0)'
        #1042#1099#1073#1086#1088#1082#1072' '#8470'2'
        #1042#1099#1073#1086#1088#1082#1072' '#8470'3'
        #1042#1099#1073#1086#1088#1082#1072' '#8470'4')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = SelListClick
      OnMouseDown = SelListMouseDown
      ExplicitTop = 14
      ExplicitHeight = 49
    end
  end
end
