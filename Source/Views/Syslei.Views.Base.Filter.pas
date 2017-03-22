unit Syslei.Views.Base.Filter;

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

  Syslei.Views.Base;

type
  TFilterBaseView = class(TBaseView)
    novoButton: TSpeedButton;
    okButton: TSpeedButton;
    sairButton: TSpeedButton;
    Novo: TAction;
    Ok: TAction;
    Sair: TAction;
    procedure SairExecute(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFilterBaseView.SairExecute(Sender: TObject);
begin
  inherited;
  Close();
end;

end.
