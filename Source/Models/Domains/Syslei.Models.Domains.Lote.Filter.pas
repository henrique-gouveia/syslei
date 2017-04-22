unit Syslei.Models.Domains.Lote.Filter;

interface
uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa;

type
  TStatusLote = (slAguardando, slAgendado, slArrematado, slTodos);
  TTipoLote = (tlAnimal, tlImovel, tlPrenda, tlTodos);

  TLoteFilter = class
  private
    FDoador: TPessoa;
    FDataCadastroFinal: TDate;
    FDataCadastroInicial: TDate;
    FStatus: TStatusLote;
    FTipo: TTipoLote;
    procedure SetDataCadastroFinal(const Value: TDate);
    procedure SetDataCadastroInicial(const Value: TDate);
    procedure SetDoador(const Value: TPessoa);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    class function CreateLoteFilterEmpty: TLoteFilter; inline; static;

    property Doador: TPessoa read FDoador write SetDoador;

    property DataCadastroInicial: TDate read FDataCadastroInicial write SetDataCadastroInicial;
    property DataCadastroFinal: TDate read FDataCadastroFinal write SetDataCadastroFinal;

    property Status: TStatusLote read FStatus write FStatus default slTodos;
    property Tipo: TTipoLote read FTipo write FTipo default tlTodos;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TLoteFilter' }

constructor TLoteFilter.Create;
begin
  inherited;
  FDoador := TPessoa.Create;
  FDataCadastroInicial := Date();
  FDataCadastroFinal := Date();
  FStatus := TStatusLote.slTodos;
  FTipo := TTipoLote.tlTodos;
end;

destructor TLoteFilter.Destroy;
begin
  FreeAndNil(FDoador);
  inherited;
end;

class function TLoteFilter.CreateLoteFilterEmpty: TLoteFilter;
begin
  Result := TLoteFilter.Create;
  Result.DataCadastroInicial := 0;
  Result.DataCadastroFinal := 0;
end;

procedure TLoteFilter.SetDataCadastroFinal(const Value: TDate);
begin
  FDataCadastroFinal := Trunc(Value);
end;

procedure TLoteFilter.SetDataCadastroInicial(const Value: TDate);
begin
  FDataCadastroInicial := Trunc(Value);
end;

procedure TLoteFilter.SetDoador(const Value: TPessoa);
begin
  if Assigned(FDoador) then
    FreeAndNil(FDoador);

  if Assigned(Value) then
    FDoador := Value
  else
    FDoador := TPessoa.Create;
end;

{$ENDREGION}

end.
