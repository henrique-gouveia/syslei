unit Syslei.ViewModels.Main;

interface

type
  TMainViewModel = class
  private
    procedure InternalShowModalView(const serviceName: String);
  public
    procedure LoteManager(Sender: TObject);
    procedure LoteReport(Sender: TObject);
    procedure PessoaManager(Sender: TObject);
    procedure ProprioManager(Sender: TObject);
    procedure VendaLoteManager(Sender: TObject);
    procedure VendaLoteReport(Sender: TObject);
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

procedure TMainViewModel.LoteReport(Sender: TObject);
begin
  InternalShowModalView(LOTE_FILTER_VIEW_NAME);
end;

procedure TMainViewModel.PessoaManager(Sender: TObject);
begin
  InternalShowModalView(PESSOA_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.ProprioManager(Sender: TObject);
begin
  InternalShowModalView(PROPRIO_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.VendaLoteManager(Sender: TObject);
begin
  InternalShowModalView(VENDA_LOTE_MANAGER_VIEW_NAME);
end;

procedure TMainViewModel.VendaLoteReport(Sender: TObject);
begin
  InternalShowModalView(VENDA_LOTE_FILTER_VIEW_NAME);
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
