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

  Syslei.Views.Base;

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
  end;

var
  FinderBaseView: TFinderBaseView;

implementation

{$R *.dfm}

end.
