unit Syslei.Tests.TestDB.Lote;

interface

uses
  Syslei.Models.Entities.Lote,
  Syslei.Models.Entities.Lote.Helpers,

  Spring,
  Spring.Collections;

type
  TLoteDataInsert = record
  private
    FDoadorIds: IList<TValue>;
    FLoteIds: IList<TValue>;
  public
    class function Create: TLoteDataInsert; inline; static;
    property DoadorIds: IList<TValue> read FDoadorIds;
    property LoteIds: IList<TValue> read FLoteIds;
  end;

  TLoteRecord = record
  public
    Descricao: String;
    DataCadastro: TDate;
    Status: TStatusLote;
    Tipo: TTipoLote;
  end;

  function GetDefaultLotes: TArray<TLoteRecord>;
  function InsertDoadoresAndLotes(const lotes: TArray<TLoteRecord>): TLoteDataInsert;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  Syslei.Tests.TestDB,
  Syslei.Tests.TestDB.Helpers;

{$REGION 'TLoteDataInsert' }

class function TLoteDataInsert.Create: TLoteDataInsert;
begin
  Result.FDoadorIds := TCollections.CreateList<TValue>();
  Result.FLoteIds := TCollections.CreateList<TValue>();
end;

{$ENDREGION}

var
  Terreno10x25: TLoteRecord = (
    Descricao: 'TERRENO 10x25';
    DataCadastro: 0;
    Status: Aguardando;
    Tipo: Imovel;
  );

  Terreno5x12: TLoteRecord = (
    Descricao: 'TERRENO 5x12';
    DataCadastro: 0;
    Status: Arrematado;
    Tipo: Imovel;
  );

  TouroAdulto1100KG: TLoteRecord = (
    Descricao: 'TOURO ADULTO 1100 KG';
    DataCadastro: 0;
    Status: Arrematado;
    Tipo: Animal;
  );

  TouroAdulto1236KG: TLoteRecord = (
    Descricao: 'TOURO ADULTO 1236 KG';
    DataCadastro: 0;
    Status: Aguardando;
    Tipo: Animal;
  );

  PredaAguardando: TLoteRecord = (
    Descricao: 'PRENDA AGUARDANDO';
    DataCadastro: 0;
    Status: Aguardando;
    Tipo: Prenda;
  );

  PredaArrematada: TLoteRecord = (
    Descricao: 'PRENDA';
    DataCadastro: 0;
    Status: Arrematado;
    Tipo: Prenda;
  );

function GetDefaultLotes: TArray<TLoteRecord>;
var
  lotes: TArray<TLoteRecord>;
begin
  SetLength(lotes, 6);

  Terreno10x25.DataCadastro := Date();
  Terreno5x12.DataCadastro := IncYear(Date(), -1);

  TouroAdulto1100KG.DataCadastro := IncMonth(Date(), -3);
  TouroAdulto1236KG.DataCadastro := Date();

  PredaAguardando.DataCadastro := Date();
  PredaArrematada.DataCadastro := IncDay(Date(), 15);

  lotes[0] := Terreno10x25;
  lotes[1] := Terreno5x12;
  lotes[2] := TouroAdulto1100KG;
  lotes[3] := TouroAdulto1236KG;
  lotes[4] := PredaAguardando;
  lotes[5] := PredaArrematada;

  Result := lotes;
end;

function InsertDoadoresAndLotes(const lotes: TArray<TLoteRecord>): TLoteDataInsert;
var
  lote: TLoteRecord;
  pessoaId, loteId: Integer;
begin
  Result := TLoteDataInsert.Create;

  for lote in lotes do
  begin
    pessoaId := InsertPessoa();
    Result.DoadorIds.Add(pessoaId);

    loteId := InsertLote(
      pessoaId,
      lote.Descricao, '', 0,
      lote.Status.ToInteger(),
      lote.Tipo.ToInteger(), 0, 0,
      lote.DataCadastro);
    Result.LoteIds.Add(loteId);
  end;
end;

end.
