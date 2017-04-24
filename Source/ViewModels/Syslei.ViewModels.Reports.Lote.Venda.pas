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

unit Syslei.ViewModels.Reports.Lote.Venda;

interface

uses
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Proprio,
  Syslei.ViewModels.Base.Report,

  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TVendaLoteReportViewModel = class(TReportViewModelBase)
  private
    [Inject]
    FProprioRepository: IPagedRepository<TProprio, Integer>;
    FProprios: IObjectList;
    FVendaLote: TVendaLote;

    function GetProprios: IObjectList;
    procedure SetProprios(const Value: IObjectList);
    procedure SetVendaLote(const Value: TVendaLote);
  public
    property Proprios: IObjectList read GetProprios write SetProprios;
    property VendaLote: TVendaLote read FVendaLote write SetVendaLote;
  end;

implementation

{$REGION 'TVendaLoteViewModel' }

function TVendaLoteReportViewModel.GetProprios: IObjectList;
begin
  if not Assigned(FProprios) then
    FProprios := FProprioRepository.FindAll() as IObjectList;
  Result := FProprios;
end;

procedure TVendaLoteReportViewModel.SetProprios(const Value: IObjectList);
begin
  FProprios := Value;
  DoPropertyChanged('Proprios')
end;

procedure TVendaLoteReportViewModel.SetVendaLote(const Value: TVendaLote);
begin
  FVendaLote := Value;
  if Assigned(FVendaLote) then
  begin
    Entities.Add(FVendaLote);
    DoPropertyChanged('Entities');
  end;
end;

{$ENDREGION}

end.
