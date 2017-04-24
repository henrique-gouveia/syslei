{******************************************************************************}
{                                                                              }
{  Copyright (c) 2017, Henrique Gouveia                                        }
{                                                                              }
{  Redistribution and use in source and binary forms, with or without          }
{  modification, are permitted provided that the following conditions are met: }
{                                                                              }
{    1. Redistributions of source code must retain the above copyright notice, }
{    this list of conditions and the following disclaimer.                     }
{                                                                              }
{    2. Redistributions in binary form must reproduce the above copyright      }
{    notice, this list of conditions and the following disclaimer in the       }
{    documentation and/or other materials provided with the distribution.      }
{                                                                              }
{    3. Neither the name of the copyright holder nor the names of its          }
{    contributors may be used to endorse or promote products derived from      }
{    this software without specific prior written permission.                  }
{                                                                              }
{  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" }
{  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE   }
{  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE  }
{  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE   }
{  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR         }
{  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF        }
{  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS    }
{  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     }
{  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)     }
{  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE  }
{  POSSIBILITY OF SUCH DAMAGE.                                                 }
{                                                                              }
{******************************************************************************}

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
