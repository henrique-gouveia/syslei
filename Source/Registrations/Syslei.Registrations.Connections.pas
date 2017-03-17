unit Syslei.Registrations.Connections;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TConnectionRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  FireDAC.Comp.Client,

  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,
  Spring.Persistence.SQL.Interfaces,

  Syslei.Modules.Connections.Consts,
  Syslei.Modules.Connections.Interfaces;

{$REGION 'TConnectionRegiterType' }

procedure TConnectionRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IDBConnection>()
    .DelegateTo(
      function: IDBConnection
      var
        connectionModule: IConnectionModule<TFDConnection>;
      begin
        connectionModule := container.Resolve<IConnectionModule<TFDConnection>>(CONNECTION_MODULE_NAME);
        Result := TFireDACConnectionAdapter.Create(connectionModule.Connection);

        if connectionModule.DriverName = 'FB' then
          Result.QueryLanguage := qlFirebird
        else
          Result.QueryLanguage := qlAnsiSQL;
      end)
    .AsSingleton();

  container
    .RegisterType<TSession>()
    .AsSingleton();
end;

{$ENDREGION}

end.
