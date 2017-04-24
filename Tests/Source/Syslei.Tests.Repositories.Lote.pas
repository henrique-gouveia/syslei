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

unit Syslei.Tests.Repositories.Lote;

interface

uses
  DUnitX.TestFramework,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Lote;

type
  [TestFixture]
  TLoteRepositoryTest = class
  private
    FLoteRepository: IPagedRepository<TLote, Integer>;
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

procedure TLoteRepositoryTest.Setup;
begin
  FLoteRepository := TSimpleRepository<TLote, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TLoteRepositoryTest.TearDown;
begin
  ClearTables();
end;

procedure TLoteRepositoryTest.TestFindOne;
var
  id, doadorId: Integer;
  lote: TLote;
begin
  doadorId := InsertPessoa();
  id := InsertLote(doadorId);

  lote := FLoteRepository.FindOne(id);
  try
    Assert.IsNotNull(lote, Format('Nenhum Lote localizada para o id %d', [id]));
    Assert.IsNotNull(lote.Doador, 'Doador do Lote não foi carregado');
    Assert.AreEqual(lote.Doador.Id, doadorId, Format('Id do Doador % difere do id esperado %d', [lote.Doador.Id, doadorId]));
    Assert.AreEqual(id, lote.Id, Format('Id do Lote %d difere do id esperado %d', [lote.Id, id]));
  finally
    lote.Free;
  end;
end;

procedure TLoteRepositoryTest.TestFindAll;
var
  I, count, doadorId: Integer;
  lotes: IList<TLote>;
begin
  doadorId := InsertPessoa();
  for I := 1 to 10 do
    InsertLote(doadorId);

  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + LOTE_TABLE_NAME + ']').Fields[0].Value;
  lotes := FLoteRepository.FindAll();

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros diferem');
end;

procedure TLoteRepositoryTest.TestInsert;
var
  doadorId: Integer;
  lote: TLote;

  table: ISQLiteTable;
begin
  doadorId := InsertPessoa();

  lote := TLote.Create();
  try
    lote.DoadorId := doadorId;
    lote.Descricao := 'LOTE INSERTED';
    lote.Numero := '123456789';
    lote.LanceInicial := 10000;

    FLoteRepository.Save(lote);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + LOTE_TABLE_NAME + '] WHERE ID = ?', [lote.Id]);

    Assert.AreEqual<Int64>(lote.DoadorId, table.FieldByName['DOADOR_ID'].AsInteger);
    Assert.AreEqual(lote.Descricao, table.FieldByName['DESCRICAO'].AsString);
    Assert.AreEqual(lote.Numero, table.FieldByName['NUMERO'].AsString);
    Assert.AreEqual(lote.LanceInicial, table.FieldByName['LANCE_INICIAL'].AsDouble);
    Assert.AreEqual(lote.Status, TStatusLote(table.FieldByName['STATUS'].AsInteger));
    Assert.AreEqual(lote.Tipo, TTipoLote(table.FieldByName['TIPO'].AsInteger));
  finally
    lote.Free;
  end;
end;

procedure TLoteRepositoryTest.TestUpdate;
var
  id, doadorId: Integer;
  lote: TLote;

  table: ISQLiteTable;
begin
  doadorId := InsertPessoa();
  id := InsertLote(doadorId);

  lote := FLoteRepository.FindOne(id);
  try
    lote.Descricao := 'LOTE UPDATED';
    lote.Numero := '987654321';
    lote.LanceInicial := 20000;

    FLoteRepository.Save(lote);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + LOTE_TABLE_NAME + '] WHERE ID = ?', [lote.Id]);

    Assert.AreEqual<Int64>(lote.DoadorId, table.FieldByName['DOADOR_ID'].AsInteger);
    Assert.AreEqual(lote.Descricao, table.FieldByName['DESCRICAO'].AsString);
    Assert.AreEqual(lote.Numero, table.FieldByName['NUMERO'].AsString);
    Assert.AreEqual(lote.LanceInicial, table.FieldByName['LANCE_INICIAL'].AsDouble);
    Assert.AreEqual(lote.Status, TStatusLote(table.FieldByName['STATUS'].AsInteger));
    Assert.AreEqual(lote.tipo, TTipoLote(table.FieldByName['TIPO'].AsInteger));
  finally
    lote.Free;
  end;
end;

procedure TLoteRepositoryTest.TestRemove;
var
  id, doadorId: Integer;
  loteInserted, loteRemoved: TLote;
begin
  doadorId := InsertPessoa();
  id := InsertLote(doadorId);

  loteInserted := FLoteRepository.FindOne(id);
  try
    FLoteRepository.Delete(loteInserted);
    loteRemoved := FLoteRepository.FindOne(id);

    Assert.IsNull(loteRemoved, 'Lote não foi removido');
  finally
    loteInserted.Free;
  end;
end;

{$ENDREGION}

initialization
  TDunitX.RegisterTestFixture(TLoteRepositoryTest);

end.
