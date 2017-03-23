unit Syslei.ViewModels.Main;

interface

type
  TMainViewModel = class
  private
    procedure InternalShowModalView(const serviceName: String);
  public
    procedure LoteManager(Sender: TObject);
    procedure PessoaManager(Sender: TObject);
  end;

implementation

uses
  Syslei.PresentationModel.View.Interfaces,
  Syslei.Views.Consts,

  Spring.Container;


{$REGION 'TMainViewModel' }

procedure TMainViewModel.LoteManager(Sender: TObject);
begin
  InternalShowModalView(LOTE_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.PessoaManager(Sender: TObject);
begin
  InternalShowModalView(PESSOA_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.InternalShowModalView(const serviceName: String);
var
  view: IView;
begin
  view := GlobalContainer.Resolve<IView>(serviceName);
  view.ShowModalView();
end;

{$ENDREGION}

end.