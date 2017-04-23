unit Syslei.Models.Domains.Lote.Venda.Filter;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa;

type
  TTipoLote = (tlAnimal, tlImovel, tlPrenda, tlTodos);

  TVendaLoteFilter = class
  private
    FComprador: TPessoa;
    FLote: TLote;
    FDataVendaInicial: TDate;
    FDataVendaFinal: TDate;
    FTipo: TTipoLote;
    FDataVenda: TDate;
    procedure SetComprador(const Value: TPessoa);
    procedure SetDataVendaInicial(const Value: TDate);
    procedure SetDataVendaFinal(const Value: TDate);
    procedure SetLote(const Value: TLote);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    class function CreateVendaLoteFilterEmpty: TVendaLoteFilter; inline; static;

    property Comprador: TPessoa read FComprador write SetComprador;
    property Lote: TLote read FLote write SetLote;

    property DataVendaInicial: TDate read FDataVendaInicial write SetDataVendaInicial;
    property DataVendaFinal: TDate read FDataVenda write SetDataVendaFinal;

    property Tipo: TTipoLote read FTipo write FTipo default tlTodos;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TVendaLoteFilter' }

constructor TVendaLoteFilter.Create;
begin
  inherited;
  FComprador := TPessoa.Create;
  FLote := TLote.Create;
  FDataVendaInicial := Date();
  FDataVendaFinal := Date();
  FTipo := TTipoLote.tlTodos;
end;

destructor TVendaLoteFilter.Destroy;
begin
  FreeAndNil(FComprador);
  FreeAndNil(FLote);
  inherited;
end;

class function TVendaLoteFilter.CreateVendaLoteFilterEmpty: TVendaLoteFilter;
begin
  Result := TVendaLoteFilter.Create;
  Result.DataVendaInicial := 0;
  Result.DataVendaFinal := 0;
end;

procedure TVendaLoteFilter.SetComprador(const Value: TPessoa);
begin
  if Assigned(FComprador) then
    FreeAndNil(FComprador);

  if Assigned(Value) then
    FComprador := Value
  else
    FComprador := TPessoa.Create;
end;

procedure TVendaLoteFilter.SetDataVendaInicial(const Value: TDate);
begin
  FDataVendaInicial := Trunc(Value);
end;

procedure TVendaLoteFilter.SetDataVendaFinal(const Value: TDate);
begin
  FDataVendaFinal := Trunc(Value);
end;

procedure TVendaLoteFilter.SetLote(const Value: TLote);
begin
  if Assigned(FLote) then
    FreeAndNil(FLote);

  if Assigned(Value) then
    FLote := Value
  else
    FLote := TLote.Create;
end;

{$ENDREGION}

end.
