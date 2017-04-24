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

unit Syslei.Models.Finders.Lote.Venda.Filter;

interface

uses
  Syslei.Models.Domains.Lote.Venda.Filter,
  Syslei.Models.Domains.Lote.Venda.Filter.Helpers,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Finders.Interfaces,

  Spring,
  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Criteria.Interfaces;

type
  TAbstractFilterVendaLoteFinder<TFilter: class, constructor> = class abstract(TInterfacedObject, IEntityFinder<TVendaLote, TFilter>)
  private
    FVendaLoteRepository: IPagedRepository<TVendaLote, Integer>;
  protected
    function Find(const filter: TFilter): IList<TVendaLote>; virtual; abstract;
    property VendaLoteRepository: IPagedRepository<TVendaLote, Integer> read FVendaLoteRepository;
  public
    constructor Create(const entityRepository: IPagedRepository<TVendaLote,Integer>); virtual;
  end;

  TFilterVendaLoteFinder = class(TAbstractFilterVendaLoteFinder<TVendaLoteFilter>)
  protected
    function Find(const filter: TVendaLoteFilter): IList<TVendaLote>; override;
  end;

  TFilterVendaLoteFinderReport = class(TAbstractFilterVendaLoteFinder<TVendaLoteFilterReport>)
  protected
    function Find(const filter: TVendaLoteFilterReport): IList<TVendaLote>; override;
  end;

implementation

uses
  System.SysUtils,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,

  Spring.Persistence.Criteria.OrderBy,
  Spring.Persistence.Criteria.Properties,
  Spring.Persistence.Criteria.Restrictions,
  Spring.Persistence.SQL.Types;

{$REGION 'TAbstractVendaLoteFinder' }

constructor TAbstractFilterVendaLoteFinder<TFilter>.Create(
  const entityRepository: IPagedRepository<TVendaLote, Integer>);
begin
  inherited Create;
  FVendaLoteRepository := entityRepository;
end;

{$ENDREGION}

{$REGION 'TVendaLoteFinder' }

function TFilterVendaLoteFinder.Find(const filter: TVendaLoteFilter): IList<TVendaLote>;
var
  criteria: ICriteria<TVendaLote>;
  criteriaProperty: IProperty;
begin
  Result := nil;

  if Assigned(filter) then
  begin
    criteria := VendaLoteRepository.FindWhere();

    if not (filter.Comprador.Nome.IsEmpty()) then
    begin
      criteriaProperty := TProperty<TPessoa>.Create('NOME');
      criteria.Add(criteriaProperty.Like(filter.Comprador.Nome, mmStart));
    end;

    if not (filter.Comprador.CpfCnpj.Replace('.', '').Replace('-', '').Replace('/', '').IsEmpty()) then
    begin
      criteriaProperty := TProperty<TPessoa>.Create('CPF_CNPJ');
      criteria.Add(criteriaProperty.Eq(filter.Comprador.CpfCnpj));
    end;

    if not (filter.Lote.Numero.IsEmpty()) then
    begin
      criteriaProperty := TProperty<TLote>.Create('NUMERO');
      criteria.Add(criteriaProperty.Eq(filter.Lote.Numero));
    end;

    if not (filter.Lote.Descricao.IsEmpty()) then
    begin
      criteriaProperty := TProperty<TLote>.Create('DESCRICAO');
      criteria.Add(criteriaProperty.Like(filter.Lote.Descricao, mmStart));
    end;

    if (filter.DataVendaInicial > 0) and (filter.DataVendaFinal > 0) then
    begin
      criteriaProperty := TProperty.Create('DATA');
      criteria.Add(criteriaProperty.Between(
        TValue.From<TDate>(filter.DataVendaInicial),
        TValue.From<TDate>(filter.DataVendaFinal)));
    end;

    Result := criteria.ToList();
  end;
end;

{$ENDREGION}

{$REGION 'TVendaLoteFinderReport' }

function TFilterVendaLoteFinderReport.Find(const filter: TVendaLoteFilterReport): IList<TVendaLote>;
var
  criteria: ICriteria<TVendaLote>;
  criteriaProperty: IProperty;
begin
  criteria := VendaLoteRepository.FindWhere();

  if Assigned(filter) then
  begin

    if (filter.Comprador.Id > 0) then
    begin
      criteriaProperty := TProperty<TPessoa>.Create('ID');
      criteria.Add(criteriaProperty.Eq(filter.Comprador.Id));
    end;

    if (filter.Tipo in [tlAnimal, tlImovel, tlPrenda]) then
    begin
      criteriaProperty := TProperty<TLote>.Create('TIPO');
      criteria.Add(criteriaProperty.Eq(filter.Tipo.ToInteger()));
    end;

    if (filter.DataVendaInicial > 0) and (filter.DataVendaFinal > 0) then
    begin
      criteriaProperty := TProperty.Create('DATA');
      criteria.Add(criteriaProperty.Between(
        TValue.From<TDate>(filter.DataVendaInicial),
        TValue.From<TDate>(filter.DataVendaFinal)));
    end;
  end;

  Result := criteria.OrderBy(TOrderBy.Asc('COMPRADOR_ID')).ToList();
end;

{$ENDREGION}

end.
