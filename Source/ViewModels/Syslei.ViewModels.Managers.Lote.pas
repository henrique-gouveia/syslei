unit Syslei.ViewModels.Managers.Lote;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,
  Syslei.ViewModels.Base.Manager,

  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TLoteManagerViewModel = class(TManagerViewModelBase<TLote>)
  private const
    ID_CONTROL_NAME = 'idEdit';
    DOADOR_ID_CONTROL_NAME = 'doadorIdEdit';
    DESCRICAO_CONTROL_NAME = 'descricaoEdit';
    NUMERO_CONTROL_NAME = 'numeroLoteEdit';
  private
    FDoador: TPessoa;
    FDoadorId: Integer;
    [Inject]
    FDoadorRepository: IPagedRepository<TPessoa, Integer>;

    function GetIsAnimalLote: Boolean;
    procedure SetDoador(const Value: TPessoa);
    procedure SetDoadorId(const Value: Integer);
    procedure SetTipoLote(const Value: TTipoLote);
  protected
    procedure SetEntityId(const Value: Integer); override;
    function Validate: Boolean; override;
  public
    destructor Destroy; override;

    procedure Novo(Sender: TObject); override;
    procedure Buscar(Sender: TObject); override;

    property Doador: TPessoa read FDoador write SetDoador;
    property DoadorId: Integer read FDoadorId write SetDoadorId;

    property IsAnimalLote: Boolean read GetIsAnimalLote;
    property TipoLote: TTipoLote write SetTipoLote;
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

{$REGION 'TLoteManagerViewModel' }

destructor TLoteManagerViewModel.Destroy;
begin
  FreeAndNil(FDoador);
  inherited;
end;

procedure TLoteManagerViewModel.Novo(Sender: TObject);
begin
  inherited;
  Doador := TPessoa.Create;
  DoadorId := 0;

  ActiveControl := ID_CONTROL_NAME;
end;

procedure TLoteManagerViewModel.Buscar(Sender: TObject);
var
  view: IView;
  {$REGION 'ShowFinderViews'}
  procedure ShowDoadorFinderView;
  var
    doadorfinderViewModel: TFinderViewModelBase<TPessoa>;
  begin
    view := GlobalContainer.Resolve<IView>(PESSOA_FINDER_VIEW_NAME);
    if Assigned(view) and (view.ShowModalView() = mrOk) then
    begin
      if view.GetDataContext() is TFinderViewModelBase<TPessoa> then
      begin
        doadorFinderViewModel := TFinderViewModelBase<TPessoa>(view.GetDataContext());
        DoadorId := doadorFinderViewModel.Entity.Id;
        ActiveControl := DOADOR_ID_CONTROL_NAME;
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
        EntityId := lotefinderViewModel.Entity.Id;
        ActiveControl := ID_CONTROL_NAME;
      end;
    end;
  end;
  {$ENDREGION}
begin
  inherited;
  if ActiveControl.Equals(DOADOR_ID_CONTROL_NAME) then
    ShowDoadorFinderView()
  else
    ShowLoteFinderView();
end;

function TLoteManagerViewModel.GetIsAnimalLote: Boolean;
begin
  Result := Entity.IsAnimal;
end;

procedure TLoteManagerViewModel.SetDoador(const Value: TPessoa);
begin
  if Assigned(Value) then
  begin
    if Assigned(FDoador) then
      FreeAndNil(FDoador);

    FDoador := Value;
  end;
  if Assigned(FDoador) then
    DoPropertyChanged('Doador');
end;

procedure TLoteManagerViewModel.SetDoadorId(const Value: Integer);
begin
  if (FDoadorId <> Value) then
  begin
    FDoadorId := Value;
    Doador := FDoadorRepository.FindOne(FDoadorId);
  end;
end;

procedure TLoteManagerViewModel.SetEntityId(const Value: Integer);
begin
  inherited;
  if (DoadorId <> Entity.DoadorId) then
    DoadorId := Entity.DoadorId;
end;

procedure TLoteManagerViewModel.SetTipoLote(const Value: TTipoLote);
begin
  DoPropertyChanged('IsAnimalLote');
end;

function TLoteManagerViewModel.Validate: Boolean;
begin
  Result := True;

  if (Entity.Numero.IsEmpty()) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Número do Lote']));
    ActiveControl := NUMERO_CONTROL_NAME;
    Exit(False);
  end;

  if (Entity.Descricao.IsEmpty()) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Descrição']));
    ActiveControl := DESCRICAO_CONTROL_NAME;
    Exit(False);
  end;

  if (Entity.DoadorId = 0) then
  begin
    Dialog.ShowWarningMessage(Format(SCampoObrigatorio, ['Doador']));
    ActiveControl := DOADOR_ID_CONTROL_NAME;
    Exit(False);
  end;
end;

{$ENDREGION}

end.
