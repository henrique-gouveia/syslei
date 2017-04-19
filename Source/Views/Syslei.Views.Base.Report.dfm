object ReportBaseView: TReportBaseView
  Left = 0
  Top = 0
  Caption = 'Report Base'
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
    Left = -1
    Top = -1
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = reportBeforePrint
    object reportHeaderBand: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 75
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object reportHeaderTitleLabel: TRLLabel
        Left = 333
        Top = 26
        Width = 51
        Height = 22
        Align = faCenter
        Caption = 'Titulo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object reportHeaderPageSystemInfo: TRLSystemInfo
        Left = 631
        Top = 0
        Width = 87
        Height = 16
        Align = faRightTop
        Info = itPageNumber
        Text = ''
      end
      object reportHeaderPageLabel: TRLLabel
        Left = 575
        Top = 0
        Width = 56
        Height = 16
        Align = faRightTop
        Caption = 'P'#225'gina.: '
      end
    end
  end
end
