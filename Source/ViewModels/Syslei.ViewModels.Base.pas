unit Syslei.ViewModels.Base;

interface

uses
  System.Classes,
  Syslei.PresentationModel.Dialog,

  DSharp.Bindings.Notifications,

  Spring,
  Spring.Container.Common,
  Spring.Collections;

type
  TViewModelBase = class(TComponent, IInterface, INotifyPropertyChanged)
  private
    FActiveControl: String;
    [Inject]
    FDialog: IDialog;

    FPropertyChanged: Event<TPropertyChangedEvent>;
    FRefCount: Integer;
  protected
    // IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // INotifyPropertyChanged
    procedure DoPropertyChanged(const propertyName: string;
      updateTrigger: TUpdateTrigger = utPropertyChanged); virtual;
    function GetOnPropertyChanged: IPropertyChangedEvent; virtual;

    procedure SetActiveControl(const Value: String); virtual;
    function Validate: Boolean; virtual;

    property Dialog: IDialog read FDialog;
  public
    constructor Create; reintroduce; overload; virtual;

    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;

    property ActiveControl: String read FActiveControl write SetActiveControl;
  end;

implementation

{$REGION 'TViewModelBase' }

constructor TViewModelBase.Create;
begin
  Create(nil);
end;

class function TViewModelBase.NewInstance: TObject;
var
  interfaceTable: PInterfaceTable;
begin
  Result := inherited NewInstance;
  interfaceTable := Result.GetInterfaceTable;
  if Assigned(interfaceTable) and (interfaceTable.EntryCount > 0) then
    TViewModelBase(Result).FRefCount := 1
  else
    TViewModelBase(Result).FRefCount := 2;
end;

procedure TViewModelBase.AfterConstruction;
begin
  Dec(FRefCount);
end;

procedure TViewModelBase.DoPropertyChanged(const propertyName: string;
  updateTrigger: TUpdateTrigger);
begin
  FPropertyChanged.Invoke(Self, TPropertyChangedEventArgsEx.Create(propertyName,
    utPropertyChanged) as IPropertyChangedEventArgs);
end;

function TViewModelBase.GetOnPropertyChanged: IPropertyChangedEvent;
begin
  Result := FPropertyChanged;
end;

function TViewModelBase.Validate: Boolean;
begin
  Result := True;
end;

procedure TViewModelBase.SetActiveControl(const Value: String);
begin
  if (FActiveControl <> Value) then
  begin
    FActiveControl := Value;
    DoPropertyChanged('ActiveControl');
  end;
end;

function TViewModelBase._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TViewModelBase._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Destroy;
end;

{$ENDREGION}

end.
