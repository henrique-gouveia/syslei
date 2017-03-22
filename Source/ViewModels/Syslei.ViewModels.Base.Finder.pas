unit Syslei.ViewModels.Base.Finder;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Base.Domain,
  Syslei.ViewModels.Interfaces,

  Spring,
  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TFinderViewModelBase<TEntity: class, constructor> = class(TViewModelBase, IFinderViewModel<TEntity>)
  private
    FEntity: TEntity;
    FEntities: IObjectList;
    [Inject]
    FEntityFinder: IEntityFinder<TEntity>;

    FSearchProperty: TPropertyData;
    FSearchProperties: IObjectList;

    function GetEntity: TEntity;
    procedure SetEntity(const value: TEntity);
    function GetEntities: IObjectList;
    procedure SetEntities(const Value: IObjectList);
    procedure SetSearchProperty(const Value: TPropertyData); virtual;
  protected
    property EntityFinder: IEntityFinder<TEntity> read FEntityFinder;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Avulsa(Sender: TObject); virtual;
    procedure Inicial(Sender: TObject); virtual;
    procedure Exata(Sender: TObject); virtual;

    property Entity: TEntity read GetEntity write SetEntity;
    property Entities: IObjectList read GetEntities write SetEntities;

    property SearchProperty: TPropertyData read FSearchProperty write SetSearchProperty;
    property SearchProperties: IObjectList read FSearchProperties;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TFinderViewModelBase<TEntity>' }

destructor TFinderViewModelBase<TEntity>.Destroy;
begin
  FreeAndNil(FSearchProperty);
  inherited;
end;

procedure TFinderViewModelBase<TEntity>.AfterConstruction;
begin
  inherited;
  FSearchProperty := TPropertyData.Create;
  FSearchProperties := TCollections.CreateObjectList<TPropertyData>() as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Novo(Sender: TObject);
begin
  Entity := TEntity.Create;
  Entities := TCollections.CreateObjectList<TEntity>() as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Avulsa(Sender: TObject);
begin
  Entities := EntityFinder.FindLikeAnyware(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Inicial(Sender: TObject);
begin
  Entities := EntityFinder.FindLikeStart(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

procedure TFinderViewModelBase<TEntity>.Exata(Sender: TObject);
begin
  Entities := EntityFinder.FindEqual(SearchProperty.Name, SearchProperty.Value) as IObjectList;
end;

function TFinderViewModelBase<TEntity>.GetEntity: TEntity;
begin
  Result := FEntity;
end;

procedure TFinderViewModelBase<TEntity>.SetEntity(const value: TEntity);
begin
  FEntity := Value;
end;

function TFinderViewModelBase<TEntity>.GetEntities: IObjectList;
begin
  if not Assigned(FEntities) then
    FEntities := TCollections.CreateObjectList<TEntity>() as IObjectList;

  Result := FEntities;
end;

procedure TFinderViewModelBase<TEntity>.SetEntities(const Value: IObjectList);
begin
  FEntities := Value;
  DoPropertyChanged('Entities');
end;

procedure TFinderViewModelBase<TEntity>.SetSearchProperty(const Value: TPropertyData);
begin
  if Assigned(FSearchProperty) then
    FreeAndNil(FSearchProperty);
  FSearchProperty := Value;
end;

{$ENDREGION}

end.
