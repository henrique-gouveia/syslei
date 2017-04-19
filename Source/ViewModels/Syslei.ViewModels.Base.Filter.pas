unit Syslei.ViewModels.Base.Filter;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Interfaces,
  Spring.Collections,
  Spring.Container.Common;

type
  TFilterViewModelBase<TEntity, TFilter: class, constructor> = class(TViewModelBase, IFilterViewModel)
  private
    [Inject]
    FEntityFinder: IEntityFinder<TEntity, TFilter>;
    FEntities: IObjectList;
    FFilter: TFilter;

    function GetEntities: IObjectList;
    procedure SetEntities(const Value: IObjectList);
    function GetFilter: TFilter;
    procedure SetFilter(const Value: TFilter);
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Novo(Sender: TObject); virtual;
    procedure Ok(Sender: TObject); virtual;
    procedure Executar(Sender: TObject); virtual;

    property Entities: IObjectList read GetEntities write SetEntities;
    property Filter: TFilter read GetFilter write SetFilter;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TFilterViewModelBase<TEntity, TFilter>' }

destructor TFilterViewModelBase<TEntity, TFilter>.Destroy;
begin
  FreeAndNil(FFilter);
  inherited;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.AfterConstruction;
begin
  inherited;
  Novo(Self);
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Novo(Sender: TObject);
begin
  FEntities := nil;
  Filter := nil;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Ok(Sender: TObject);
begin
  Executar(Self);
end;

procedure TFilterViewModelBase<TEntity, TFilter>.Executar(Sender: TObject);
begin
  Entities := FEntityFinder.Find(Filter) as IObjectList;
end;

function TFilterViewModelBase<TEntity, TFilter>.GetEntities: IObjectList;
begin
  Result := FEntities;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.SetEntities(const Value: IObjectList);
begin
  if Assigned(Value) then
    FEntities := Value
  else
    FEntities := TCollections.CreateObjectList<TObject>() as IObjectList;

  DoPropertyChanged('Entities');
end;

function TFilterViewModelBase<TEntity, TFilter>.GetFilter: TFilter;
begin
  Result := FFilter;
end;

procedure TFilterViewModelBase<TEntity, TFilter>.SetFilter(const Value: TFilter);
begin
  if Assigned(FFilter) then
    FreeAndNil(FFilter);

  if Assigned(Value) then
    FFilter := Value
  else
    FFilter := TFilter.Create;

  DoPropertyChanged('Filter');
end;

{$ENDREGION}

end.
