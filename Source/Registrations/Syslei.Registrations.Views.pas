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
  Syslei.Views.Finders.Lote,
  Syslei.Views.Finders.Lote.Venda,
  Syslei.Views.Finders.Pessoa,
  Syslei.Views.Managers.Lote,
  Syslei.Views.Managers.Lote.Venda,
  Syslei.Views.Managers.Pessoa,
  Syslei.Views.Reports.Lote.Venda.Promissoria,

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
    .RegisterType<TLoteFinderView>(LOTE_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TLoteFinderView
      begin
        Application.CreateForm(TLoteFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(LOTE_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TLoteManagerView>(LOTE_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TLoteManagerView
      begin
        Application.CreateForm(TLoteManagerView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(LOTE_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaFinderView>(PESSOA_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaFinderView
      begin
        Application.CreateForm(TPessoaFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(PESSOA_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaManagerView>(PESSOA_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaManagerView
      var
        dataContext: TObject;
      begin
        dataContext := container.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME);
        Application.CreateForm(TPessoaManagerView, Result);

        Result.DataContext := dataContext;
        Result.Caption := 'Gerenciar Pessoa';

        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPessoaManagerView>(PROPRIO_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TPessoaManagerView
      var
        dataContext: TObject;
      begin
        dataContext := container.Resolve<TObject>(PROPRIO_MANAGER_VIEW_MODEL_NAME);
        Application.CreateForm(TPessoaManagerView, Result);

        Result.DataContext := dataContext;
        Result.Caption := 'Gerenciar Pr�prio';

        // connect controls to viewmodel properties
        ViewModelBinder.Bind(dataContext, Result);
      end);

  container
    .RegisterType<TVendaLoteFinderView>(VENDA_LOTE_FINDER_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteFinderView
      begin
        Application.CreateForm(TVendaLoteFinderView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(VENDA_LOTE_FINDER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TVendaLoteManagerView>(VENDA_LOTE_MANAGER_VIEW_NAME)
    .DelegateTo(
      function: TVendaLoteManagerView
      begin
        Application.CreateForm(TVendaLoteManagerView, Result);
        // connect controls to viewmodel properties
        ViewModelBinder.Bind(container.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME), Result);
      end);

  container
    .RegisterType<TPromissoriaVendaLoteReportView>(PROMISSORIA_VENDA_LOTE_REPORT_VIEW_NAME)
    .DelegateTo(
      function: TPromissoriaVendaLoteReportView
      begin
        Application.CreateForm(TPromissoriaVendaLoteReportView, Result);
      end);
end;

{$ENDREGION}

end.
