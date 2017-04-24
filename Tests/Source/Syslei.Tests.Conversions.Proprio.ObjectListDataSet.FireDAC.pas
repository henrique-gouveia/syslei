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

unit Syslei.Tests.Conversions.Proprio.ObjectListDataSet.FireDAC;

interface

uses
  DUnitX.TestFramework,
  DSharp.Core.DataConversion,
  Spring.Persistence.Core.Interfaces,
  Syslei.Models.Entities.Proprio;

type
  [TestFixture]
  TObjectListProprioDataSetConverterTest = class
  private
    FConverter: IValueConverter;
    FProprioRepository: IPagedRepository<TProprio, Integer>;
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

  Syslei.Conversions.Lote.ObjectListDataSet.FireDAC;

{$REGION 'TObjectListProprioDataSetConverterTest' }

procedure TObjectListProprioDataSetConverterTest.Setup;
begin
  FConverter := TObjectListLoteDataSetConverter.Create(nil);
  FProprioRepository := TSimpleRepository<TProprio, Integer>.Create(
    TTestSession.GetInstance().GetSession());
end;

procedure TObjectListProprioDataSetConverterTest.TestConvert;
var
  proprios: IObjectList;
  proprioDataSet: TDataSet;
begin
  InsertProprio();

  proprios := FProprioRepository.FindAll() as IObjectList;
  proprioDataSet := FConverter.Convert(TValue.From<IObjectList>(proprios)).AsType<TDataSet>();

  Assert.IsNotNull(proprioDataSet);
  Assert.AreEqual(proprios.Count, proprioDataSet.RecordCount);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TObjectListProprioDataSetConverterTest);

end.
