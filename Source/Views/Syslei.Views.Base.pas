unit Syslei.Views.Base;

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
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.ExtCtrls,
  Vcl.ImgList,

  Syslei.PresentationModel.View.VCLForm;

type
  TBaseView = class(TForm)
    actions: TActionList;
    images: TImageList;
    topPanel: TPanel;
    contentPanel: TPanel;
  end;

implementation

{$R *.dfm}

end.
