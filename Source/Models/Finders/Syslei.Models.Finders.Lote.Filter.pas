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

unit Syslei.Models.Finders.Lote.Filter;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Finders.Interfaces,
  Syslei.Models.Domains.Lote.Filter,
  Syslei.Models.Domains.Lote.Filter.Helpers,

  Spring,
  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TFilterLoteFinder = class(TInterfacedObject, IEntityFinder<TLote, TLoteFilter>)
  private
    FLoteRepository: IPagedRepository<TLote, Integer>;
  protected
    function Find(const filter: TLoteFilter): IList<TLote>; virtual;
  public
    constructor Create(const entityRepository: IPagedRepository<TLote,Integer>); virtual;
  end;

implementation

uses
  System.SysUtils,
  Syslei.Models.Entities.Pessoa,
  Spring.Persistence.Criteria.Properties,
  Spring.Persistence.Criteria.Restrictions,
  Spring.Persistence.SQL.Types;

{$REGION 'TLoteFinder' }

constructor TFilterLoteFinder.Create(const entityRepository: IPagedRepository<TLote, Integer>);
begin
  inherited Create;
  FLoteRepository := entityRepository;
end;

function TFilterLoteFinder.Find(const filter: TLoteFilter): IList<TLote>;
var
  criteria: ICriteria<TLote>;
  criteriaProperty: IProperty;
begin
  criteria := FLoteRepository.FindWhere();

  if Assigned(filter) then
  begin
    if (filter.Doador.Id > 0) then
    begin
      criteriaProperty := TProperty<TPessoa>.Create('ID');
      criteria.Add(criteriaProperty.Eq(filter.Doador.Id));
    end;

    if (filter.Status in [slAguardando, slAgendado, slArrematado]) then
    begin
      criteriaProperty := TProperty.Create('STATUS');
      criteria.Add(criteriaProperty.Eq(filter.Status.ToInteger()));
    end;

    if (filter.Tipo in [tlAnimal, tlImovel, tlPrenda]) then
    begin
      criteriaProperty := TProperty.Create('TIPO');
      criteria.Add(criteriaProperty.Eq(filter.Tipo.ToInteger()));
    end;

    if (filter.DataCadastroInicial > 0) and (filter.DataCadastroFinal > 0) then
    begin
      criteriaProperty := TProperty.Create('DATA_CADASTRO');
      criteria.Add(criteriaProperty.Between(
        TValue.From<TDate>(filter.DataCadastroInicial),
        TValue.From<TDate>(filter.DataCadastroFinal)));
    end;
  end;

  Result := criteria.ToList();
end;

{$ENDREGION}

end.
