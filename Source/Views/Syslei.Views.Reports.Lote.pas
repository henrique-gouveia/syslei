unit Syslei.Views.Reports.Lote;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,

  Data.DB,

  RLReport,
  RLRichText,

  Syslei.ViewModels.Consts,
  Syslei.Views.Base.Report,

  DSharp.Bindings,
  DSharp.Bindings.VCLControls,

  Spring.Container.Common;

type
  TLoteReportView = class(TReportBaseView)
    reportColumnHeaderBand: TRLBand;
    reportDetailBand: TRLBand;
    reportSummaryrBand: TRLBand;
    idLabel: TRLLabel;
    numeroLabel: TRLLabel;
    descricaoLabel: TRLLabel;
    tipoLabel: TRLLabel;
    idadeLabel: TRLLabel;
    sexoLabel: TRLLabel;
    lanceInicialLabel: TRLLabel;
    idText: TRLDBText;
    numeroText: TRLDBText;
    descricaoRichText: TRLDBRichText;
    tipoText: TRLDBText;
    idadeText: TRLDBText;
    sexoText: TRLDBText;
    lanceInicialSimpleResult: TRLDBResult;
    registrosCountLabel: TRLLabel;
    registrosCountResult: TRLDBResult;
    totalSumLabel: TRLLabel;
    totalSumResult: TRLDBResult;
    dataSource: TDataSource;
    bindings: TBindingGroup;
    procedure ControlTextBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
    procedure FormDestroy(Sender: TObject);
  private const
    TIPO_LOTE_ANIMAL = 'ANIMAL';
    TIPO_LOTE_IMOVEL = 'IMÓVEL';
  private
    procedure ConfigureBind;
  protected
    procedure SetDataContext(const Value: TObject); override;
  public
    [Inject(LOTE_REPORT_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Spring.Container;

{$REGION 'TLoteReportView' }

procedure TLoteReportView.ControlTextBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := dataSource.DataSet.FieldByName('Tipo').AsString = TIPO_LOTE_ANIMAL;
end;

procedure TLoteReportView.FormDestroy(Sender: TObject);
begin
  inherited;
  GlobalContainer.Release(DataContext);
end;

procedure TLoteReportView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TLoteReportView.ConfigureBind;
begin
  bindings.AddBinding(DataContext, 'Entities', dataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME, [Self]));
end;

{$ENDREGION}

end.
