object AutoSelectionForm: TAutoSelectionForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' '#1040#1074#1090#1086#1087#1086#1076#1073#1086#1088
  ClientHeight = 122
  ClientWidth = 249
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 2
    Top = 0
    Width = 245
    Height = 94
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 0
    Align = alTop
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    ExplicitWidth = 248
    object GridPanel3: TGridPanel
      AlignWithMargins = True
      Left = 4
      Top = 16
      Width = 239
      Height = 73
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 40.751241465156670000
        end
        item
          Value = 41.482888149308410000
        end
        item
          Value = 17.765870385534920000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Label4
          Row = 1
        end
        item
          Column = 1
          ColumnSpan = 2
          Control = MethodCB
          Row = 1
        end
        item
          Column = 0
          Control = Label1
          Row = 0
        end
        item
          Column = 1
          ColumnSpan = 2
          Control = CriteriaCB
          Row = 0
        end
        item
          Column = 0
          ColumnSpan = 2
          Control = Label2
          Row = 2
        end
        item
          Column = 2
          Control = minCellNumEdit
          Row = 2
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 24.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 24.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 30.000000000000000000
        end>
      TabOrder = 0
      ExplicitTop = 14
      ExplicitWidth = 242
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 91
        Height = 14
        Margins.Top = 6
        Margins.Bottom = 0
        Align = alTop
        Caption = #1052#1077#1090#1086#1076
        ParentShowHint = False
        ShowHint = True
        ExplicitWidth = 36
      end
      object MethodCB: TComboBox
        AlignWithMargins = True
        Left = 100
        Top = 27
        Width = 136
        Height = 22
        Hint = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
        Align = alClient
        AutoCloseUp = True
        BevelKind = bkFlat
        Style = csDropDownList
        DoubleBuffered = True
        Enabled = False
        ItemIndex = 0
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = #1055#1077#1088#1077#1073#1086#1088
        Items.Strings = (
          #1055#1077#1088#1077#1073#1086#1088
          #1048#1084#1080#1090#1072#1094#1080#1103' '#1086#1090#1078#1080#1075#1072)
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 6
        Width = 91
        Height = 14
        Margins.Top = 6
        Margins.Bottom = 0
        Align = alTop
        Caption = #1050#1088#1080#1090#1077#1088#1080#1081
        ParentShowHint = False
        ShowHint = True
        ExplicitWidth = 55
      end
      object CriteriaCB: TComboBox
        AlignWithMargins = True
        Left = 100
        Top = 0
        Width = 136
        Height = 22
        Hint = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
        Margins.Top = 0
        Align = alClient
        AutoCloseUp = True
        BevelKind = bkFlat
        Style = csDropDownList
        DoubleBuffered = True
        ItemIndex = 0
        ParentDoubleBuffered = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = '1'#8804'D<1.5, R<0'
        Items.Strings = (
          '1'#8804'D<1.5, R<0'
          '1.5'#8804'D<2, R<0'
          '2'#8804'D<3, R<0'
          'D>3, R<0')
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 57
        Width = 191
        Height = 14
        Margins.Top = 9
        Margins.Bottom = 0
        Align = alTop
        Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1103#1095#1077#1077#1082
        ParentShowHint = False
        ShowHint = True
        ExplicitWidth = 186
      end
      object minCellNumEdit: TEdit
        AlignWithMargins = True
        Left = 200
        Top = 54
        Width = 36
        Height = 24
        Margins.Top = 6
        Margins.Bottom = 0
        Align = alClient
        NumbersOnly = True
        TabOrder = 2
        Text = '8'
        ExplicitLeft = 164
        ExplicitWidth = 75
        ExplicitHeight = 22
      end
    end
  end
  object StartSelectionBtn: TButton
    AlignWithMargins = True
    Left = 2
    Top = 96
    Width = 245
    Height = 24
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Caption = #1055#1086#1080#1089#1082' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
    TabOrder = 1
    OnClick = StartSelectionBtnClick
  end
  object ProgressBar: TProgressBar
    AlignWithMargins = True
    Left = 5
    Top = 124
    Width = 239
    Height = 22
    Margins.Left = 5
    Margins.Top = 2
    Margins.Right = 5
    Margins.Bottom = 2
    Align = alTop
    DoubleBuffered = False
    Max = 4
    ParentDoubleBuffered = False
    MarqueeInterval = 1
    Step = 1
    TabOrder = 2
    Visible = False
  end
end
