unit Syslei.Views.Base.Manager;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.Actions,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,

  Vcl.ActnList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ImgList,

  Syslei.Views.Base;

type
  TManagerBaseView = class(TBaseView)
    novoButton: TSpeedButton;
    excluirButton: TSpeedButton;
    gravarButton: TSpeedButton;
    buscarButton: TSpeedButton;
    sairButton: TSpeedButton;
    Novo: TAction;
    Gravar: TAction;
    Excluir: TAction;
    Buscar: TAction;
    Sair: TAction;
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TManagerBaseView.SairExecute(Sender: TObject);
begin
  inherited;
  Close();
end;

end.
