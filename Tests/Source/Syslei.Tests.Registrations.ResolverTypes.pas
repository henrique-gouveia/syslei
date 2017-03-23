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
    procedure TestResolveDBConnection;
    [Test]
    procedure TestResolveLoteFinder;
    [Test]
    procedure TestResolvePessoaFinder;
    [Test]
    procedure TestResolveLoteRepository;
    [Test]
    procedure TestResolvePessoaRepository;
    [Test]
    procedure TestResolveVendaLoteRepository;
    [Test]
    procedure TestResolveLoteManagerView;
    [Test]
    procedure TestResolvePessoaManagerView;
    [Test]
    procedure TestResolveVendaLoteManagerView;
    [Test]
    procedure TestResolveLoteManagerViewModel;
    [Test]
    procedure TestResolvePessoaManagerViewModel;
    [Test]
    procedure TestResolveVendaLoteManagerViewModel;
    [Test]
    procedure TestResolveLoteFinderView;
    [Test]
    procedure TestResolvePessoaFinderView;
    [Test]
    procedure TestResolveLoteFinderViewModel;
    [Test]
    procedure TestResolvePessoaFinderViewModel;
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
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Pessoa,
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

    Assert.IsNotNull(connectionModuleOne, 'Tipo TFirebirdConnectionModule não foi resolvido');
    Assert.IsNotNull(connectionModuleTwo, 'Tipo TFirebirdConnectionModule não foi resolvido');
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

    Assert.IsNotNull(connectionModuleOne, 'Tipo IConnectionModule<TFDConnection> não foi resolvido');
    Assert.IsNotNull(connectionModuleTwo, 'Tipo IConnectionModule<TFDConnection> não foi resolvido');
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
    Assert.IsNotNull(controlStringConverter, 'Tipo TControlStringConverter não foi resolvido');
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

    Assert.IsNotNull(connectionOne, 'Tipo IDBConnection não foi resolvido');
    Assert.IsNotNull(connectionTwo, 'Tipo IDBConnection não foi resolvido');
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
    Assert.IsNotNull(loteFinder, 'Tipo IEntityFinder<TLote> não foi resolvido');
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
    Assert.IsNotNull(pessoaFinder, 'Tipo IEntityFinder<TPessoa> não foi resolvido');
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
    Assert.IsNotNull(loteRepository, 'Tipo IPagedRepository<TLote,Integer> não foi resolvido');
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
    Assert.IsNotNull(pessoaRepository, 'Tipo IPagedRepository<TPessoa,Integer> não foi resolvido');
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
    Assert.IsNotNull(vendaLoteRepository, 'Tipo IPagedRepository<TVendaLote,Integer> não foi resolvido');
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
    Assert.IsNotNull(loteManagerView, 'Tipo TLoteManagerView não foi resolvido');
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
    Assert.IsNotNull(pessoaManagerView, 'Tipo TPessoaManagerView não foi resolvido');
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
    Assert.IsNotNull(vendaLoteManagerView, 'Tipo TVendaLoteManagerView não foi resolvido');
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

    Assert.IsNotNull(loteManagerViewModelOne, 'Tipo TLoteManagerViewModel não foi resolvido');
    Assert.IsNotNull(loteManagerViewModelTwo, 'Tipo TLoteManagerViewModel não foi resolvido');
    Assert.AreEqual(loteManagerViewModelOne, loteManagerViewModelTwo);
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

    Assert.IsNotNull(pessoaManagerViewModelOne, 'Tipo TPessoaManagerViewModel não foi resolvido');
    Assert.IsNotNull(pessoaManagerViewModelTwo, 'Tipo TPessoaManagerViewModel não foi resolvido');
    Assert.AreEqual(pessoaManagerViewModelOne, pessoaManagerViewModelTwo);
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

    Assert.IsNotNull(vendaLoteManagerViewModelOne, 'Tipo TVendaLoteManagerViewModel não foi resolvido');
    Assert.IsNotNull(vendaLoteManagerViewModelTwo, 'Tipo TVendaLoteManagerViewModel não foi resolvido');
    Assert.AreEqual(vendaLoteManagerViewModelOne, vendaLoteManagerViewModelTwo);
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
    Assert.IsNotNull(loteFinderView, 'Tipo TLoteFinderView não foi resolvido');
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
    Assert.IsNotNull(pessoaFinderView, 'Tipo TPessoaFinderView não foi resolvido');
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

    Assert.IsNotNull(loteFinderViewModelOne, 'Tipo TLoteFinderViewModel não foi resolvido');
    Assert.IsNotNull(loteFinderViewModelTwo, 'Tipo TLoteFinderViewModel não foi resolvido');
    Assert.AreEqual(loteFinderViewModelOne, loteFinderViewModelTwo);
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

    Assert.IsNotNull(pessoaFinderViewModelOne, 'Tipo TPessoaFinderViewModel não foi resolvido');
    Assert.IsNotNull(pessoaFinderViewModelTwo, 'Tipo TPessoaFinderViewModel não foi resolvido');
    Assert.AreEqual(pessoaFinderViewModelOne, pessoaFinderViewModelTwo);
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

    Assert.IsNotNull(sessionOne, 'Tipo TSession não foi resolvido');
    Assert.IsNotNull(sessionTwo, 'Tipo TSession não foi resolvido');
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
