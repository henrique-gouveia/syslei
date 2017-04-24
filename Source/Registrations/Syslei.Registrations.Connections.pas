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

unit Syslei.Registrations.Connections;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TConnectionRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  FireDAC.Comp.Client,

  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,
  Spring.Persistence.SQL.Interfaces,

  Syslei.Modules.Connections.Consts,
  Syslei.Modules.Connections.Interfaces;

{$REGION 'TConnectionRegiterType' }

procedure TConnectionRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IDBConnection>()
    .DelegateTo(
      function: IDBConnection
      var
        connectionModule: IConnectionModule<TFDConnection>;
      begin
        connectionModule := container.Resolve<IConnectionModule<TFDConnection>>(CONNECTION_MODULE_NAME);
        Result := TFireDACConnectionAdapter.Create(connectionModule.Connection);

        if connectionModule.DriverName = 'FB' then
          Result.QueryLanguage := qlFirebird
        else
          Result.QueryLanguage := qlAnsiSQL;
      end)
    .AsSingleton();

  container
    .RegisterType<TSession>()
    .AsSingleton();
end;

{$ENDREGION}

end.
