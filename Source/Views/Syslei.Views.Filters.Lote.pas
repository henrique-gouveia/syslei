unit Syslei.Views.Filters.Lote;

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
  Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,

  Vcl.Grids,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Filter,

  DSharp.Bindings.VCLControls,
  DSharp.Bindings,

  Spring,
  Spring.Container.Common;

type
  TLoteFilterView = class(TFilterBaseView)
    Buscar: TAction;
    buscarButton: TSpeedButton;
    doadorGroup: TGroupBox;
    doadorIdEdit: TEdit;
    doadorNomeEdit: TEdit;
    statusGroup: TRadioGroup;
    tipoGroup: TRadioGroup;
    periodoCadastroGroup: TGroupBox;
    dataInicialCadastroLabel: TLabel;
    dataInicialCadastroDtp: TDateTimePicker;
    dataFinalCadastroLabel: TLabel;
    dataFinalCadastroDtp: TDateTimePicker;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_FILTER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TLoteFilterView' }

procedure TLoteFilterView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TLoteFilterView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteFilterView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'DoadorId', doadorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  binding.UpdateSource();

  bindings.AddBinding(DataContext, 'Filter.Doador.Id', doadorIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Filter.Doador.Nome', doadorNomeEdit, 'Text', bmOneWay);

  bindings.AddBinding(DataContext, 'Filter.Status', statusGroup, 'ItemIndex');
  bindings.AddBinding(DataContext, 'Filter.Tipo', tipoGroup, 'ItemIndex');

  bindings.AddBinding(DataContext, 'Filter.DataInicialCadastro', dataInicialCadastroDtp, 'Date');
  bindings.AddBinding(DataContext, 'Filter.DataFinalCadastro', dataFinalCadastroDtp, 'Date');
end;

{$ENDREGION}

end.
