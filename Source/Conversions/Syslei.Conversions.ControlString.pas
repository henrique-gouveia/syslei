unit Syslei.Conversions.ControlString;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  DSharp.Core.DataConversion;

type
  TControlStringConverter = class(TValueConverter)
  private
    FTargetForm: TCustomForm;
  public
    constructor Create(const targetForm: TCustomForm); reintroduce;
    function Convert(const Value: TValue): TValue; override;
    function ConvertBack(const Value: TValue): TValue; override;
  end;

implementation

{$REGION 'TControlStringConverter' }

constructor TControlStringConverter.Create(const targetForm: TCustomForm);
begin
  inherited Create;
  FTargetForm := targetForm;
end;

function TControlStringConverter.Convert(const Value: TValue): TValue;
var
  I: Integer;
begin
  for I := 0 to Pred(FTargetForm.ComponentCount) do
    if FTargetForm.Components[I].Name = Value.AsString then
    begin
      Result := FTargetForm.Components[I];
      Break;
    end;
end;

function TControlStringConverter.ConvertBack(const Value: TValue): TValue;
begin
  if (Value.AsObject <> nil) then
    Result := TControl(Value.AsObject).Name;
end;

{$ENDREGIOn}

end.
