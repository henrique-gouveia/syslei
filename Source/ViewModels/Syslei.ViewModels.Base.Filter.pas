unit Syslei.ViewModels.Base.Filter;

interface

uses
  Syslei.ViewModels.Base,
  Syslei.ViewModels.Interfaces,
  Spring.Collections;

type
  TFilterViewModelBase = class(TViewModelBase, IFilterViewModel)
  private
    FEntities: IObjectList;

    function GetEntities: IObjectList;
    procedure SetEntities(const Value: IObjectList);
  protected
    procedure Execute; virtual; abstract;
  public
    procedure Novo(Sender: TObject); virtual;
    procedure Ok(Sender: TObject); virtual;

    property Entities: IObjectList read GetEntities write SetEntities;
  end;

implementation

{$REGION 'TFilterViewModelBase' }

procedure TFilterViewModelBase.Novo(Sender: TObject);
begin

end;

procedure TFilterViewModelBase.Ok(Sender: TObject);
begin

end;

function TFilterViewModelBase.GetEntities: IObjectList;
begin
  if not Assigned(FEntities) then
    FEntities := TCollections.CreateObjectList<TObject>() as IObjectList;
  Result := FEntities;
end;

procedure TFilterViewModelBase.SetEntities(const Value: IObjectList);
begin
  FEntities := Value;
  DoPropertyChanged('Entities');
end;

{$ENDREGION}

end.
