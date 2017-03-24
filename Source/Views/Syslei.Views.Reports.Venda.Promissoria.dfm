object PromissoriaVendaReportView: TPromissoriaVendaReportView
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
  PixelsPerInch = 96
  TextHeight = 13
  object report: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
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
      object numeroVendaPanel: TRLPanel
        Left = 8
        Top = 8
        Width = 250
        Height = 81
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object codigoVendaLabel: TRLLabel
          Left = 8
          Top = 28
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
          Top = 28
          Width = 23
          Height = 24
          DataField = 'Id'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object tituloPanel: TRLPanel
        Left = 264
        Top = 8
        Width = 189
        Height = 81
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object tituloLabel: TRLLabel
          Left = 5
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
      object valorVendaPanel: TRLPanel
        Left = 459
        Top = 8
        Width = 250
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
        object valorText: TRLDBText
          Left = 118
          Top = 28
          Width = 126
          Height = 24
          DataField = 'LanceArremate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object compradorPanel: TRLPanel
        Left = 8
        Top = 95
        Width = 701
        Height = 66
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        object compradorNomeLabel: TRLLabel
          Left = 8
          Top = 4
          Width = 75
          Height = 16
          Caption = 'Comprador'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object compradorCpfLabel: TRLLabel
          Left = 8
          Top = 26
          Width = 30
          Height = 16
          Caption = 'CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object compradorNomeText: TRLDBText
          Left = 89
          Top = 4
          Width = 124
          Height = 16
          Text = ''
        end
        object compradorCpfText: TRLDBText
          Left = 44
          Top = 26
          Width = 109
          Height = 16
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
          Width = 138
          Height = 16
          Text = ''
        end
      end
      object lotePanel: TRLPanel
        Left = 8
        Top = 167
        Width = 701
        Height = 82
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
          Width = 112
          Height = 16
          Text = ''
        end
        object loteNumeroText: TRLDBText
          Left = 64
          Top = 4
          Width = 95
          Height = 16
          Text = ''
        end
        object loteAnimalPanel: TRLPanel
          Left = 8
          Top = 39
          Width = 333
          Height = 39
          object loteAnimalIdadeLabel: TRLLabel
            Left = 0
            Top = 0
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
            Top = 22
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
            Top = 0
            Width = 121
            Height = 16
            Text = ''
          end
          object loteAnimalSexoText: TRLDBText
            Left = 43
            Top = 22
            Width = 120
            Height = 16
            Text = ''
          end
        end
      end
      object emitentePanel: TRLPanel
        Left = 8
        Top = 255
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
        object emitenteCpfLabel: TRLLabel
          Left = 8
          Top = 24
          Width = 30
          Height = 16
          Caption = 'CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object emitenteCpfText: TRLDBText
          Left = 44
          Top = 24
          Width = 98
          Height = 16
          Text = ''
        end
        object emitenteNomeText: TRLDBText
          Left = 89
          Top = 4
          Width = 113
          Height = 16
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
          Width = 127
          Height = 16
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
          Caption = 'Assinatura do Emitente'
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
end
