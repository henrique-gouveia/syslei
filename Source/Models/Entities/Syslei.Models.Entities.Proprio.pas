unit Syslei.Models.Entities.Proprio;

interface

uses
  Spring.Persistence.Mapping.Attributes;

type
  [Entity]
  [Table('PROPRIO')]
  {$IFDEF FIREBIRD_DB}
  [Sequence('GEN_PROPRIO_ID', 0, 1)]
  {$ENDIF}
  TProprio = class(TObject)
  private
    [Column('ID', [cpPrimaryKey])]
    {$IFDEF SQLITE_DB}
    [AutoGenerated]
    {$ENDIF}
    FId: Integer;

    [Column('NOME')]
    FNome: String;
    [Column('CPF_CNPJ')]
    FCpfCnpj: String;
    [Column('FONE1')]
    FTelefone: String;
    [Column('DATA_CADASTRO')]
    FDataCadastro: TDate;
  public
    constructor Create; virtual;

    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property CpfCnpj: String read FCpfCnpj write FCpfCnpj;
    property Telefone: String read FTelefone write FTelefone;
    property DataCadastro: TDate read FDataCadastro write FDataCadastro;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TPessoa' }

constructor TProprio.Create;
begin
  inherited Create;
  FDataCadastro := Date();
end;

{$ENDREGION}

end.
