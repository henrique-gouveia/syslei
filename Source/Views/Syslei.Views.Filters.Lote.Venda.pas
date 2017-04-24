unit Syslei.Views.Filters.Lote.Venda;

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
  TVendaLoteFilterView = class(TFilterBaseView)
    Buscar: TAction;
    buscarButton: TSpeedButton;
    compradorGroup: TGroupBox;
    compradorIdEdit: TEdit;
    compradorNomeEdit: TEdit;
    tipoGroup: TRadioGroup;
    periodoCadastroGroup: TGroupBox;
    dataVendaInicialLabel: TLabel;
    dataVendaInicialDtp: TDateTimePicker;
    dataVendaFinalLabel: TLabel;
    dataVendaFinalDtp: TDateTimePicker;
    bindings: TBindingGroup;
    procedure FormDestroy(Sender: TObject);
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(VENDA_LOTE_FILTER_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  Spring.Container,
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts;

{$REGION 'TLoteFilterView' }

procedure TVendaLoteFilterView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TVendaLoteFilterView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TVendaLoteFilterView.ConfigureBind;
var
  binding: TBinding;
begin
  bindings.AddBinding(DataContext, 'ActiveControl', Self, 'ActiveControl', bmTwoWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [Self]));

  binding := bindings.AddBinding(DataContext, 'CompradorId', compradorIdEdit, 'Text', bmOneWayToSource);
  binding.SourceUpdateTrigger := utLostFocus;
  binding.UpdateSource();

  bindings.AddBinding(DataContext, 'Filter.Comprador.Id', compradorIdEdit, 'Text', bmOneWay);
  bindings.AddBinding(DataContext, 'Filter.Comprador.Nome', compradorNomeEdit, 'Text', bmOneWay);

  bindings.AddBinding(DataContext, 'Filter.Tipo', tipoGroup, 'ItemIndex');

  bindings.AddBinding(DataContext, 'Filter.DataVendaInicial', dataVendaInicialDtp, 'Date');
  bindings.AddBinding(DataContext, 'Filter.DataVendaFinal', dataVendaFinalDtp, 'Date');
end;

{$ENDREGION}

end.
