unit Syslei.Conversions.Lote.ObjectListDataSet.FireDAC;

interface

uses
  System.SysUtils,
  System.Classes,

  DSharp.Core.DataConversion,

  Data.DB,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TObjectListLoteDataSetConverter = class(TDataModule, IValueConverter)
    loteDataSet: TFDMemTable;
    loteDataSetId: TIntegerField;
    loteDataSetNumero: TStringField;
    loteDataSetDescricao: TStringField;
    loteDataSetStatus: TStringField;
    loteDataSetTipo: TStringField;
    loteDataSetIdade: TIntegerField;
    loteDataSetSexo: TStringField;
    loteDataSetLanceInicial: TCurrencyField;
  private
    function Convert(const Value: TValue): TValue;
    function ConvertBack(const Value: TValue): TValue;

    procedure AppendLoteDataSet(const arg: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.StrUtils,
  Spring.Collections,
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Helpers;

{$REGION 'TObjectListLoteDataSetConverter' }

constructor TObjectListLoteDataSetConverter.Create(AOwner: TComponent);
begin
  inherited;
  loteDataSet.Open();
end;

function TObjectListLoteDataSetConverter.Convert(const Value: TValue): TValue;
var
  lotes: IObjectList;
begin
  if Value.TryAsType<IObjectList>(lotes) then
  begin
    loteDataSet.EmptyDataSet();
    lotes.ForEach(AppendLoteDataSet);
    Result := loteDataSet;
  end;
end;

procedure TObjectListLoteDataSetConverter.AppendLoteDataSet(const arg: TObject);
var
  lote: TLote;
begin
  lote := TLote(arg);

  loteDataSet.Append();
  try
    loteDataSetId.AsInteger := lote.Id;
    loteDataSetNumero.AsString := lote.Numero;
    loteDataSetDescricao.AsString := lote.Descricao;
    loteDataSetStatus.AsString := lote.Status.ToLongString().ToUpper();
    loteDataSetTipo.AsString := lote.Tipo.ToLongString().ToUpper();
    loteDataSetIdade.AsInteger := lote.Idade;
    loteDataSetSexo.AsString := lote.Sexo.ToShortString();
    loteDataSetLanceInicial.AsFloat := lote.LanceInicial;
  finally
    loteDataSet.Post();
  end;
end;

function TObjectListLoteDataSetConverter.ConvertBack(const Value: TValue): TValue;
begin

end;

{$ENDREGION}

end.
