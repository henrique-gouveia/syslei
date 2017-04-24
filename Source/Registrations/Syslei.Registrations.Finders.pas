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

unit Syslei.Registrations.Finders;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TFindersRegisterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  Syslei.Models.Domains.Lote.Filter,
  Syslei.Models.Domains.Lote.Venda.Filter,

  Syslei.Models.Finders.Interfaces,
  Syslei.Models.Finders.Simple,
  Syslei.Models.Finders.Lote.Filter,
  Syslei.Models.Finders.Lote.Venda.Filter,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa;


{$REGION 'TFindersRegisterType' }

procedure TFindersRegisterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<IEntityFinder<TLote>, TSimpleEntityFinder<TLote, Integer>>();

  container
    .RegisterType<IEntityFinder<TPessoa>, TSimpleEntityFinder<TPessoa, Integer>>();

  container
    .RegisterType<IEntityFinder<TLote, TLoteFilter>, TFilterLoteFinder>();

  container
    .RegisterType<IEntityFinder<TVendaLote, TVendaLoteFilter>, TFilterVendaLoteFinder>();

  container
    .RegisterType<IEntityFinder<TVendaLote, TVendaLoteFilterReport>, TFilterVendaLoteFinderReport>();
end;

{$ENDREGIOn}

end.
