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

unit Syslei.Tests.Repositories.Proprio;

interface

uses
  DUnitX.TestFramework,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Proprio;

type
  [TestFixture]
  TProprioRepositoryTest = class
  private
    FProprioRepository: IPagedRepository<TProprio, Integer>;
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

{$REGION 'TProprioRepositoryTest' }

procedure TProprioRepositoryTest.Setup;
begin
  FProprioRepository := TSimpleRepository<TProprio, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TProprioRepositoryTest.TearDown;
begin
  ClearTables();
end;

procedure TProprioRepositoryTest.TestFindOne;
var
  id: Integer;
  proprio: TProprio;
begin
  id := InsertProprio();

  proprio := FProprioRepository.FindOne(id);
  try
    Assert.IsNotNull(proprio, Format('Nenhum Proprio localizado para o id %d', [id]));
    Assert.AreEqual(id, proprio.Id, Format('Id do proprio %d difere do id esperado %d', [proprio.Id, id]));
  finally
    proprio.Free;
  end;
end;

procedure TProprioRepositoryTest.TestFindAll;
var
  I, count: Integer;
  proprios: IList<TProprio>;
begin
  for I := 1 to 10 do
    InsertProprio('PESSOA' + I.ToString(), '', '(88)91234-4321', Date());

  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + PROPRIO_TABLE_NAME + ']').Fields[0].Value;
  proprios := FProprioRepository.FindAll();

  Assert.IsNotNull(proprios, 'Nenhum Proprio localizado');
  Assert.AreEqual(count, proprios.Count, 'Total de registros diferem');
end;

procedure TProprioRepositoryTest.TestInsert;
var
  proprio: TProprio;
  table: ISQLiteTable;
begin
  proprio := TProprio.Create();
  try
    proprio.Nome := 'PROPRIO INSERTED';
    proprio.CpfCnpj := '165.223.333-41';
    proprio.Telefone := '(88)4321-1234';
    proprio.DataCadastro := Date();

    FProprioRepository.Save(proprio);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PROPRIO_TABLE_NAME + '] WHERE ID = ?', [proprio.Id]);

    Assert.AreEqual(proprio.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(proprio.CpfCnpj, table.FieldByName['CPF_CNPJ'].AsString);
    Assert.AreEqual(proprio.Telefone, table.FieldByName['FONE1'].AsString);
    Assert.AreEqual(proprio.DataCadastro, table.FieldByName['DATA_CADASTRO'].AsDateTime);
  finally
    proprio.Free;
  end;
end;

procedure TProprioRepositoryTest.TestUpdate;
var
  id: Integer;
  proprio: TProprio;

  table: ISQLiteTable;
begin
  id := InsertProprio();
  proprio := FProprioRepository.FindOne(id);
  try
    proprio.Nome := 'PROPRIO UPDATED';
    proprio.CpfCnpj := '355.734.728-10';
    proprio.Telefone := '(88)94321-1234';

    FProprioRepository.Save(proprio);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PROPRIO_TABLE_NAME + '] WHERE ID = ?', [proprio.Id]);

    Assert.AreEqual(proprio.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(proprio.CpfCnpj, table.FieldByName['CPF_CNPJ'].AsString);
    Assert.AreEqual(proprio.Telefone, table.FieldByName['FONE1'].AsString);
    Assert.AreEqual(proprio.DataCadastro, table.FieldByName['DATA_CADASTRO'].AsDateTime);
  finally
    proprio.Free;
  end;
end;

procedure TProprioRepositoryTest.TestRemove;
var
  id: Integer;
  proprioInserted, proprioRemoved: TProprio;
begin
  id := InsertProprio();
  proprioInserted := FProprioRepository.FindOne(id);
  try
    FProprioRepository.Delete(proprioInserted);
    proprioRemoved := FProprioRepository.FindOne(id);

    Assert.IsNull(proprioRemoved, 'Proprio não foi removido');
  finally
    proprioInserted.Free;
  end;
end;

{$ENDREGION}

initialization
  TDunitX.RegisterTestFixture(TProprioRepositoryTest);

end.
