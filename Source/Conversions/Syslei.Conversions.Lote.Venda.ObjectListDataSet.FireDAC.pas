unit Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

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
  TObjectListVendaLoteDataSetConverter = class(TDataModule, IValueConverter)
    vendaLoteDataSet: TFDMemTable;
    vendaLoteDataSetId: TIntegerField;
    vendaLoteDataSetData: TDateField;
    vendaLoteDataSetLanceArremate: TCurrencyField;
    vendaLoteDataSetCompradorId: TIntegerField;
    vendaLoteDataSetCompradorNome: TStringField;
    vendaLoteDataSetCompradorCpfCnpj: TStringField;
    vendaLoteDataSetCompradorTelefone: TStringField;
    vendaLoteDataSetLoteId: TIntegerField;
    vendaLoteDataSetLoteNumero: TStringField;
    vendaLoteDataSetLoteDescricao: TStringField;
    vendaLoteDataSetLoteTipo: TStringField;
    vendaLoteDataSetLoteIdade: TIntegerField;
    vendaLoteDataSetLoteSexo: TStringField;
  private
    function Convert(const Value: TValue): TValue;
    function ConvertBack(const Value: TValue): TValue;

    procedure AppendVendaDataSet(const arg: TObject);
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
  Syslei.Models.Entities.Lote.Helpers,
  Syslei.Models.Entities.Lote.Venda;

{$REGION 'TObjectListVendaLoteDataSetConverter' }

constructor TObjectListVendaLoteDataSetConverter.Create(AOwner: TComponent);
begin
  inherited;
  vendaLoteDataSet.Open();
end;

function TObjectListVendaLoteDataSetConverter.Convert(const Value: TValue): TValue;
var
  vendasLote: IObjectList;
begin
  if Value.TryAsType<IObjectList>(vendasLote) then
  begin
    vendaLoteDataSet.EmptyDataSet();
    vendasLote.ForEach(AppendVendaDataSet);
    Result := vendaLoteDataSet;
  end;
end;

procedure TObjectListVendaLoteDataSetConverter.AppendVendaDataSet(const arg: TObject);
var
  vendaLote: TVendaLote;
begin
  vendaLote := TVendaLote(arg);

  vendaLoteDataSet.Append();
  try
    vendaLoteDataSetId.AsInteger := vendaLote.Id;
    vendaLoteDataSetData.AsDateTime := vendaLote.Data;
    vendaLoteDataSetLanceArremate.AsFloat := vendaLote.LanceArremate;

    vendaLoteDataSetCompradorId.AsInteger := vendaLote.Comprador.Id;
    vendaLoteDataSetCompradorNome.AsString := vendaLote.Comprador.Nome;
    vendaLoteDataSetCompradorCpfCnpj.AsString := vendaLote.Comprador.CpfCnpj;
    vendaLoteDataSetCompradorTelefone.AsString := vendaLote.Comprador.Telefone;

    vendaLoteDataSetLoteId.AsInteger := vendaLote.Lote.Id;
    vendaLoteDataSetLoteNumero.AsString := vendaLote.Lote.Numero;
    vendaLoteDataSetLoteDescricao.AsString := vendaLote.Lote.Descricao;
    vendaLoteDataSetLoteTipo.AsString := vendaLote.Lote.Tipo.ToLongString().ToUpper();
    vendaLoteDataSetLoteIdade.AsInteger := vendaLote.Lote.Idade;
    vendaLoteDataSetLoteSexo.AsString := vendaLote.Lote.Sexo.ToShortString();
  finally
    vendaLoteDataSet.Post();
  end;
end;

function TObjectListVendaLoteDataSetConverter.ConvertBack(const Value: TValue): TValue;
begin

end;

{$ENDREGION}

end.
