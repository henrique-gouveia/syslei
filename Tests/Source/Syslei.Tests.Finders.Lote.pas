unit Syslei.Tests.Finders.Lote;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Finders.Interfaces,

  Spring.Persistence.Core.Interfaces;

type
  [TestFixture]
  TLoteFinderTest = class
  private
    FLoteFinder: IEntityFinder<TLote>;
    procedure InsertLotes;
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

procedure TLoteFinderTest.Setup;
var
  loteRepository: IPagedRepository<TLote,Integer>;
begin
  loteRepository := TSimpleRepository<TLote,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FLoteFinder := TSimpleEntityFinder<TLote, Integer>.Create(loteRepository);

  InsertLotes();
end;

var
  Descricoes: array of String = ['TERRENO 10x25', 'TERRENO 5x12', 'TOURO ADULTO 1100 KG'];

procedure TLoteFinderTest.InsertLotes;
var
  descricao: String;
  pessoaId: Integer;
begin
  pessoaId := InsertPessoa();
  for descricao in Descricoes do
    InsertLote(pessoaId, descricao);
end;

procedure TLoteFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TLoteFinderTest.TestFindWithCriteriaAndRestrictionEqual;
var
  lotes: IList<TLote>;
begin
  lotes := FLoteFinder.FindEqual('DESCRICAO', Descricoes[1]);

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(1, lotes.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(lotes.Items[0].Descricao, Descricoes[1]);
end;

procedure TLoteFinderTest.TestFindWithCriteriaAndRestrictionLikeAnyware;
var
  lotes: IList<TLote>;
begin
  lotes := FLoteFinder.FindLikeAnyware('DESCRICAO', 'TE');

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(2, lotes.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(lotes.Items[0].Descricao, Descricoes[0]);
  Assert.AreEqual(lotes.Items[1].Descricao, Descricoes[1]);
end;

procedure TLoteFinderTest.TestFindWithCriteriaAndRestrictionLikeStart;
var
  lotes: IList<TLote>;
begin
  lotes := FLoteFinder.FindLikeStart('DESCRICAO', 'TO');

  Assert.IsNotNull(lotes, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(1, lotes.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(lotes.Items[0].Descricao, Descricoes[2]);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TLoteFinderTest);

end.
