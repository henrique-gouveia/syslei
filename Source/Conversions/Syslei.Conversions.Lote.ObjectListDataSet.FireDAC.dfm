object ObjectListLoteDataSetConverter: TObjectListLoteDataSetConverter
  OldCreateOrder = False
  Height = 150
  Width = 215
  object loteDataSet: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 91
    Top = 59
    object loteDataSetId: TIntegerField
      FieldName = 'Id'
    end
    object loteDataSetNumero: TStringField
      FieldName = 'Numero'
    end
    object loteDataSetDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object loteDataSetStatus: TStringField
      FieldName = 'Status'
    end
    object loteDataSetTipo: TStringField
      FieldName = 'Tipo'
    end
    object loteDataSetIdade: TIntegerField
      FieldName = 'Idade'
    end
    object loteDataSetSexo: TStringField
      FieldName = 'Sexo'
      Size = 12
    end
    object loteDataSetLanceInicial: TCurrencyField
      FieldName = 'LanceInicial'
    end
  end
end
