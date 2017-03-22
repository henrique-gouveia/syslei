object FirebirdConnectionModule: TFirebirdConnectionModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object SysleiConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=SYSLEI')
    LoginPrompt = False
    Left = 91
    Top = 16
  end
  object guixWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 72
  end
  object firebirdDriverLink: TFDPhysFBDriverLink
    Left = 40
    Top = 72
  end
end
