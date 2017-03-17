unit Syslei.Tests.TestSession;

interface

uses
  Spring.Persistence.Core.Session;

type
  TTestSession = class
  private class var
    FInstance: TTestSession;
  private
    FSession: TSession;
    constructor Create;
  public
    destructor Destroy; override;

    class procedure Cleanup;
    class function GetInstance: TTestSession;
    function GetSession: TSession;
  end;

implementation

uses
  Spring.Persistence.Adapters.SQLite,
  Spring.Persistence.Core.ConnectionFactory,
  Spring.Persistence.Core.Interfaces,

  Syslei.Tests.TestDB;

constructor TTestSession.Create;
var
  connection: IDBConnection;
begin
  inherited Create;
  connection := TConnectionFactory.GetInstance(dtSQLite, TestDB);
  FSession := TSession.Create(connection);
end;

destructor TTestSession.Destroy;
begin
  FSession.Free;
  inherited;
end;

class procedure TTestSession.Cleanup;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

class function TTestSession.GetInstance: TTestSession;
begin
  if not Assigned(FInstance) then
    FInstance := TTestSession.Create();
  Result := FInstance;
end;

function TTestSession.GetSession: TSession;
begin
  Result := FSession;
end;

initialization

finalization
  TTestSession.Cleanup();

end.
