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

unit Syslei.Tests.Finders.Pessoa.Simple;

interface

uses
  DUnitX.TestFramework,

  Syslei.Models.Entities.Pessoa,
  Syslei.Models.Finders.Interfaces,

  Spring.Persistence.Core.Interfaces;

type
  [TestFixture]
  TSimplePessoaFinderTest = class
  private
    FSimplePessoaFinder: IEntityFinder<TPessoa>;
    procedure InsertPessoas;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestFindWithCriteriaAndRestrictionEqual;
    [Test]
    procedure TestFindWithCriteriaAndRestrictionLikeAnyware;
    [Test]
    procedure TestFindWithCriteriaAndRestrictionLikeStart;
  end;

implementation

uses
  System.SysUtils,

  Spring.Collections,
  Spring.Persistence.Core.Repository.Simple,

  Syslei.Models.Finders.Simple,

  Syslei.Tests.TestDB,
  Syslei.Tests.TestSession;

{$REGION 'TFinderPessoaTest' }

procedure TSimplePessoaFinderTest.Setup;
var
  pessoaRepository: IPagedRepository<TPessoa,Integer>;
begin
  pessoaRepository := TSimpleRepository<TPessoa,Integer>.Create(
    TTestSession.GetInstance().GetSession());

  FSimplePessoaFinder := TSimpleEntityFinder<TPessoa, Integer>.Create(pessoaRepository);

  InsertPessoas();
end;

var
  Nomes: array of String = ['JOÃO', 'MARIA', 'JOSÉ'];

procedure TSimplePessoaFinderTest.InsertPessoas;
var
  nome: String;
begin
  for nome in Nomes do
    InsertPessoa(nome);
end;

procedure TSimplePessoaFinderTest.TearDown;
begin
  ClearTables();
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionEqual;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindEqual('NOME', 'JOSÉ');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(1, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[2]);
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionLikeAnyware;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindLikeAnyware('NOME', 'JO');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(2, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[0]);
  Assert.AreEqual(pessoas.Items[1].Nome, Nomes[2]);
end;

procedure TSimplePessoaFinderTest.TestFindWithCriteriaAndRestrictionLikeStart;
var
  pessoas: IList<TPessoa>;
begin
  pessoas := FSimplePessoaFinder.FindLikeStart('NOME', 'M');

  Assert.IsNotNull(pessoas, 'Nenhuma Pessoa localizada');
  Assert.AreEqual(1, pessoas.Count, 'Total de registros difere dos experados');
  Assert.AreEqual(pessoas.Items[0].Nome, Nomes[1]);
end;

{$ENDREGION}

initialization
  TDUnitX.RegisterTestFixture(TSimplePessoaFinderTest);

end.
