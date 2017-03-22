object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'Sistema de Gest'#227'o para Leil'#227'o'
  ClientHeight = 462
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object backgroundImage: TImage
    Left = 0
    Top = 48
    Width = 584
    Height = 414
    Align = alClient
    Center = True
    Stretch = True
    ExplicitTop = 54
  end
  object toolBar: TToolBar
    Left = 0
    Top = 0
    Width = 584
    Height = 48
    ButtonHeight = 48
    ButtonWidth = 48
    Caption = 'toolBar'
    DrawingStyle = dsGradient
    TabOrder = 0
    object pessoaManagerButton: TToolButton
      Left = 0
      Top = 0
      Action = PessoaManager
    end
  end
  object toolBarImages: TImageList
    ColorDepth = cd32Bit
    Height = 32
    Width = 32
    Left = 464
    Top = 109
  end
  object Actions: TActionList
    Left = 464
    Top = 63
    object PessoaManager: TAction
      Category = 'Cadastro'
      Caption = 'Pessoas'
    end
  end
end
