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
  Syslei.Models.Finders.Interfaces,
  Syslei.Models.Finders.Simple,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa;


{$REGION 'TFindersRegisterType' }

procedure TFindersRegisterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IEntityFinder<TLote>, TSimpleEntityFinder<TLote, Integer>>();

  container
    .RegisterType<IEntityFinder<TPessoa>, TSimpleEntityFinder<TPessoa, Integer>>();
end;

{$ENDREGIOn}

end.
