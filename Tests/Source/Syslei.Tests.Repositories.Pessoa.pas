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
    InsertPessoa('PESSOA' + I.ToString(), '', Date());

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
    pessoa.Cpf := '165.223.333-41';
    pessoa.DataCadastro := Date();

    FPessoaRepository.Save(pessoa);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PESSOA_TABLE_NAME + '] WHERE ID = ?', [pessoa.Id]);

    Assert.AreEqual(pessoa.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(pessoa.Cpf, table.FieldByName['CPF'].AsString);
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
    pessoa.Cpf := '355.734.728-10';

    FPessoaRepository.Save(pessoa);
    table := TestDB.GetUniTableIntf('SELECT * FROM [' + PESSOA_TABLE_NAME + '] WHERE ID = ?', [pessoa.Id]);

    Assert.AreEqual(pessoa.Nome, table.FieldByName['NOME'].AsString);
    Assert.AreEqual(pessoa.Cpf, table.FieldByName['CPF'].AsString);
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
