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

unit Syslei.Models.Domains.Lote.Filter;

interface
uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Pessoa;

type
  TStatusLote = (slAguardando, slAgendado, slArrematado, slTodos);
  TTipoLote = (tlAnimal, tlImovel, tlPrenda, tlTodos);

  TLoteFilter = class
  private
    FDoador: TPessoa;
    FDataCadastroFinal: TDate;
    FDataCadastroInicial: TDate;
    FStatus: TStatusLote;
    FTipo: TTipoLote;
    procedure SetDataCadastroFinal(const Value: TDate);
    procedure SetDataCadastroInicial(const Value: TDate);
    procedure SetDoador(const Value: TPessoa);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    class function CreateLoteFilterEmpty: TLoteFilter; inline; static;

    property Doador: TPessoa read FDoador write SetDoador;

    property DataCadastroInicial: TDate read FDataCadastroInicial write SetDataCadastroInicial;
    property DataCadastroFinal: TDate read FDataCadastroFinal write SetDataCadastroFinal;

    property Status: TStatusLote read FStatus write FStatus default slTodos;
    property Tipo: TTipoLote read FTipo write FTipo default tlTodos;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TLoteFilter' }

constructor TLoteFilter.Create;
begin
  inherited;
  FDoador := TPessoa.Create;
  FDataCadastroInicial := Date();
  FDataCadastroFinal := Date();
  FStatus := TStatusLote.slTodos;
  FTipo := TTipoLote.tlTodos;
end;

destructor TLoteFilter.Destroy;
begin
  FreeAndNil(FDoador);
  inherited;
end;

class function TLoteFilter.CreateLoteFilterEmpty: TLoteFilter;
begin
  Result := TLoteFilter.Create;
  Result.DataCadastroInicial := 0;
  Result.DataCadastroFinal := 0;
end;

procedure TLoteFilter.SetDataCadastroFinal(const Value: TDate);
begin
  FDataCadastroFinal := Trunc(Value);
end;

procedure TLoteFilter.SetDataCadastroInicial(const Value: TDate);
begin
  FDataCadastroInicial := Trunc(Value);
end;

procedure TLoteFilter.SetDoador(const Value: TPessoa);
begin
  if Assigned(FDoador) then
    FreeAndNil(FDoador);

  if Assigned(Value) then
    FDoador := Value
  else
    FDoador := TPessoa.Create;
end;

{$ENDREGION}

end.
