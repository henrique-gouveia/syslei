unit Syslei.Views.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.UITypes,
  Vcl.Imaging.pngimage,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.ComCtrls,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Menus,

  RLXLSXFilter,
  RLXLSFilter,
  RLPDFFilter,
  RLHTMLFilter,
  RLFilters,
  RLRichFilter;

type
  TMainView = class(TForm)
    Actions: TActionList;
    ProprioManager: TAction;
    PessoaManager: TAction;
    LoteManager: TAction;
    LoteReport: TAction;
    VendaLoteManager: TAction;
    VendaLoteReport: TAction;
    Sair: TAction;
    toolBar: TToolBar;
    toolBarImages: TImageList;
    backgroundImage: TImage;
    logoImage: TImage;
    proprioManagerButton: TToolButton;
    pessoaManagerButton: TToolButton;
    loteManagerButton: TToolButton;
    separador1: TToolButton;
    vendaLoteManagerButton: TToolButton;
    separador2: TToolButton;
    sairButton: TToolButton;
    loteMenu: TPopupMenu;
    loteManagerMenuItem: TMenuItem;
    loteReportMenuItem: TMenuItem;
    vendaLoteMenu: TPopupMenu;
    vendaLoteManagerMenuItem: TMenuItem;
    vendaLoteReportMenuItem: TMenuItem;
    richFilter: TRLRichFilter;
    htmlFilter: TRLHTMLFilter;
    pdfFilter: TRLPDFFilter;
    xlsFilter: TRLXLSFilter;
    xlsxFilter: TRLXLSXFilter;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TMainView.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Deseja realmente fechar o sistema ?', mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TMainView.SairExecute(Sender: TObject);
begin
  Close;
end;

end.
