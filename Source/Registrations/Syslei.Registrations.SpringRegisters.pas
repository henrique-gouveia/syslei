unit Syslei.Registrations.SpringRegisters;

interface

uses
  Syslei.Registrations.Interfaces,

  Spring.Container,
  Spring.Collections;

type
  TSpringRegisterType = class(TInterfacedObject, IRegisterType<TContainer>)
    procedure RegistryType(const container: TContainer); virtual; abstract;
  end;

  TSpringRegisterTypeExecutor = class(TInterfacedObject, IRegisterTypeExecutor<TContainer>)
  private
    FRegisters: IList<IRegisterType<TContainer>>;
  public
    constructor Create;

    procedure Execute;
    procedure AddRegister(const registerType: IRegisterType<TContainer>);
  end;

implementation

{$REGION 'TSpringRegisterTypeExecutor' }

constructor TSpringRegisterTypeExecutor.Create;
begin
  inherited Create;
  FRegisters := TCollections.CreateList<IRegisterType<TContainer>>;
end;

procedure TSpringRegisterTypeExecutor.AddRegister(const registerType: IRegisterType<TContainer>);
begin
  if not FRegisters.Contains(registerType) then
    FRegisters.Add(registerType);
end;

procedure TSpringRegisterTypeExecutor.Execute;
var
  container: TContainer;
  registerType: IRegisterType<TContainer>;
begin
  container := GlobalContainer();

  for registerType in FRegisters do
    registerType.RegistryType(container);

  container.Build();
end;

{$ENDREGION}

end.
