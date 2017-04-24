unit Syslei.Models.Domains.Lote.Venda.Filter;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa;

type
  TTipoLote = (tlAnimal, tlImovel, tlPrenda, tlTodos);

  TVendaLoteFilterCustom = class
  private
    FComprador: TPessoa;
    FLote: TLote;
    FDataVendaInicial: TDate;
    FDataVendaFinal: TDate;
    FTipo: TTipoLote;
    procedure SetComprador(const Value: TPessoa);
    procedure SetDataVendaInicial(const Value: TDate);
    procedure SetDataVendaFinal(const Value: TDate);
    procedure SetLote(const Value: TLote);
  protected
    property Comprador: TPessoa read FComprador write SetComprador;
    property Lote: TLote read FLote write SetLote;

    property DataVendaInicial: TDate read FDataVendaInicial write SetDataVendaInicial;
    property DataVendaFinal: TDate read FDataVendaFinal write SetDataVendaFinal;

    property Tipo: TTipoLote read FTipo write FTipo default tlTodos;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TVendaLoteFilter = class(TVendaLoteFilterCustom)
  public
    class function CreateVendaLoteFilterEmpty: TVendaLoteFilter; inline; static;

    property Comprador;
    property Lote;
    property DataVendaInicial;
    property DataVendaFinal;
  end;

  TVendaLoteFilterReport = class(TVendaLoteFilterCustom)
  public
    class function CreateVendaLoteFilterReportEmpty: TVendaLoteFilterReport; inline; static;

    property Comprador;
    property DataVendaInicial;
    property DataVendaFinal;
    property Tipo;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TVendaLoteFilterCustom' }

constructor TVendaLoteFilterCustom.Create;
begin
  inherited;
  FComprador := TPessoa.Create;
  FLote := TLote.Create;
  FDataVendaInicial := Date();
  FDataVendaFinal := Date();
  FTipo := TTipoLote.tlTodos;
end;

destructor TVendaLoteFilterCustom.Destroy;
begin
  FreeAndNil(FComprador);
  FreeAndNil(FLote);
  inherited;
end;

procedure TVendaLoteFilterCustom.SetComprador(const Value: TPessoa);
begin
  if Assigned(FComprador) then
    FreeAndNil(FComprador);

  if Assigned(Value) then
    FComprador := Value
  else
    FComprador := TPessoa.Create;
end;

procedure TVendaLoteFilterCustom.SetDataVendaInicial(const Value: TDate);
begin
  FDataVendaInicial := Trunc(Value);
end;

procedure TVendaLoteFilterCustom.SetDataVendaFinal(const Value: TDate);
begin
  FDataVendaFinal := Trunc(Value);
end;

procedure TVendaLoteFilterCustom.SetLote(const Value: TLote);
begin
  if Assigned(FLote) then
    FreeAndNil(FLote);

  if Assigned(Value) then
    FLote := Value
  else
    FLote := TLote.Create;
end;

{$ENDREGION}

{$REGION 'TVendaLoteFilter' }

class function TVendaLoteFilter.CreateVendaLoteFilterEmpty: TVendaLoteFilter;
begin
  Result := TVendaLoteFilter.Create;
  Result.DataVendaInicial := 0;
  Result.DataVendaFinal := 0;
end;

{$ENDREGION}

{$REGION 'TVendaLoteFilterReport' }

class function TVendaLoteFilterReport.CreateVendaLoteFilterReportEmpty: TVendaLoteFilterReport;
begin
  Result := TVendaLoteFilterReport.Create;
  Result.DataVendaInicial := 0;
  Result.DataVendaFinal := 0;
end;

{$ENDREGION}

end.
