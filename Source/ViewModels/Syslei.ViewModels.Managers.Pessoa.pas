unit Syslei.ViewModels.Managers.Pessoa;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager;

type
  TPessoaManagerViewModel = class(TManagerViewModelBase<TPessoa>)
  private const
    ID_CONTROL_NAME = 'idEdit';
    NOME_CONTROL_NAME = 'nomeEdit';
  protected
    function Validate: Boolean; override;
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;
  end;

implementation

uses
  System.SysUtils,

  Syslei.ViewModels.Base.Finder,
  Syslei.Views.Consts,
  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.ResourceStrings,
  Syslei.PresentationModel.View.Interfaces,

  Spring.Container;

{$REGION 'TPessoaManagerViewModel' }

procedure TPessoaManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  ActiveControl := ID_CONTROL_NAME;
end;

procedure TPessoaManagerViewModel.Buscar(Sender: TObject);
var
  view: IView;
  finderViewModel: TFinderViewModelBase<TPessoa>;
begin
  inherited;
  view := GlobalContainer.Resolve<IView>(PESSOA_FINDER_VIEW_NAME);
  if Assigned(view) and (view.ShowModalView() = mrOk) then
  begin
    if view.GetDataContext() is TFinderViewModelBase<TPessoa> then
    begin
      finderViewModel := TFinderViewModelBase<TPessoa>(view.GetDataContext());
      EntityId := finderViewModel.Entity.Id;
      ActiveControl := ID_CONTROL_NAME;
    end;
  end;
end;

function TPessoaManagerViewModel.Validate: Boolean;
begin
  Result := True;

  if (Entity.Nome.IsEmpty()) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Nome']));
    ActiveControl := NOME_CONTROL_NAME;
    Exit(False);
  end;
end;

{$ENDREGION}

end.
