unit Syslei.Tests.Finders.Lote.Simple;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Finders.Interfaces,

  Syslei.Tests.TestDB.Lote;

type
  [TestFixture]
  TSimpleLoteFinderTest = class
  private
    FSimpleLoteFinder: IEntityFinder<TLote>;
    FLoteDataInsert: TLoteDataInsert;
    FLotes: TArray<TLoteRecord>;
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
  SQLiteTable3,

  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Finders.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Consts,
  Syslei.Tests.TestSession;

{$REGION 'TFinderPessoaTest' }

procedure TSimpleLoteFinderTest.Setup;
var
  loteRepository: IPagedRepository<TLote,Integer>;
begin
  loteRepository := TSimpleRepository<TLote,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FSimpleLoteFinder := TSimpleEntityFinder<TLote, Integer>.Create(loteRepository);

  FLotes := GetDefaultLotes();
  FLoteDataInsert := InsertDoadoresAndLotes(FLotes);
end;

procedure TSimpleLoteFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TSimpleLoteFinderTest.TestFindWithCriteriaAndRestrictionEqual;
var
  lotes: IList<TLote>;
  table: ISQLiteTable;
  index, count: Integer;
begin
  count := TestDB.GetUniTableIntf(
    'SELECT COUNT(*) FROM '
  + '[' + LOTE_TABLE_NAME + '] '
  + 'WHERE DESCRICAO = ?', [FLotes[1].Descricao]).Fields[0].Value;

  table := TestDB.GetUniTableIntf(
    'SELECT * FROM '
  + '[' + LOTE_TABLE_NAME + '] '
  + 'WHERE DESCRICAO = ?', [FLotes[1].Descricao]);

  lotes := FSimpleLoteFinder.FindEqual('DESCRICAO', FLotes[1].Descricao);

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');

  index := 0;
  while not table.EOF do
  begin
    Assert.AreEqual(lotes.Items[index].Descricao, table.FieldByName['DESCRICAO'].AsString);
    if table.Next() then
      Inc(index);
  end;
end;

procedure TSimpleLoteFinderTest.TestFindWithCriteriaAndRestrictionLikeAnyware;
var
  lotes: IList<TLote>;
  table: ISQLiteTable;
  loteDescricao: String;
  index, count: Integer;
begin
  loteDescricao := 'TER';

  count := TestDB.GetUniTableIntf(Format(
    'SELECT COUNT(*) FROM '
  + '[' + LOTE_TABLE_NAME + ']'
  + 'WHERE DESCRICAO LIKE "%s%s%s"', ['%', loteDescricao, '%'])).Fields[0].Value;

  table := TestDB.GetUniTableIntf(Format(
    'SELECT * FROM '
  + '[' + LOTE_TABLE_NAME + '] '
  + 'WHERE DESCRICAO LIKE "%s%s%s"', ['%', loteDescricao, '%']));

  lotes := FSimpleLoteFinder.FindLikeAnyware('DESCRICAO', loteDescricao);

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');

  index := 0;
  while not table.EOF do
  begin
    Assert.AreEqual(lotes.Items[index].Descricao, table.FieldByName['DESCRICAO'].AsString);
    if table.Next() then
      Inc(index);
  end;
end;

procedure TSimpleLoteFinderTest.TestFindWithCriteriaAndRestrictionLikeStart;
var
  lotes: IList<TLote>;
  table: ISQLiteTable;
  index, count: Integer;
  loteDescricao: String;
begin
  loteDescricao := 'TOU';

  count := TestDB.GetUniTableIntf(Format(
    'SELECT COUNT(*) FROM '
  + '[' + LOTE_TABLE_NAME + ']'
  + 'WHERE DESCRICAO LIKE "%s%s"', [loteDescricao, '%'])).Fields[0].Value;

  table := TestDB.GetUniTableIntf(Format(
    'SELECT * FROM '
  + '[' + LOTE_TABLE_NAME + '] '
  + 'WHERE DESCRICAO LIKE "%s%s"', [loteDescricao, '%']));

  lotes := FSimpleLoteFinder.FindLikeStart('DESCRICAO', loteDescricao);

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');

  index := 0;
  while not table.EOF do
  begin
    Assert.AreEqual(lotes.Items[index].Descricao, table.FieldByName['DESCRICAO'].AsString);
    if table.Next() then
      Inc(index);
  end;
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TSimpleLoteFinderTest);

end.
