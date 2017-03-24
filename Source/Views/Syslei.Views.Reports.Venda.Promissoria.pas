unit Syslei.Views.Reports.Venda.Promissoria;

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
  RLReport,

  Syslei.PresentationModel.View.Interfaces,
  Syslei.PresentationModel.View.VCLForm;

type
  TPromissoriaVendaReportView = class(TForm, IReportPreview)
    report: TRLReport;
    reportDetailBand: TRLBand;
    numeroVendaPanel: TRLPanel;
    tituloPanel: TRLPanel;
    valorVendaPanel: TRLPanel;
    compradorPanel: TRLPanel;
    lotePanel: TRLPanel;
    emitentePanel: TRLPanel;
    codigoVendaLabel: TRLLabel;
    codigoVendaText: TRLDBText;
    tituloLabel: TRLLabel;
    valorLabel: TRLLabel;
    valorText: TRLDBText;
    compradorNomeLabel: TRLLabel;
    compradorCpfLabel: TRLLabel;
    compradorNomeText: TRLDBText;
    compradorCpfText: TRLDBText;
    loteNumeroLabel: TRLLabel;
    LoteDescricaoLabel: TRLLabel;
    LoteDescricaoText: TRLDBText;
    loteNumeroText: TRLDBText;
    loteAnimalPanel: TRLPanel;
    loteAnimalIdadeLabel: TRLLabel;
    loteAnimalSexoLabel: TRLLabel;
    loteAnimalIdadeText: TRLDBText;
    loteAnimalSexoText: TRLDBText;
    emitenteNomeLabel: TRLLabel;
    emitenteCpfLabel: TRLLabel;
    emitenteCpfText: TRLDBText;
    emitenteNomeText: TRLDBText;
    emitenteTelefoneLabel: TRLLabel;
    emitenteTelefoneText: TRLDBText;
    compradorTelefoneLabel: TRLLabel;
    compradorTelefoneText: TRLDBText;
    emitenteAssinaturaPanel: TRLPanel;
    emitenteAssinaturaNomeLabel: TRLLabel;
    emitenteAssinaturaLabel: TRLLabel;
    compradorAssinaturaPanel: TRLPanel;
    compradorAssinaturaNomeLabel: TRLLabel;
    compradorAssinaturaLabel: TRLLabel;
    procedure reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
  protected
    function Preview: Boolean;
    function PreviewModal: Boolean;
  end;

implementation

{$R *.dfm}

{$REGION 'TPromissoriaVendaReportView' }

procedure TPromissoriaVendaReportView.reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  report.DataSource.DataSet.Open();
end;

function TPromissoriaVendaReportView.Preview: Boolean;
begin
  Result := report.Preview();
end;

function TPromissoriaVendaReportView.PreviewModal: Boolean;
begin
  Result := report.PreviewModal();
end;

{$ENDREGION}

end.
