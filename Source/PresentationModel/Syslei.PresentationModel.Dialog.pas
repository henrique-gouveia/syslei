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

unit Syslei.PresentationModel.Dialog;

interface

uses
  System.UITypes;

type
  TModalResult = System.UITypes.TModalResult;
  TDialogAction = reference to procedure(const result: TModalResult);

  IDialog = interface
  ['{203AD4EB-CE78-496B-9FD8-BC3058EA3AAF}']
    procedure ShowConfirmationMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
    procedure ShowErrorMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
    procedure ShowInformationMessage(const msg: String;
      const dialogAction: TDialogAction =  nil);
    procedure ShowWarningMessage(const msg: String;
      const dialogAction: TDialogAction = nil);
  end;

const
  mrNone = System.UITypes.mrNone;
  mrOk = System.UITypes.mrOk;
  mrCancel = System.UITypes.mrCancel;
  mrAbort = System.UITypes.mrAbort;
  mrRetry = System.UITypes.mrRetry;
  mrIgnore = System.UITypes.mrIgnore;
  mrYes = System.UITypes.mrYes;
  mrNo = System.UITypes.mrNo;
  mrClose = System.UITypes.mrClose;
  mrHelp = System.UITypes.mrHelp;
  mrTryAgain = System.UITypes.mrTryAgain;
  mrContinue = System.UITypes.mrContinue;
  mrAll = System.UITypes.mrAll;
  mrNoToAll = System.UITypes.mrNoToAll;
  mrYesToAll = System.UITypes.mrYesToAll;

implementation

end.
