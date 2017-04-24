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

unit Syslei.PresentationModel.View.VCLForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  Vcl.Forms,
  Syslei.PresentationModel.View.Interfaces;

type
  TForm = class(Vcl.Forms.TForm, IView)
  private
    FDataContext: TObject;
    FRefCount: Integer;
  protected
    // IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // IDataContextable
    function GetDataContext: TObject; virtual;
    procedure SetDataContext(const value: TObject); virtual;

    // IView
    procedure ShowView;
    function ShowModalView: Integer;

    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create; reintroduce; overload; virtual;
    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;
  end;
implementation

{$REGION 'TForm' }

constructor TForm.Create;
begin
  inherited Create(nil);
end;

class function TForm.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TForm(Result).FRefCount := 1;
end;

procedure TForm.AfterConstruction;
begin
  Dec(FRefCount);
end;

function TForm.GetDataContext: TObject;
begin
  Result := FDataContext;
end;

procedure TForm.SetDataContext(const value: TObject);
begin
  FDataContext := value;
end;

procedure TForm.ShowView;
begin
  Show;
end;

function TForm.ShowModalView: Integer;
begin
  Result := ShowModal;
end;

procedure TForm.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg in [WM_SETCURSOR, WM_SETFOCUS]) then
    ActiveChanged;
end;

function TForm._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TForm._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Destroy;
end;

{$ENDREGION}

end.
