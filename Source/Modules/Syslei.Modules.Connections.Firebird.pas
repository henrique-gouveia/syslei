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

unit Syslei.Modules.Connections.Firebird;

interface

uses
  System.SysUtils,
  System.Classes,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.UI,

  Syslei.Modules.Connections.Interfaces;

type
  TFirebirdConnectionModule = class(TDataModule, IConnectionModule<TFDConnection>)
    SysleiConnection: TFDConnection;
    guixWaitCursor: TFDGUIxWaitCursor;
    firebirdDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  protected
    function GetConnection: TFDConnection; virtual;
    function GetDriverName: String; virtual;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION 'TFirebirdConnectionModule' }

procedure TFirebirdConnectionModule.DataModuleCreate(Sender: TObject);
begin
  {$IFDEF FIREBIRD_DB}
  SysleiConnection.Connected := True;
  {$ENDIF}
end;

function TFirebirdConnectionModule.GetConnection: TFDConnection;
begin
  Result := SysleiConnection;
end;

function TFirebirdConnectionModule.GetDriverName: String;
begin
  Result := SysleiConnection.DriverName;
end;

{$ENDREGION}

end.
