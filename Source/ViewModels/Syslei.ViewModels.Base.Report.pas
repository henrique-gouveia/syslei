unit Syslei.ViewModels.Base.Report;

interface

uses
  Syslei.ViewModels.Base,
  Spring.Collections;

type
  TReportViewModelBase = class(TViewModelBase)
  private
    FEntities: IObjectList;
    function GetEntities: IObjectList; virtual;
    procedure SetEntities(const Value: IObjectList); virtual;
  public
    property Entities: IObjectList read GetEntities write SetEntities;
  end;

implementation

{$REGION 'TReportViewModelBase' }

function TReportViewModelBase.GetEntities: IObjectList;
begin
  if not Assigned(FEntities) then
    FEntities := TCollections.CreateObjectList<TObject>() as IObjectList;
  Result := FEntities;
end;

procedure TReportViewModelBase.SetEntities(const Value: IObjectList);
begin
  FEntities := Value;
  DoPropertyChanged('Entities');
end;

{$ENDREGION}

end.
