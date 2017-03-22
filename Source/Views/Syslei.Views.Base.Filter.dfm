inherited FilterBaseView: TFilterBaseView
  Caption = 'Filter Base'
  ClientHeight = 262
  ClientWidth = 484
  ExplicitWidth = 500
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 16
  inherited topPanel: TPanel
    Width = 484
    ExplicitWidth = 484
    object novoButton: TSpeedButton
      Left = 244
      Top = 0
      Width = 80
      Height = 55
      Action = Novo
      Align = alRight
      Layout = blGlyphTop
      ExplicitLeft = 122
      ExplicitTop = -6
      ExplicitHeight = 50
    end
    object okButton: TSpeedButton
      Left = 324
      Top = 0
      Width = 80
      Height = 55
      Action = Ok
      Align = alRight
      Layout = blGlyphTop
      ExplicitLeft = 611
      ExplicitHeight = 50
    end
    object sairButton: TSpeedButton
      Left = 404
      Top = 0
      Width = 80
      Height = 55
      Action = Sair
      Align = alRight
      Layout = blGlyphTop
      ExplicitLeft = 578
      ExplicitHeight = 50
    end
  end
  inherited contentPanel: TPanel
    Width = 484
    Height = 207
    ExplicitWidth = 484
    ExplicitHeight = 207
  end
  inherited actions: TActionList
    object Novo: TAction
      Category = 'Main'
      Caption = 'Novo-F5'
      ImageIndex = 0
      ShortCut = 116
    end
    object Ok: TAction
      Category = 'Main'
      Caption = 'Ok-F9'
      ImageIndex = 1
      ShortCut = 116
    end
    object Sair: TAction
      Category = 'Main'
      Caption = 'Sair-ESC'
      ImageIndex = 2
      ShortCut = 27
      OnExecute = SairExecute
    end
  end
  inherited images: TImageList
    Bitmap = {
      494C010103000800180018001800FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000001800000001002000000000000024
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF000000000000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF5B3531FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005B3531FF5B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF00000000000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF00000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF00000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF00000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF00000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF0000
      00005B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000005B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF00000000000000005B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF0000000000000000000000005B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF000000000000000000000000000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF0000000000000000000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF5B3531FF5B3531FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF000000000000000000000000000000000000
      000000000000000000005B3531FF5B3531FF000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005B35
      31FF5B3531FF5B3531FF00000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000005B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B35
      31FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF5B3531FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000180000000100010000000000200100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
