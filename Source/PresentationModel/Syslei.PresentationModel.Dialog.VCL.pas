{******************************************************************************}
{                                                                              }
{  Copyright (c) 2017, Henrique Gouveia                                        }
{                                                                              }
{  Redistribution and use in source and binary forms, with or without          }
{  modification, are permitted provided that the following conditions are met: }
{                                                                              }
{    1. Redistributions of source code must retain the above copyright notice, }
{    this list of conditions and the following disclaimer.                     }
{                                                                              }
{    2. Redistributions in binary form must reproduce the above copyright      }
{    notice, this list of conditions and the following disclaimer in the       }
{    documentation and/or other materials provided with the distribution.      }
{                                                                              }
{    3. Neither the name of the copyright holder nor the names of its          }
{    contributors may be used to endorse or promote products derived from      }
{    this software without specific prior written permission.                  }
{                                                                              }
{  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" }
{  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE   }
{  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  }
{  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE   }
{  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR         }
{  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF        }
{  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS    }
{  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     }
{  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)     }
{  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE  }
{  POSSIBILITY OF SUCH DAMAGE.                                                 }
{                                                                              }
{******************************************************************************}

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
