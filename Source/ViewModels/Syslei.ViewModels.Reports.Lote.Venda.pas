unit Syslei.ViewModels.Reports.Lote.Venda;

interface

uses
  Syslei.Models.Entities.Lote.Venda,
  Syslei.Models.Entities.Proprio,
  Syslei.ViewModels.Base.Report,

  Spring.Collections,
  Spring.Container.Common,
  Spring.Persistence.Core.Interfaces;

type
  TVendaLoteReportViewModel = class(TReportViewModelBase)
  private
    [Inject]
    FProprioRepository: IPagedRepository<TProprio, Integer>;
    FProprios: IObjectList;
    FVendaLote: TVendaLote;

    function GetProprios: IObjectList;
    procedure SetProprios(const Value: IObjectList);
    procedure SetVendaLote(const Value: TVendaLote);
  public
    property Proprios: IObjectList read GetProprios write SetProprios;
    property VendaLote: TVendaLote read FVendaLote write SetVendaLote;
  end;

implementation

{$REGION 'TVendaLoteViewModel' }

function TVendaLoteReportViewModel.GetProprios: IObjectList;
begin
  if not Assigned(FProprios) then
    FProprios := FProprioRepository.FindAll() as IObjectList;
  Result := FProprios;
end;

procedure TVendaLoteReportViewModel.SetProprios(const Value: IObjectList);
begin
  FProprios := Value;
  DoPropertyChanged('Proprios')
end;

procedure TVendaLoteReportViewModel.SetVendaLote(const Value: TVendaLote);
begin
  FVendaLote := Value;
  if Assigned(FVendaLote) then
  begin
    Entities.Add(FVendaLote);
    DoPropertyChanged('Entities');
  end;
end;

{$ENDREGION}

end.
