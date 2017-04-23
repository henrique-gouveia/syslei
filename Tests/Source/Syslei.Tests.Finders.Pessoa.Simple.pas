unit Syslei.Tests.Finders.Pessoa.Simple;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Entities.Pessoa,
  Syslei.Models.Finders.Interfaces,

  Spring.Persistence.Core.Interfaces;

type
  [TestFixture]
  TSimplePessoaFinderTest = class
  private
    FSimplePessoaFinder: IEntityFinder<TPessoa>;
    procedure InsertPessoas;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindWithCriteriaAndRestrictionEqual;
    [Test]
    procedure TestFindWithCriteriaAndRestrictionLikeAnyware;
    [Test]
    procedure TestFindWithCriteriaAndRestrictionLikeStart;
  end;

implementation

uses
  System.SysUtils,

  Spring.Collections,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Finders.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestSession;

{$REGION 'TFinderPessoaTest' }

procedure TSimplePessoaFinderTest.Setup;
var
  pessoaRepository: IPagedRepository<TPessoa,Integer>;
begin
  pessoaRepository := TSimpleRepository<TPessoa,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FSimplePessoaFinder := TSimpleEntityFinder<TPessoa, Integer>.Create(pessoaRepository);

  InsertPessoas();
end;

var
  Nomes: array of String = ['JOÃO', 'MARIA', 'JOSÉ'];

procedure TSimplePessoaFinderTest.InsertPessoas;
var
  nome: String;
begin
  for nome in Nomes do
    InsertPessoa(nome);
end;

procedure TSimplePessoaFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionEqual;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindEqual('NOME', 'JOSÉ');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(1, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[2]);
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionLikeAnyware;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindLikeAnyware('NOME', 'JO');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(2, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[0]);
  Assert.AreEqual(pessoas.Items[1].Nome, Nomes[2]);
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionLikeStart;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindLikeStart('NOME', 'M');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(1, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[1]);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TSimplePessoaFinderTest);

end.
