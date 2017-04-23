object PromissoriaVendaLoteReportView: TPromissoriaVendaLoteReportView
  Left = 0
  Top = 0
  Caption = 'Nota Promiss'#243'ria'
  ClientHeight = 462
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object report: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dataSource
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = reportBeforePrint
    object reportDetailBand: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 400
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object numeroVendaInfoPanel: TRLPanel
        Left = 208
        Top = 8
        Width = 191
        Height = 81
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object codigoVendaLabel: TRLLabel
          Left = 8
          Top = 13
          Width = 28
          Height = 24
          Caption = 'N'#186
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object codigoVendaText: TRLDBText
          Left = 42
          Top = 13
          Width = 23
          Height = 24
          DataField = 'Id'
          DataSource = dataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object dataVendaLabel: TRLLabel
          Left = 8
          Top = 43
          Width = 52
          Height = 24
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dataVendaText: TRLDBText
          Left = 66
          Top = 43
          Width = 51
          Height = 24
          DataField = 'Data'
          DataSource = dataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object tituloInfoPanel: TRLPanel
        Left = 8
        Top = 8
        Width = 194
        Height = 81
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object tituloLabel: TRLLabel
          Left = 7
          Top = 28
          Width = 179
          Height = 24
          Align = faCenter
          Caption = 'Nota Promiss'#243'ria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object valorVendaInfoPanel: TRLPanel
        Left = 405
        Top = 8
        Width = 304
        Height = 81
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object valorLabel: TRLLabel
          Left = 8
          Top = 28
          Width = 104
          Height = 24
          Caption = 'Valor (R$)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object valorResult: TRLDBResult
          Left = 116
          Top = 28
          Width = 180
          Height = 24
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'LanceArremate'
          DataSource = dataSource
          DisplayMask = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          OnCompute = ResultCompute
        end
      end
      object compradorInfoPanel: TRLPanel
        Left = 8
        Top = 95
        Width = 701
        Height = 66
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object compradorCpfCnpjLabel: TRLLabel
          Left = 8
          Top = 26
          Width = 68
          Height = 16
          Caption = 'CPF/CPNJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object compradorCpfCnpjText: TRLDBText
          Left = 82
          Top = 26
          Width = 112
          Height = 16
          DataField = 'CompradorCpfCnpj'
          DataSource = dataSource
          Text = ''
        end
        object compradorTelefoneLabel: TRLLabel
          Left = 8
          Top = 46
          Width = 60
          Height = 16
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object compradorTelefoneText: TRLDBText
          Left = 74
          Top = 46
          Width = 115
          Height = 16
          DataField = 'CompradorTelefone'
          DataSource = dataSource
          Text = ''
        end
        object compradorPanel: TRLPanel
          Left = 8
          Top = 4
          Width = 688
          Height = 16
          object compradorLabel: TRLLabel
            Left = 0
            Top = 0
            Width = 83
            Height = 16
            Align = faLeftTop
            Caption = 'Comprador  '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object compradorIdText: TRLDBText
            Left = 83
            Top = 0
            Width = 77
            Height = 16
            Align = faLeftTop
            DataField = 'CompradorId'
            DataSource = dataSource
            Text = ''
          end
          object compradorNomeText: TRLDBText
            Left = 160
            Top = 0
            Width = 113
            Height = 16
            Align = faLeftTop
            DataField = 'CompradorNome'
            DataSource = dataSource
            Text = ' - '
          end
        end
      end
      object loteInfoPanel: TRLPanel
        Left = 8
        Top = 167
        Width = 701
        Height = 84
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object loteNumeroLabel: TRLLabel
          Left = 8
          Top = 4
          Width = 50
          Height = 16
          Caption = 'N'#186' Lote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LoteDescricaoLabel: TRLLabel
          Left = 8
          Top = 24
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
        object LoteDescricaoText: TRLDBText
          Left = 80
          Top = 24
          Width = 87
          Height = 16
          DataField = 'LoteDescricao'
          DataSource = dataSource
          Text = ''
        end
        object loteNumeroText: TRLDBText
          Left = 64
          Top = 4
          Width = 74
          Height = 16
          DataField = 'LoteNumero'
          DataSource = dataSource
          Text = ''
        end
        object loteAnimalPanel: TRLPanel
          Left = 8
          Top = 39
          Width = 333
          Height = 43
          BeforePrint = LoteAnimalPanelBeforePrint
          object loteAnimalIdadeLabel: TRLLabel
            Left = 0
            Top = 4
            Width = 40
            Height = 16
            Caption = 'Idade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteAnimalSexoLabel: TRLLabel
            Left = 0
            Top = 26
            Width = 37
            Height = 16
            Caption = 'Sexo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object loteAnimalIdadeText: TRLDBText
            Left = 46
            Top = 4
            Width = 60
            Height = 16
            DataField = 'LoteIdade'
            DataSource = dataSource
            Text = ''
          end
          object loteAnimalSexoText: TRLDBText
            Left = 43
            Top = 26
            Width = 59
            Height = 16
            DataField = 'LoteSexo'
            DataSource = dataSource
            Text = ''
          end
        end
      end
      object emitenteInfoPanel: TRLPanel
        Left = 8
        Top = 257
        Width = 701
        Height = 66
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object emitenteNomeLabel: TRLLabel
          Left = 8
          Top = 4
          Width = 60
          Height = 16
          Caption = 'Emitente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object emitenteCpfCnpjLabel: TRLLabel
          Left = 8
          Top = 24
          Width = 68
          Height = 16
          Caption = 'CPF/CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object emitenteCpfCnpjText: TRLDBText
          Left = 82
          Top = 24
          Width = 49
          Height = 16
          DataField = 'CpfCnpj'
          DataSource = proprioDataSource
          Text = ''
        end
        object emitenteNomeText: TRLDBText
          Left = 74
          Top = 4
          Width = 38
          Height = 16
          DataField = 'Nome'
          DataSource = proprioDataSource
          Text = ''
        end
        object emitenteTelefoneLabel: TRLLabel
          Left = 8
          Top = 46
          Width = 60
          Height = 16
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object emitenteTelefoneText: TRLDBText
          Left = 74
          Top = 46
          Width = 52
          Height = 16
          DataField = 'Telefone'
          DataSource = proprioDataSource
          Text = ''
        end
      end
      object emitenteAssinaturaPanel: TRLPanel
        Left = 8
        Top = 356
        Width = 315
        Height = 32
        object emitenteAssinaturaNomeLabel: TRLLabel
          Left = 0
          Top = 16
          Width = 314
          Height = 16
          Align = faCenterBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Assinatura do Emitente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object emitenteAssinaturaLabel: TRLLabel
          Left = 1
          Top = 0
          Width = 312
          Height = 16
          Align = faCenterTop
          Caption = '____________________________________________'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object compradorAssinaturaPanel: TRLPanel
        Left = 394
        Top = 356
        Width = 315
        Height = 32
        object compradorAssinaturaNomeLabel: TRLLabel
          Left = 0
          Top = 16
          Width = 314
          Height = 16
          Align = faCenterBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Assinatura do Comprador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object compradorAssinaturaLabel: TRLLabel
          Left = 1
          Top = 0
          Width = 312
          Height = 16
          Align = faCenterTop
          Caption = '____________________________________________'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object dataSource: TDataSource
    Left = 276
    Top = 409
  end
  object bindings: TBindingGroup
    Left = 489
    Top = 409
    Bindings = <>
  end
  object proprioDataSource: TDataSource
    Left = 383
    Top = 409
  end
end
