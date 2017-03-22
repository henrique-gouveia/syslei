unit Syslei.Registrations.Conversions;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TConversionsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Syslei.Conversions.ControlString;

{$REGION 'TConversionsRegiterType' }

procedure TConversionsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TControlStringConverter>(CONVERSION_CONTROL_STRING_NAME);
end;

{$ENDREGION}

end.
