unit Syslei.Tests.Conversions.ControlString;

interface

uses
  System.Classes,

  Vcl.Controls,
  Vcl.Forms,

  DUnitX.TestFramework,
  DSharp.Core.DataConversion;

type
  [TestFixture]
  TControlStringTest = class
  private
    FConverter: IValueConverter;
    FTargetForm: TCustomForm;

    function CreateControl(const controlType: TComponentClass; const owner: TComponent;
      const name: String): TComponent;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestConvert;
    [Test]
    procedure TestConvertBack;
  end;

implementation

uses
  Vcl.StdCtrls,
  Syslei.Conversions.ControlString;

{$REGION 'TControlStringTest' }

procedure TControlStringTest.Setup;
begin
  FTargetForm := TForm.Create(nil);
  FTargetForm.Name := 'mainForm';

  FConverter := TControlStringConverter.Create(FTargetForm);
end;

procedure TControlStringTest.TearDown;
begin
  FTargetForm.Free;
end;

const
  CONTROL_NAME = 'controlName';

procedure TControlStringTest.TestConvert;
var
  edit: TComponent;
  control: TComponent;
begin
  edit := CreateControl(TEdit, FTargetForm, CONTROL_NAME);
  control := FConverter.Convert(CONTROL_NAME).AsType<TComponent>();

  Assert.IsNotNull(control);
  Assert.AreEqual(edit, control);
end;

procedure TControlStringTest.TestConvertBack;
var
  edit: TComponent;
  controlName: String;
begin
  edit := CreateControl(TEdit, FTargetForm, CONTROL_NAME);
  controlName := FConverter.ConvertBack(edit).AsString;

  Assert.IsNotEmpty(controlName);
  Assert.AreEqual(CONTROL_NAME, controlName);
end;

function TControlStringTest.CreateControl(const controlType: TComponentClass; const owner: TComponent;
  const name: String): TComponent;
begin
  Result := controlType.Create(owner);
  Result.Name := name;
end;


{$ENDREGION}

initialization
  TDunitX.RegisterTestFixture(TControlStringTest);

end.
