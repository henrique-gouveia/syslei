unit Syslei.ViewModels.Managers.Lote;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager,

  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TLoteManagerViewModel = class(TManagerViewModelBase<TLote>)
  private
    FDoador: TPessoa;
    FDoadorId: Integer;
    [Inject]
    FDoadorRepository: IPagedRepository<TPessoa, Integer>;

    function GetIsAnimalLote: Boolean;
    procedure SetDoador(const Value: TPessoa);
    procedure SetDoadorId(const Value: Integer);
    procedure SetTipoLote(const Value: TTipoLote);
  protected
    procedure SetEntityId(const Value: Integer); override;
  public
    destructor Destroy; override;

    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;

    property Doador: TPessoa read FDoador write SetDoador;
    property DoadorId: Integer read FDoadorId write SetDoadorId;

    property IsAnimalLote: Boolean read GetIsAnimalLote;
    property TipoLote: TTipoLote write SetTipoLote;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TLoteManagerViewModel' }

destructor TLoteManagerViewModel.Destroy;
begin
  FreeAndNil(FDoador);
  inherited;
end;

procedure TLoteManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  ActiveControl := 'idEdit';
  Doador := TPessoa.Create;
  DoadorId := 0;
end;

procedure TLoteManagerViewModel.Buscar(Sender: TObject);
begin
  inherited;

end;

function TLoteManagerViewModel.GetIsAnimalLote: Boolean;
begin
  Result := Entity.IsAnimal;
end;

procedure TLoteManagerViewModel.SetDoador(const Value: TPessoa);
begin
  if Assigned(FDoador) then
    FreeAndNil(FDoador);

  FDoador := Value;

  if Assigned(FDoador) then
    DoPropertyChanged('Doador');
end;

procedure TLoteManagerViewModel.SetDoadorId(const Value: Integer);
begin
  if (FDoadorId <> Value) then
  begin
    FDoadorId := Value;
    Doador := FDoadorRepository.FindOne(FDoadorId);
  end;
end;

procedure TLoteManagerViewModel.SetEntityId(const Value: Integer);
begin
  inherited;
  if (DoadorId <> Entity.DoadorId) then
    DoadorId := Entity.DoadorId;
end;

procedure TLoteManagerViewModel.SetTipoLote(const Value: TTipoLote);
begin
  DoPropertyChanged('IsAnimalLote');
end;

{$ENDREGION}

end.
