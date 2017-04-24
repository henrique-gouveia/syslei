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

unit Syslei.Tests.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

interface

uses
  DUnitX.TestFramework,
  DSharp.Core.DataConversion,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Lote.Venda;

type
  [TestFixture]
  TObjectListVendaLoteDataSetConverterTest = class
  private
    FConverter: IValueConverter;
    FLoteRepository: IPagedRepository<TVendaLote, Integer>;
  public
    [Setup]
    procedure Setup;

    [Test]
    procedure TestConvert;
  end;

implementation

uses
  Data.DB,

  Spring.Collections,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestSession,

  Syslei.Conversions.Lote.Venda.ObjectListDataSet.FireDAC;

{$REGION 'TObjectListVendaLoteDataSetConverterTest' }

procedure TObjectListVendaLoteDataSetConverterTest.Setup;
begin
  FConverter := TObjectListVendaLoteDataSetConverter.Create(nil);
  FLoteRepository := TSimpleRepository<TVendaLote, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TObjectListVendaLoteDataSetConverterTest.TestConvert;
var
  vendaLotes: IObjectList;
  vendaLoteDataSet: TDataSet;

  I, compradorId, doadorId, loteId: Integer;
begin
  doadorId := InsertPessoa();
  loteId := InsertLote(doadorId);

  compradorId := InsertPessoa();
  for I := 1 to 10 do
    InsertVendaLote(compradorId, loteId);

  vendaLotes := FLoteRepository.FindAll() as IObjectList;
  vendaLoteDataSet := FConverter.Convert(TValue.From<IObjectList>(vendaLotes)).AsType<TDataSet>();

  Assert.IsNotNull(vendaLoteDataSet);
  Assert.AreEqual(vendaLotes.Count, vendaLoteDataSet.RecordCount);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TObjectListVendaLoteDataSetConverterTest);

end.
