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

  Syslei.Views.Consts,
  Syslei.Views.Main,
  Syslei.Views.Managers.Pessoa,

  Syslei.ViewModels.Consts,

  Syslei.PresentationModel.View.Interfaces,
  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.Dialog.VCL,

  DSharp.PresentationModel.ViewModelBinder,
  DSharp.PresentationModel.VCLConventionManager;

{$REGION 'TViewsRegiterType' }

procedure TViewsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IDialog, TVCLDialogAdapter>();

  container
    .RegisterType<TMainView>()
    .DelegateTo(
      function: TMainView
      begin
        Application.CreateForm(TMainView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(MAIN_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaManagerView>(PESSOA_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaManagerView
      begin
        Application.CreateForm(TPessoaManagerView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME), Result);
      end);
end;

{$ENDREGION}

end.
