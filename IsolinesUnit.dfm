object IsolinesForm: TIsolinesForm
  AlignWithMargins = True
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = #1048#1079#1086#1083#1080#1085#1080#1080
  ClientHeight = 699
  ClientWidth = 270
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressLabel: TLabel
    Left = 275
    Top = 499
    Width = 71
    Height = 13
    Caption = 'ProgressLabel'
    Transparent = False
  end
  object SaveButton: TButton
    AlignWithMargins = True
    Left = 9
    Top = 669
    Width = 252
    Height = 27
    Margins.Left = 9
    Margins.Right = 9
    Align = alBottom
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Constraints.MaxHeight = 27
    Constraints.MaxWidth = 252
    Constraints.MinHeight = 27
    Constraints.MinWidth = 233
    Enabled = False
    TabOrder = 2
    OnClick = SaveButtonClick
  end
  object ProgressBar: TProgressBar
    AlignWithMargins = True
    Left = 9
    Top = 638
    Width = 252
    Height = 25
    Margins.Left = 9
    Margins.Right = 9
    Align = alBottom
    DoubleBuffered = False
    Constraints.MaxHeight = 25
    Constraints.MaxWidth = 252
    Constraints.MinHeight = 25
    Constraints.MinWidth = 233
    Max = 4
    ParentDoubleBuffered = False
    MarqueeInterval = 1
    Step = 1
    TabOrder = 3
    Visible = False
  end
  object GroupBox7: TGroupBox
    AlignWithMargins = True
    Left = 6
    Top = 0
    Width = 258
    Height = 89
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 95
    Align = alTop
    Caption = #1042#1099#1073#1086#1088#1082#1080
    Color = clBtnFace
    Constraints.MaxWidth = 258
    Constraints.MinWidth = 121
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    object SelectionCLB: TCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 248
      Height = 69
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
      TabOrder = 0
      OnClickCheck = SelectionCLBClick
      OnMouseDown = SelectionCLBMouseDown
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 140
    Top = 92
    Width = 124
    Height = 90
    Margins.Bottom = 0
    Caption = #1042#1080#1076' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
    TabOrder = 1
    object A4RadioButton: TRadioButton
      AlignWithMargins = True
      Left = 10
      Top = 18
      Width = 109
      Height = 17
      Hint = #1056#1072#1079#1088#1077#1079#1072#1090#1100' '#1040'2 '#1085#1072' '#1083#1080#1089#1090#1099' '#1040'4 ('#1052#1072#1089#1096#1090#1072#1073' 1 '#1089#1084' '#1085#1072' '#1103#1095#1077#1081#1082#1091')'
      Margins.Left = 8
      Align = alTop
      Caption = #1051#1080#1089#1090#1099' '#1040'4 '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object A2RadioButton: TRadioButton
      AlignWithMargins = True
      Left = 10
      Top = 41
      Width = 109
      Height = 17
      Hint = #1052#1072#1089#1096#1090#1072#1073' 1 '#1089#1084' '#1085#1072' '#1103#1095#1077#1081#1082#1091', '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080' '#1085#1072' '#1087#1083#1086#1090#1090#1077#1088#1077
      Margins.Left = 8
      Align = alTop
      Caption = #1051#1080#1089#1090' '#1040'2'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object A4mRadioButton: TRadioButton
      AlignWithMargins = True
      Left = 10
      Top = 64
      Width = 109
      Height = 17
      Hint = #1059#1084#1077#1089#1090#1080#1090#1100' '#1074#1089#1102' '#1090#1072#1073#1083#1080#1094#1091' '#1085#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1073#1077#1079' '#1084#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1103
      Margins.Left = 8
      Align = alTop
      Caption = #1041#1077#1079' '#1087#1086#1076#1075#1086#1085#1082#1080
      Checked = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = True
    end
  end
  object ReviseMemo: TMemo
    Left = 275
    Top = 143
    Width = 254
    Height = 350
    Lines.Strings = (
      ''
      
        '# ==============================================================' +
        '======='
      ''
      '# '#1054#1095#1080#1097#1072#1077#1084' '#1087#1072#1084#1103#1090#1100
      'gc.collect()'
      '# '#1063#1090#1086'-'#1090#1086' '#1074#1086#1083#1096#1077#1073#1085#1086#1077', '#1089#1087#1072#1089#1072#1077#1090' '#1087#1072#1084#1103#1090#1100
      'matplotlib.use('#39'agg'#39')'
      '# '#1058#1072#1073#1083#1080#1094#1072
      'ind = 0'
      '# '#1044#1074#1091#1084#1077#1088#1085#1099#1081' '#1084#1072#1089#1089#1080#1074
      'BufferArray = []'
      '# '#1052#1085#1086#1078#1080#1090#1077#1083#1100' '#1091#1084#1077#1085#1100#1096#1077#1085#1080#1103
      'factor = 3'
      ''
      '# '#1047#1072#1087#1086#1083#1085#1077#1085#1080#1077
      'for _ in range(PythonModule.yCol):'
      '    row = []'
      '    for _ in range(PythonModule.xCol):'
      '        row.append(float(PythonModule.GridArray[ind]))'
      '        ind = ind + 1'
      '    BufferArray.append(row)'
      ''
      'BufferArray = np.array(BufferArray, dtype='#39'single'#39')'
      '# '#1048#1085#1090#1077#1088#1087#1086#1083#1080#1088#1091#1077#1084' '#1080#1089#1093#1086#1076#1085#1099#1081' '#1084#1072#1089#1089#1080#1074
      
        'BufferArray = zoom(BufferArray, PythonModule.InterpLvl, output=n' +
        'p.float32, order=PythonModule.order, mode='#39'nearest'#39', grid_mode=T' +
        'rue)'
      '# '#1057#1086#1079#1076#1072#1077#1084' '#1085#1086#1074#1091#1102' '#1092#1080#1075#1091#1088#1091' '#1089' '#1079#1072#1076#1072#1085#1085#1086#1081' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100#1102
      
        'fig = plt.figure(figsize=(round(PythonModule.xCol / factor), rou' +
        'nd(PythonModule.yCol / factor)), dpi=PythonModule.Dpi)'
      '# '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082' '#1092#1080#1075#1091#1088#1077' '#1086#1073#1083#1072#1089#1090#1100' '#1086#1089#1077#1081
      'ax = fig.add_subplot(111)'
      '# '#1056#1072#1079#1084#1077#1088#1085#1086#1089#1090#1080
      
        'MeshX, MeshY = np.meshgrid(np.arange(0, BufferArray.shape[1], 1)' +
        ', np.arange(0, BufferArray.shape[0], 1))'
      ''
      
        '# '#1057#1074#1077#1088#1082#1072': ------------------------------------------------------' +
        '---------------'
      '# '#1044#1083#1103' D'
      'if PythonModule.IsoMode == '#39'D'#39':'
      '    # '#1042#1099#1074#1086#1076#1080#1084' '#1082#1086#1085#1090#1091#1088#1072
      
        '    CntrDash = plt.contour(MeshX, MeshY, BufferArray, [0.5, 1.5]' +
        ', colors='#39'black'#39', linewidths=PythonModule.linewidths / factor, l' +
        'inestyles='#39'dashed'#39')'
      
        '    CntrSolid0 = plt.contour(MeshX, MeshY, BufferArray, [0], col' +
        'ors='#39'black'#39', linewidths=PythonModule.linewidths * 2 / factor, li' +
        'nestyles='#39'solid'#39')'
      
        '    CntrSolid12 = plt.contour(MeshX, MeshY, BufferArray, [1, 2],' +
        ' colors='#39'black'#39', linewidths=PythonModule.linewidths / factor, li' +
        'nestyles='#39'solid'#39')'
      
        '    CntrDashDot3 = plt.contour(MeshX, MeshY, BufferArray, [3], c' +
        'olors='#39'black'#39', linewidths=PythonModule.linewidths / factor, line' +
        'styles='#39'dashdot'#39')'
      '    # '#1052#1077#1090#1082#1072' '#1082#1086#1085#1090#1091#1088#1072
      
        '    plt.clabel(CntrDash, inline=1, fontsize=round(PythonModule.f' +
        'ontsize * 1.5 / factor), colors='#39'black'#39')'
      
        '    plt.clabel(CntrSolid0, inline=1, fontsize=round(PythonModule' +
        '.fontsize * 1.5 / factor), colors='#39'black'#39')'
      
        '    plt.clabel(CntrSolid12, inline=1, fontsize=round(PythonModul' +
        'e.fontsize * 1.5 / factor), colors='#39'black'#39')'
      
        '    plt.clabel(CntrDashDot3, inline=1, fontsize=round(PythonModu' +
        'le.fontsize * 1.5 / factor), colors='#39'black'#39')'
      '# '#1044#1083#1103' R'
      'elif PythonModule.IsoMode == '#39'R'#39':'
      '    # '#1042#1099#1074#1086#1076#1080#1084' '#1082#1086#1085#1090#1091#1088#1072
      
        '    plt.contourf(MeshX, MeshY, BufferArray, [-100, 0], colors='#39'r' +
        'ed'#39', alpha=0.1)'
      
        '    plt.contour(MeshX, MeshY, BufferArray, [0], colors='#39'red'#39', li' +
        'newidths=PythonModule.linewidths / factor, linestyles='#39'solid'#39')'
      ''
      
        '# '#1050#1086#1088#1088#1077#1083#1103#1094#1080#1103': --------------------------------------------------' +
        '----------------'
      'elif PythonModule.IsoMode == '#39'C'#39':'
      '    # '#1044#1074#1091#1084#1077#1088#1085#1099#1081' '#1084#1072#1089#1089#1080#1074' '#1076#1083#1103' R'
      '    ind = 0'
      '    BufferArrayR = []'
      '    BufferArrayCorrel = np.zeros(BufferArray.shape)'
      ''
      '    for _ in range(PythonModule.yCol):'
      '        row = []'
      '        for _ in range(PythonModule.xCol):'
      '            row.append(float(PythonModule.GridArray2[ind]))'
      '            ind = ind + 1'
      '        BufferArrayR.append(row)'
      
        '    BufferArrayR = zoom(BufferArrayR, PythonModule.InterpLvl, ou' +
        'tput=np.float32, order=PythonModule.order, mode='#39'nearest'#39', grid_' +
        'mode=True)'
      ''
      '    # '#1054#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1082#1086#1088#1088#1077#1083#1103#1094#1080#1080
      
        '    BufferArrayCorrel = np.where((BufferArray >= 1) & (BufferArr' +
        'ay < 1.5) & (BufferArrayR >= 0) & (BufferArrayCorrel == 0), 5, B' +
        'ufferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 1) & (BufferArr' +
        'ay < 1.5) & (BufferArrayR < 0) & (BufferArrayCorrel == 0), 6, Bu' +
        'fferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 1.5) & (BufferA' +
        'rray < 2) & (BufferArrayR >= 0) & (BufferArrayCorrel == 0), 7, B' +
        'ufferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 1.5) & (BufferA' +
        'rray < 2) & (BufferArrayR < 0) & (BufferArrayCorrel == 0), 8, Bu' +
        'fferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 2) & (BufferArr' +
        'ay < 3) & (BufferArrayR >= 0) & (BufferArrayCorrel == 0), 9, Buf' +
        'ferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 2) & (BufferArr' +
        'ay < 3) & (BufferArrayR < 0) & (BufferArrayCorrel == 0), 10, Buf' +
        'ferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 3) & (BufferArr' +
        'ayR < 0) & (BufferArrayCorrel == 0), 11, BufferArrayCorrel)'
      
        '    BufferArrayCorrel = np.where((BufferArray >= 3) & (BufferArr' +
        'ayR >= 0) & (BufferArrayCorrel == 0), 12, BufferArrayCorrel)'
      '    BufferArray = BufferArrayCorrel'
      '    BufferArrayR = []'
      '    BufferArrayCorrel = []'
      ''
      '    # '#1050#1086#1085#1090#1091#1088#1099' --------'
      '    levels = [0.1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]'
      
        '    #         +<0.5       +<1         +<1.5          +<2       +' +
        '<3           ->3'
      
        '    hatches = ['#39'.'#39', '#39'..'#39', '#39'+++'#39', '#39'xxx'#39', '#39'c'#39', '#39'xxxxx'#39', '#39'k'#39', '#39'c'#39', ' +
        #39'#'#39', '#39'#'#39', '#39#39', '#39'1234#'#39']'
      
        '    #              -<0.5         - <1         -<1.5       -<2   ' +
        '     -<3          +>3'
      
        '    chatches = ['#39'xxxx'#39', '#39#39', '#39'xxxx'#39', '#39#39', '#39'xxxx'#39', '#39#39', '#39'xxxx'#39', '#39#39', ' +
        #39'xxxx'#39', '#39#39', '#39#39', '#39'xxxx'#39']'
      
        '    colors = ['#39'none'#39','#39'none'#39','#39'none'#39','#39'none'#39', to_rgba('#39'cornflowerbl' +
        'ue'#39', 0.5), to_rgba('#39'cornflowerblue'#39', 0.5),'
      
        '               to_rgba('#39'limegreen'#39', 0.5), to_rgba('#39'limegreen'#39', 0' +
        '.5), to_rgba('#39'gold'#39', 0.5), to_rgba('#39'gold'#39', 0.5),'
      '               to_rgba('#39'tomato'#39', 0.5), to_rgba('#39'tomato'#39', 0.5)]'
      
        '    hcolors = ['#39'none'#39', '#39'none'#39', '#39'none'#39', '#39'none'#39', to_rgba('#39'cornflow' +
        'erblue'#39', 0.3), to_rgba('#39'cornflowerblue'#39', 0.1),'
      
        '               to_rgba('#39'limegreen'#39', 0.3), to_rgba('#39'limegreen'#39', 0' +
        '.1), to_rgba('#39'gold'#39', 0.3), to_rgba('#39'gold'#39', 0.1),'
      '               to_rgba('#39'tomato'#39', 0.3), to_rgba('#39'tomato'#39', 0.1)]'
      ''
      '    # '#1062#1074#1077#1090#1072
      '    if PythonModule.IsColorMap == True:'
      '        if PythonModule.IsHatch == False:'
      
        '            plt.contourf(MeshX, MeshY, BufferArray, levels, hatc' +
        'hes=chatches, colors=colors, Nchunk=20)'
      '        else:'
      
        '            plt.contourf(MeshX, MeshY, BufferArray, levels, colo' +
        'rs=hcolors, Nchunk=20)'
      ''
      '    # '#1064#1090#1088#1080#1093#1086#1074#1082#1072
      '    if PythonModule.IsHatch == True:'
      '        # '#1050#1088#1072#1089#1085#1099#1077
      
        '        redCnt = plt.contourf(MeshX, MeshY, BufferArray, [7, 8, ' +
        '9, 10, 11, 12], hatches=['#39'1234'#39', '#39#39', '#39'1234'#39', '#39'1234#'#39', '#39#39'], color' +
        's='#39'none'#39', Nchunk=20)'
      
        '        for collection in redCnt.collections:  # '#1054#1082#1088#1072#1089#1082#1072' '#1074' '#1082#1088#1072#1089#1085 +
        #1099#1081
      '            collection.set_edgecolor('#39'tomato'#39')'
      '            collection.set_linewidth(0.)'
      '        # '#1063#1077#1088#1085#1099#1077
      
        '        plt.contourf(MeshX, MeshY, BufferArray, levels, colors='#39 +
        'none'#39', hatches=hatches, Nchunk=20)  # '#1042#1089#1077' '#1095#1077#1088#1085#1099#1077' '#1082#1086#1085#1090#1091#1088#1099
      ''
      '    # '#1051#1080#1085#1080#1080' '#1075#1088#1072#1085#1080#1094
      
        '    plt.contour(MeshX, MeshY, BufferArray, levels, linewidths=Py' +
        'thonModule.linewidths/factor/2, colors='#39'black'#39', antialiased=True' +
        ', Nchunk=20)'
      ''
      '# ------------------------------------------------'
      ''
      '# '#1064#1088#1080#1092#1090
      'rcParams['#39'font.family'#39'] = '#39'sans-serif'#39
      'rcParams['#39'font.sans-serif'#39'] = ['#39'Segoe UI'#39']'
      '# '#1044#1083#1103' '#1088#1072#1074#1085#1086#1075#1086' '#1089#1086#1086#1090#1085#1086#1096#1077#1085#1080#1103' '#1089#1090#1086#1088#1086#1085' '#1092#1080#1075#1091#1088#1099
      'ax.set_aspect(aspect='#39'equal'#39')'
      '# '#1054#1095#1080#1089#1090#1082#1072' '#1084#1072#1089#1089#1080#1074#1072
      'BufferArray = []'
      '# '#1059#1073#1080#1088#1072#1077#1084' '#1086#1089#1080' '#1080' '#1086#1090#1089#1090#1091#1087#1099
      'plt.axis('#39'off'#39')'
      '# '#1057#1086#1093#1088#1072#1085#1103#1077#1084' '#1092#1072#1081#1083
      
        'fig.savefig('#39'temp.png'#39', bbox_inches='#39'tight'#39', pad_inches=0, trans' +
        'parent=True, aspect='#39'auto'#39')'
      
        '# '#1055#1088#1072#1074#1080#1084' '#1077#1075#1086' '#1089#1090#1086#1088#1086#1085#1099' ('#1082#1086#1082#1086#1075#1086#1090#1086'-'#1090#1086' '#1095#1077#1088#1090#1072' '#1089#1086#1086#1090#1085#1086#1096#1077#1085#1080#1103' '#1089#1090#1086#1088#1086#1085' '#1074#1089#1077' '#1088 +
        #1072#1074#1085#1086' '#1082#1088#1080#1074#1099#1077')'
      'image = Image.open('#39'temp.png'#39')'
      
        'image = image.resize((PythonModule.xCol * PythonModule.CanvasSca' +
        'le, PythonModule.yCol * PythonModule.CanvasScale))'
      'image.save('#39'temp.png'#39')'
      '# '#1054#1095#1080#1097#1072#1077#1084' '#1082#1086#1085#1090#1091#1088#1072
      'fig.clear()'
      'plt.close(fig)'
      ''
      '# '#1051#1077#1075#1077#1085#1076#1072
      'def saveLegend(name):'
      
        '    fig_legend.legend(handles=custom_artists, labelspacing=0.3, ' +
        'ncol=3, fontsize=10.5, edgecolor='#39'black'#39', loc=2,'
      '                      facecolor='#39'none'#39', handleheight=2)'
      
        '    fig_legend.savefig(name, bbox_inches='#39'tight'#39', transparent=Tr' +
        'ue, aspect='#39'auto'#39')'
      '    image = Image.open(name)'
      
        '    image = image.resize((11 * PythonModule.CanvasScale, round(2' +
        '.5 * PythonModule.CanvasScale)))'
      '    image.save(name)'
      ''
      'if PythonModule.IsoMode == '#39'C'#39':'
      '    if PythonModule.IsHatch == True:'
      
        '        fig_legend = plt.figure(dpi=PythonModule.Dpi, figsize=(5' +
        ', 1))'
      '        # '#1051#1077#1075#1077#1085#1076#1072' '#1074' '#1096#1090#1088#1080#1093#1086#1074#1082#1077' '#1080' '#1094#1074#1077#1090#1072#1093
      '        if PythonModule.IsColorMap == True:'
      '            custom_artists = ['
      
        '                Patch(facecolor=hcolors[4], edgecolor='#39'black'#39', h' +
        'atch=hatches[4], label='#39'1'#8804'D<1.5, R'#8805'0'#39'),'
      
        '                Patch(facecolor=hcolors[5], edgecolor='#39'black'#39', h' +
        'atch=hatches[5], label='#39'1'#8804'D<1.5, R<0'#39'),'
      
        '                Patch(facecolor=hcolors[6], edgecolor='#39'black'#39', h' +
        'atch=hatches[6], label='#39'1.5'#8804'D<2, R'#8805'0'#39'),'
      
        '                Patch(facecolor=hcolors[7], edgecolor='#39'black'#39', h' +
        'atch=hatches[7], label='#39'1.5'#8804'D<2, R<0'#39'),'
      
        '                Patch(facecolor=hcolors[8], edgecolor='#39'black'#39', h' +
        'atch=hatches[8], label='#39'2'#8804'D<3, R'#8805'0'#39'),'
      
        '                Patch(facecolor=hcolors[9], edgecolor='#39'black'#39', h' +
        'atch=hatches[9], label='#39'2'#8804'D<3, R<0'#39'),'
      
        '                Patch(facecolor=hcolors[11], edgecolor='#39'black'#39', ' +
        'hatch=hatches[11], label='#39'D>3, R'#8805'0'#39'),'
      
        '                Patch(facecolor=hcolors[10], edgecolor='#39'black'#39', ' +
        'hatch=hatches[10], label='#39'D>3, R<0'#39')]'
      '        # '#1051#1077#1075#1077#1085#1076#1072' '#1090#1086#1083#1100#1082#1086' '#1087#1086' '#1096#1090#1088#1080#1093#1086#1074#1082#1077
      '        else:'
      '            custom_artists = ['
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[4], label='#39'1'#8804'D<1.5, R'#8805'0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[5], label='#39'1'#8804'D<1.5, R<0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[6], label='#39'1.5'#8804'D<2, R'#8805'0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[7], label='#39'1.5'#8804'D<2, R<0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[8], label='#39'2'#8804'D<3, R'#8805'0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[9], label='#39'2'#8804'D<3, R<0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[11], label='#39'D>3, R'#8805'0'#39'),'
      
        '                Patch(facecolor='#39'none'#39', edgecolor='#39'black'#39', hatch' +
        '=hatches[10], label='#39'D>3, R<0'#39')]'
      '        saveLegend('#39'legend.png'#39')'
      ''
      
        '        # '#1042#1090#1086#1088#1072#1103' '#1083#1077#1075#1077#1085#1076#1072' '#1082#1072#1082' '#1082#1086#1089#1090#1099#1083#1100' - '#1085#1077#1074#1086#1079#1084#1086#1078#1085#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1076 +
        #1083#1103' '#1096#1090#1088#1080#1093#1086#1074#1082#1080' '#1089#1088#1072#1079#1091' 2 '#1094#1074#1077#1090#1072
      
        '        fig_legend = plt.figure(dpi=PythonModule.Dpi, figsize=(5' +
        ', 1))'
      '        custom_artists = ['
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', label='#39'1' +
        #8804'D<1.5, R'#8805'0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', label='#39'1' +
        #8804'D<1.5, R<0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', label='#39'1' +
        '.5'#8804'D<2, R'#8805'0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', hatch='#39'1' +
        '234'#39', label='#39'1.5'#8804'D<2, R<0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', label='#39'2' +
        #8804'D<3, R'#8805'0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', hatch='#39'1' +
        '234'#39', label='#39'2'#8804'D<3, R<0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', label='#39'D' +
        '>3, R'#8805'0'#39'),'
      
        '            Patch(facecolor='#39'none'#39', edgecolor='#39'tomato'#39', hatch='#39'1' +
        '234#'#39', label='#39'D>3, R<0'#39')]'
      '        saveLegend('#39'legendRED.png'#39')'
      ''
      '    # '#1051#1077#1075#1077#1085#1076#1072' '#1090#1086#1083#1100#1082#1086' '#1074' '#1094#1074#1077#1090#1072#1093
      
        '    elif (PythonModule.IsHatch == False) and (PythonModule.IsCol' +
        'orMap == True):'
      
        '        fig_legend = plt.figure(dpi=PythonModule.Dpi, figsize=(5' +
        ', 1))'
      '        custom_artists = ['
      
        '            Patch(facecolor=colors[4], edgecolor='#39'black'#39', hatch=' +
        'chatches[4], label='#39'1'#8804'D<1.5, R'#8805'0'#39'),'
      
        '            Patch(facecolor=colors[5], edgecolor='#39'black'#39', hatch=' +
        'chatches[5], label='#39'1'#8804'D<1.5, R<0'#39'),'
      
        '            Patch(facecolor=colors[6], edgecolor='#39'black'#39', hatch=' +
        'chatches[6], label='#39'1.5'#8804'D<2, R'#8805'0'#39'),'
      
        '            Patch(facecolor=colors[7], edgecolor='#39'black'#39', hatch=' +
        'chatches[7], label='#39'1.5'#8804'D<2, R<0'#39'),'
      
        '            Patch(facecolor=colors[8], edgecolor='#39'black'#39', hatch=' +
        'chatches[8], label='#39'2'#8804'D<3, R'#8805'0'#39'),'
      
        '            Patch(facecolor=colors[9], edgecolor='#39'black'#39', hatch=' +
        'chatches[9], label='#39'2'#8804'D<3, R<0'#39'),'
      
        '            Patch(facecolor=colors[11], edgecolor='#39'black'#39', hatch' +
        '=chatches[11], label='#39'D>3, R'#8805'0'#39'),'
      
        '            Patch(facecolor=colors[10], edgecolor='#39'black'#39', hatch' +
        '=chatches[10], label='#39'D>3, R<0'#39') ]'
      '        saveLegend('#39'legend.png'#39')'
      ''
      '    fig_legend.clear()'
      '    plt.close(fig_legend)'
      ''
      '# '#1054#1095#1080#1097#1072#1077#1084' '#1082#1086#1085#1090#1091#1088#1072
      'plt.clf()'
      'plt.close('#39'all'#39')'
      'matplotlib.pyplot.figure().clear()'
      'matplotlib.pyplot.close()'
      '# '#1054#1095#1080#1097#1072#1077#1084' '#1087#1072#1084#1103#1090#1100
      'del BufferArray, MeshX, MeshY'
      'gc.collect()'
      ''
      ''
      ''
      '')
    TabOrder = 4
    Visible = False
    WordWrap = False
  end
  object PyLibMemo: TMemo
    Left = 275
    Top = 8
    Width = 254
    Height = 129
    Lines.Strings = (
      'import numpy as np'
      'import matplotlib'
      'from matplotlib import rcParams'
      'from matplotlib.colors import to_rgba'
      'import matplotlib.pyplot as plt'
      'import gc'
      'import PythonModule'
      'from scipy.ndimage import zoom'
      'from PIL import Image, ImageChops'
      'from matplotlib.patches import Polygon, Patch'
      ''
      '# '#1050#1088#1077#1089#1090
      'class hatchCross(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      
        '        [[0, -0.4], [0, 0.4], [0, 0], [-0.4, 0], [0.4, 0], [0, 0' +
        ']],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'c'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      '# '#1044#1074#1086#1081#1085#1086#1081' '#1082#1088#1077#1089#1090
      'class hatchDoubleCross(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      
        '        [[-0.4, 0], [-0.1, 0], [-0.1, 0.4], [-0.1, -0.4], [-0.1,' +
        ' 0], [0.1, 0], [0.1, 0.4], [0.1, -0.4], [0.1, 0],'
      '         [0.4, 0]],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'k'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      '# '#1044#1074#1086#1081#1085#1072#1103' '#1088#1077#1096#1077#1090#1082#1072
      'class hatchCage(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      
        '        [[-0.4, 0.1], [0.4, 0.1], [0.1, 0.1], [0.1, 0.4], [0.1, ' +
        '-0.4], [0.1, -0.1], [0.4, -0.1], [-0.4, -0.1],'
      '         [-0.1, -0.1], [-0.1, -0.4], [-0.1, 0.4], [-0.1, 0.1]],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'#'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      '# '#1058#1086#1095#1082#1080' '#1087#1086' '#1091#1075#1083#1072#1084
      'class hatchDots1(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      
        '        [[-0.4, -0.4], [-0.5, -0.4], [-0.5, -0.5], [-0.4, -0.5]]' +
        ','
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'1'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      'class hatchDots2(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      '        [[0.4, -0.4], [0.5, -0.4], [0.5, -0.5], [0.4, -0.5]],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'2'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      'class hatchDots3(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      '        [[-0.4, 0.4], [-0.5, 0.4], [-0.5, 0.5], [-0.4, 0.5]],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'3'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      'class hatchDots4(matplotlib.hatch.Shapes):'
      '    path = Polygon('
      '        [[0.4, 0.4], [0.5, 0.4], [0.5, 0.5], [0.4, 0.5]],'
      '        closed=True, fill=False).get_path()'
      '    def __init__(self, hatch, density):'
      '        self.filled = False'
      '        self.size = 0.5'
      '        self.num_rows = (hatch.count('#39'4'#39')) * density'
      '        self.shape_vertices = self.path.vertices'
      '        self.shape_codes = self.path.codes'
      '        matplotlib.hatch.Shapes.__init__(self, hatch, density)'
      ''
      '# '#1050#1072#1089#1090#1086#1084#1085#1099#1077' '#1096#1090#1088#1080#1093#1086#1074#1082#1080
      'matplotlib.hatch._hatch_types.append(hatchCross)'
      'matplotlib.hatch._hatch_types.append(hatchDoubleCross)'
      'matplotlib.hatch._hatch_types.append(hatchCage)'
      'matplotlib.hatch._hatch_types.append(hatchDots1)'
      'matplotlib.hatch._hatch_types.append(hatchDots2)'
      'matplotlib.hatch._hatch_types.append(hatchDots3)'
      'matplotlib.hatch._hatch_types.append(hatchDots4)'
      'matplotlib.rcParams['#39'hatch.linewidth'#39'] = 0.1')
    TabOrder = 5
    Visible = False
    WordWrap = False
  end
  object GroupBox6: TGroupBox
    AlignWithMargins = True
    Left = 6
    Top = 92
    Width = 127
    Height = 67
    Hint = #1056#1077#1078#1080#1084' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1080#1079#1086#1083#1080#1085#1080#1081' '#1085#1072' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1080
    Margins.Left = 6
    Margins.Right = 6
    Caption = #1056#1077#1078#1080#1084' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '
    Constraints.MaxWidth = 256
    TabOrder = 6
    object GridPanel2: TGridPanel
      Left = 2
      Top = 15
      Width = 123
      Height = 50
      Align = alClient
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = ModeReviseRB
          Row = 1
        end
        item
          Column = 0
          Control = ModeСorrelRB
          Row = 0
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 24.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 24.000000000000000000
        end>
      TabOrder = 0
      object ModeReviseRB: TRadioButton
        AlignWithMargins = True
        Left = 6
        Top = 27
        Width = 114
        Height = 18
        Hint = 'R, '#1085#1072#1083#1086#1078#1077#1085#1085#1072#1103' '#1085#1072' D'
        Margins.Left = 6
        Align = alClient
        Caption = #1057#1074#1077#1088#1082#1072
        TabOrder = 0
        OnClick = ModeReviseRBClick
      end
      object ModeСorrelRB: TRadioButton
        AlignWithMargins = True
        Left = 6
        Top = 3
        Width = 114
        Height = 18
        Hint = #1056#1077#1085#1078#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1079#1086#1085#1099' '#1087#1077#1088#1077#1089#1077#1095#1077#1085#1080#1103' D '#1080' R'
        Margins.Left = 6
        Align = alClient
        Caption = #1050#1086#1088#1088#1077#1083#1103#1094#1080#1103
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = ModeСorrelRBClick
      end
    end
  end
  object GroupBox5: TGroupBox
    Left = 6
    Top = 165
    Width = 127
    Height = 17
    TabOrder = 7
  end
  object ExtraSettingsPanel: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 184
    Width = 258
    Height = 483
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 8
    object CanvasSettingsBox: TGroupBox
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 258
      Height = 68
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alTop
      Caption = #1061#1086#1083#1089#1090
      TabOrder = 0
      object GridPanel7: TGridPanel
        Left = 2
        Top = 15
        Width = 254
        Height = 51
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 41.233218581104130000
          end
          item
            Value = 58.766781418895860000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = GridCheck
            Row = 0
          end
          item
            Column = 0
            Control = CheckGridCB
            Row = 1
          end
          item
            Column = 1
            Control = CoordsCB
            Row = 0
          end
          item
            Column = 1
            Control = DotsCheckCB
            Row = 1
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end>
        TabOrder = 0
        object GridCheck: TCheckBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Width = 96
          Height = 17
          Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1089#1077#1090#1082#1080' '#1085#1072' '#1093#1086#1083#1089#1090#1077
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1057#1077#1090#1082#1072
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckGridCB: TCheckBox
          AlignWithMargins = True
          Left = 6
          Top = 27
          Width = 96
          Height = 17
          Hint = #1046#1080#1088#1085#1099#1077' '#1088#1072#1084#1082#1080' '#1087#1086' '#1087#1077#1088#1074#1099#1084' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1072#1084' '#1086#1089#1077#1081
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1057#1077#1090#1082#1072' '#1089#1074#1077#1088#1082#1080
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object CoordsCB: TCheckBox
          AlignWithMargins = True
          Left = 111
          Top = 3
          Width = 140
          Height = 17
          Hint = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103', '#1089#1080#1075#1084#1099', '#1089#1088#1077#1076#1085#1080#1077', '#1074#1099#1073#1086#1088#1082#1072' '#1087#1086#1076' '#1089#1077#1090#1082#1086#1081
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 2
        end
        object DotsCheckCB: TCheckBox
          AlignWithMargins = True
          Left = 111
          Top = 27
          Width = 140
          Height = 17
          Hint = #1042' '#1094#1077#1085#1090#1088' '#1103#1095#1077#1081#1082#1080' '#1087#1086#1084#1077#1089#1090#1080#1090#1100' '#1090#1086#1095#1082#1091' '#1080' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' D '#1080' R'
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1058#1086#1095#1082#1080' '#1074#1099#1089#1086#1090
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
    object SignBox: TGroupBox
      AlignWithMargins = True
      Left = 0
      Top = 71
      Width = 258
      Height = 43
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alTop
      Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077
      TabOrder = 1
      object GridPanel1: TGridPanel
        Left = 2
        Top = 15
        Width = 254
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 41.233218581104130000
          end
          item
            Value = 58.766781418895860000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = IsHatchCB
            Row = 0
          end
          item
            Column = 1
            Control = IsColorMapCB
            Row = 0
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end>
        TabOrder = 0
        object IsHatchCB: TCheckBox
          AlignWithMargins = True
          Left = 6
          Top = 3
          Width = 96
          Height = 17
          Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1089#1077#1090#1082#1080' '#1085#1072' '#1093#1086#1083#1089#1090#1077
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1064#1090#1088#1080#1093#1086#1074#1082#1072
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = IsHatchCBClick
        end
        object IsColorMapCB: TCheckBox
          AlignWithMargins = True
          Left = 111
          Top = 3
          Width = 140
          Height = 17
          Hint = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103', '#1089#1080#1075#1084#1099', '#1089#1088#1077#1076#1085#1080#1077', '#1074#1099#1073#1086#1088#1082#1072' '#1087#1086#1076' '#1089#1077#1090#1082#1086#1081
          Margins.Left = 6
          Margins.Bottom = 4
          Align = alTop
          Caption = #1062#1074#1077#1090
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 1
          OnClick = IsColorMapCBClick
        end
      end
    end
    object InfoSettingsBox: TGroupBox
      AlignWithMargins = True
      Left = 0
      Top = 117
      Width = 258
      Height = 219
      Hint = #1055#1086#1076#1087#1080#1089#1100' '#1073#1091#1076#1077#1090' '#1074#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1076' '#1082#1072#1088#1090#1086#1081
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alTop
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Constraints.MaxHeight = 222
      Constraints.MinHeight = 72
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object SignatureEdit: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 65
        Width = 248
        Height = 21
        Hint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1072#1088#1090#1099
        Margins.Top = 1
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TextHint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1072#1088#1090#1099
      end
      object ScaleEdit: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 115
        Width = 248
        Height = 21
        Hint = #1052#1072#1089#1096#1090#1072#1073' '#1082#1072#1088#1090#1099
        Margins.Top = 1
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = #1052#1072#1089#1096#1090#1072#1073' 1:50000'
        TextHint = #1053#1080#1078#1085#1103#1103' '#1087#1086#1076#1087#1080#1089#1100
      end
      object TypeEdit: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 90
        Width = 248
        Height = 21
        Hint = #1058#1080#1087' '#1082#1072#1088#1090#1099
        Margins.Top = 1
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = #1057#1093#1077#1084#1072' '#1088#1072#1079#1074#1080#1090#1080#1103' '#1075#1080#1076#1088#1086#1090#1077#1088#1084#1072#1083#1100#1085#1099#1093' '#1089#1080#1089#1090#1077#1084
        TextHint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1093#1077#1084#1099
      end
      object ApplicationEdit: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 40
        Width = 248
        Height = 21
        Hint = #1055#1086#1076#1087#1080#1089#1100' '#1074' '#1074#1077#1088#1093#1085#1077#1084' '#1091#1075#1083#1091
        Margins.Top = 1
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' ___'
        TextHint = #1042#1077#1088#1093#1085#1103#1103' '#1087#1086#1076#1087#1080#1089#1100
      end
      object PrintLegendCB: TCheckBox
        AlignWithMargins = True
        Left = 8
        Top = 171
        Width = 245
        Height = 17
        Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1089#1077#1090#1082#1080' '#1085#1072' '#1093#1086#1083#1089#1090#1077
        Margins.Left = 6
        Margins.Bottom = 4
        Align = alTop
        Caption = #1059#1089#1083#1086#1074#1085#1099#1077' '#1086#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object PrintInfoCB: TCheckBox
        AlignWithMargins = True
        Left = 8
        Top = 195
        Width = 245
        Height = 17
        Hint = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103', '#1089#1080#1075#1084#1099', '#1089#1088#1077#1076#1085#1080#1077', '#1074#1099#1073#1086#1088#1082#1072' '#1087#1086#1076' '#1089#1077#1090#1082#1086#1081
        Margins.Left = 6
        Margins.Bottom = 4
        Align = alTop
        Caption = #1058#1072#1073#1083#1080#1094#1072' '#1080' '#1074#1099#1073#1086#1088#1082#1080
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 5
      end
      object PrintTitleCB: TCheckBox
        AlignWithMargins = True
        Left = 8
        Top = 18
        Width = 245
        Height = 17
        Hint = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103', '#1089#1080#1075#1084#1099', '#1089#1088#1077#1076#1085#1080#1077', '#1074#1099#1073#1086#1088#1082#1072' '#1087#1086#1076' '#1089#1077#1090#1082#1086#1081
        Margins.Left = 6
        Margins.Bottom = 4
        Align = alTop
        Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082':'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 6
        OnClick = PrintTitleCBClick
      end
      object GridPanel4: TGridPanel
        Left = 2
        Top = 139
        Width = 254
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 82.110631086437370000
          end
          item
            Value = 17.889368913562630000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = UseFileNameButton
            Row = 0
          end
          item
            Column = 1
            Control = ClearSignatureButton
            Row = 0
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end>
        TabOrder = 7
        object UseFileNameButton: TButton
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 203
          Height = 24
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072
          TabOrder = 0
          OnClick = UseFileNameButtonClick
        end
        object ClearSignatureButton: TButton
          AlignWithMargins = True
          Left = 209
          Top = 0
          Width = 42
          Height = 24
          Hint = #1054#1095#1080#1089#1090#1080#1090#1100
          Margins.Left = 0
          Margins.Top = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = '<'
          TabOrder = 1
          OnClick = ClearSignatureButtonClick
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 339
      Width = 258
      Height = 143
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = #1050#1086#1085#1090#1091#1088#1099
      TabOrder = 3
      object GridPanel3: TGridPanel
        AlignWithMargins = True
        Left = 4
        Top = 15
        Width = 252
        Height = 126
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 59.409628774829890000
          end
          item
            Value = 40.590371225170120000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label1
            Row = 0
          end
          item
            Column = 0
            Control = LineWidthsLabel
            Row = 2
          end
          item
            Column = 1
            Control = LineWidthsCB
            Row = 2
          end
          item
            Column = 0
            Control = FontSizeLabel
            Row = 3
          end
          item
            Column = 1
            Control = FontSizeCB
            Row = 3
          end
          item
            Column = 1
            Control = InterpLvlEdit
            Row = 0
          end
          item
            Column = 0
            Control = Label3
            Row = 1
          end
          item
            Column = 0
            Control = Label4
            Row = 4
          end
          item
            Column = 1
            Control = InterpOrderCB
            Row = 1
          end
          item
            Column = 1
            Control = DPIEdit
            Row = 4
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
            Value = 24.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 24.000000000000000000
          end>
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 6
          Width = 144
          Height = 13
          Hint = #1044#1080#1089#1082#1088#1077#1090#1085#1086#1089#1090#1100' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080' ('#1053#1040' '#1088#1072#1079')'
          Margins.Top = 6
          Margins.Bottom = 0
          Align = alTop
          Caption = #1059#1088#1086#1074#1077#1085#1100' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 127
        end
        object LineWidthsLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 54
          Width = 144
          Height = 13
          Hint = #1058#1086#1083#1097#1080#1085#1072' '#1074#1089#1077#1093' '#1080#1079#1086#1083#1080#1085#1080#1081
          Margins.Top = 6
          Margins.Bottom = 0
          Align = alTop
          Caption = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1081
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 85
        end
        object LineWidthsCB: TComboBox
          AlignWithMargins = True
          Left = 153
          Top = 51
          Width = 96
          Height = 21
          Hint = #1058#1086#1083#1097#1080#1085#1072' '#1074#1089#1077#1093' '#1080#1079#1086#1083#1080#1085#1080#1081
          Align = alClient
          AutoCloseUp = True
          BevelKind = bkFlat
          Style = csDropDownList
          DoubleBuffered = True
          ItemIndex = 2
          ParentDoubleBuffered = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = '0,8'
          OnChange = LineWidthsCBChange
          Items.Strings = (
            '0,4'
            '0,6'
            '0,8'
            '1'
            '1,2')
        end
        object FontSizeLabel: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 78
          Width = 144
          Height = 13
          Hint = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072' '#1074#1089#1077#1093' '#1084#1077#1090#1086#1082' '#1080#1079#1086#1083#1080#1085#1080#1081
          Margins.Top = 6
          Align = alTop
          Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072' '#1084#1077#1090#1082#1080
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 119
        end
        object FontSizeCB: TComboBox
          AlignWithMargins = True
          Left = 153
          Top = 75
          Width = 96
          Height = 21
          Hint = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072' '#1074#1089#1077#1093' '#1084#1077#1090#1086#1082' '#1080#1079#1086#1083#1080#1085#1080#1081
          Align = alClient
          AutoCloseUp = True
          BevelKind = bkFlat
          Style = csDropDownList
          DoubleBuffered = True
          Enabled = False
          ItemIndex = 3
          ParentDoubleBuffered = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = '10'
          OnChange = FontSizeCBChange
          Items.Strings = (
            '4'
            '6'
            '8'
            '10'
            '12'
            '14')
        end
        object InterpLvlEdit: TEdit
          AlignWithMargins = True
          Left = 153
          Top = 3
          Width = 96
          Height = 21
          Margins.Bottom = 0
          Align = alClient
          NumbersOnly = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = '45'
          OnChange = InterpLvlEditChange
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 30
          Width = 144
          Height = 13
          Hint = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
          Margins.Top = 6
          Margins.Bottom = 0
          Align = alTop
          Caption = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 129
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 102
          Width = 144
          Height = 13
          Hint = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
          Margins.Top = 6
          Margins.Bottom = 0
          Align = alTop
          Caption = #1050#1072#1095#1077#1089#1090#1074#1086' (DPI)'
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 74
        end
        object InterpOrderCB: TComboBox
          AlignWithMargins = True
          Left = 153
          Top = 27
          Width = 96
          Height = 21
          Hint = #1055#1086#1088#1103#1076#1086#1082' '#1080#1085#1090#1077#1088#1087#1086#1083#1103#1094#1080#1080
          Align = alClient
          AutoCloseUp = True
          BevelKind = bkFlat
          Style = csDropDownList
          DoubleBuffered = True
          ItemIndex = 3
          ParentDoubleBuffered = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Text = '3'
          OnChange = InterpOrderCBChange
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5')
        end
        object DPIEdit: TEdit
          AlignWithMargins = True
          Left = 153
          Top = 99
          Width = 96
          Height = 21
          Margins.Bottom = 0
          Align = alClient
          NumbersOnly = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = '210'
          OnChange = DPIEditChange
        end
      end
    end
  end
  object ShowExtraSettingsBtn: TButton
    Left = 6
    Top = 163
    Width = 128
    Height = 19
    Caption = #1044#1086#1087'. '#1085#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 9
    OnClick = ShowExtraSettingsBtnClick
  end
  object PythonModule: TPythonModule
    Engine = PythonEngine
    ModuleName = 'PythonModule'
    Errors = <>
    Left = 222
    Top = 477
  end
  object PythonEngine: TPythonEngine
    AutoLoad = False
    DllName = 'python39.dll'
    DllPath = 
      'IncludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName)' +
      ')+'#39'python\'#39
    APIVersion = 1013
    RegVersion = '3.9'
    UseLastKnownVersion = False
    OnBeforeLoad = PythonEngineBeforeLoad
    AutoFinalize = False
    Left = 158
    Top = 477
  end
end
