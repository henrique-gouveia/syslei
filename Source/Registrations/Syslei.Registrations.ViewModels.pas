unit Syslei.Registrations.ViewModels;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TViewModelsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Syslei.ViewModels.Consts,
  Syslei.ViewModels.Main,
  Syslei.ViewModels.Finders.Lote,
  Syslei.ViewModels.Finders.Pessoa,
  Syslei.ViewModels.Managers.Lote,
  Syslei.ViewModels.Managers.Lote.Venda,
  Syslei.ViewModels.Managers.Pessoa;

{$REGION 'TViewModelsRegiterType' }

procedure TViewModelsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TObject, TMainViewModel>(MAIN_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TLoteFinderViewModel>(LOTE_FINDER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TLoteManagerViewModel>(LOTE_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TPessoaFinderViewModel>(PESSOA_FINDER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TPessoaManagerViewModel>(PESSOA_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();

  container
    .RegisterType<TObject, TVendaLoteManagerViewModel>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME)
    .AsSingleton();
end;

{$ENDREGION}

end.
