unit Syslei.Registrations;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

  procedure RegisterTypes;

implementation

uses
  Syslei.Registrations.Connections,
  Syslei.Registrations.Conversions,
  Syslei.Registrations.Finders,
  Syslei.Registrations.Interfaces,
  Syslei.Registrations.Modules,
  Syslei.Registrations.Repositories,
  Syslei.Registrations.ViewModels,
  Syslei.Registrations.Views;

procedure RegisterTypes;
var
  registerTypeExecutor: IRegisterTypeExecutor<TContainer>;
begin
  registerTypeExecutor := TSpringRegisterTypeExecutor.Create;

  registerTypeExecutor.AddRegister(TConnectionRegiterType.Create());
  registerTypeExecutor.AddRegister(TConversionsRegiterType.Create());
  registerTypeExecutor.AddRegister(TFindersRegisterType.Create());
  registerTypeExecutor.AddRegister(TModulesRegiterType.Create());
  registerTypeExecutor.AddRegister(TRepositoriesRegisterType.Create());
  registerTypeExecutor.AddRegister(TViewModelsRegiterType.Create());
  registerTypeExecutor.AddRegister(TViewsRegiterType.Create());

  registerTypeExecutor.Execute();
end;

end.
