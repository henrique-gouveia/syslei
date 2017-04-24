inherited VendaLoteReportView: TVendaLoteReportView
  Caption = 'Vendas de Lotes'
  OnDestroy = FormDestroy
  ExplicitWidth = 810
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited report: TRLReport
    DataSource = dataSource
    inherited reportHeaderBand: TRLBand
      Borders.DrawBottom = False
      inherited reportHeaderTitleLabel: TRLLabel
        Left = 284
        Width = 150
        Caption = 'Vendas de Lotes'
        ExplicitLeft = 284
        ExplicitWidth = 150
      end
    end
    object compradorGroup: TRLGroup
      Left = 38
      Top = 113
      Width = 718
      Height = 109
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      DataFields = 'CompradorId'
      object compradorColumnHeaderBand: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 17
        BandType = btColumnHeader
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        object compradorIdLabel: TRLLabel
          AlignWithMargins = True
          Left = 0
          Top = 1
          Width = 76
          Height = 15
          Align = faLeftTop
          Caption = 'Comprador   '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object compradorIdText: TRLDBText
          AlignWithMargins = True
          Left = 76
          Top = 1
          Width = 74
          Height = 15
          Align = faLeftTop
          Alignment = taCenter
          DataField = 'compradorId'
          DataSource = dataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          Transparent = False
        end
        object compradorNomeText: TRLDBText
          AlignWithMargins = True
          Left = 150
          Top = 1
          Width = 107
          Height = 15
          Align = faLeftTop
          DataField = 'CompradorNome'
          DataSource = dataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = '- '
          Transparent = False
        end
      end
      object vendaLoteGroup: TRLGroup
        Left = 0
        Top = 17
        Width = 718
        Height = 59
        DataFields = 'CompradorId'
        object vendaLotesDetailBand: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 58
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          object vendaIdLabel: TRLLabel
            Left = 5
            Top = 5
            Width = 18
            Height = 16
            Caption = 'N'#186
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object vendaIdText: TRLDBText
            Left = 29
            Top = 6
            Width = 14
            Height = 16
            DataField = 'Id'
            DataSource = dataSource
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object vendaDataLabel: TRLLabel
            Left = 77
            Top = 6
            Width = 33
            Height = 16
            Caption = 'Data'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object vendaDataText: TRLDBText
            Left = 116
            Top = 6
            Width = 31
            Height = 16
            DataField = 'Data'
            DataSource = dataSource
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Text = ''
          end
          object loteIdLabel: TRLLabel
            Left = 5
            Top = 23
            Width = 49
            Height = 16
            Caption = 'C'#243'digo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteNumeroLabel: TRLLabel
            Left = 60
            Top = 23
            Width = 54
            Height = 16
            Caption = 'N'#250'mero'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteDescricaoLabel: TRLLabel
            Left = 140
            Top = 23
            Width = 66
            Height = 16
            Caption = 'Descri'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteTipoLabel: TRLLabel
            Left = 440
            Top = 23
            Width = 32
            Height = 16
            Caption = 'Tipo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteIdadeLabel: TRLLabel
            Left = 524
            Top = 23
            Width = 40
            Height = 16
            Caption = 'Idade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            BeforePrint = ControlTextBeforePrint
          end
          object loteSexoLabel: TRLLabel
            Left = 566
            Top = 23
            Width = 37
            Height = 16
            Caption = 'Sexo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            BeforePrint = ControlTextBeforePrint
          end
          object vendaLanceArremateLabel: TRLLabel
            Left = 609
            Top = 23
            Width = 106
            Height = 16
            Caption = 'Lance Arremate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteIdText: TRLDBText
            Left = 5
            Top = 40
            Width = 49
            Height = 16
            AutoSize = False
            DataField = 'LoteId'
            DataSource = dataSource
            Text = ''
          end
          object loteNumeroText: TRLDBText
            Left = 60
            Top = 40
            Width = 74
            Height = 16
            AutoSize = False
            DataField = 'LoteNumero'
            DataSource = dataSource
            Text = ''
          end
          object loteDescricaoRichText: TRLDBRichText
            Left = 140
            Top = 40
            Width = 294
            Height = 16
            AutoSize = False
            Behavior = [beSiteExpander]
            DataField = 'LoteDescricao'
            DataSource = dataSource
          end
          object loteTipoText: TRLDBText
            Left = 440
            Top = 40
            Width = 78
            Height = 16
            AutoSize = False
            DataField = 'LoteTipo'
            DataSource = dataSource
            Text = ''
          end
          object loteIdadeText: TRLDBText
            Left = 524
            Top = 40
            Width = 40
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            DataField = 'LoteIdade'
            DataSource = dataSource
            Text = ''
            BeforePrint = ControlTextBeforePrint
          end
          object loteSexoText: TRLDBText
            Left = 566
            Top = 40
            Width = 37
            Height = 16
            Alignment = taCenter
            AutoSize = False
            DataField = 'LoteSexo'
            DataSource = dataSource
            Text = ''
            BeforePrint = ControlTextBeforePrint
          end
          object lanceArremateText: TRLDBText
            Left = 609
            Top = 37
            Width = 106
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            DataField = 'LanceArremate'
            DataSource = dataSource
            Text = ''
          end
        end
      end
      object summaryBand: TRLBand
        Left = 0
        Top = 76
        Width = 718
        Height = 32
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Computable = False
        object totalLabel: TRLLabel
          Left = 512
          Top = 1
          Width = 75
          Height = 16
          Align = faTopOnly
          Caption = 'Total Geral'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object totalResult: TRLDBResult
          Left = 593
          Top = 1
          Width = 122
          Height = 16
          Align = faTopOnly
          Alignment = taRightJustify
          AutoSize = False
          ComputeNulls = False
          DataField = 'LanceArremate'
          DataSource = dataSource
          DisplayMask = ',0.00'
          Info = riSum
          Text = ''
        end
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
