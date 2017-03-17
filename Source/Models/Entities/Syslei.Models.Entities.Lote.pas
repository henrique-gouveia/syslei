unit Syslei.Models.Entities.Lote;

interface

uses
  Syslei.Models.Entities.Pessoa,
  Spring.Persistence.Mapping.Attributes;

type
  TStatusLote = (Aguardando, Agendado, Arrematado);
  TTipoLote = (Imovel, Animal);

  [Entity]
  [Table('LOTE')]
  TLote = class
  private
    [Column('ID', [cpPrimaryKey])]
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
  public
    constructor Create;
    destructor Destroy; override;

    property Id: Integer read FId write FId;
    property DoadorId: Integer read FDoadorId write FDoadorId;
    property Doador: TPessoa read FDoador write FDoador;
    property Descricao: String read FDescricao write FDescricao;
    property Numero: String read FNumero write FNumero;
    property LanceInicial: Double read FLanceInicial write FLanceInicial;
    property Status: TStatusLote read FStatus write FStatus default Aguardando;
    property Tipo: TTipoLote read FTipo write FTipo default Imovel;
  end;

implementation

{$REGION 'TBem' }

constructor TLote.Create;
begin
  inherited Create;
  FDoador := TPessoa.Create;
end;

destructor TLote.Destroy;
begin
  FDoador.Free;
  inherited;
end;

{$ENDREGION}

end.
