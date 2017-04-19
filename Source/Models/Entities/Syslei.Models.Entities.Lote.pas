unit Syslei.Models.Entities.Lote;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Spring.Persistence.Mapping.Attributes;

type
  TSexo = (Masculino, Feminino);
  TStatusLote = (Aguardando, Agendado, Arrematado);
  TTipoLote = (Animal, Imovel, Prenda);

  [Entity]
  [Table('LOTE')]
  {$IFDEF FIREBIRD_DB}
  [Sequence('GEN_LOTE_ID', 1, 1)]
  {$ENDIF}  TLote = class
  private
    [Column('ID', [cpPrimaryKey])]
    {$IFDEF SQLITE_DB}
    [AutoGenerated]
    {$ENDIF}
    FId: Integer;

    [Column('DOADOR_ID')]
    [ForeignJoinColumn('DoadorId', 'PESSOA', 'ID', [fsOnDeleteNoAction, fsOnUpdateNoAction])]
    FDoadorId: Integer;
    [ManyToOne(True, [ckCascadeAll], 'FDoadorId')]
    FDoador: TPessoa;

    [Column('DESCRICAO')]
    FDescricao: String;
    [Column('NUMERO')]
    FNumero: String;
    [Column('LANCE_INICIAL')]
    FLanceInicial: Double;
    [Column('STATUS')]
    FStatus: TStatusLote;
    [Column('TIPO')]
    FTipo: TTipoLote;
    [Column('DATA_CADASTRO')]
    FDataCadastro: TDate;
    [Column('IDADE')]
    FIdade: Integer;
    [Column('SEXO')]
    FSexo: TSexo;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function IsAnimal: Boolean;
    function IsImovel: Boolean;
    function IsPrenda: Boolean;

    property Id: Integer read FId write FId;
    property DoadorId: Integer read FDoadorId write FDoadorId;
    property Doador: TPessoa read FDoador write FDoador;
    property Descricao: String read FDescricao write FDescricao;
    property Numero: String read FNumero write FNumero;
    property LanceInicial: Double read FLanceInicial write FLanceInicial;
    property Status: TStatusLote read FStatus write FStatus default Aguardando;
    property Tipo: TTipoLote read FTipo write FTipo default Imovel;
    property Idade: Integer read FIdade write FIdade;
    property Sexo: TSexo read FSexo write FSexo;
    property DataCadastro: TDate read FDataCadastro write FDataCadastro;
  end;

implementation

uses
  System.SysUtils;

{$REGION 'TLote' }

constructor TLote.Create;
begin
  inherited Create;
  FDoador := TPessoa.Create;
  FStatus := TStatusLote.Aguardando;
  FTipo := TTipoLote.Imovel;
  FDataCadastro := Date();
end;

destructor TLote.Destroy;
begin
  FDoador.Free;
  inherited;
end;

function TLote.IsAnimal: Boolean;
begin
  Result := FTipo = TTipoLote.Animal;
end;

function TLote.IsImovel: Boolean;
begin
  Result := FTipo = TTipoLote.Imovel;
end;

function TLote.IsPrenda: Boolean;
begin
  Result := FTipo = TTipoLote.Prenda;
end;

{$ENDREGION}

end.
