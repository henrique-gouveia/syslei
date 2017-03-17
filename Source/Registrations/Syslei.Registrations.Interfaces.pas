unit Syslei.Registrations.Interfaces;

interface

type
  IRegisterType<T: class, constructor> = interface
    ['{AA692DEC-38EF-4045-BA45-04AA3E28B0F7}']
    procedure RegistryType(const container: T);
  end;

  IRegisterTypeExecutor<T: class, constructor> = interface
    ['{FC90826A-140F-48D6-AA85-F6268E32A3ED}']
    procedure Execute;
    procedure AddRegister(const registerType: IRegisterType<T>);
  end;

implementation

end.
