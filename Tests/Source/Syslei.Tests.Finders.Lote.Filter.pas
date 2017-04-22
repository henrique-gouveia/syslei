unit Syslei.Tests.Finders.Lote.Filter;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Domains.Lote.Filter,
  Syslei.Models.Entities.Lote,
  Syslei.Models.Finders.Interfaces,

  Syslei.Tests.TestDB.Lote;

type
  [TestFixture]
  TFilterLoteFinderTest = class
  private
    FFilterLoteFinder: IEntityFinder<TLote, TLoteFilter>;
    FLoteDataInsert: TDataInsert;
    FLotes: TArray<TLoteRecord>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindWhithoutFilter;
    [Test(False)]
    procedure TestFindFilterByDataCadastroBetween;
    [Test]
    procedure TestFindFilterByDoador;
    [Test]
    procedure TestFindFilterByStatus;
    [Test]
    procedure TestFindFilterByTipo;
  end;

implementation

uses
  System.SysUtils,

  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Entities.Pessoa,
  Syslei.Models.Finders.Lote.Filter,
  Syslei.Models.Domains.Lote.Filter.Helpers,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Consts,
  Syslei.Tests.TestSession;

{$REGION 'TLoteFinderTest' }

procedure TFilterLoteFinderTest.Setup;
var
  loteRepository: IPagedRepository<TLote,Integer>;
begin
  loteRepository := TSimpleRepository<TLote,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FFilterLoteFinder := TFilterLoteFinder.Create(loteRepository);

  FLotes := GetDefaultLotes();
  FLoteDataInsert := InsertDoadoresAndLotes(FLotes);
end;

procedure TFilterLoteFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TFilterLoteFinderTest.TestFindWhithoutFilter;
var
  count: Integer;
  lotes: IList<TLote>;
begin
  count := TestDB.GetUniTableIntf('SELECT COUNT(*) FROM [' + LOTE_TABLE_NAME + ']').Fields[0].Value;
  lotes := FFilterLoteFinder.Find(nil);

  Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
  Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');
end;

procedure TFilterLoteFinderTest.TestFindFilterByDataCadastroBetween;
var
  count: Integer;
  dataCadastroInicial, dataCadastroFinal: TDate;
  lotes: IList<TLote>;
  filter: TLoteFilter;
begin
  filter := TLoteFilter.CreateLoteFilterEmpty();
  try
    dataCadastroInicial := Trunc(IncMonth(Date(), -4));
    dataCadastroFinal := Trunc(IncMonth(Date(), 4));

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + LOTE_TABLE_NAME + ']'
    + 'WHERE DATA_CADASTRO BETWEEN ? AND ?', [dataCadastroInicial, dataCadastroFinal]
    ).Fields[0].Value;

    filter.DataCadastroInicial := dataCadastroInicial;
    filter.DataCadastroFinal := dataCadastroFinal;
    lotes := FFilterLoteFinder.Find(filter);

    Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
    Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterLoteFinderTest.TestFindFilterByDoador;
var
  count: Integer;
  lotes: IList<TLote>;
  filter: TLoteFilter;
  doadorRepository: IPagedRepository<TPessoa, Integer>;
begin
  filter := TLoteFilter.CreateLoteFilterEmpty();
  try
    doadorRepository := TSimpleRepository<TPessoa, Integer>.Create(
      TTestSession.GetInstance().GetSession());

    filter.Doador := doadorRepository.FindOne(FLoteDataInsert.DoadorIds.First.AsInteger);

    count := TestDB.GetUniTableIntf(
      'SELECT COUNT(*) FROM '
    + '[' + LOTE_TABLE_NAME + ']'
    + 'WHERE DOADOR_ID = ?', [FLoteDataInsert.DoadorIds.First.AsInteger]).Fields[0].Value;
    lotes := FFilterLoteFinder.Find(filter);

    Assert.IsNotNull(lotes, 'Nenhum Lote localizado');
    Assert.AreEqual(count, lotes.Count, 'Total de registros difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterLoteFinderTest.TestFindFilterByStatus;
const
  LOTE_SELECT_COUNT_BY_STATUS = 'SELECT COUNT(*) FROM ' + '[' + LOTE_TABLE_NAME + ']' + 'WHERE STATUS = %d';
var
  countAguardando, countAgendado, countArrematado: Integer;
  lotesAguardando, lotesAgendado, lotesArrematado: IList<TLote>;
  filter: TLoteFilter;
begin
  filter := TLoteFilter.CreateLoteFilterEmpty();
  try
    countAguardando := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_STATUS, [Syslei.Models.Domains.Lote.Filter.TStatusLote.slAguardando.ToInteger()])
    ).Fields[0].Value;

    countAgendado := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_STATUS, [Syslei.Models.Domains.Lote.Filter.TStatusLote.slAgendado.ToInteger()])
    ).Fields[0].Value;

    countArrematado := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_STATUS, [Syslei.Models.Domains.Lote.Filter.TStatusLote.slArrematado.ToInteger()])
    ).Fields[0].Value;

    filter.Status := Syslei.Models.Domains.Lote.Filter.TStatusLote.slAguardando;
    lotesAguardando := FFilterLoteFinder.Find(filter);

    filter.Status := Syslei.Models.Domains.Lote.Filter.TStatusLote.slAgendado;
    lotesAgendado := FFilterLoteFinder.Find(filter);

    filter.Status := Syslei.Models.Domains.Lote.Filter.TStatusLote.slArrematado;
    lotesArrematado := FFilterLoteFinder.Find(filter);

    Assert.IsNotNull(lotesAguardando, 'Nenhum Lote Aguardando localizado');
    Assert.AreEqual(countAguardando, lotesAguardando.Count, 'Total de registros de Lotes Aguardando difere dos experados');
    Assert.IsNotNull(lotesAgendado, 'Nenhum Lote Agendado localizado');
    Assert.AreEqual(countAgendado, lotesAgendado.Count, 'Total de registros de Lotes Agendados difere dos experados');
    Assert.IsNotNull(lotesArrematado, 'Nenhum Lote Arrematado localizado');
    Assert.AreEqual(countArrematado, lotesArrematado.Count, 'Total de registros de Lotes Arrematados difere dos experados');
  finally
    filter.Free;
  end;
end;

procedure TFilterLoteFinderTest.TestFindFilterByTipo;
const
  LOTE_SELECT_COUNT_BY_TIPO = 'SELECT COUNT(*) FROM '+ '[' + LOTE_TABLE_NAME + ']' + 'WHERE TIPO = %d';
var
  countAnimal, countImovel, countPrenda: Integer;
  lotesAnimal, lotesImovel, lotesPrenda: IList<TLote>;
  filter: TLoteFilter;
begin
  filter := TLoteFilter.CreateLoteFilterEmpty();
  try
    countAnimal := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Filter.TTipoLote.tlAnimal.ToInteger()])
    ).Fields[0].Value;

    countImovel := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Filter.TTipoLote.tlImovel.ToInteger()])
    ).Fields[0].Value;

    countPrenda := TestDB.GetUniTableIntf(
      Format(LOTE_SELECT_COUNT_BY_TIPO, [Syslei.Models.Domains.Lote.Filter.TTipoLote.tlPrenda.ToInteger()])
    ).Fields[0].Value;

    filter.Tipo := Syslei.Models.Domains.Lote.Filter.TTipoLote.tlAnimal;
    lotesAnimal := FFilterLoteFinder.Find(filter);

    filter.Tipo := Syslei.Models.Domains.Lote.Filter.TTipoLote.tlImovel;
    lotesImovel := FFilterLoteFinder.Find(filter);

    filter.Tipo := Syslei.Models.Domains.Lote.Filter.TTipoLote.tlPrenda;
    lotesPrenda := FFilterLoteFinder.Find(filter);

    Assert.IsNotNull(lotesAnimal, 'Nenhum Lote Animal localizado');
    Assert.AreEqual(countAnimal, lotesAnimal.Count, 'Total de registros de Lotes Animal difere dos experados');
    Assert.IsNotNull(lotesImovel, 'Nenhum Lote Imóvel localizado');
    Assert.AreEqual(countImovel, lotesImovel.Count, 'Total de registros de Lotes Imóvel difere dos experados');
    Assert.IsNotNull(lotesPrenda, 'Nenhum Lote Prenad localizado');
    Assert.AreEqual(countPrenda, lotesPrenda.Count, 'Total de registros de Lotes Prenda difere dos experados');
  finally
    filter.Free;
  end;
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TFilterLoteFinderTest);

end.
