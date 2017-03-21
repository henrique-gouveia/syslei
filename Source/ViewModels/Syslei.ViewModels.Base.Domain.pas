unit Syslei.ViewModels.Base.Domain;

interface

uses
  System.Rtti;

type
  TPropertyData = class
  private
    FDescription: String;
    FName: String;
    FValue: TValue;
  public
    constructor Create(const description, name: String); overload;
    function ToString: string; override;

    property Description: String read FDescription write FDescription;
    property Name: String read FName write FName;
    property Value: TValue read FValue write FValue;
  end;

implementation

{$REGION 'TPropertyData' }

constructor TPropertyData.Create(const description, name: String);
begin
  inherited Create;
  FDescription := description;
  FName := name;
end;

function TPropertyData.ToString: string;
begin
  Result := FDescription;
end;

{$ENDREGION}

end.
