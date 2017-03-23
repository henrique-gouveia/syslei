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
    const cpf: String = '';
    const telefone: String = '';
    const dataCadastro: TDate = 0): Variant;

  function InsertProprio(
    const nome: String = 'PROPRIO';
    const cpf: String = '';
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
  Syslei.Tests.TestDB.Consts;

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
    doadorId, descricao, numero, lanceInicial, status, tipo, idade, sexo, dataCadastro]);
  Result := TestDB.GetLastInsertRowID();;
end;

function InsertPessoa(
  const nome: String;
  const cpf: String;
  const telefone: String;
  const dataCadastro: TDate): Variant;
begin
  TestDB.ExecSQL(PESSOA_INSERT_COMMAND, [nome, cpf, telefone, dataCadastro]);
  Result := TestDB.GetLastInsertRowID();
end;

function InsertProprio(
  const nome: String;
  const cpf: String;
  const telefone: String;
  const dataCadastro: TDate): Variant;
begin
  TestDB.ExecSQL(PROPRIO_INSERT_COMMAND, [nome, cpf, telefone, dataCadastro]);
  Result := TestDB.GetLastInsertRowID();
end;

function InsertVendaLote(
  const compradorId: Integer;
  const loteId: Integer;
  const lanceArremate: Double;
  const data: TDate): Variant;
begin
  TestDB.ExecSQL(VENDA_LOTE_INSERT_COMMAND, [compradorId, loteId, lanceArremate, data]);
  Result := TestDB.GetLastInsertRowID();
end;

initialization
  TestDB := TSQLiteDatabase.Create(':memory:');
  CreateTables();

finalization
  TestDB.Free;

end.
