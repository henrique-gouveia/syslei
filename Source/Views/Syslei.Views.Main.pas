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

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ToolWin,
  Vcl.ComCtrls,
  Vcl.ActnList,
  Vcl.ImgList;

type
  TMainView = class(TForm)
    Actions: TActionList;
    PessoaManager: TAction;
    toolBar: TToolBar;
    toolBarImages: TImageList;
    backgroundImage: TImage;
    pessoaManagerButton: TToolButton;
  end;

implementation

{$R *.dfm}

end.
