unit Syslei.Registrations;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

  procedure RegisterTypes;

implementation

uses
  Syslei.Registrations.Connections,
  Syslei.Registrations.Interfaces,
  Syslei.Registrations.Modules,
  Syslei.Registrations.Repositories;

procedure RegisterTypes;
var
  registerTypeExecutor: IRegisterTypeExecutor<TContainer>;
begin
  registerTypeExecutor := TSpringRegisterTypeExecutor.Create;

  registerTypeExecutor.AddRegister(TConnectionRegiterType.Create());
  registerTypeExecutor.AddRegister(TModulesRegiterType.Create());
  registerTypeExecutor.AddRegister(TRepositoriesRegisterType.Create());

  registerTypeExecutor.Execute();
end;

end.
