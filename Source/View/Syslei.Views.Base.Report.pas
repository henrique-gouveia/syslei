unit Syslei.Views.Base.Report;

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

  Syslei.PresentationMode.Views.Interfaces,
  Syslei.PresentationMode.Views.Vcl.Forms;

type
  TReportBaseView = class(TForm, IReportPreview)
    report: TRLReport;
    reportHeaderBand: TRLBand;
    reportHeaderTitleLabel: TRLLabel;
    reportHeaderPageSystemInfo: TRLSystemInfo;
    reportHeaderPageLabel: TRLLabel;
    reportFooterBand: TRLBand;
    reportFooterInfoLabel: TRLLabel;
    procedure reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
  protected
    function Preview: Boolean;
    function PreviewModal: Boolean;
  end;

implementation

{$R *.dfm}

{$REGION 'TReportBaseView' }

procedure TReportBaseView.reportBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  report.DataSource.DataSet.Open();
end;

function TReportBaseView.Preview: Boolean;
begin
  Result := report.Preview();
end;

function TReportBaseView.PreviewModal: Boolean;
begin
  Result := report.PreviewModal();
end;

{$ENDREGION}

end.
