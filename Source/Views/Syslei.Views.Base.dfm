object BaseView: TBaseView
  Left = 0
  Top = 0
  Caption = 'Base'
  ClientHeight = 412
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object topPanel: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object contentPanel: TPanel
    Left = 0
    Top = 55
    Width = 634
    Height = 357
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object actions: TActionList
    Images = images
    Left = 13
    Top = 4
  end
  object images: TImageList
    ColorDepth = cd32Bit
    Height = 24
    Width = 24
    Left = 52
    Top = 4
  end
end
