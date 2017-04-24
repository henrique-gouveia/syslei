unit Syslei.Tests.Finders.Lote.Venda.Filter;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Domains.Lote.Venda.Filter,
  Syslei.Models.Domains.Lote.Venda.Filter.Helpers,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Finders.Interfaces,

  Syslei.Tests.TestDB.Lote.Venda;

type
  [TestFixture]
  TFilterVendaLoteFinderTest = class
  private
    FFilterVendaLoteFinder: IEntityFinder<TVendaLote, TVendaLoteFilter>;
    FVendaLoteDataInsert: TVendaLoteDataInsert;
    FVendaLotes: TArray<TVendaLoteRecord>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindWhithoutFilter;
    [Test]
    procedure TestFindFilterByDataBetween;
    [Test]
    procedure TestFindFilterByCompradorNomeLikeStart;
    [Test]
    procedure TestFindFilterByCompradorCpfCnpjEquals;
    [Test]
    procedure TestFindFilterByLoteDescricaoLikeStart;
    [Test]
    procedure TestFindFilterByLoteNumeroEquals;
  end;

  [TestFixture]
  TFilterVendaLoteFinderReportTest = class
  private
    FFilterVendaLoteFinderReport: IEntityFinder<TVendaLote, TVendaLoteFilterReport>;
    FVendaLoteDataInsert: TVendaLoteDataInsert;
    FVendaLotes: TArray<TVendaLoteRecord>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindWhithoutFilter;
    [Test]
    procedure TestFindFilterByCompradorId;
    [Test]
    procedure TestFindFilterByDataBetween;
    [Test]
    procedure TestFindFilterByTipo;
  end;

implementation

uses
  System.SysUtils,

  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,
  Syslei.Models.Finders.Lote.Venda.Filter,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Consts,
  Syslei.Tests.TestDB.Helpers,
  Syslei.Tests.TestSession;

{$REGION 'TFilterVendaLoteFinderTest' }

procedure TFilterVendaLoteFinderTest.Setup;
var
  vendaLoteRepository: IPagedRepository<TVendaLote,Integer>;
begin
  vendaLoteRepository := TSimpleRepository<TVendaLote,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FFilterVendaLoteFinder := TFilterVendaLoteFinder.Create(vendaLoteRepository);

  FVendaLotes := GetDefaultVendaLotes();
  FVendaLoteDataInsert := InsertCompradoresAndLotesAndVenda(FVendaLotes);
end;

procedure TFilterVendaLoteFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TFilterVendaLoteFinderTest.TestFindWhithoutFilter;
var
  vendaLotes: IList<TVendaLote>;
begin
  vendaLotes := FFilterVendaLoteFinder.Find(nil);
  Assert.IsNull(vendaLotes, 'Venda de Lotes localizados');
end;

procedure TFilterVendaLoteFinderTest.TestFindFilterByDataBetween;
var
  count: Integer;
  dataVendaInicial, dataVendaFinal: TDate;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilter;
begin
  filter := TVendaLoteFilter.CreateVendaLoteFilterEmpty();
  try
    dataVendaInicial := Trunc(IncMonth(Date(), -4));
    dataVendaFinal := Trunc(IncMonth(Date(), 4));

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + ']'
    + 'WHERE DATA BETWEEN ? AND ?', [
        dataVendaInicial.ToDateISOString(),
        dataVendaFinal.ToDateISOString()]
    ).Fields[0].Value;

    filter.DataVendaInicial := dataVendaInicial;
    filter.DataVendaInicial := dataVendaFinal;
    vendaLotes := FFilterVendaLoteFinder.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderTest.TestFindFilterByCompradorNomeLikeStart;
var
  count: Integer;
  compradorNome: String;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilter;
begin
  filter := TVendaLoteFilter.CreateVendaLoteFilterEmpty();
  try
    compradorNome := 'JOSÉ';

    count := TestDB.GetUniTableIntf(Format(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + '] AS v '
    + 'INNER JOIN ' + PESSOA_TABLE_NAME + ' AS c ON v.COMPRADOR_ID = c.ID '
    + 'WHERE c.NOME LIKE "%s%s"', [compradorNome, '%'])
    ).Fields[0].Value;

    filter.Comprador.Nome := compradorNome;
    vendaLotes := FFilterVendaLoteFinder.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderTest.TestFindFilterByCompradorCpfCnpjEquals;
var
  count: Integer;
  compradorCpfCnpj: String;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilter;
begin
  filter := TVendaLoteFilter.CreateVendaLoteFilterEmpty();
  try
    compradorCpfCnpj := '14.175.522/0001-39';

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + '] AS v '
    + 'INNER JOIN ' + PESSOA_TABLE_NAME + ' AS c ON v.COMPRADOR_ID = c.ID '
    + 'WHERE c.CPF_CNPJ = ?', [compradorCpfCnpj]
    ).Fields[0].Value;

    filter.Comprador.CpfCnpj := compradorCpfCnpj;
    vendaLotes := FFilterVendaLoteFinder.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderTest.TestFindFilterByLoteDescricaoLikeStart;
var
  count: Integer;
  loteDescricao: String;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilter;
begin
  filter := TVendaLoteFilter.CreateVendaLoteFilterEmpty();
  try
    loteDescricao := 'TERRENO';

    count := TestDB.GetUniTableIntf(Format(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + '] AS v '
    + 'INNER JOIN ' + LOTE_TABLE_NAME + ' AS l ON v.LOTE_ID = l.ID '
    + 'WHERE l.DESCRICAO LIKE "%s%s"', [loteDescricao, '%'])
    ).Fields[0].Value;

    filter.Lote.Descricao := loteDescricao;
    vendaLotes := FFilterVendaLoteFinder.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderTest.TestFindFilterByLoteNumeroEquals;
var
  count: Integer;
  loteNumero: String;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilter;
begin
  filter := TVendaLoteFilter.CreateVendaLoteFilterEmpty();
  try
    loteNumero := '1010';

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + '] AS v '
    + 'INNER JOIN ' + LOTE_TABLE_NAME + ' AS l ON v.LOTE_ID = l.ID '
    + 'WHERE l.NUMERO = ?', [loteNumero]
    ).Fields[0].Value;

    filter.Lote.Numero := loteNumero;
    vendaLotes := FFilterVendaLoteFinder.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

{$ENDREGION}

{$REGION 'TFilterVendaLoteFinderReportTest' }

procedure TFilterVendaLoteFinderReportTest.Setup;
var
  vendaLoteRepository: IPagedRepository<TVendaLote,Integer>;
begin
  vendaLoteRepository := TSimpleRepository<TVendaLote,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FFilterVendaLoteFinderReport := TFilterVendaLoteFinderReport.Create(vendaLoteRepository);

  FVendaLotes := GetDefaultVendaLotes();
  FVendaLoteDataInsert := InsertCompradoresAndLotesAndVenda(FVendaLotes);
end;

procedure TFilterVendaLoteFinderReportTest.TearDown;
begin
  ClearTables();
end;

procedure TFilterVendaLoteFinderReportTest.TestFindWhithoutFilter;
var
  count: Integer;
  lotes: IList<TVendaLote>;
begin
  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + VENDA_LOTE_TABLE_NAME + ']').Fields[0].Value;
  lotes := FFilterVendaLoteFinderReport.Find(nil);

  Assert.IsNotNull(lotes, 'Nenhuma Venda de Lotes localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');
end;

procedure TFilterVendaLoteFinderReportTest.TestFindFilterByCompradorId;
var
  count: Integer;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilterReport;
begin
  filter := TVendaLoteFilterReport.CreateVendaLoteFilterReportEmpty();
  try
    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + ']'
    + 'WHERE COMPRADOR_ID = ?', [FVendaLoteDataInsert.CompradorIds.First.AsInteger]).Fields[0].Value;

    filter.Comprador.Id := FVendaLoteDataInsert.CompradorIds.First.AsInteger;
    vendaLotes := FFilterVendaLoteFinderReport.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhum Lote localizado');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderReportTest.TestFindFilterByDataBetween;
var
  count: Integer;
  dataVendaInicial, dataVendaFinal: TDate;
  vendaLotes: IList<TVendaLote>;
  filter: TVendaLoteFilterReport;
begin
  filter := TVendaLoteFilterReport.CreateVendaLoteFilterReportEmpty();
  try
    dataVendaInicial := Trunc(IncMonth(Date(), -4));
    dataVendaFinal := Trunc(IncMonth(Date(), 4));

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + VENDA_LOTE_TABLE_NAME + ']'
    + 'WHERE DATA BETWEEN ? AND ?', [
        dataVendaInicial.ToDateISOString(),
        dataVendaFinal.ToDateISOString()]
    ).Fields[0].Value;

    filter.DataVendaInicial := dataVendaInicial;
    filter.DataVendaInicial := dataVendaFinal;
    vendaLotes := FFilterVendaLoteFinderReport.Find(filter);

    Assert.IsNotNull(vendaLotes, 'Nenhuma Venda de Lotes localizada');
    Assert.AreEqual(count, vendaLotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterVendaLoteFinderReportTest.TestFindFilterByTipo;
const
  VENDA_LOTE_SELECT_COUNT_BY_TIPO =
    'SELECT COUNT(*) FROM '
  + '[' + VENDA_LOTE_TABLE_NAME + '] AS v '
  + 'INNER JOIN ' + LOTE_TABLE_NAME + ' AS l ON v.LOTE_ID = l.ID '
  + 'WHERE l.TIPO = %d';
var
  countAnimal, countImovel, countPrenda: Integer;
  lotesAnimal, lotesImovel, lotesPrenda: IList<TVendaLote>;
  filter: TVendaLoteFilterReport;
begin
  filter := TVendaLoteFilterReport.CreateVendaLoteFilterReportEmpty();
  try
    countAnimal := TestDB.GetUniTableIntf(
      Format(VENDA_LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlAnimal.ToInteger()])
    ).Fields[0].Value;

    countImovel := TestDB.GetUniTableIntf(
      Format(VENDA_LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlImovel.ToInteger()])
    ).Fields[0].Value;

    countPrenda := TestDB.GetUniTableIntf(
      Format(VENDA_LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlPrenda.ToInteger()])
    ).Fields[0].Value;

    filter.Tipo := Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlAnimal;
    lotesAnimal := FFilterVendaLoteFinderReport.Find(filter);

    filter.Tipo := Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlImovel;
    lotesImovel := FFilterVendaLoteFinderReport.Find(filter);

    filter.Tipo := Syslei.Models.Domains.Lote.Venda.Filter.TTipoLote.tlPrenda;
    lotesPrenda := FFilterVendaLoteFinderReport.Find(filter);

    Assert.IsNotNull(lotesAnimal, 'Nenhuma Venda de Lote Animal localizado');
    Assert.AreEqual(countAnimal, lotesAnimal.Count, 'Total de registros de Lotes Animal difere dos experados');
    Assert.IsNotNull(lotesImovel, 'Nenhuma Venda de Lote Imóvel localizado');
    Assert.AreEqual(countImovel, lotesImovel.Count, 'Total de registros de Lotes Imóvel difere dos experados');
    Assert.IsNotNull(lotesPrenda, 'Nenhuma Venda de Lote Prenda localizada');
    Assert.AreEqual(countPrenda, lotesPrenda.Count, 'Total de registros de Lotes Prenda difere dos experados');
  finally
    filter.Free;
  end;
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TFilterVendaLoteFinderTest);
  TDUnitX.RegisterTestFixture(TFilterVendaLoteFinderReportTest);

end.
