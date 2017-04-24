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
    procedure TestResolveFilterLoteFinder;
    [Test]
    procedure TestResolveFilterVendaLote;
    [Test]
    procedure TestResolveFilterVendaLoteReport;

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
    procedure TestResolveLoteFilterView;
    [Test]
    procedure TestResolveLoteFilterViewModel;
    [Test]
    procedure TestResolveVendaLoteFilterView;
    [Test]
    procedure TestResolveVendaLoteFilterViewModel;

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
    procedure TestResolveLoteReportView;
    [Test]
    procedure TestResolveLoteReportViewModel;
    [Test]
    procedure TestResolvePromissoriaVendaLoteReportView;
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

  Syslei.Models.Domains.Lote.Filter,
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

procedure TResolverTypeTest.TestResolveObjectListLoteDataSetConverter;
var
  objectListLoteDataSetConverter: IValueConverter;
begin
  try
    objectListLoteDataSetConverter := GlobalContainer.Resolve<IValueConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME, [nil]);
    Assert.IsNotNull(objectListLoteDataSetConverter, 'Tipo TObjectListLoteDataSetConverter não foi resolvido');
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
    Assert.IsNotNull(objectListProprioDataSetConverter, 'Tipo TObjectListProprioDataSetConverter não foi resolvido');
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
    Assert.IsNotNull(objectListVendaLoteDataSetConverter, 'Tipo TObjectListVendaLoteDataSetConverter não foi resolvido');
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

procedure TResolverTypeTest.TestResolveFilterLoteFinder;
var
  filterLoteFinder: IEntityFinder<TLote, TLoteFilter>;
begin
  try
    filterLoteFinder := GlobalContainer.Resolve<IEntityFinder<TLote, TLoteFilter>>();
    Assert.IsNotNull(filterLoteFinder, 'Tipo IEntityFinder<TLote, TLoterFilter> não foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveFilterVendaLote;
var
  filterVendaLoteFinder: IEntityFinder<TVendaLote, TVendaLoteFilter>;
begin
  try
    filterVendaLoteFinder := GlobalContainer.Resolve<IEntityFinder<TVendaLote, TVendaLoteFilter>>();
    Assert.IsNotNull(filterVendaLoteFinder, 'Tipo IEntityFinder<TLote, TVendaLoterFilter> não foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveFilterVendaLoteReport;
var
  filterVendaLoteFinderReport: IEntityFinder<TVendaLote, TVendaLoteFilterReport>;
begin
  try
    filterVendaLoteFinderReport := GlobalContainer.Resolve<IEntityFinder<TVendaLote, TVendaLoteFilterReport>>();
    Assert.IsNotNull(filterVendaLoteFinderReport, 'Tipo IEntityFinder<TVendaLote, TVendaLoteFilterReport> não foi resolvido');
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

procedure TResolverTypeTest.TestResolveVendaLoteFinder;
var
  vendaLoteFinder: IEntityFinder<TVendaLote, TVendaLoteFilter>;
begin
  try
    vendaLoteFinder := GlobalContainer.Resolve<IEntityFinder<TVendaLote, TVendaLoteFilter>>();
    Assert.IsNotNull(vendaLoteFinder, 'Tipo IEntityFinder<TVendaLote, TVendaLoteFilter> não foi resolvido');
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

procedure TResolverTypeTest.TestResolveProprioRepository;
var
  proprioRepository: IPagedRepository<TProprio,Integer>;
begin
  try
    proprioRepository := GlobalContainer.Resolve<IPagedRepository<TProprio,Integer>>();
    Assert.IsNotNull(proprioRepository, 'Tipo IPagedRepository<TProprio,Integer> não foi resolvido');
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

procedure TResolverTypeTest.TestResolveLoteFilterView;
var
  loteFilterView: IView;
begin
  try
    loteFilterView := GlobalContainer.Resolve<IView>(LOTE_FILTER_VIEW_NAME);
    Assert.IsNotNull(loteFilterView, 'Tipo TLoteFilterView não foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveLoteFilterViewModel;
var
  loteFilterViewModelOne, loteFilterViewModelTwo: TObject;
begin
  try
    loteFilterViewModelOne := GlobalContainer.Resolve<TObject>(LOTE_FILTER_VIEW_MODEL_NAME);
    loteFilterViewModelTwo := GlobalContainer.Resolve<TObject>(LOTE_FILTER_VIEW_MODEL_NAME);

    Assert.IsNotNull(loteFilterViewModelOne, 'Tipo TLoteFilterViewModel não foi resolvido');
    Assert.IsNotNull(loteFilterViewModelTwo, 'Tipo TLoteFilterViewModel não foi resolvido');
    Assert.AreEqual(loteFilterViewModelOne, loteFilterViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteFilterView;
var
  vendaLoteFilterView: IView;
begin
  try
    vendaLoteFilterView := GlobalContainer.Resolve<IView>(VENDA_LOTE_FILTER_VIEW_NAME);
    Assert.IsNotNull(vendaLoteFilterView, 'Tipo TVendaLoteFilterView não foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolveVendaLoteFilterViewModel;
var
  vendaLoteFilterViewModelOne, vendaLoteFilterViewModelTwo: TObject;
begin
  try
    vendaLoteFilterViewModelOne := GlobalContainer.Resolve<TObject>(VENDA_LOTE_FILTER_VIEW_MODEL_NAME);
    vendaLoteFilterViewModelTwo := GlobalContainer.Resolve<TObject>(VENDA_LOTE_FILTER_VIEW_MODEL_NAME);

    Assert.IsNotNull(vendaLoteFilterViewModelOne, 'Tipo TVendaLoteFilterViewModel não foi resolvido');
    Assert.IsNotNull(vendaLoteFilterViewModelTwo, 'Tipo TVendaLoteFilterViewModel não foi resolvido');
    Assert.AreEqual(vendaLoteFilterViewModelOne, vendaLoteFilterViewModelTwo);
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

procedure TResolverTypeTest.TestResolveVendaLoteFinderView;
var
  vendaLoteFinderView: IView;
begin
  try
    vendaLoteFinderView := GlobalContainer.Resolve<IView>(VENDA_LOTE_FINDER_VIEW_NAME);
    Assert.IsNotNull(vendaLoteFinderView, 'Tipo TVendaLoteFinderView não foi resolvido');
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

    Assert.IsNotNull(vendaLoteFinnderViewModelOne, 'Tipo TVendaLoteFinderViewModel não foi resolvido');
    Assert.IsNotNull(vendaLoteFinderViewModelTwo, 'Tipo TVendaLoteFinderViewModel não foi resolvido');
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
    Assert.IsNotNull(loteManagerView, 'Tipo TLoteManagerView não foi resolvido');
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

procedure TResolverTypeTest.TestResolveProprioManagerView;
var
  proprioManagerView: IView;
begin
  try
    proprioManagerView := GlobalContainer.Resolve<IView>(PROPRIO_MANAGER_VIEW_NAME);
    Assert.IsNotNull(proprioManagerView, 'Tipo TProprioManagerView não foi resolvido');
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

    Assert.IsNotNull(proprioManagerViewModelOne, 'Tipo TProprioManagerViewModel não foi resolvido');
    Assert.IsNotNull(proprioManagerViewModelTwo, 'Tipo TProprioManagerViewModel não foi resolvido');
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
    Assert.IsNotNull(vendaLoteManagerView, 'Tipo TVendaLoteManagerView não foi resolvido');
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

procedure TResolverTypeTest.TestResolveLoteReportView;
var
  loteReportView: IReportPreview;
begin
  try
    loteReportView := GlobalContainer.Resolve<IReportPreview>(LOTE_REPORT_VIEW_NAME);
    Assert.IsNotNull(loteReportView, 'Tipo TLoteReportView não foi resolvido');
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end
end;

procedure TResolverTypeTest.TestResolveLoteReportViewModel;
var
  loteReportViewModelOne, loteReportViewModelTwo: TObject;
begin
  try
    loteReportViewModelOne := GlobalContainer.Resolve<TObject>(LOTE_REPORT_VIEW_MODEL_NAME);
    loteReportViewModelTwo := GlobalContainer.Resolve<TObject>(LOTE_REPORT_VIEW_MODEL_NAME);

    Assert.IsNotNull(loteReportViewModelOne, 'Tipo TLoteReportViewModel não foi resolvido');
    Assert.IsNotNull(loteReportViewModelTwo, 'Tipo TLoteReportViewModel não foi resolvido');
    Assert.AreEqual(loteReportViewModelOne, loteReportViewModelTwo);
  except
    on E: Exception do
      Assert.Fail(E.Message);
  end;
end;

procedure TResolverTypeTest.TestResolvePromissoriaVendaLoteReportView;
var
  promissoriaVendaLoteReportView: IReportPreview;
begin
  try
    promissoriaVendaLoteReportView := GlobalContainer.Resolve<IReportPreview>(PROMISSORIA_VENDA_LOTE_REPORT_VIEW_NAME);
    Assert.IsNotNull(promissoriaVendaLoteReportView, 'Tipo TVendaLoteReportView não foi resolvido');
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
    Assert.IsNotNull(vendaLoteReportView, 'Tipo TVendaLoteReportView não foi resolvido');
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
    vendaLoteReportViewModelOne := GlobalContainer.Resolve<TObject>(VENDA_LOTE_REPORT_VIEW_MODEL_NAME);
    vendaLoteReportViewModelTwo := GlobalContainer.Resolve<TObject>(VENDA_LOTE_REPORT_VIEW_MODEL_NAME);

    Assert.IsNotNull(vendaLoteReportViewModelOne, 'Tipo TVendaLoteReportViewModel não foi resolvido');
    Assert.IsNotNull(vendaLoteReportViewModelTwo, 'Tipo TVendaLoteReportViewModel não foi resolvido');
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
