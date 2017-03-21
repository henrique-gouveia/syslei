unit Syslei.Models.Finders.Simple;

interface

uses
  Syslei.Models.Finders.Interfaces,
  Spring,
  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TSimpleEntityFinder<TEntity: class, constructor; TID> = class(TInterfacedObject, IEntityFinder<TEntity>)
  private
    FEntityRepository: IPagedRepository<TEntity,TID>;
  protected
    function FindEqual(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;
    function FindLikeAnyware(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;
    function FindLikeStart(const propertyName: String; const propertyValue: TValue): IList<TEntity>; virtual;

    property EntityRepository: IPagedRepository<TEntity,TID> read FEntityRepository;
  public
    constructor Create(const entityRepository: IPagedRepository<TEntity,TID>); virtual;
  end;

implementation

uses
  Spring.Persistence.Criteria.Restrictions,
  Spring.Persistence.SQL.Types;

{$REGION 'TSimpleEntityFinder<T, TID>' }

constructor TSimpleEntityFinder<TEntity, TID>.Create(const entityRepository: IPagedRepository<TEntity,TID>);
begin
  inherited Create;
  FEntityRepository := entityRepository;
end;

function TSimpleEntityFinder<TEntity, TID>.FindEqual(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Eq(
                  propertyName,
                  propertyValue)
              );
end;

function TSimpleEntityFinder<TEntity, TID>.FindLikeAnyware(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Like(
                  propertyName,
                  propertyValue.AsString,
                  mmAnywhere)
              );
end;

function TSimpleEntityFinder<TEntity, TID>.FindLikeStart(const propertyName: String;
  const propertyValue: TValue): IList<TEntity>;
begin
  Result := FEntityRepository
              .FindWhere(
                Restrictions.Like(
                  propertyName,
                  propertyValue.AsString,
                  mmStart)
              );
end;

{$ENDREGION}

end.
