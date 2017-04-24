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

unit Syslei.Tests.Repositories.Pessoa;

interface

uses
  DUnitX.TestFramework,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Pessoa;

type
  [TestFixture]
  TPessoaRepositoryTest = class
  private
    FPessoaRepository: IPagedRepository<TPessoa, Integer>;
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

{$REGION 'TPessoaRepositoryTest' }

procedure TPessoaRepositoryTest.Setup;
begin
  FPessoaRepository := TSimpleRepository<TPessoa, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TPessoaRepositoryTest.TearDown;
begin
  ClearTables();
end;

procedure TPessoaRepositoryTest.TestFindOne;
var
  id: Integer;
  pessoa: TPessoa;
begin
  id := InsertPessoa();

  pessoa := FPessoaRepository.FindOne(id);
  try
    Assert.IsNotNull(pessoa, Format('Nenhuma Pessoa localizada para o id %d', [id]));
    Assert.AreEqual(id, pessoa.Id, Format('Id da pessoa %d difere do id esperado %d', [pessoa.Id, id]));
  finally
    pessoa.Free;
  end;
end;

procedure TPessoaRepositoryTest.TestFindAll;
var
  I, count: Integer;
  pessoas: IList<TPessoa>;
begin
  for I := 1 to 10 do
    InsertPessoa('PESSOA' + I.ToString(), '', '(88)91234-4321', Date());

  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + PESSOA_TABLE_NAME + ']').Fields[0].Value;
  pessoas := FPessoaRepository.FindAll();

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(count, pessoas.Count, 'Total de registros diferem');
end;

procedure TPessoaRepositoryTest.TestInsert;
var
  pessoa: TPessoa;
  table: ISQLiteTable;
begin
  pessoa := TPessoa.Create();
  try
    pessoa.Nome := 'PESSOA INSERTED';
    pessoa.CpfCnpj := '165.223.333-41';
    pessoa.Telefone := '(88)4321-1234';
    pessoa.DataCadastro := Date();

    FPessoaRepository.Save(pessoa);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PESSOA_TABLE_NAME + '] WHERE ID = ?', [pessoa.Id]);

    Assert.AreEqual(pessoa.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(pessoa.CpfCnpj, table.FieldByName['CPF_CNPJ'].AsString);
    Assert.AreEqual(pessoa.Telefone, table.FieldByName['FONE1'].AsString);
    Assert.AreEqual(pessoa.DataCadastro, table.FieldByName['DATA_CADASTRO'].AsDateTime);
  finally
    pessoa.Free;
  end;
end;

procedure TPessoaRepositoryTest.TestUpdate;
var
  id: Integer;
  pessoa: TPessoa;

  table: ISQLiteTable;
begin
  id := InsertPessoa();
  pessoa := FPessoaRepository.FindOne(id);
  try
    pessoa.Nome := 'PESSOA UPDATED';
    pessoa.CpfCnpj := '355.734.728-10';
    pessoa.Telefone := '(88)94321-1234';

    FPessoaRepository.Save(pessoa);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PESSOA_TABLE_NAME + '] WHERE ID = ?', [pessoa.Id]);

    Assert.AreEqual(pessoa.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(pessoa.CpfCnpj, table.FieldByName['CPF_CNPJ'].AsString);
    Assert.AreEqual(pessoa.Telefone, table.FieldByName['FONE1'].AsString);
    Assert.AreEqual(pessoa.DataCadastro, table.FieldByName['DATA_CADASTRO'].AsDateTime);
  finally
    pessoa.Free;
  end;
end;

procedure TPessoaRepositoryTest.TestRemove;
var
  id: Integer;
  pessoaInserted, pessoaRemoved: TPessoa;
begin
  id := InsertPessoa();
  pessoaInserted := FPessoaRepository.FindOne(id);
  try
    FPessoaRepository.Delete(pessoaInserted);
    pessoaRemoved := FPessoaRepository.FindOne(id);

    Assert.IsNull(pessoaRemoved, 'Pessoa não foi removida');
  finally
    pessoaInserted.Free;
  end;
end;

{$ENDREGION}

initialization
  TDunitX.RegisterTestFixture(TPessoaRepositoryTest);

end.
