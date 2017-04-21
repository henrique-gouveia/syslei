object ObjectListVendaLoteDataSetConverter: TObjectListVendaLoteDataSetConverter
  OldCreateOrder = False
  Height = 150
  Width = 215
  object vendaLoteDataSet: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 91
    Top = 59
    object vendaLoteDataSetId: TIntegerField
      FieldName = 'Id'
    end
    object vendaLoteDataSetData: TDateField
      FieldName = 'Data'
    end
    object vendaLoteDataSetLanceArremate: TFMTBCDField
      FieldName = 'LanceArremate'
      DisplayFormat = ',0.00'
      Size = 15
    end
    object vendaLoteDataSetCompradorId: TIntegerField
      FieldName = 'CompradorId'
    end
    object vendaLoteDataSetCompradorNome: TStringField
      FieldName = 'CompradorNome'
      Size = 60
    end
    object vendaLoteDataSetCompradorCpfCnpj: TStringField
      FieldName = 'CompradorCpfCnpj'
    end
    object vendaLoteDataSetCompradorTelefone: TStringField
      FieldName = 'CompradorTelefone'
      Size = 15
    end
    object vendaLoteDataSetLoteId: TIntegerField
      FieldName = 'LoteId'
    end
    object vendaLoteDataSetLoteNumero: TStringField
      FieldName = 'LoteNumero'
    end
    object vendaLoteDataSetLoteDescricao: TStringField
      FieldName = 'LoteDescricao'
      Size = 100
    end
    object vendaLoteDataSetLoteTipo: TStringField
      FieldName = 'LoteTipo'
      Size = 10
    end
    object vendaLoteDataSetLoteIdade: TIntegerField
      FieldName = 'LoteIdade'
    end
    object vendaLoteDataSetLoteSexo: TStringField
      FieldName = 'LoteSexo'
      Size = 1
    end
  end
end
