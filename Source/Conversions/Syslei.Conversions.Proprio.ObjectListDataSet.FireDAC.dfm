object ObjectListProprioDataSetConverter: TObjectListProprioDataSetConverter
  OldCreateOrder = False
  Height = 150
  Width = 215
  object proprioDataSet: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 91
    Top = 59
    object proprioDataSetId: TIntegerField
      FieldName = 'Id'
    end
    object proprioDataSetNome: TStringField
      FieldName = 'Nome'
      Size = 60
    end
    object proprioDataSetCpfCnpj: TStringField
      FieldName = 'CpfCnpj'
    end
    object proprioDataSetTelefone: TStringField
      FieldName = 'Telefone'
      Size = 15
    end
  end
end
