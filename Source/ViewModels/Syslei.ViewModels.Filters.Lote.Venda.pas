unit Syslei.ViewModels.Filters.Lote.Venda;

interface

uses
  Syslei.Models.Domains.Lote.Venda.Filter,

  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa,

  Syslei.Models.Finders.Interfaces,

  Syslei.ViewModels.Base.Filter,

  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TVendaLoteFilterViewModel = class(TFilterViewModelBase<TVendaLote, TVendaLoteFilterReport>)
  private const
    COMPRADOR_ID_CONTROL_NAME = 'compradorIdEdit';
  private
    FCompradorId: Integer;
    [Inject]
    FCompradorRepository: IPagedRepository<TPessoa, Integer>;
    procedure SetCompradorId(const Value: Integer);
  public
    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject);
    procedure Ok(Sender: TObject); override;

    property CompradorId: Integer read FCompradorId write SetCompradorId;
  end;

implementation

uses
  Syslei.ViewModels.Base.Finder,
  Syslei.ViewModels.Base.Report,

  Syslei.Views.Consts,

  Syslei.PresentationModel.Dialog,
  Syslei.PresentationModel.View.Interfaces,

  Spring.Container;

{$REGION 'TLoteFilterViewModel' }

procedure TVendaLoteFilterViewModel.Novo(Sender: TObject);
begin
  inherited;
  CompradorId := 0;
end;

procedure TVendaLoteFilterViewModel.Buscar(Sender: TObject);
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
      CompradorId := finderViewModel.Entity.Id;
      ActiveControl := COMPRADOR_ID_CONTROL_NAME;
    end;
  end;
end;

procedure TVendaLoteFilterViewModel.Ok(Sender: TObject);
var
  reportPreview: IReportPreview;
begin
  inherited;
  reportPreview := GlobalContainer.Resolve<IReportPreview>(VENDA_LOTE_REPORT_VIEW_NAME);
  if Assigned(reportPreview) and (reportPreview.GetDataContext() is TReportViewModelBase)  then
  begin
    TReportViewModelBase(reportPreview.GetDataContext()).Entities := Entities;
    reportPreview.PreviewModal();
  end;
end;

procedure TVendaLoteFilterViewModel.SetCompradorId(const Value: Integer);
begin
  if (FCompradorId <> Value) then
  begin
    FCompradorId := Value;
    Filter.Comprador := FCompradorRepository.FindOne(FCompradorId);
    DoPropertyChanged('Filter');
  end;
end;

{$ENDREGION}

end.
