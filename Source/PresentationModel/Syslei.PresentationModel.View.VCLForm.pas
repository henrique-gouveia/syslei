unit Syslei.PresentationModel.View.VCLForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  Vcl.Forms,
  Syslei.PresentationModel.View.Interfaces;

type
  TForm = class(Vcl.Forms.TForm, IView)
  private
    FDataContext: TObject;
    FRefCount: Integer;
  protected
    // IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    // IDataContextable
    function GetDataContext: TObject; virtual;
    procedure SetDataContext(const value: TObject); virtual;

    // IView
    procedure ShowView;
    function ShowModalView: Integer;

    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create; reintroduce; overload; virtual;
    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;
  end;
implementation

{$REGION 'TForm' }

constructor TForm.Create;
begin
  inherited Create(nil);
end;

class function TForm.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TForm(Result).FRefCount := 1;
end;

procedure TForm.AfterConstruction;
begin
  Dec(FRefCount);
end;

function TForm.GetDataContext: TObject;
begin
  Result := FDataContext;
end;

procedure TForm.SetDataContext(const value: TObject);
begin
  FDataContext := value;
end;

procedure TForm.ShowView;
begin
  Show;
end;

function TForm.ShowModalView: Integer;
begin
  Result := ShowModal;
end;

procedure TForm.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg in [WM_SETCURSOR, WM_SETFOCUS]) then
    ActiveChanged;
end;

function TForm._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TForm._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Destroy;
end;

{$ENDREGION}

end.
