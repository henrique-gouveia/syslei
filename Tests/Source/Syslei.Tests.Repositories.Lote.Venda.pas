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

unit Syslei.Tests.Repositories.Lote.Venda;

interface

uses
  DUnitX.TestFramework,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Lote.Venda;

type
  [TestFixture]
  TVendaLoteRepositoryTest = class
  private
    FVendaLoteRepository: IPagedRepository<TVendaLote, Integer>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindOne;
    [Test]
    procedure TestFindAll;
    [Test]
    procedure TestInsert;
    [Test]
    procedure TestUpdate;
    [Test]
    procedure TestRemove;
  end;

implementation

uses
  System.SysUtils,
  SQLiteTable3,

  Spring.Collections,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Consts,
  Syslei.Tests.TestSession;

{$REGION 'TLoteRepositoryTest' }

procedure TVendaLoteRepositoryTest.Setup;
begin
  FVendaLoteRepository := TSimpleRepository<TVendaLote, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TVendaLoteRepositoryTest.TearDown;
begin
  ClearTables();
end;

procedure TVendaLoteRepositoryTest.TestFindOne;
var
  id, compradorId, doadorId, loteId: Integer;
  vendaLote: TVendaLote;
begin
  doadorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  id := InsertVendaLote(compradorId, loteId);

  vendaLote := FVendaLoteRepository.FindOne(id);
  try
    Assert.IsNotNull(vendaLote, Format('Nenhum Venda de Lote localizada para o id %d', [id]));
    Assert.IsNotNull(vendaLote.Comprador, 'Comprador do Lote n�o foi carregado');
    Assert.AreEqual(vendaLote.Comprador.Id, compradorId, Format('Id do Comprador % difere do id esperado %d', [
      vendaLote.Comprador.Id, compradorId]));
    Assert.IsNotNull(vendaLote.Lote, 'Comprador do Lote n�o foi carregado');
    Assert.AreEqual(vendaLote.Lote.Id, loteId, Format('Id do Lote % difere do id esperado %d', [
      vendaLote.Lote.Id, loteId]));
    Assert.AreEqual(id, vendaLote.Id, Format('Id da Venda de Lote %d difere do id esperado %d', [vendaLote.Id, id]));
  finally
    vendaLote.Free;
  end;
end;

procedure TVendaLoteRepositoryTest.TestFindAll;
var
  I, count, compradorId, doadorId, loteId: Integer;
  vendasLote: IList<TVendaLote>;
begin
  doadorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  for I := 1 to 10 do
    InsertVendaLote(compradorId, loteId);

  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + VENDA_LOTE_TABLE_NAME + ']').Fields[0].Value;
  vendasLote := FVendaLoteRepository.FindAll();

  Assert.IsNotNull(vendasLote, 'Nenhuma Venda de Lote localizada');
  Assert.AreEqual(count, vendasLote.Count, 'Total de registros diferem');
end;

procedure TVendaLoteRepositoryTest.TestInsert;
var
  compradorId, doadorId, loteId: Integer;
  vendaLote: TVendaLote;

  table: ISQLiteTable;
begin
  doadorId := InsertPessoa();
  compradorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  vendaLote := TVendaLote.Create();
  try
    vendaLote.Data := Date();
    vendaLote.compradorId := compradorId;
    vendaLote.LoteId := loteId;
    vendaLote.LanceArremate := 10000;

    FVendaLoteRepository.Save(vendaLote);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + VENDA_LOTE_TABLE_NAME + '] WHERE ID = ?', [vendaLote.Id]);

    Assert.AreEqual<Int64>(vendaLote.compradorId, table.FieldByName['COMPRADOR_ID'].AsInteger);
    Assert.AreEqual<Int64>(vendaLote.LoteId, table.FieldByName['LOTE_ID'].AsInteger);
    Assert.AreEqual(vendaLote.Data, table.FieldByName['DATA'].AsDateTime);
    Assert.AreEqual(vendaLote.LanceArremate, table.FieldByName['LANCE_ARREMATE'].AsDouble);
  finally
    vendaLote.Free;
  end;
end;

procedure TVendaLoteRepositoryTest.TestUpdate;
var
  id,
  compradorId, compradorUpdateId, doadorId,
  loteId, loteUpdateId: Integer;

  vendaLote: TVendaLote;

  table: ISQLiteTable;
begin
  doadorId := InsertPessoa();

  loteId := InsertLote(doadorId);
  loteUpdateId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  compradorUpdateId := InsertPessoa();

  id := InsertVendaLote(compradorId, loteId);

  vendaLote := FVendaLoteRepository.FindOne(id);
  try
    vendaLote.CompradorId := compradorUpdateId;
    vendaLote.LoteId := loteUpdateId;
    vendaLote.LanceArremate := 20000;

    FVendaLoteRepository.Save(vendaLote);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + VENDA_LOTE_TABLE_NAME + '] WHERE ID = ?', [vendaLote.Id]);

    Assert.AreEqual<Int64>(vendaLote.compradorId, table.FieldByName['COMPRADOR_ID'].AsInteger);
    Assert.AreEqual<Int64>(vendaLote.LoteId, table.FieldByName['LOTE_ID'].AsInteger);
    Assert.AreEqual(vendaLote.LanceArremate, table.FieldByName['LANCE_ARREMATE'].AsDouble);
  finally
    vendaLote.Free;
  end;
end;

procedure TVendaLoteRepositoryTest.TestRemove;
var
  id, doadorId, compradorId, loteId: Integer;
  vendaLoteInserted, vendaLoteRemoved: TVendaLote;
begin
  doadorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  id := InsertVendaLote(compradorId, loteId);

  vendaLoteInserted := FVendaLoteRepository.FindOne(id);
  try
    FVendaLoteRepository.Delete(vendaLoteInserted);
    vendaLoteRemoved := FVendaLoteRepository.FindOne(id);

    Assert.IsNull(vendaLoteRemoved, 'Venda de Lote n�o foi removida');
  finally
    vendaLoteInserted.Free;
  end;
end;

{$ENDREGION}

initialization
  TDunitX.RegisterTestFixture(TVendaLoteRepositoryTest);

end.
