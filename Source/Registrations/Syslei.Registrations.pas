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

unit Syslei.Registrations;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

  procedure RegisterTypes;

implementation

uses
  Syslei.Registrations.Connections,
  Syslei.Registrations.Conversions,
  Syslei.Registrations.Finders,
  Syslei.Registrations.Interfaces,
  Syslei.Registrations.Modules,
  Syslei.Registrations.Repositories,
  Syslei.Registrations.ViewModels,
  Syslei.Registrations.Views;

procedure RegisterTypes;
var
  registerTypeExecutor: IRegisterTypeExecutor<TContainer>;
begin
  registerTypeExecutor := TSpringRegisterTypeExecutor.Create;

  registerTypeExecutor.AddRegister(TConnectionRegiterType.Create());
  registerTypeExecutor.AddRegister(TConversionsRegiterType.Create());
  registerTypeExecutor.AddRegister(TFindersRegisterType.Create());
  registerTypeExecutor.AddRegister(TModulesRegiterType.Create());
  registerTypeExecutor.AddRegister(TRepositoriesRegisterType.Create());
  registerTypeExecutor.AddRegister(TViewModelsRegiterType.Create());
  registerTypeExecutor.AddRegister(TViewsRegiterType.Create());

  registerTypeExecutor.Execute();
end;

end.
