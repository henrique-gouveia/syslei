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

unit Syslei.ViewModels.Base;

interface

uses
  System.Classes,
  Syslei.PresentationModel.Dialog,

  DSharp.Bindings.Notifications,

  Spring,
  Spring.Container.Common,
  Spring.Collections;

type
  TViewModelBase = class(TComponent, IInterface, INotifyPropertyChanged)
  private
    FActiveControl: String;
    [Inject]
    FDialog: IDialog;

    FPropertyChanged: Event<TPropertyChangedEvent>;
    FRefCount: Integer;
  protected
    // IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // INotifyPropertyChanged
    procedure DoPropertyChanged(const propertyName: string;
      updateTrigger: TUpdateTrigger = utPropertyChanged); virtual;
    function GetOnPropertyChanged: IPropertyChangedEvent; virtual;

    procedure SetActiveControl(const Value: String); virtual;
    function Validate: Boolean; virtual;

    property Dialog: IDialog read FDialog;
  public
    constructor Create; reintroduce; overload; virtual;

    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;

    property ActiveControl: String read FActiveControl write SetActiveControl;
  end;

implementation

{$REGION 'TViewModelBase' }

constructor TViewModelBase.Create;
begin
  Create(nil);
end;

class function TViewModelBase.NewInstance: TObject;
var
  interfaceTable: PInterfaceTable;
begin
  Result := inherited NewInstance;
  interfaceTable := Result.GetInterfaceTable;
  if Assigned(interfaceTable) and (interfaceTable.EntryCount > 0) then
    TViewModelBase(Result).FRefCount := 1
  else
    TViewModelBase(Result).FRefCount := 2;
end;

procedure TViewModelBase.AfterConstruction;
begin
  Dec(FRefCount);
end;

procedure TViewModelBase.DoPropertyChanged(const propertyName: string;
  updateTrigger: TUpdateTrigger);
begin
  FPropertyChanged.Invoke(Self, TPropertyChangedEventArgsEx.Create(propertyName,
    utPropertyChanged) as IPropertyChangedEventArgs);
end;

function TViewModelBase.GetOnPropertyChanged: IPropertyChangedEvent;
begin
  Result := FPropertyChanged;
end;

function TViewModelBase.Validate: Boolean;
begin
  Result := True;
end;

procedure TViewModelBase.SetActiveControl(const Value: String);
begin
  if (FActiveControl <> Value) then
  begin
    FActiveControl := Value;
    DoPropertyChanged('ActiveControl');
  end;
end;

function TViewModelBase._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TViewModelBase._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Destroy;
end;

{$ENDREGION}

end.
