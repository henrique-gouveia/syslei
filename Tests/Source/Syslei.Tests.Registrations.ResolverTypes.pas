unit Syslei.Tests.Registrations.ResolverTypes;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TResolverTypeTest = class
  public
    [Test]
    procedure TestResolveConnectionModuleWhenTryByConcreteClass;
    [Test]
    procedure TestResolveConnectionModuleWhenTryByInterface;

    [Test]
    procedure TestResolveControlStringConverter;
    [Test]
    procedure TestResolveObjectListLoteDataSetConverter;
    [Test]
    procedure TestResolveObjectListVendaLoteDataSetConverter;
    [Test]
    procedure TestResolveObjectListProprioDataSetConverter;

    [Test]
    procedure TestResolveDBConnection;

    [Test]
    procedure TestResolveLoteFinder;
    [Test]
    procedure TestResolvePessoaFinder;
    [Test]
    procedure TestResolveVendaLoteFinder;

    [Test]
    procedure TestResolveLoteRepository;
    [Test]
    procedure TestResolvePessoaRepository;
    [Test]
    procedure TestResolveProprioRepository;
    [Test]
    procedure TestResolveVendaLoteRepository;

    [Test]
    procedure TestResolveLoteFinderView;
    [Test]
    procedure TestResolveLoteFinderViewModel;
    [Test]
    procedure TestResolvePessoaFinderView;
    [Test]
    procedure TestResolvePessoaFinderViewModel;
    [Test]
    procedure TestResolveVendaLoteFinderView;
    [Test]
    procedure TestResolveVendaLoteFinderViewModel;

    [Test]
    procedure TestResolveLoteManagerView;
    [Test]
    procedure TestResolveLoteManagerViewModel;
    [Test]
    procedure TestResolvePessoaManagerView;
    [Test]
    procedure TestResolvePessoaManagerViewModel;
    [Test]
    procedure TestResolveProprioManagerView;
    [Test]
    procedure TestResolveProprioManagerViewModel;
    [Test]
    procedure TestResolveVendaLoteManagerView;
    [Test]
    procedure TestResolveVendaLoteManagerViewModel;

    [Test]
    procedure TestResolveVendaLoteReportView;
    [Test]
    procedure TestResolveVendaLoteReportViewModel;

    [Test]
    procedure TestResolveSession;
  end;

implementation

uses
  System.SysUtils,

  FireDAC.Comp.Client,

  DSharp.Core.DataConversion,

  Spring.Container,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,

  Syslei.Conversions.Consts,
  Syslei.Models.Domains.Lote.Venda.Filter,
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa,
  Syslei.Models.Entities.Proprio,
  Syslei.Models.Finders.Interfaces,
  Syslei.Modules.Connections.Consts,
  Syslei.Modules.Connections.Firebird,
  Syslei.Modules.Connections.Interfaces,
  Syslei.PresentationModel.View.Interfaces,
  Syslei.Registrations,
  Syslei.Views.Consts,
  Syslei.ViewModels.Consts,
  Syslei.Tests.TestSession;

{$REGION 'TSpringResolverTest' }

procedure TResolverTypeTest.TestResolveConnectionModuleWhenTryByConcreteClass;
var
  connectionModuleOne,
  connectionModuleTwo: TFirebirdConnectionModule;
begin
  try
    connectionModuleOne := GlobalContainer.Resolve<TFirebirdConnectionModule>();
    connectionModuleTwo := GlobalContainer.Resolve<TFirebirdConnectionModule>();

    Assert.IsNotNull(connectionModuleOne, 'Tipo TFirebirdConnectionModule n�o foi resolvido');
    Assert.IsNotNull(connectionModuleTwo, 'Tipo TFirebirdConnectionModule n�o foi resolvido');
    Assert.AreEqual(connectionModuleOne, connectionModuleTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveConnectionModuleWhenTryByInterface;
var
  connectionModuleOne,
  connectionModuleTwo: IConnectionModule<TFDConnection>;
begin
  try
    connectionModuleOne := GlobalContainer.Resolve<IConnectionModule<TFDConnection>>(CONNECTION_MODULE_NAME);
    connectionModuleTwo := GlobalContainer.Resolve<IConnectionModule<TFDConnection>>(CONNECTION_MODULE_NAME);

    Assert.IsNotNull(connectionModuleOne, 'Tipo IConnectionModule<TFDConnection> n�o foi resolvido');
    Assert.IsNotNull(connectionModuleTwo, 'Tipo IConnectionModule<TFDConnection> n�o foi resolvido');
    Assert.AreEqual(connectionModuleOne, connectionModuleTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveControlStringConverter;
var
  controlStringConverter: IValueConverter;
begin
  try
    controlStringConverter := GlobalContainer.Resolve<IValueConverter>(CONVERSION_CONTROL_STRING_NAME, [nil]);
    Assert.IsNotNull(controlStringConverter, 'Tipo TControlStringConverter n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveObjectListLoteDataSetConverter;
var
  objectListLoteDataSetConverter: IValueConverter;
begin
  try
    objectListLoteDataSetConverter := GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME, [nil]);
    Assert.IsNotNull(objectListLoteDataSetConverter, 'Tipo TObjectListLoteDataSetConverter n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveObjectListProprioDataSetConverter;
var
  objectListProprioDataSetConverter: IValueConverter;
begin
  try
    objectListProprioDataSetConverter := GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_PROPRIODATASET_NAME, [nil]);
    Assert.IsNotNull(objectListProprioDataSetConverter, 'Tipo TObjectListProprioDataSetConverter n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveObjectListVendaLoteDataSetConverter;
var
  objectListVendaLoteDataSetConverter: IValueConverter;
begin
  try
    objectListVendaLoteDataSetConverter := GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME, [nil]);
    Assert.IsNotNull(objectListVendaLoteDataSetConverter, 'Tipo TObjectListVendaLoteDataSetConverter n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveDBConnection;
var
  connectionOne, connectionTwo: IDBConnection;
begin
  try
    connectionOne := GlobalContainer.Resolve<IDBConnection>();
    connectionTwo := GlobalContainer.Resolve<IDBConnection>();

    Assert.IsNotNull(connectionOne, 'Tipo IDBConnection n�o foi resolvido');
    Assert.IsNotNull(connectionTwo, 'Tipo IDBConnection n�o foi resolvido');
    Assert.AreEqual(connectionOne, connectionTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteFinder;
var
  loteFinder: IEntityFinder<TLote>;
begin
  try
    loteFinder := GlobalContainer.Resolve<IEntityFinder<TLote>>();
    Assert.IsNotNull(loteFinder, 'Tipo IEntityFinder<TLote> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaFinder;
var
  pessoaFinder: IEntityFinder<TPessoa>;
begin
  try
    pessoaFinder := GlobalContainer.Resolve<IEntityFinder<TPessoa>>();
    Assert.IsNotNull(pessoaFinder, 'Tipo IEntityFinder<TPessoa> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteFinder;
var
  vendaLoteFinder: IEntityFinder<TVendaLote, TVendaLoteFilter>;
begin
  try
    vendaLoteFinder := GlobalContainer.Resolve<IEntityFinder<TVendaLote, TVendaLoteFilter>>();
    Assert.IsNotNull(vendaLoteFinder, 'Tipo IEntityFinder<TVendaLote, TVendaLoteFilter> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteRepository;
var
  loteRepository: IPagedRepository<TLote,Integer>;
begin
  try
    loteRepository := GlobalContainer.Resolve<IPagedRepository<TLote,Integer>>();
    Assert.IsNotNull(loteRepository, 'Tipo IPagedRepository<TLote,Integer> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaRepository;
var
  pessoaRepository: IPagedRepository<TPessoa,Integer>;
begin
  try
    pessoaRepository := GlobalContainer.Resolve<IPagedRepository<TPessoa,Integer>>();
    Assert.IsNotNull(pessoaRepository, 'Tipo IPagedRepository<TPessoa,Integer> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveProprioRepository;
var
  proprioRepository: IPagedRepository<TProprio,Integer>;
begin
  try
    proprioRepository := GlobalContainer.Resolve<IPagedRepository<TProprio,Integer>>();
    Assert.IsNotNull(proprioRepository, 'Tipo IPagedRepository<TProprio,Integer> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteRepository;
var
  vendaLoteRepository: IPagedRepository<TVendaLote,Integer>;
begin
  try
    vendaLoteRepository := GlobalContainer.Resolve<IPagedRepository<TVendaLote,Integer>>();
    Assert.IsNotNull(vendaLoteRepository, 'Tipo IPagedRepository<TVendaLote,Integer> n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteFinderView;
var
  loteFinderView: IView;
begin
  try
    loteFinderView := GlobalContainer.Resolve<IView>(LOTE_FINDER_VIEW_NAME);
    Assert.IsNotNull(loteFinderView, 'Tipo TLoteFinderView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteFinderViewModel;
var
  loteFinderViewModelOne, loteFinderViewModelTwo: TObject;
begin
  try
    loteFinderViewModelOne := GlobalContainer.Resolve<TObject>(LOTE_FINDER_VIEW_MODEL_NAME);
    loteFinderViewModelTwo := GlobalContainer.Resolve<TObject>(LOTE_FINDER_VIEW_MODEL_NAME);

    Assert.IsNotNull(loteFinderViewModelOne, 'Tipo TLoteFinderViewModel n�o foi resolvido');
    Assert.IsNotNull(loteFinderViewModelTwo, 'Tipo TLoteFinderViewModel n�o foi resolvido');
    Assert.AreEqual(loteFinderViewModelOne, loteFinderViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaFinderView;
var
  pessoaFinderView: IView;
begin
  try
    pessoaFinderView := GlobalContainer.Resolve<IView>(PESSOA_FINDER_VIEW_NAME);
    Assert.IsNotNull(pessoaFinderView, 'Tipo TPessoaFinderView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaFinderViewModel;
var
  pessoaFinderViewModelOne, pessoaFinderViewModelTwo: TObject;
begin
  try
    pessoaFinderViewModelOne := GlobalContainer.Resolve<TObject>(PESSOA_FINDER_VIEW_MODEL_NAME);
    pessoaFinderViewModelTwo := GlobalContainer.Resolve<TObject>(PESSOA_FINDER_VIEW_MODEL_NAME);

    Assert.IsNotNull(pessoaFinderViewModelOne, 'Tipo TPessoaFinderViewModel n�o foi resolvido');
    Assert.IsNotNull(pessoaFinderViewModelTwo, 'Tipo TPessoaFinderViewModel n�o foi resolvido');
    Assert.AreEqual(pessoaFinderViewModelOne, pessoaFinderViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteFinderView;
var
  vendaLoteFinderView: IView;
begin
  try
    vendaLoteFinderView := GlobalContainer.Resolve<IView>(VENDA_LOTE_FINDER_VIEW_NAME);
    Assert.IsNotNull(vendaLoteFinderView, 'Tipo TVendaLoteFinderView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteFinderViewModel;
var
  vendaLoteFinnderViewModelOne, vendaLoteFinderViewModelTwo: TObject;
begin
  try
    vendaLoteFinnderViewModelOne := GlobalContainer.Resolve<TObject>(VENDA_LOTE_FINDER_VIEW_MODEL_NAME);
    vendaLoteFinderViewModelTwo := GlobalContainer.Resolve<TObject>(VENDA_LOTE_FINDER_VIEW_MODEL_NAME);

    Assert.IsNotNull(vendaLoteFinnderViewModelOne, 'Tipo TVendaLoteFinderViewModel n�o foi resolvido');
    Assert.IsNotNull(vendaLoteFinderViewModelTwo, 'Tipo TVendaLoteFinderViewModel n�o foi resolvido');
    Assert.AreEqual(vendaLoteFinnderViewModelOne, vendaLoteFinderViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteManagerView;
var
  loteManagerView: IView;
begin
  try
    loteManagerView := GlobalContainer.Resolve<IView>(LOTE_MANAGER_VIEW_NAME);
    Assert.IsNotNull(loteManagerView, 'Tipo TLoteManagerView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteManagerViewModel;
var
  loteManagerViewModelOne, loteManagerViewModelTwo: TObject;
begin
  try
    loteManagerViewModelOne := GlobalContainer.Resolve<TObject>(LOTE_MANAGER_VIEW_MODEL_NAME);
    loteManagerViewModelTwo := GlobalContainer.Resolve<TObject>(LOTE_MANAGER_VIEW_MODEL_NAME);

    Assert.IsNotNull(loteManagerViewModelOne, 'Tipo TLoteManagerViewModel n�o foi resolvido');
    Assert.IsNotNull(loteManagerViewModelTwo, 'Tipo TLoteManagerViewModel n�o foi resolvido');
    Assert.AreEqual(loteManagerViewModelOne, loteManagerViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaManagerView;
var
  pessoaManagerView: IView;
begin
  try
    pessoaManagerView := GlobalContainer.Resolve<IView>(PESSOA_MANAGER_VIEW_NAME);
    Assert.IsNotNull(pessoaManagerView, 'Tipo TPessoaManagerView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePessoaManagerViewModel;
var
  pessoaManagerViewModelOne, pessoaManagerViewModelTwo: TObject;
begin
  try
    pessoaManagerViewModelOne := GlobalContainer.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME);
    pessoaManagerViewModelTwo := GlobalContainer.Resolve<TObject>(PESSOA_MANAGER_VIEW_MODEL_NAME);

    Assert.IsNotNull(pessoaManagerViewModelOne, 'Tipo TPessoaManagerViewModel n�o foi resolvido');
    Assert.IsNotNull(pessoaManagerViewModelTwo, 'Tipo TPessoaManagerViewModel n�o foi resolvido');
    Assert.AreEqual(pessoaManagerViewModelOne, pessoaManagerViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveProprioManagerView;
var
  proprioManagerView: IView;
begin
  try
    proprioManagerView := GlobalContainer.Resolve<IView>(PROPRIO_MANAGER_VIEW_NAME);
    Assert.IsNotNull(proprioManagerView, 'Tipo TProprioManagerView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveProprioManagerViewModel;
var
  proprioManagerViewModelOne, proprioManagerViewModelTwo: TObject;
begin
  try
    proprioManagerViewModelOne := GlobalContainer.Resolve<TObject>(PROPRIO_MANAGER_VIEW_MODEL_NAME);
    proprioManagerViewModelTwo := GlobalContainer.Resolve<TObject>(PROPRIO_MANAGER_VIEW_MODEL_NAME);

    Assert.IsNotNull(proprioManagerViewModelOne, 'Tipo TProprioManagerViewModel n�o foi resolvido');
    Assert.IsNotNull(proprioManagerViewModelTwo, 'Tipo TProprioManagerViewModel n�o foi resolvido');
    Assert.AreEqual(proprioManagerViewModelOne, proprioManagerViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteManagerView;
var
  vendaLoteManagerView: IView;
begin
  try
    vendaLoteManagerView := GlobalContainer.Resolve<IView>(VENDA_LOTE_MANAGER_VIEW_NAME);
    Assert.IsNotNull(vendaLoteManagerView, 'Tipo TVendaLoteManagerView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteManagerViewModel;
var
  vendaLoteManagerViewModelOne, vendaLoteManagerViewModelTwo: TObject;
begin
  try
    vendaLoteManagerViewModelOne := GlobalContainer.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME);
    vendaLoteManagerViewModelTwo := GlobalContainer.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME);

    Assert.IsNotNull(vendaLoteManagerViewModelOne, 'Tipo TVendaLoteManagerViewModel n�o foi resolvido');
    Assert.IsNotNull(vendaLoteManagerViewModelTwo, 'Tipo TVendaLoteManagerViewModel n�o foi resolvido');
    Assert.AreEqual(vendaLoteManagerViewModelOne, vendaLoteManagerViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteReportView;
var
  vendaLoteReportView: IReportPreview;
begin
  try
    vendaLoteReportView := GlobalContainer.Resolve<IReportPreview>(PROMISSORIA_VENDA_LOTE_REPORT_VIEW_NAME);
    Assert.IsNotNull(vendaLoteReportView, 'Tipo TVendaLoteReportView n�o foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteReportViewModel;
var
  vendaLoteReportViewModelOne, vendaLoteReportViewModelTwo: TObject;
begin
  try
    vendaLoteReportViewModelOne := GlobalContainer.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME);
    vendaLoteReportViewModelTwo := GlobalContainer.Resolve<TObject>(VENDA_LOTE_MANAGER_VIEW_MODEL_NAME);

    Assert.IsNotNull(vendaLoteReportViewModelOne, 'Tipo TVendaLoteReportViewModel n�o foi resolvido');
    Assert.IsNotNull(vendaLoteReportViewModelTwo, 'Tipo TVendaLoteReportViewModel n�o foi resolvido');
    Assert.AreEqual(vendaLoteReportViewModelOne, vendaLoteReportViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveSession;
var
  sessionOne, sessionTwo: TSession;
begin
  try
    sessionOne := GlobalContainer.Resolve<TSession>();
    sessionTwo := GlobalContainer.Resolve<TSession>();

    Assert.IsNotNull(sessionOne, 'Tipo TSession n�o foi resolvido');
    Assert.IsNotNull(sessionTwo, 'Tipo TSession n�o foi resolvido');
    Assert.AreEqual(sessionOne, sessionTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TResolverTypeTest);
  RegisterTypes();

end.
