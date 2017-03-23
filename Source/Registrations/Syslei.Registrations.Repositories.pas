unit Syslei.Registrations.Repositories;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TRepositoriesRegisterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa;

{$REGION 'TRepositoriesRegisterType' }

procedure TRepositoriesRegisterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IPagedRepository<TLote,Integer>, TSimpleRepository<TLote, Integer>>();

  container
    .RegisterType<IPagedRepository<TPessoa,Integer>, TSimpleRepository<TPessoa, Integer>>();

  container
    .RegisterType<IPagedRepository<TVendaLote,Integer>, TSimpleRepository<TVendaLote, Integer>>();
end;

{$ENDREGION}

end.
