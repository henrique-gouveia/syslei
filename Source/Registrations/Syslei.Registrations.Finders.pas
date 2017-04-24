unit Syslei.Registrations.Finders;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TFindersRegisterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Syslei.Models.Domains.Lote.Filter,
  Syslei.Models.Domains.Lote.Venda.Filter,

  Syslei.Models.Finders.Interfaces,
  Syslei.Models.Finders.Simple,
  Syslei.Models.Finders.Lote.Filter,
  Syslei.Models.Finders.Lote.Venda.Filter,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa;


{$REGION 'TFindersRegisterType' }

procedure TFindersRegisterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IEntityFinder<TLote>, TSimpleEntityFinder<TLote, Integer>>();

  container
    .RegisterType<IEntityFinder<TPessoa>, TSimpleEntityFinder<TPessoa, Integer>>();

  container
    .RegisterType<IEntityFinder<TLote, TLoteFilter>, TFilterLoteFinder>();

  container
    .RegisterType<IEntityFinder<TVendaLote, TVendaLoteFilter>, TFilterVendaLoteFinder>();

  container
    .RegisterType<IEntityFinder<TVendaLote, TVendaLoteFilterReport>, TFilterVendaLoteFinderReport>();
end;

{$ENDREGIOn}

end.
