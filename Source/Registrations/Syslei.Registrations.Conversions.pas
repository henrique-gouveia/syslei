unit Syslei.Registrations.Conversions;

interface

uses
  Syslei.Registrations.SpringRegisters,
  Spring.Container;

type
  TConversionsRegiterType = class(TSpringRegisterType)
  public
    procedure RegistryType(const container: TContainer); override;
  end;

implementation

uses
  DSharp.Core.DataConversion,
  Syslei.Conversions.Consts,
  Syslei.Conversions.ControlString,
  Syslei.Conversions.Lote.ObjectListDataSet.FireDAC,
  Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC,
  Syslei.Conversions.Proprio.ObjectListDataSet.FireDAC;

{$REGION 'TConversionsRegiterType' }

procedure TConversionsRegiterType.RegistryType(const container: TContainer);
begin
  inherited;
  container
    .RegisterType<TControlStringConverter>(CONVERSION_CONTROL_STRING_NAME);

  container
    .RegisterType<TObjectListLoteDataSetConverter>(CONVERSION_OBJECTLIST_LOTEDATASET_NAME);

  container
    .RegisterType<TObjectListProprioDataSetConverter>(CONVERSION_OBJECTLIST_PROPRIODATASET_NAME);

  container
    .RegisterType<TObjectListVendaLoteDataSetConverter>(CONVERSION_OBJECTLIST_VENDALOTEDATASET_NAME);
end;

{$ENDREGION}

end.
