unit Syslei.Views.Reports.Lote.Venda;

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
  TVendaLoteReportView = class(TReportBaseView)
    compradorGroup: TRLGroup;
    compradorColumnHeaderBand: TRLBand;
    compradorIdLabel: TRLLabel;
    compradorIdText: TRLDBText;
    compradorNomeText: TRLDBText;
    vendaLoteGroup: TRLGroup;
    vendaLotesDetailBand: TRLBand;
    vendaIdLabel: TRLLabel;
    vendaIdText: TRLDBText;
    vendaDataLabel: TRLLabel;
    vendaDataText: TRLDBText;
    loteIdLabel: TRLLabel;
    loteNumeroLabel: TRLLabel;
    loteDescricaoLabel: TRLLabel;
    loteTipoLabel: TRLLabel;
    loteIdadeLabel: TRLLabel;
    loteSexoLabel: TRLLabel;
    vendaLanceArremateLabel: TRLLabel;
    loteIdText: TRLDBText;
    loteNumeroText: TRLDBText;
    loteDescricaoRichText: TRLDBRichText;
    loteTipoText: TRLDBText;
    loteIdadeText: TRLDBText;
    loteSexoText: TRLDBText;
    lanceArremateText: TRLDBText;
    summaryBand: TRLBand;
    totalLabel: TRLLabel;
    totalResult: TRLDBResult;
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
    [Inject(VENDA_LOTE_REPORT_VIEW_MODEL_NAME)]
    property DataContext: TObject read GetDataContext write SetDataContext;
  end;

implementation

{$R *.dfm}

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Spring.Container;

{$REGION 'TVendaLoteReportView' }

procedure TVendaLoteReportView.ControlTextBeforePrint(Sender: TObject; var Text: string; var PrintIt: Boolean);
begin
  inherited;
  PrintIt := dataSource.DataSet.FieldByName('LoteTipo').AsString = TIPO_LOTE_ANIMAL;
end;

procedure TVendaLoteReportView.FormDestroy(Sender: TObject);
begin
  GlobalContainer.Release(DataContext);
end;

procedure TVendaLoteReportView.SetDataContext(const Value: TObject);
begin
  inherited;
  ConfigureBind();
end;

procedure TVendaLoteReportView.ConfigureBind;
begin
  bindings.AddBinding(DataContext, 'Entities', dataSource, 'DataSet', bmOneWay,
    GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME, [Self]));
end;

{$ENDREGION}

end.
