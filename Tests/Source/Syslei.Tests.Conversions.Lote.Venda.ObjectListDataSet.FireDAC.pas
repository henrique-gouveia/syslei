unit Syslei.Tests.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

interface

uses
  DUnitX.TestFramework,
  DSharp.Core.DataConversion,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Lote.Venda;

type
  [TestFixture]
  TObjectListVendaLoteDataSetConverterTest = class
  private
    FConverter: IValueConverter;
    FLoteRepository: IPagedRepository<TVendaLote, Integer>;
  public
    [Setup]
    procedure Setup;

    [Test]
    procedure TestConvert;
  end;

implementation

uses
  Data.DB,

  Spring.Collections,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestSession,

  Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

{$REGION 'TObjectListVendaLoteDataSetConverterTest' }

procedure TObjectListVendaLoteDataSetConverterTest.Setup;
begin
  FConverter := TObjectListVendaLoteDataSetConverter.Create(nil);
  FLoteRepository := TSimpleRepository<TVendaLote, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TObjectListVendaLoteDataSetConverterTest.TestConvert;
var
  vendaLotes: IObjectList;
  vendaLoteDataSet: TDataSet;

  I, compradorId, doadorId, loteId: Integer;
begin
  doadorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  for I := 1 to 10 do
    InsertVendaLote(compradorId, loteId);

  vendaLotes := FLoteRepository.FindAll() as IObjectList;
  vendaLoteDataSet := FConverter.Convert(TValue.From<IObjectList>(vendaLotes)).AsType<TDataSet>();

  Assert.IsNotNull(vendaLoteDataSet);
  Assert.AreEqual(vendaLotes.Count, vendaLoteDataSet.RecordCount);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TObjectListVendaLoteDataSetConverterTest);

end.
