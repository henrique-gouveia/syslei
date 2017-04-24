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

unit Syslei.Conversions.Proprio.ObjectListDataSet.FireDAC;

interface

uses
  System.SysUtils,
  System.Classes,

  DSharp.Core.DataConversion,

  Data.DB,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TObjectListProprioDataSetConverter = class(TDataModule, IValueConverter)
    proprioDataSet: TFDMemTable;
    proprioDataSetId: TIntegerField;
    proprioDataSetNome: TStringField;
    proprioDataSetCpfCnpj: TStringField;
    proprioDataSetTelefone: TStringField;
  protected
    function Convert(const Value: TValue): TValue;
    function ConvertBack(const Value: TValue): TValue;

    procedure AppendPessoaDataSet(const arg: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.StrUtils,
  Spring.Collections,
  Syslei.Models.Entities.Proprio;

{$REGION 'TObjectListProprioDataSetConverter' }

constructor TObjectListProprioDataSetConverter.Create(AOwner: TComponent);
begin
  inherited;
  proprioDataSet.Open();
end;

function TObjectListProprioDataSetConverter.Convert(const Value: TValue): TValue;
var
  proprios: IObjectList;
begin
  if Value.TryAsType<IObjectList>(proprios) then
  begin
    proprioDataSet.EmptyDataSet();
    proprios.ForEach(AppendPessoaDataSet);
    Result := proprioDataSet;
  end;
end;

procedure TObjectListProprioDataSetConverter.AppendPessoaDataSet(const arg: TObject);
var
  pessoa: TProprio;
begin
  pessoa := TProprio(arg);

  proprioDataSet.Append();
  try
    proprioDataSetId.AsInteger := pessoa.Id;
    proprioDataSetNome.AsString := pessoa.Nome;
    proprioDataSetCpfCnpj.AsString := pessoa.CpfCnpj;
    proprioDataSetTelefone.AsString := pessoa.Telefone;
  finally
    proprioDataSet.Post();
  end;
end;

function TObjectListProprioDataSetConverter.ConvertBack(const Value: TValue): TValue;
begin

end;

{$ENDREGION}

end.
