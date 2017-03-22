unit Syslei.Views.Base.Finder;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
  Vcl.StdCtrls,

  Data.DB,

  Syslei.Views.Base,
  DSharp.Bindings.VCLControls;

type
  TFinderBaseView = class(TBaseView)
    novoButton: TSpeedButton;
    avulsaButton: TSpeedButton;
    inicialButton: TSpeedButton;
    exataButton: TSpeedButton;
    okButton: TSpeedButton;
    sairButton: TSpeedButton;
    headerPanel: TPanel;
    propertyNameBox: TGroupBox;
    propertyNameCombo: TComboBox;
    propertyValueBox: TGroupBox;
    propertyValueEdit: TEdit;
    dataGrid: TDBGrid;
    dataSource: TDataSource;
    Novo: TAction;
    Avulsa: TAction;
    Inicial: TAction;
    Exata: TAction;
    Ok: TAction;
    Sair: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OkExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFinderBaseView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  dataSource.DataSet.Close;
end;

procedure TFinderBaseView.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(dataSource.DataSet) then
    dataSource.DataSet.Open;
end;

procedure TFinderBaseView.OkExecute(Sender: TObject);
begin
  inherited;
  if Assigned(dataSource.DataSet) and not dataSource.DataSet.IsEmpty() then
    ModalResult := mrOk;
end;

procedure TFinderBaseView.SairExecute(Sender: TObject);
begin
  inherited;
  Close();
end;

end.
