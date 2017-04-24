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

unit Syslei.Registrations.SpringRegisters;

interface

uses
  Syslei.Registrations.Interfaces,

  Spring.Container,
  Spring.Collections;

type
  TSpringRegisterType = class(TInterfacedObject, IRegisterType<TContainer>)
    procedure RegistryType(const container: TContainer); virtual; abstract;
  end;

  TSpringRegisterTypeExecutor = class(TInterfacedObject, IRegisterTypeExecutor<TContainer>)
  private
    FRegisters: IList<IRegisterType<TContainer>>;
  public
    constructor Create;

    procedure Execute;
    procedure AddRegister(const registerType: IRegisterType<TContainer>);
  end;

implementation

{$REGION 'TSpringRegisterTypeExecutor' }

constructor TSpringRegisterTypeExecutor.Create;
begin
  inherited Create;
  FRegisters := TCollections.CreateList<IRegisterType<TContainer>>;
end;

procedure TSpringRegisterTypeExecutor.AddRegister(const registerType: IRegisterType<TContainer>);
begin
  if not FRegisters.Contains(registerType) then
    FRegisters.Add(registerType);
end;

procedure TSpringRegisterTypeExecutor.Execute;
var
  container: TContainer;
  registerType: IRegisterType<TContainer>;
begin
  container := GlobalContainer();

  for registerType in FRegisters do
    registerType.RegistryType(container);

  container.Build();
end;

{$ENDREGION}

end.
