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

unit Syslei.Tests.TestDB;

interface

uses
  System.SysUtils,
  System.Classes,
  SQLiteTable3;

type
  ETestDBTableDoesNotExist = class(Exception);

  procedure ClearTables;
  procedure CreateTables;

  function DeleteFrom(const tableName: String): Integer;

  function InsertLote(
    const doadorId: Integer;
    const descricao: String = 'LOTE';
    const numero: String = '';
    const lanceInicial: Double = 0;
    const status: Integer = 0;
    const tipo: Integer = 0;
    const idade: Integer = 0;
    const sexo: Integer = 0;
    const dataCadastro: TDate = 0): Variant;

  function InsertPessoa(
    const nome: String = 'PESSOA';
    const cpfCnpj: String = '';
    const telefone: String = '';
    const dataCadastro: TDate = 0): Variant;

  function InsertProprio(
    const nome: String = 'PROPRIO';
    const cpfCnpj: String = '';
    const telefone: String = '';
    const dataCadastro: TDate = 0): Variant;

  function InsertVendaLote(
    const compradorId: Integer;
    const loteId: Integer;
    const lanceArremate: Double = 0;
    const data: TDate = 0): Variant;

var
  TestDB: TSQLiteDatabase = nil;

implementation

uses
  Syslei.Tests.TestDB.Consts,
  Syslei.Tests.TestDB.Helpers;

procedure CreateTables;
  function TablesExists: Boolean;
  begin
    Result := TestDB.TableExists(LOTE_TABLE_NAME)
      and TestDB.TableExists(PESSOA_TABLE_NAME)
      and TestDB.TableExists(PROPRIO_TABLE_NAME)
      and TestDB.TableExists(VENDA_LOTE_TABLE_NAME);
  end;
begin
  TestDB.ExecSQL(LOTE_CREATE_COMMAND);
  TestDB.ExecSQL(PESSOA_CREATE_COMMAND);
  TestDB.ExecSQL(PROPRIO_CREATE_COMMAND);
  TestDB.ExecSQL(VENDA_LOTE_CREATE_COMMAND);

  if not (TablesExists()) then
  begin
    raise ETestDBTableDoesNotExist.Create('Tables does not exists.');
  end;
end;

procedure ClearTables;
begin
  DeleteFrom(LOTE_TABLE_NAME);
  DeleteFrom(PESSOA_TABLE_NAME);
  DeleteFrom(PROPRIO_TABLE_NAME);
  DeleteFrom(VENDA_LOTE_TABLE_NAME);
end;

function DeleteFrom(const tableName: String): Integer;
var
  affecteds: Integer;
begin
  TestDB.ExecSQL(Format(TABLE_DELETE_COMMAND, [tableName]), affecteds);
  Result := affecteds;
end;

function InsertLote(
  const doadorId: Integer;
  const descricao: String;
  const numero: String;
  const lanceInicial: Double;
  const status: Integer;
  const tipo: Integer;
  const idade: Integer;
  const sexo: Integer;
  const dataCadastro: TDate): Variant;
begin
  TestDB.ExecSQL(LOTE_INSERT_COMMAND, [
    doadorId, descricao, numero, lanceInicial, status, tipo, idade, sexo, dataCadastro.ToDateISOString()]);
  Result := TestDB.GetLastInsertRowID();;
end;

function InsertPessoa(
  const nome: String;
  const cpfCnpj: String;
  const telefone: String;
  const dataCadastro: TDate): Variant;
begin
  TestDB.ExecSQL(PESSOA_INSERT_COMMAND, [nome, cpfCnpj, telefone, dataCadastro.ToDateISOString()]);
  Result := TestDB.GetLastInsertRowID();
end;

function InsertProprio(
  const nome: String;
  const cpfCnpj: String;
  const telefone: String;
  const dataCadastro: TDate): Variant;
begin
  TestDB.ExecSQL(PROPRIO_INSERT_COMMAND, [nome, cpfCnpj, telefone, dataCadastro.ToDateISOString()]);
  Result := TestDB.GetLastInsertRowID();
end;

function InsertVendaLote(
  const compradorId: Integer;
  const loteId: Integer;
  const lanceArremate: Double;
  const data: TDate): Variant;
begin
  TestDB.ExecSQL(VENDA_LOTE_INSERT_COMMAND, [compradorId, loteId, lanceArremate, data.ToDateISOString()]);
  Result := TestDB.GetLastInsertRowID();
end;

initialization
  TestDB := TSQLiteDatabase.Create(':memory:');
  CreateTables();

finalization
  TestDB.Free;

end.
