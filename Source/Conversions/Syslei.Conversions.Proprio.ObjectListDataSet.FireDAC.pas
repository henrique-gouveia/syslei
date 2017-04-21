unit Syslei.Conversions.Proprio.ObjectListDataSet.FireDAC;

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
  TObjectListProprioDataSetConverter = class(TDataModule, IValueConverter)
    proprioDataSet: TFDMemTable;
    proprioDataSetId: TIntegerField;
    proprioDataSetNome: TStringField;
    proprioDataSetCpfCnpj: TStringField;
    proprioDataSetTelefone: TStringField;
  protected
    function Convert(const Value: TValue): TValue;
    function ConvertBack(const Value: TValue): TValue;

    procedure AppendPessoaDataSet(const arg: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.StrUtils,
  Spring.Collections,
  Syslei.Models.Entities.Proprio;

{$REGION 'TObjectListProprioDataSetConverter' }

constructor TObjectListProprioDataSetConverter.Create(AOwner: TComponent);
begin
  inherited;
  proprioDataSet.Open();
end;

function TObjectListProprioDataSetConverter.Convert(const Value: TValue): TValue;
var
  proprios: IObjectList;
begin
  if Value.TryAsType<IObjectList>(proprios) then
  begin
    proprioDataSet.EmptyDataSet();
    proprios.ForEach(AppendPessoaDataSet);
    Result := proprioDataSet;
  end;
end;

procedure TObjectListProprioDataSetConverter.AppendPessoaDataSet(const arg: TObject);
var
  pessoa: TProprio;
begin
  pessoa := TProprio(arg);

  proprioDataSet.Append();
  try
    proprioDataSetId.AsInteger := pessoa.Id;
    proprioDataSetNome.AsString := pessoa.Nome;
    proprioDataSetCpfCnpj.AsString := pessoa.CpfCnpj;
    proprioDataSetTelefone.AsString := pessoa.Telefone;
  finally
    proprioDataSet.Post();
  end;
end;

function TObjectListProprioDataSetConverter.ConvertBack(const Value: TValue): TValue;
begin

end;

{$ENDREGION}

end.
