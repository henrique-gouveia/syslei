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

unit Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

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
  TObjectListVendaLoteDataSetConverter = class(TDataModule, IValueConverter)
    vendaLoteDataSet: TFDMemTable;
    vendaLoteDataSetId: TIntegerField;
    vendaLoteDataSetData: TDateField;
    vendaLoteDataSetLanceArremate: TCurrencyField;
    vendaLoteDataSetCompradorId: TIntegerField;
    vendaLoteDataSetCompradorNome: TStringField;
    vendaLoteDataSetCompradorCpfCnpj: TStringField;
    vendaLoteDataSetCompradorTelefone: TStringField;
    vendaLoteDataSetLoteId: TIntegerField;
    vendaLoteDataSetLoteNumero: TStringField;
    vendaLoteDataSetLoteDescricao: TStringField;
    vendaLoteDataSetLoteTipo: TStringField;
    vendaLoteDataSetLoteIdade: TIntegerField;
    vendaLoteDataSetLoteSexo: TStringField;
  private
    function Convert(const Value: TValue): TValue;
    function ConvertBack(const Value: TValue): TValue;

    procedure AppendVendaDataSet(const arg: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.StrUtils,
  Spring.Collections,
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Helpers,
  Syslei.Models.Entities.Lote.Venda;

{$REGION 'TObjectListVendaLoteDataSetConverter' }

constructor TObjectListVendaLoteDataSetConverter.Create(AOwner: TComponent);
begin
  inherited;
  vendaLoteDataSet.Open();
end;

function TObjectListVendaLoteDataSetConverter.Convert(const Value: TValue): TValue;
var
  vendasLote: IObjectList;
begin
  if Value.TryAsType<IObjectList>(vendasLote) then
  begin
    vendaLoteDataSet.EmptyDataSet();
    vendasLote.ForEach(AppendVendaDataSet);
    Result := vendaLoteDataSet;
  end;
end;

procedure TObjectListVendaLoteDataSetConverter.AppendVendaDataSet(const arg: TObject);
var
  vendaLote: TVendaLote;
begin
  vendaLote := TVendaLote(arg);

  vendaLoteDataSet.Append();
  try
    vendaLoteDataSetId.AsInteger := vendaLote.Id;
    vendaLoteDataSetData.AsDateTime := vendaLote.Data;
    vendaLoteDataSetLanceArremate.AsFloat := vendaLote.LanceArremate;

    vendaLoteDataSetCompradorId.AsInteger := vendaLote.Comprador.Id;
    vendaLoteDataSetCompradorNome.AsString := vendaLote.Comprador.Nome;
    vendaLoteDataSetCompradorCpfCnpj.AsString := vendaLote.Comprador.CpfCnpj;
    vendaLoteDataSetCompradorTelefone.AsString := vendaLote.Comprador.Telefone;

    vendaLoteDataSetLoteId.AsInteger := vendaLote.Lote.Id;
    vendaLoteDataSetLoteNumero.AsString := vendaLote.Lote.Numero;
    vendaLoteDataSetLoteDescricao.AsString := vendaLote.Lote.Descricao;
    vendaLoteDataSetLoteTipo.AsString := vendaLote.Lote.Tipo.ToLongString().ToUpper();
    vendaLoteDataSetLoteIdade.AsInteger := vendaLote.Lote.Idade;
    vendaLoteDataSetLoteSexo.AsString := vendaLote.Lote.Sexo.ToShortString();
  finally
    vendaLoteDataSet.Post();
  end;
end;

function TObjectListVendaLoteDataSetConverter.ConvertBack(const Value: TValue): TValue;
begin

end;

{$ENDREGION}

end.
