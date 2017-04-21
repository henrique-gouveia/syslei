unit Syslei.Tests.Conversions.Lote.ObjectListDataSet.FireDAC;

interface

uses
  DUnitX.TestFramework,
  DSharp.Core.DataConversion,
  Spring.Persistence.Core.Interfaces,  
  Syslei.Models.Entities.Lote;

type
  [TestFixture]
  TObjectListLoteDataSetConverterTest = class
  private
    FConverter: IValueConverter;
    FLoteRepository: IPagedRepository<TLote, Integer>;
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

  Syslei.Conversions.Lote.ObjectListDataSet.FireDAC;

{$REGION 'TObjectListLoteDataSetConverterTest' }

procedure TObjectListLoteDataSetConverterTest.Setup;
begin
  FConverter := TObjectListLoteDataSetConverter.Create(nil);
  FLoteRepository := TSimpleRepository<TLote, Integer>.Create(
    TTestSession.GetInstance().GetSession());  
end;

procedure TObjectListLoteDataSetConverterTest.TestConvert;
var
  lotes: IObjectList;
  loteDataSet: TDataSet;

  I, doadorId: Integer;
begin
  doadorId := InsertPessoa();
  for I := 1 to 10 do
    InsertLote(doadorId);

  lotes := FLoteRepository.FindAll() as IObjectList;
  loteDataSet := FConverter.Convert(TValue.From<IObjectList>(lotes)).AsType<TDataSet>();

  Assert.IsNotNull(loteDataSet);
  Assert.AreEqual(lotes.Count, loteDataSet.RecordCount);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TObjectListLoteDataSetConverterTest);
  
end.
