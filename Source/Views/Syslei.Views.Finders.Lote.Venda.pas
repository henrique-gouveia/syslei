unit Syslei.Views.Finders.Lote.Venda;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,

  Data.DB,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring,
  Spring.Container.Common;

type
  TVendaLoteFinderView = class(TBaseView)
    novoButton: TSpeedButton;
    okButton: TSpeedButton;
    sairButton: TSpeedButton;
    Executar: TAction;
    Novo: TAction;
    Ok: TAction;
    Sair: TAction;
    headerPanel: TPanel;
    compradorBox: TGroupBox;
    compradorNomeEdit: TEdit;
    compradorNomeLabel: TLabel;
    compradorCpfCnpjLabel: TLabel;
    compradorCpfCnpjMask: TMaskEdit;
    loteBox: TGroupBox;
    loteNumeroLabel: TLabel;
    loteNumeroEdit: TEdit;
    loteDescricaoLabel: TLabel;
    loteDescricaoEdit: TEdit;
    vendaBox: TGroupBox;
    vendaDataInicialLabel: TLabel;
    vendaDataInicialDtp: TDateTimePicker;
    vendaDataFinalLabel: TLabel;
    vendaDataFinalDtp: TDateTimePicker;
    dataGrid: TDBGrid;
    dataSource: TDataSource;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
    procedure OkExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  private
    FModelIdBind: TBinding;
    procedure ConfigureBind;
    function GetModelId: Integer;
  protected
    procedure ActiveChanged; override;
    procedure SetDataContext(const Value: TObject); override;
    procedure SourceChanged(Sender: TObject; const EventArgs: IPropertyChangedEventArgs);
  public
    [Inject(VENDA_LOTE_FINDER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
    property ModelId: Integer  read GetModelId;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TVendaLoteFinderView' }

procedure TVendaLoteFinderView.ActiveChanged;
begin
  inherited;
  bindings.GetBindingForTarget(Self).UpdateSource();
end;

procedure TVendaLoteFinderView.FormDestroy(Sender: TObject);
begin
  GlobalContainer.Release(DataContext);
end;

function TVendaLoteFinderView.GetModelId: Integer;
begin
  Result := dataSource.DataSet.FieldByName('Id').AsInteger;
end;

procedure TVendaLoteFinderView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TVendaLoteFinderView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'Filter.Comprador.Nome', compradorNomeEdit, 'Text');
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  binding := bindings.AddBinding(DataContext, 'Filter.Comprador.CpfCnpj', compradorCpfCnpjMask, 'Text');
  binding.SourceUpdateTrigger := utLostFocus;
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  binding := bindings.AddBinding(DataContext, 'Filter.Lote.Numero', loteNumeroEdit, 'Text');
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  binding := bindings.AddBinding(DataContext, 'Filter.Lote.Descricao', loteDescricaoEdit, 'Text');
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  binding := bindings.AddBinding(DataContext, 'Filter.DataInicialVenda', vendaDataInicialDtp, 'Date');
  binding.SourceUpdateTrigger := utLostFocus;
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  binding := bindings.AddBinding(DataContext, 'Filter.DataFinalVenda', vendaDataFinalDtp, 'Date');
  binding.SourceUpdateTrigger := utLostFocus;
  binding.NotifyOnSourceUpdated := True;
  binding.OnSourceUpdated := SourceChanged;

  FModelIdBind := bindings.AddBinding(DataContext, 'EntityId', Self, 'ModelId', bmOneWayToSource);
  FModelIdBind.SourceUpdateTrigger := utExplicit;

  bindings.AddBinding(DataContext, 'Entities', dataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME, [Self]));
end;

procedure TVendaLoteFinderView.SourceChanged(Sender: TObject; const EventArgs: IPropertyChangedEventArgs);
begin
  if Assigned(Executar.OnExecute) then
    Executar.Execute();
end;

procedure TVendaLoteFinderView.OkExecute(Sender: TObject);
begin
  inherited;
  if Assigned(dataSource.DataSet) and not dataSource.DataSet.IsEmpty() then
    ModalResult := mrOk;

  if (ModalResult = mrOk) then
    FModelIdBind.UpdateSource();
end;

procedure TVendaLoteFinderView.SairExecute(Sender: TObject);
begin
  inherited;
  Close();
end;

{$ENDREGION}

end.
