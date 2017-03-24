unit Syslei.ViewModels.Managers.Lote.Venda;

interface

uses

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager,

  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TVendaLoteManagerViewModel = class(TManagerViewModelBase<TVendaLote>)
  private const
    ID_CONTROL_NAME = 'idEdit';
    COMPRADOR_ID_CONTROL_NAME = 'compradorIdEdit';
    LOTE_ID_CONTROL_NAME = 'loteIdEdit';
  private
    FComprador: TPessoa;
    FCompradorId: Integer;
    FLote: TLote;
    FLoteId: Integer;
    [Inject]
    FCompradorRepository: IPagedRepository<TPessoa, Integer>;
    [Inject]
    FLoteRepository: IPagedRepository<TLote, Integer>;

    procedure SetComprador(const Value: TPessoa);
    procedure SetCompradorId(const Value: Integer);
    procedure SetLote(const Value: TLote);
    procedure SetLoteId(const Value: Integer);
  protected
    procedure SetEntityId(const Value: Integer); override;
    function Validate: Boolean; override;
  public
    destructor Destroy; override;

    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;

    property Comprador: TPessoa read FComprador write SetComprador;
    property CompradorId: Integer read FCompradorId write SetCompradorId;
    property Lote: TLote read FLote write SetLote;
    property LoteId: Integer read FLoteId write SetLoteId;
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

{$REGION 'TVendaLoteManagerViewModel' }

destructor TVendaLoteManagerViewModel.Destroy;
begin
  FreeAndNil(FComprador);
  FreeAndNil(FLote);
  inherited;
end;

procedure TVendaLoteManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  Comprador := TPessoa.Create;
  CompradorId := 0;
  Lote := TLote.Create;
  LoteId := 0;

  ActiveControl := ID_CONTROL_NAME;
end;

procedure TVendaLoteManagerViewModel.Buscar(Sender: TObject);
var
  view: IView;
  {$REGION 'ShowFinderViews'}
  procedure ShowCompradorFinderView;
  var
    compradorfinderViewModel: TFinderViewModelBase<TPessoa>;
  begin
    view := GlobalContainer.Resolve<IView>(PESSOA_FINDER_VIEW_NAME);
    if Assigned(view) and (view.ShowModalView() = mrOk) then
    begin
      if view.GetDataContext() is TFinderViewModelBase<TPessoa> then
      begin
        compradorfinderViewModel := TFinderViewModelBase<TPessoa>(view.GetDataContext());
        CompradorId := compradorfinderViewModel.Entity.Id;
        ActiveControl := COMPRADOR_ID_CONTROL_NAME;
      end;
    end;
  end;

  procedure ShowLoteFinderView;
  var
    lotefinderViewModel: TFinderViewModelBase<TLote>;
  begin
    view := GlobalContainer.Resolve<IView>(LOTE_FINDER_VIEW_NAME);
    if Assigned(view) and (view.ShowModalView() = mrOk) then
    begin
      if view.GetDataContext() is TFinderViewModelBase<TLote> then
      begin
        lotefinderViewModel := TFinderViewModelBase<TLote>(view.GetDataContext());
        LoteId := lotefinderViewModel.Entity.Id;
        ActiveControl := LOTE_ID_CONTROL_NAME;
      end;
    end;
  end;
  {$ENDREGION}
begin
  inherited;
  if ActiveControl.Equals(COMPRADOR_ID_CONTROL_NAME) then
    ShowCompradorFinderView()
  else if ActiveControl.Equals(LOTE_ID_CONTROL_NAME) then
    ShowLoteFinderView();
end;

procedure TVendaLoteManagerViewModel.SetComprador(const Value: TPessoa);
begin
  if Assigned(Value) then
  begin
    if Assigned(FComprador) then
      FreeAndNil(FComprador);

    FComprador := Value;
  end;
  if Assigned(FComprador) then
    DoPropertyChanged('Comprador');
end;

procedure TVendaLoteManagerViewModel.SetCompradorId(const Value: Integer);
begin
  if (FCompradorId <> Value) then
  begin
    FCompradorId := Value;
    Comprador := FCompradorRepository.FindOne(FCompradorId);
  end;
end;

procedure TVendaLoteManagerViewModel.SetLote(const Value: TLote);
begin
  if Assigned(Value) then
  begin
    if Assigned(FLote) then
      FreeAndNil(FLote);

    FLote := Value;
  end;

  if Assigned(FLote) then
    DoPropertyChanged('Lote');
end;

procedure TVendaLoteManagerViewModel.SetLoteId(const Value: Integer);
begin
  if (FLoteId <> Value) then
  begin
    FLoteId := Value;
    Lote := FLoteRepository.FindOne(FLoteId);
  end;
end;

procedure TVendaLoteManagerViewModel.SetEntityId(const Value: Integer);
begin
  inherited;
  if (CompradorId <> Entity.CompradorId) then
    CompradorId := Entity.CompradorId;

  if (LoteId <> Entity.LoteId) then
    LoteId := Entity.LoteId;
end;

function TVendaLoteManagerViewModel.Validate: Boolean;
begin
  Result := True;

  if (Entity.CompradorId = 0) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Comprador']));
    ActiveControl := COMPRADOR_ID_CONTROL_NAME;
    Exit(False);
  end;

  if (Entity.LoteId = 0) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Lote']));
    ActiveControl := LOTE_ID_CONTROL_NAME;
    Exit(False);
  end;
end;

{$ENDREGION}

end.
