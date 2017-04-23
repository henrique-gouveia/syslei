inherited LoteReportView: TLoteReportView
  Caption = 'Listagem de Lotes'
  OnDestroy = FormDestroy
  ExplicitWidth = 810
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited report: TRLReport
    DataSource = dataSource
    inherited reportHeaderBand: TRLBand
      inherited reportHeaderTitleLabel: TRLLabel
        Left = 332
        Width = 53
        Caption = 'Lotes'
        ExplicitLeft = 332
        ExplicitWidth = 53
      end
    end
    object reportDetailBand: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 16
      object idText: TRLDBText
        Left = 0
        Top = 0
        Width = 49
        Height = 16
        Align = faTopOnly
        AutoSize = False
        DataField = 'Id'
        DataSource = dataSource
        Text = ''
      end
      object numeroText: TRLDBText
        Left = 55
        Top = 0
        Width = 74
        Height = 16
        Align = faTopOnly
        AutoSize = False
        DataField = 'Numero'
        DataSource = dataSource
        Text = ''
      end
      object descricaoRichText: TRLDBRichText
        Left = 135
        Top = 0
        Width = 300
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Behavior = [beSiteExpander]
        DataField = 'Descricao'
        DataSource = dataSource
      end
      object tipoText: TRLDBText
        Left = 441
        Top = 0
        Width = 80
        Height = 16
        Align = faTopOnly
        AutoSize = False
        DataField = 'Tipo'
        DataSource = dataSource
        Text = ''
      end
      object idadeText: TRLDBText
        Left = 527
        Top = 0
        Width = 40
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'Idade'
        DataSource = dataSource
        Text = ''
        BeforePrint = ControlTextBeforePrint
      end
      object sexoText: TRLDBText
        Left = 575
        Top = 0
        Width = 35
        Height = 16
        Align = faTopOnly
        Alignment = taCenter
        AutoSize = False
        DataField = 'Sexo'
        DataSource = dataSource
        Text = ''
        BeforePrint = ControlTextBeforePrint
      end
      object lanceInicialSimpleResult: TRLDBResult
        Left = 616
        Top = 0
        Width = 102
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'LanceInicial'
        DataSource = dataSource
        DisplayMask = ',0.00'
        Text = ''
        OnCompute = ResultCompute
      end
    end
    object reportColumnHeaderBand: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 16
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object idLabel: TRLLabel
        Left = 0
        Top = -1
        Width = 49
        Height = 16
        Align = faBottomOnly
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object descricaoLabel: TRLLabel
        Left = 135
        Top = -1
        Width = 66
        Height = 16
        Align = faBottomOnly
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object numeroLabel: TRLLabel
        Left = 55
        Top = -1
        Width = 54
        Height = 16
        Align = faBottomOnly
        Caption = 'N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object tipoLabel: TRLLabel
        Left = 441
        Top = -1
        Width = 32
        Height = 16
        Align = faBottomOnly
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object idadeLabel: TRLLabel
        Left = 527
        Top = -1
        Width = 40
        Height = 16
        Align = faBottomOnly
        Caption = 'Idade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object sexoLabel: TRLLabel
        Left = 573
        Top = -1
        Width = 37
        Height = 16
        Align = faBottomOnly
        Caption = 'Sexo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lanceInicialLabel: TRLLabel
        Left = 632
        Top = -1
        Width = 86
        Height = 16
        Align = faBottomOnly
        Caption = 'Lance Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object reportSummaryrBand: TRLBand
      Left = 38
      Top = 145
      Width = 718
      Height = 16
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object totalSumLabel: TRLLabel
        Left = 551
        Top = 0
        Width = 36
        Height = 16
        Align = faBottomOnly
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object totalSumResult: TRLDBResult
        Left = 593
        Top = 1
        Width = 125
        Height = 16
        Align = faTopOnly
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'LanceInicial'
        DataSource = dataSource
        DisplayMask = ',0.00'
        Info = riSum
        Text = ''
        OnCompute = ResultCompute
      end
      object registrosCountLabel: TRLLabel
        Left = 0
        Top = 0
        Width = 62
        Height = 16
        Align = faBottomOnly
        Caption = 'Registros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object registrosCountResult: TRLDBResult
        Left = 68
        Top = 1
        Width = 46
        Height = 16
        Align = faTopOnly
        Info = riCount
        Text = ''
      end
    end
  end
  object dataSource: TDataSource
    Left = 357
    Top = 409
  end
  object bindings: TBindingGroup
    Left = 410
    Top = 409
    Bindings = <>
  end
end
