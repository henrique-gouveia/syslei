unit Syslei.Models.Finders.Lote.Filter;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Finders.Interfaces,
  Syslei.Models.Domains.Lote.Filter,
  Syslei.Models.Domains.Lote.Filter.Helpers,

  Spring,
  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TFilterLoteFinder = class(TInterfacedObject, IEntityFinder<TLote, TLoteFilter>)
  private
    FLoteRepository: IPagedRepository<TLote, Integer>;
  protected
    function Find(const filter: TLoteFilter): IList<TLote>; virtual;
  public
    constructor Create(const entityRepository: IPagedRepository<TLote,Integer>); virtual;
  end;

implementation

uses
  System.SysUtils,
  Syslei.Models.Entities.Pessoa,
  Spring.Persistence.Criteria.Properties,
  Spring.Persistence.Criteria.Restrictions,
  Spring.Persistence.SQL.Types;

{$REGION 'TLoteFinder' }

constructor TFilterLoteFinder.Create(const entityRepository: IPagedRepository<TLote, Integer>);
begin
  inherited Create;
  FLoteRepository := entityRepository;
end;

function TFilterLoteFinder.Find(const filter: TLoteFilter): IList<TLote>;
var
  criteria: ICriteria<TLote>;
  criteriaProperty: IProperty;
begin
  criteria := FLoteRepository.FindWhere();

  if Assigned(filter) then
  begin
    if (filter.Doador.Id > 0) then
    begin
      criteriaProperty := TProperty<TPessoa>.Create('ID');
      criteria.Add(criteriaProperty.Eq(filter.Doador.Id));
    end;

    if (filter.Status in [slAguardando, slAgendado, slArrematado]) then
    begin
      criteriaProperty := TProperty.Create('STATUS');
      criteria.Add(criteriaProperty.Eq(filter.Status.ToInteger()));
    end;

    if (filter.Tipo in [tlAnimal, tlImovel, tlPrenda]) then
    begin
      criteriaProperty := TProperty.Create('TIPO');
      criteria.Add(criteriaProperty.Eq(filter.Tipo.ToInteger()));
    end;

    if (filter.DataCadastroInicial > 0) and (filter.DataCadastroFinal > 0) then
    begin
      criteriaProperty := TProperty.Create('DATA_CADASTRO');
      criteria.Add(criteriaProperty.Between(
        TValue.From<TDate>(filter.DataCadastroInicial),
        TValue.From<TDate>(filter.DataCadastroFinal)));
    end;
  end;

  Result := criteria.ToList();
end;

{$ENDREGION}

end.
