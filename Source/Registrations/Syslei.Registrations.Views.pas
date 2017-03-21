unit Syslei.Registrations.Views;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TViewsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,

  Syslei.Views.Main;

{$REGION 'TViewsRegiterType' }

procedure TViewsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TMainView>()
    .DelegateTo(
      function: TMainView
      begin
        Application.CreateForm(TMainView, Result);
      end);
end;

{$ENDREGION}

end.
