unit Syslei.PresentationModel.Dialog.VCL;

interface

uses
  System.UITypes,
  Syslei.PresentationModel.Dialog;

type
  TVCLDialogAdapter = class(TInterfacedObject, IDialog)
  private
    procedure ShowDialogMessage(const msg: string; const dialogType: TMsgDlgType;
      const dialogAction: TDialogAction = nil; const buttons: TMsgDlgButtons = [TMsgDlgBtn.mbOK];
      const helpContext: LongInt = 0);
  public
    procedure ShowConfirmationMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
    procedure ShowErrorMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
    procedure ShowInformationMessage(const msg: String;
      const dialogAction: TDialogAction =  nil);
    procedure ShowWarningMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
  end;

implementation

uses
  System.SysUtils,
  Vcl.Dialogs;

{$REGION 'IFMXDialogAdapter' }

procedure TVCLDialogAdapter.ShowConfirmationMessage(const msg: String; const dialogAction: TDialogAction);
begin
  ShowDialogMessage(msg, TMsgDlgType.mtConfirmation, dialogAction,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo]);
end;

procedure TVCLDialogAdapter.ShowErrorMessage(const msg: String; const dialogAction: TDialogAction);
begin
  ShowDialogMessage(msg, TMsgDlgType.mtError, dialogAction);
end;

procedure TVCLDialogAdapter.ShowInformationMessage(const msg: String; const dialogAction: TDialogAction);
begin
  ShowDialogMessage(msg, TMsgDlgType.mtInformation, dialogAction);
end;

procedure TVCLDialogAdapter.ShowWarningMessage(const msg: String; const dialogAction: TDialogAction);
begin
  ShowDialogMessage(msg, TMsgDlgType.mtWarning);
end;

procedure TVCLDialogAdapter.ShowDialogMessage(const msg: string; const dialogType: TMsgDlgType;
  const dialogAction: TDialogAction; const buttons: TMsgDlgButtons; const helpContext: Integer);
var
  result: Integer;
begin
  result := MessageDlg(msg, dialogType, buttons, helpContext);
  if Assigned(dialogAction) then
    dialogAction(result);
end;

{$ENDREGION}

end.
