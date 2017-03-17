unit Syslei.Registrations.Modules;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TModulesRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Vcl.Forms,

  Syslei.Modules.Connections.Consts,
  Syslei.Modules.Connections.Firebird;

{$REGION 'TDataModulesRegiterType' }

procedure TModulesRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TFirebirdConnectionModule>(CONNECTION_MODULE_NAME)
    .DelegateTo(
      function: TFirebirdConnectionModule
      begin
        Application.CreateForm(TFirebirdConnectionModule, Result);
      end)
    .AsSingleton();
end;

{$ENDREGION}

end.
