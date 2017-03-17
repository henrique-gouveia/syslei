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
    procedure TestResolveDBConnection;
    [Test]
    procedure TestResolveLoteRepository;
    [Test]
    procedure TestResolvePessoaRepository;
    [Test]
    procedure TestResolveSession;
  end;

implementation

uses
  System.SysUtils,

  FireDAC.Comp.Client,

  Spring.Container,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,

  Syslei.Registrations,
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa,
  Syslei.Modules.Connections.Consts,
  Syslei.Modules.Connections.Firebird,
  Syslei.Modules.Connections.Interfaces,
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
