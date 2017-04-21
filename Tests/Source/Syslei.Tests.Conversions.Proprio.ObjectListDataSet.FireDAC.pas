unit Syslei.Tests.Conversions.Proprio.ObjectListDataSet.FireDAC;

interface

uses
  DUnitX.TestFramework,
  DSharp.Core.DataConversion,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Proprio;

type
  [TestFixture]
  TObjectListProprioDataSetConverterTest = class
  private
    FConverter: IValueConverter;
    FProprioRepository: IPagedRepository<TProprio, Integer>;
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

{$REGION 'TObjectListProprioDataSetConverterTest' }

procedure TObjectListProprioDataSetConverterTest.Setup;
begin
  FConverter := TObjectListLoteDataSetConverter.Create(nil);
  FProprioRepository := TSimpleRepository<TProprio, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TObjectListProprioDataSetConverterTest.TestConvert;
var
  proprios: IObjectList;
  proprioDataSet: TDataSet;
begin
  InsertProprio();

  proprios := FProprioRepository.FindAll() as IObjectList;
  proprioDataSet := FConverter.Convert(TValue.From<IObjectList>(proprios)).AsType<TDataSet>();

  Assert.IsNotNull(proprioDataSet);
  Assert.AreEqual(proprios.Count, proprioDataSet.RecordCount);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TObjectListProprioDataSetConverterTest);

end.
