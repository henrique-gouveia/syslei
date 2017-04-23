unit Syslei.ViewModels.Finders.Lote.Venda;

interface

uses
  Syslei.Models.Domains.Lote.Venda.Filter,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Finders.Interfaces,

  Syslei.ViewModels.Base,

  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TVendaLoteFinderViewModel = class(TViewModelBase)
  private const
    COMPRADOR_NOME_CONTROL_NAME = 'compradorNomeEdit';
  private
    FEntity: TVendaLote;
    FEntityId: Integer;
    FEntities: IObjectList;

    [Inject]
    FEntityFinder: IEntityFinder<TVendaLote, TVendaLoteFilter>;
    [Inject]
    FEntityRepository: IPagedRepository<TVendaLote, Integer>;

    FFilter: TVendaLoteFilter;

    function GetEntities: IObjectList;
    procedure SetEntity(const Value: TVendaLote);

    procedure SetEntities(const Value: IObjectList);
    function GetEntity: TVendaLote;

    procedure SetEntityId(const Value: Integer);

    function GetFilter: TVendaLoteFilter;
    procedure SetFilter(const Value: TVendaLoteFilter);
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Executar(Sender: TObject); virtual;

    property Entity: TVendaLote read GetEntity write SetEntity;
    property EntityId: Integer read FEntityId write SetEntityId;
    property Entities: IObjectList read GetEntities write SetEntities;

    property Filter: TVendaLoteFilter read GetFilter write SetFilter;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TVendaLoteTFinderViewModel' }

destructor TVendaLoteFinderViewModel.Destroy;
begin
  FreeAndNil(FEntity);
  FreeAndNil(FFilter);
  inherited;
end;

procedure TVendaLoteFinderViewModel.AfterConstruction;
begin
  inherited;
  Novo(Self);
end;

procedure TVendaLoteFinderViewModel.Novo(Sender: TObject);
begin
  Entity := nil;
  Entities := nil;
  Filter := nil;

  ActiveControl := COMPRADOR_NOME_CONTROL_NAME;
end;

procedure TVendaLoteFinderViewModel.Executar(Sender: TObject);
begin
  Entities := FEntityFinder.Find(Filter) as IObjectList;
end;

function TVendaLoteFinderViewModel.GetEntity: TVendaLote;
begin
  Result := FEntity;
end;

procedure TVendaLoteFinderViewModel.SetEntity(const Value: TVendaLote);
begin
  if Assigned(FEntity) then
    FreeAndNil(FEntity);

  if Assigned(Value) then
    FEntity := Value
  else
    FEntity := TVendaLote.Create;

  DoPropertyChanged('Entity');
end;

procedure TVendaLoteFinderViewModel.SetEntityId(const Value: Integer);
begin
  if (FEntityId <> Value) then
  begin
    FEntityId := Value;
    Entity := FEntityRepository.FindOne(FEntityId);
  end;
end;

function TVendaLoteFinderViewModel.GetEntities: IObjectList;
begin
  Result := FEntities;
end;

procedure TVendaLoteFinderViewModel.SetEntities(const Value: IObjectList);
begin
  if Assigned(Value) then
    FEntities := Value
  else
    FEntities := TCollections.CreateObjectList<TVendaLote>() as IObjectList;

  DoPropertyChanged('Entities');
end;

function TVendaLoteFinderViewModel.GetFilter: TVendaLoteFilter;
begin
  Result := FFilter;
end;

procedure TVendaLoteFinderViewModel.SetFilter(const Value: TVendaLoteFilter);
begin
  if Assigned(FFilter) then
    FreeAndNil(FFilter);

  if Assigned(Value) then
    FFilter := Value
  else
    FFilter := TVendaLoteFilter.Create;

  DoPropertyChanged('Filter');
end;

{$ENDREGION}

end.
