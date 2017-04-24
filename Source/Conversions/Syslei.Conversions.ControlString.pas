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
