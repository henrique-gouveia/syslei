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

unit Syslei.Registrations.Conversions;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TConversionsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Syslei.Conversions.ControlString,
  Syslei.Conversions.Lote.ObjectListDataSet.FireDAC,
  Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC,
  Syslei.Conversions.Proprio.ObjectListDataSet.FireDAC;

{$REGION 'TConversionsRegiterType' }

procedure TConversionsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TControlStringConverter>(CONVERSION_CONTROL_STRING_NAME);

  container
    .RegisterType<TObjectListLoteDataSetConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME);

  container
    .RegisterType<TObjectListProprioDataSetConverter>(CONVERSION_OBJECTLIST_PROPRIODATASET_NAME);

  container
    .RegisterType<TObjectListVendaLoteDataSetConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME);
end;

{$ENDREGION}

end.
