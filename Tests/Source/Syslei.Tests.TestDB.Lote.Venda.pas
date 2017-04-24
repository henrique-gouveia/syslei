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

unit Syslei.Tests.TestDB.Lote.Venda;

interface

uses
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Tests.TestDB.Lote,

  Spring,
  Spring.Collections;

type
  TVendaLoteDataInsert = record
  private
    FCompradorIds: IList<TValue>;
    FLoteIds: IList<TValue>;
    FVendaLoteIds: IList<TValue>;
  public
    class function Create: TVendaLoteDataInsert; inline; static;
    property CompradorIds: IList<TValue> read FCompradorIds;
    property LoteIds: IList<TValue> read FLoteIds;
    property VendaLoteIds: IList<TValue> read FVendaLoteIds;
  end;

  TVendaLoteRecord = record
  public
    CompradorNome: String;
    CompradorCpfCnpj: String;
    LoteDescricao: String;
    LoteNumero: String;
    Data: TDate;
    LanceArremate: Double;
  end;

  function GetDefaultVendaLotes: TArray<TVendaLoteRecord>;
  function InsertCompradoresAndLotesAndVenda(const vendaLotes: TArray<TVendaLoteRecord>): TVendaLoteDataInsert;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Helpers;

{$REGION 'TVendaLoteDataInsert' }

class function TVendaLoteDataInsert.Create: TVendaLoteDataInsert;
begin
  Result.FCompradorIds := TCollections.CreateList<TValue>();
  Result.FLoteIds := TCollections.CreateList<TValue>();
  Result.FVendaLoteIds := TCollections.CreateList<TValue>();
end;

{$ENDREGION}

var
  VendaTerreno5x12: TVendaLoteRecord = (
    CompradorNome: 'JOSÉ DA COSTA';
    CompradorCpfCnpj: '115.682.821-09';
    LoteDescricao: 'TERRENO 5x12';
    LoteNumero: '1010';
    Data: 0;
    LanceArremate: 10000
  );

  VendaTouroAdulto1100KG: TVendaLoteRecord = (
    CompradorNome: 'JOÃO DA SILVA';
    CompradorCpfCnpj: '14.175.522/0001-39';
    LoteDescricao: 'TOURO ADULTO 1100 KG';
    LoteNumero: '1020';
    Data: 0;
    LanceArremate: 1800
  );

  VendaPrenda: TVendaLoteRecord = (
    CompradorNome: 'JOSÉ DA COSTA';
    CompradorCpfCnpj: '115.682.821-09';
    LoteDescricao: 'PRENDA';
    LoteNumero: '1030';
    Data: 0;
    LanceArremate: 1200
  );

function GetDefaultVendaLotes: TArray<TVendaLoteRecord>;
var
  vendaLotes: TArray<TVendaLoteRecord>;
begin
  SetLength(vendaLotes, 3);

  VendaTerreno5x12.Data := IncMonth(Date(), -3);
  VendaTouroAdulto1100KG.Data := IncMonth(Date(), -2);
  VendaPrenda.Data := IncMonth(Date(), -1);

  vendaLotes[0] := VendaTerreno5x12;
  vendaLotes[1] := VendaTouroAdulto1100KG;
  vendaLotes[2] := VendaPrenda;

  Result := vendaLotes;
end;

function InsertCompradoresAndLotesAndVenda(const vendaLotes: TArray<TVendaLoteRecord>): TVendaLoteDataInsert;
var
  venda: TVendaLoteRecord;
  compradorId, doadorId, loteId, vendaId: Integer;
begin
  Result := TVendaLoteDataInsert.Create;

  doadorId := InsertPessoa();
  for venda in vendaLotes do
  begin
    compradorId := InsertPessoa(venda.CompradorNome, venda.CompradorCpfCnpj);
    Result.CompradorIds.Add(compradorId);

    loteId := InsertLote(doadorId, venda.LoteDescricao, venda.LoteNumero);
    Result.LoteIds.Add(loteId);

    vendaId := InsertVendaLote(compradorId, loteId, venda.LanceArremate, venda.Data);
    Result.VendaLoteIds.Add(vendaId);
  end;
end;

end.
